import 'package:get/get.dart';
import 'package:sugar/pages/home/discover/su_discover_model.dart';
import 'package:sugar/su_export_comment.dart';

import '../../../global/user/user_logic.dart';
import '../su_home_logic.dart';
import 'su_discover_state.dart';

class SUDiscoverLogic extends GetxController with WidgetsBindingObserver {
  final SUDiscoverState state = SUDiscoverState();
  final PageController pageController = PageController();
  final UserLogic userLogic = Get.find<UserLogic>();
  final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();
  RxBool canSlide = false.obs;
  late String threadId = '';
  late String threadName = '';

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

  ///-------------------------------Network Request-------------------------------
  ///创建会话
  Future<void> createThreads(Map<String, dynamic> params) async {
    debugPrint('--------------getUserToken--begin');
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
      sendMessages(params1);
    } else {
      await HttpManager.instance.post(
          url:
              '${SUUrl.kCreateThreadUrl}${userLogic.user.properties?.projectId}/threads',
          params: params,
          success: (response) {
            final session = SUSessionModel.fromJson(response);
            threadName = session.name ?? '';
            sendMessages(params1);
          },
          failure: (err) {
            // LoadingUtil.failure(text: err['msg']);
          });
    }
  }

  ///发送消息
  Future<void> sendMessages(Map<String, dynamic> params) async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.post(
        url: '$threadName/messages',
        params: params,
        success: (response) {
          debugPrint('--------------------发送消息response : $response');

          aiReplyMessages();
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///AI 助手回复消息
  Future<void> aiReplyMessages() async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.post(
        url: '${SUUrl.kCreateThreadUrl}/$projectId/threads/$threadId:reply',
        params: null,
        success: (response) {
          debugPrint('--------------------AI 助手回复消息response : $response');
          Future.delayed(const Duration(seconds: 2), () {
            if (response['name'] != null) {
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
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.get(
        url: '/$name',
        params: null,
        success: (response) {
          debugPrint('--------------------轮训获取AI回复response : $response');
          Future.delayed(const Duration(seconds: 2), () {});
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///获取消息列表
  Future<void> getMessagesList() async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.get(
        url: '/$threadName/messages',
        params: null,
        success: (response) {
          debugPrint('--------------------发送消息response : $response');
          if (response['messages'] != null) {
            response['messages'].forEach((v) {
              messageData!.add(SUMessageModel.fromJson(v));
            });
          }
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }
}
