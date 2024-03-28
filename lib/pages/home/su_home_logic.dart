import 'dart:developer';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/user/user_logic.dart';
import '../../global/user/user_state.dart';
import '../../su_export_comment.dart';
import 'discover/su_discover_logic.dart';
import 'discover/su_discover_model.dart';
import 'su_home_state.dart';

class SUHomeLogic extends GetxController {
  final SUHomeState state = SUHomeState();
  late String code = '';
  late String stateStr = '';
  late String name = '';
  late int pageIndex = 0;

  List<SUAssistantModel>? dataSource;
  List<SUSessionModel>? threadData;

  final userLogic = Get.find<UserLogic>();
  final logicDis = Get.put(SUDiscoverLogic());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bus.on(SUDefVal.kPushNeedLogin, onEventCallback);
    bus.on(SUDefVal.kWebBlockCode, onLoginFinishBack);
    dataSource = <SUAssistantModel>[];
    threadData = <SUSessionModel>[];

    dynamic params = Get.arguments;
    code = StringUtils.isNotNullOrEmpty(params?["code"]) ? params!["code"] : '';
    stateStr =
        StringUtils.isNotNullOrEmpty(params?["state"]) ? params!["state"] : '';
    if (code.isNotEmpty && stateStr.isNotEmpty) {
      getUserToken(params);
    } else {
      getLocalToken();
    }
  }

  Future<void> getLocalToken() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = SharedPreferenceUtil().getData(SUDefVal.kToken);
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      log('decodedToken : \n ${decodedToken['name']}');
      name = decodedToken['name'];
      if (name.isNotEmpty && name != '') {
        HttpManager.instance.updateHeaders({
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token'
        });
        getUserInfo();
      }
    } else {
      var params = {
        "title": '登录',
        "url": SUUrl.kLoginWebUrl,
        "need_back": false
      };
      // SURouterHelper.pathPage(SURouterPath.webViewPath, params);
      SURouterHelper.pathOffAllPage(SURouterPath.webViewPath, params);
    }
  }

  ///监听跳转登录页面
  void onEventCallback(dynamic arg) {
    var params = {"title": '登录', "url": SUUrl.kLoginWebUrl, "need_back": false};
    // SURouterHelper.pathPage(SURouterPath.webViewPath, params);
    SURouterHelper.pathOffAllPage(SURouterPath.webViewPath, params);
  }

  ///监听登录
  void onLoginFinishBack(dynamic arg) {
    getUserToken(arg);
  }

  ///监听翻页
  void changePageIndex(int index) {
    pageIndex = index;
    if ((dataSource?.length ?? 0) > index) {
      final listModel = dataSource![pageIndex];
      logicDis.assistantId = listModel.name!;
      List<SUSessionModel>? adults = threadData
          ?.where((user) => user.assistant == logicDis.assistantId)
          .toList();
      if ((adults?.length ?? 0) > 0) {
        logicDis.threadName = adults?.last?.name ?? '';
        logicDis.assistantModel = dataSource![index];
        logicDis.getMessagesList();
      }
    }
  }

  ///-------------------------------Network Request-------------------------------
  ///获取用户token
  Future<void> getUserToken(Map<String, String> params) async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.post(
        url: SUUrl.kGetTokenUrl,
        params: params,
        success: (value) {
          String token = value['accessToken'];
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          log('decodedToken : \n ${decodedToken['name']}');

          name = decodedToken['name'];
          SharedPreferences.getInstance().then((preferences) {
            preferences.setString(SUDefVal.kToken, token);
            HttpManager.instance.updateHeaders({
              'Content-Type': 'application/json; charset=utf-8',
              'Authorization': 'Bearer $token'
            });
            // 在这里执行后续代码
            if (name.isNotEmpty && name != '') {
              getUserInfo();
            }
          });
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///获取用户信息
  Future<void> getUserInfo() async {
    // var params = {
    //   "account_id": name,
    // };
    LoadingUtil.show();
    await HttpManager.instance.get(
        url: '${SUUrl.kGetUserInfoUrl}$name/userInfo',
        params: null,
        success: (value) {
          LoadingUtil.hide();
          log('response : \n $value');
          userLogic.user = UserModel.fromJson(value);
          userLogic.updateUser(userLogic.user);
          LoadingUtil.info(text: '登录成功');
          getThreadsList();
        },
        failure: (err) {
          LoadingUtil.hide();
          LoadingUtil.info(text: '登录失败');
        });
  }

  ///获取所有会话列表
  Future<void> getThreadsList() async {
    await HttpManager.instance.get(
        url:
            '${SUUrl.kCreateThreadUrl}/${userLogic.user.properties?.projectId}/threads',
        params: null,
        success: (response) {
          debugPrint('--------------------获取会话列表response : $response');
          if (response['threads'] != null) {
            response['threads'].forEach((v) {
              threadData!.add(SUSessionModel.fromJson(v));
            });
          }
          getAssistantsList();
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
          getAssistantsList();
        });
  }

  ///获取助手列表
  Future<void> getAssistantsList() async {
    await HttpManager.instance.get(
        url: SUUrl.kGetAssListUrl,
        params: null,
        success: (response) {
          if (response['assistants'] != null) {
            response['assistants'].forEach((v) {
              dataSource!.add(SUAssistantModel.fromJson(v));
            });
            // logicDis.update();
            if ((dataSource?.length ?? 0) > 0) {
              final listModel = dataSource![0];
              logicDis.assistantId = listModel.name!;
              // Iterable<SUSessionModel>? adults = threadData
              //     ?.where((user) => user.assistant == logicDis.assistantId);
              List<SUSessionModel>? adults = threadData
                  ?.where((user) => user.assistant == logicDis.assistantId)
                  .toList();

              if ((adults?.length ?? 0) > 0) {
                logicDis.threadName = adults?.last?.name ?? '';
                logicDis.assistantModel = dataSource![0];
                logicDis.getMessagesList();
              }
            }
            logicDis.update([SUDefVal.kDiscover]);
            if ((dataSource?.length ?? 0) > 1) {
              logicDis.canSlide.value = true;
            } else {
              logicDis.canSlide.value = false;
            }
          }
          log('----------------------dataSource : \n ${dataSource?.length}');
        },
        failure: (err) {
          LoadingUtil.failure(text: err['msg']);
        });
  }
}
