import 'package:get/get.dart';
import 'package:sugar/pages/home/discover/su_discover_model.dart';
import 'package:sugar/su_export_comment.dart';

import '../../../global/db/daos/chat_content_dao.dart';
import '../../../global/db/daos/session_list_dao.dart';
import '../../../global/db/database_helper.dart';
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
  RxBool isStopGeneration = false.obs;

  late String threadId = '';
  late String threadName = '';
  late SUAssistantModel assistantModel = SUAssistantModel();

  late String projectId = '';
  late String assistantId = '';
  int currentIndex = 0;
  List<SUMessageModel>? messageData;

  List<SUChatContentModel>? dataList;

  @override
  void onInit() {
    super.onInit();
    messageData = <SUMessageModel>[];
    dataList = <SUChatContentModel>[];
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

  // ///添加打招呼的消息
  // void addCallMessage(String content) {
  //   SUChatContentModel messageModel = SUChatContentModel();
  //   messageModel.name = '';
  //   messageModel.type = SUChatType.intro;
  //   messageModel.isFold = false;
  //   messageModel.content = content;
  //   dataList!.insert(0, messageModel);
  //   assistantModel.metadata?.chats = dataList;
  //
  //   final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
  //   homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
  //   update([SUDefVal.kChatBottom]);
  // }

  ///添加我的消息
  void addMineMessage(String content) {
    SUChatContentModel messageModel = SUChatContentModel();
    messageModel.name = '';
    messageModel.type = SUChatType.mine;
    messageModel.isFold = false;
    messageModel.content = content;
    dataList!.insert(0, messageModel);
    assistantModel.metadata?.chats = dataList;

    final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
    homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
    update([SUDefVal.kChatBottom]);
  }

  ///添加回复消息
  void addReplyMessage(String content) {
    SUChatContentModel messageModel = SUChatContentModel();
    messageModel.name = '';
    messageModel.type = SUChatType.others;
    messageModel.isFold = false;
    messageModel.isFinish = false;

    messageModel.content = content;
    // messageData!.add(messageModel);
    dataList!.insert(0, messageModel);
    assistantModel.metadata?.chats = dataList;

    final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
    homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
    update([SUDefVal.kChatBottom]);
  }

  ///替换消息
  void replaceMessage(String content, bool isFinish) {
    if ((dataList?.length ?? 0) > 0) {
      final model = dataList![0];
      model.content = content;
      model.isFinish = isFinish;

      dataList![0] = model;
      assistantModel.metadata?.chats = dataList;
      final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
      homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
      update([SUDefVal.kChatBottom]);
    }
  }

  // 添加会话数据
  Future<void> insertThreadDB(SUSessionModel session) async {
    try {
      final sessionListDao = SessionListDao(DatabaseHelper.instance.database);
      await sessionListDao.insertOrUpdate({
        'assistant': session.assistant,
        'name': session.name,
        'displayName': session.displayName,
        'description': session.description,
        'owner': session.owner,
        'createTime': session.createTime,
        'updateTime': session.updateTime
      });
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

// 添加聊天数据
  void insertChatDB(SUMessageModel messageModel) async {
    try {
      final chatContentDao = ChatContentDao(DatabaseHelper.instance.database);
      await chatContentDao.insertOrUpdate({
        'sessionName': threadName,
        'name': messageModel.name,
        'contentType': messageModel.inlineSource?.contentType,
        'content': messageModel.inlineSource?.data,
        'author': messageModel.author,
        'createTime': messageModel.createTime,
        'updateTime': messageModel.updateTime
      });
      final sessionListDao = SessionListDao(DatabaseHelper.instance.database);
      // final sessionList = await sessionListDao.getAll();
      final data = await sessionListDao.query('name', threadName);
      final lastModel = data.last;

      sessionListDao.insertOrUpdate({
        'assistant': lastModel['assistant'],
        'name': lastModel['name'],
        'displayName': lastModel['displayName'],
        'description': lastModel['description'],
        'owner': lastModel['owner'],
        'createTime': lastModel['createTime'],
        'lastTime': messageModel.createTime,
        'lastMessage': messageModel.inlineSource?.data,
        'updateTime': lastModel['updateTime']
      });
      debugPrint('查询到的  session数据: $data');
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

  // 条件sessionName查询聊天表数据
  void _fetchTableData() async {
    try {
      final chatContentDao = ChatContentDao(DatabaseHelper.instance.database);
      // final data = await chatContentDao.getAll();

      final data = await chatContentDao.query('sessionName', threadName);
      //List<SUChatContentModel> chatContentList = data.map((json) => SUChatContentModel.fromJson(json)).toList();
      dataList = <SUChatContentModel>[];

      debugPrint('item 表中的数据: $data');
      data.forEach((json) {
        SUChatContentModel chatContent = SUChatContentModel.fromJson(json);
        chatContent.type = (chatContent.author == userLogic.user.name?.value)
            ? SUChatType.mine
            : SUChatType.others;
        chatContent.isFinish = true;

        dataList?.add(chatContent);
      });
      dataList = dataList!.reversed.toList();

      assistantModel.metadata?.chats = dataList;
      final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
      homeLogic.dataSource![homeLogic.pageIndex] = assistantModel;
      update([SUDefVal.kChatBottom]);
      debugPrint('---------------chatContent: 刷新');
    } catch (error) {
      debugPrint('find error: $error');
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
          success: (response) async {
            final session = SUSessionModel.fromJson(response);
            await insertThreadDB(session);

            threadName = session.name ?? '';
            sendMessages(params1, content);
            bus.emit(SUDefVal.kChattedUpdate, params);
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
          getMessage(response['name']);
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
    isStopGeneration.value = false;
    canSlide.value = false;

    await HttpManager.instance.post(
        url: '$paraUrl:reply',
        params: null,
        success: (response) {
          debugPrint('--------------------AI 助手回复消息response : $response');
          Future.delayed(const Duration(seconds: 1), () {
            if (response['name'] != null) {
              addReplyMessage('');
              getReplyMessages(response['name']);
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
              replaceMessage(firstMessage?.conte?.inlineSource?.data ?? "",
                  replayModel?.done ?? false);
            }
            if (isStopGeneration.value) {
              isStreamLoading.value = false;
              canSlide.value = true;
              return;
            }
            if ((replayModel?.done ?? false)) {
              isStreamLoading.value = false;
              canSlide.value = true;
              getMessage(replayModel.response?.messages?.last ?? '');
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
          debugPrint('--------------------获取消息列表 response : $response');

          if (response['messages'] != null) {
            messageData = <SUMessageModel>[];
            List<Map<String, dynamic>> mapValues = [];

            response['messages'].forEach((v) {
              SUMessageModel messageModel = SUMessageModel.fromJson(v);

              List<String>? substrings = messageModel.name?.split("/messages/");

              mapValues.add({
                'sessionName': substrings?.first ?? '',
                'name': messageModel.name,
                'contentType': messageModel.inlineSource?.contentType,
                'content': messageModel.inlineSource?.data,
                'author': messageModel.author,
                'createTime': messageModel.createTime,
                'updateTime': messageModel.updateTime
              });
              messageModel.type =
                  (messageModel.author == userLogic.user.name?.value)
                      ? SUChatType.mine
                      : SUChatType.others;
              messageData!.add(messageModel);
              // messageData!.add(SUMessageModel.fromJson(v));
            });
            final chatContentDao =
                ChatContentDao(DatabaseHelper.instance.database);
            chatContentDao.batchInsert(mapValues);
            messageData = messageData!.reversed.toList();

            assistantModel.metadata?.needRefresh = false;
            assistantModel.metadata?.messages = messageData;
            _fetchTableData();
          }
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///获取某条消息
  Future<void> getMessage(String name) async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.get(
        url: name,
        params: null,
        success: (response) {
          debugPrint('--------------------获取某条消息 response : $response');
          SUMessageModel messageModel = SUMessageModel.fromJson(response);
          insertChatDB(messageModel);
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }
}
