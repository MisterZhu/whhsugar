import 'dart:developer';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/user/user_logic.dart';
import '../../global/user/user_state.dart';
import '../../su_export_comment.dart';
import 'discover/su_discover_model.dart';
import 'su_home_state.dart';

class SUHomeLogic extends GetxController {
  final SUHomeState state = SUHomeState();
  late String code = '';
  late String stateStr = '';
  late String name = '';
  List<SUAssistantModel>? dataSource;
  final userLogic = Get.find<UserLogic>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bus.on(SUDefVal.kPushNeedLogin, onEventCallback);
    bus.on(SUDefVal.kWebBlockCode, onLoginFinishBack);

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

  ///-------------------------------Network Request-------------------------------
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
          getAssistantsList();
        },
        failure: (err) {
          LoadingUtil.hide();
          LoadingUtil.info(text: '登录失败');
        });
  }

  Future<void> getAssistantsList() async {
    await HttpManager.instance.get(
        url: SUUrl.kGetAssListUrl,
        params: null,
        success: (response) {
          if (response['assistants'] != null) {
            dataSource = <SUAssistantModel>[];
            response['assistants'].forEach((v) {
              dataSource!.add(SUAssistantModel.fromJson(v));
            });
          }
          log('----------------------dataSource : \n ${dataSource?.length}');
        },
        failure: (err) {
          LoadingUtil.failure(text: err['msg']);
        });
  }
}
