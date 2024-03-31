import 'package:get/get.dart';
import 'package:sugar/pages/home/discover/su_discover_model.dart';
import 'package:sugar/su_export_comment.dart';

import '../../../global/user/user_logic.dart';
import '../chats/details/su_reply_model.dart';
import '../su_home_logic.dart';
import 'su_discover_state.dart';
import 'su_discover_model.dart';

class SUDiscoverLogic extends GetxController with WidgetsBindingObserver {
  final SUDiscoverState state = SUDiscoverState();
  final PageController pageController = PageController();
  final UserLogic userLogic = Get.find<UserLogic>();
  RxBool canSlide = true.obs;
  RxBool isStreamLoading = false.obs;

  late String threadId = '';
  late String threadName = '';
  late SUAssistantModel assistantModel = SUAssistantModel();

  late String projectId = '';
  late String assistantId = '';
  int currentIndex = 0;
  List<SUMessageModel>? messageData;

  @override
  void onInit() {
    super.onInit();
    messageData = <SUMessageModel>[];
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    final bool isKeyboardOpen =
        WidgetsBinding.instance.window.viewInsets.bottom > 0;
    Future.delayed(const Duration(milliseconds: 10), () async {
      SUUtils.getCurrentContext(completionHandler: (context) async {
        state.keywordH = MediaQuery.of(context).viewInsets.bottom;
        debugPrint("bottomInset = ${state.keywordH}");
      });
      if (isKeyboardOpen) {
        // 键盘弹出时的操作
        debugPrint('Keyboard opened');
        update([SUDefVal.kChatInput]);
      } else {
        // 键盘收回时的操作
        debugPrint('Keyboard closed');
        update([SUDefVal.kChatInput]);
      }
    });
  }

  ///添加我的消息
  void addMineMessage(String content) {
    SUMessageModel messageModel = SUMessageModel();
    messageModel.name = '';
    messageModel.type = SUChatType.mine;
    messageModel.isFold = false;
    messageModel.inlineSource = DisInlineSource(
      data: content,
      contentType: 'text/plain',
    );
    messageData!.insert(0, messageModel);
    assistantModel.metadata?.messages = messageData;
    debugPrint(
        '----------------------------------------------messageModel：${messageModel.inlineSource?.data}');

    final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
    homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
    update([SUDefVal.kChatBottom]);
  }

  ///添加回复消息
  void addReplyMessage(String content) {
    SUMessageModel messageModel = SUMessageModel();
    messageModel.name = '';
    messageModel.type = SUChatType.others;
    messageModel.isFold = false;
    messageModel.inlineSource = DisInlineSource(
      data: content,
      contentType: 'text/plain',
    );
    // messageData!.add(messageModel);
    messageData!.insert(0, messageModel);
    assistantModel.metadata?.messages = messageData;

    final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
    homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
    update([SUDefVal.kChatBottom]);
  }

  ///替换消息
  void replaceMessage(String content) {
    if ((messageData?.length ?? 0) > 0) {
      final model = messageData![0];
      model.inlineSource?.data = content;
      messageData![0] = model;
      assistantModel.metadata?.messages = messageData;
      final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
      homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
      update([SUDefVal.kChatBottom]);
    }
  }

  ///-------------------------------Network Request-------------------------------
  ///创建会话
  Future<void> createThreads(Map<String, dynamic> params) async {
    debugPrint('--------------getUserToken--begin');
    final content = params['description'];
    var params1 = {
      "inlineSource": {
        "data": params['description'],
        "contentType": "text/plain"
      },
      // "labels": {
      //   "property1": "string",
      //   "property2": "string"
      // }
    };
    if (threadName != '') {
      sendMessages(params1, content);
    } else {
      await HttpManager.instance.post(
          url:
              '${SUUrl.kCreateThreadUrl}${userLogic.user.properties?.projectId}/threads',
          params: params,
          success: (response) {
            final session = SUSessionModel.fromJson(response);
            threadName = session.name ?? '';
            sendMessages(params1, content);
          },
          failure: (err) {
            // LoadingUtil.failure(text: err['msg']);
          });
    }
  }

  ///发送消息
  Future<void> sendMessages(Map<String, dynamic> params, String content) async {
    debugPrint('--------------getUserToken--begin');
    addMineMessage(content);
    await HttpManager.instance.post(
        url: '$threadName/messages',
        params: params,
        success: (response) {
          debugPrint('--------------------发送消息response1 : $response');
          aiReplyMessages(response['name']);
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///AI 助手回复消息
  Future<void> aiReplyMessages(String name) async {
    debugPrint('--------------getUserToken--begin');
    List<String> substrings = name.split("/messages/");
    late String paraUrl = '';
    if (substrings.isNotEmpty) {
      paraUrl = substrings[0];
    }
    await HttpManager.instance.post(
        url: '$paraUrl:reply',
        params: null,
        success: (response) {
          debugPrint('--------------------AI 助手回复消息response : $response');
          Future.delayed(const Duration(seconds: 1), () {
            if (response['name'] != null) {
              addReplyMessage('');
              getReplyMessages(response['name']);
              canSlide.value = false;
            }
          });
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///轮训获取AI回复
  Future<void> getReplyMessages(String name) async {
    await HttpManager.instance.get(
        url: name,
        params: null,
        success: (response) {
          debugPrint('--------------------轮训获取AI回复response : $response');
          if (response != null) {
            final SUAIReplyModel replayModel =
                SUAIReplyModel.fromJson(response);
            final ReMetadata? metaModel = replayModel.metadata;
            final List<ReMessages>? messages = metaModel?.partialResult?.msg;
            if (messages != null && messages.isNotEmpty) {
              final ReMessages firstMessage = messages[0];
              debugPrint(
                  '--------------------replayModel : ${firstMessage?.conte?.inlineSource?.data ?? ""}');
              replaceMessage(firstMessage?.conte?.inlineSource?.data ?? "");
            }
            if ((replayModel?.done ?? false)) {
              isStreamLoading.value = false;
              canSlide.value = true;
            } else {
              isStreamLoading.value = true;
              Future.delayed(const Duration(seconds: 1), () {
                getReplyMessages(name);
              });
            }
          } else {
            debugPrint('--------------------replayModel :');
          }
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///获取消息列表
  Future<void> getMessagesList() async {
    debugPrint('--------------getUserToken--begin');
    // messageData = assistantModel.metadata?.messages;

    await HttpManager.instance.get(
        url: '$threadName/messages',
        params: null,
        success: (response) {
<<<<<<< HEAD
          debugPrint('--------------------获取消息列表 response : $response');
=======
          debugPrint('--------------------获取消息列表response2 : $response');
>>>>>>> main
          if (response['messages'] != null) {
            messageData = <SUMessageModel>[];

            response['messages'].forEach((v) {
              SUMessageModel messageModel = SUMessageModel.fromJson(v);
              messageModel.type =
                  (messageModel.author == userLogic.user.name?.value)
                      ? SUChatType.mine
                      : SUChatType.others;
              messageData!.add(messageModel);
              // messageData!.add(SUMessageModel.fromJson(v));
            });
            messageData = messageData!.reversed.toList();

            assistantModel.metadata?.needRefresh = false;
            assistantModel.metadata?.messages = messageData;
            final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
            homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
            update([SUDefVal.kChatBottom]);
          }
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///获取某条消息
  Future<void> getMessage() async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.get(
        url: '/$threadName/messages',
        params: null,
        success: (response) {
          debugPrint('--------------------获取某条消息 response : $response');
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }
}
