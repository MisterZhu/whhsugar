import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../su_export_comment.dart';
import 'user_state.dart';

class UserLogic extends GetxController {
  // final UserState model = UserState();
  UserState user = UserState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bus.on(SUDefVal.kWebBlockCode, onEventCallback);
    user = UserState.fromJson({
      'name': 'Lisa',
      'age': 18,
      'avatar': 'https://qiniu.aimissu.top/temporary/image34.jpg',
      'token': '123456',
    });

    updateUser(user);
  }

  void onEventCallback(dynamic arg) {
    debugPrint('--------------Event callback triggered with argument: $arg');
    getUserToken(arg);
  }

  // 更新用户信息
  void updateUser(UserState newUser) async {
    // 更新用户信息
    // user(newUser);
    user = newUser;
    // user.refresh();
    // 保存用户信息到SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', jsonEncode(newUser.toJson()));
  }

  // 从SharedPreferences中获取用户信息
  Future<void> getUserInfoFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfoString = prefs.getString('user_info');
    if (userInfoString != null) {
      Map<String, dynamic> userInfoMap = jsonDecode(userInfoString);
    }
  }

  ///-------------------------------Network Request-------------------------------

  Future<void> getUserToken(Map<String, String> params) async {
    // var params = {
    //   "params": {
    //     "user": {
    //       "account": userInfo.account,
    //       "name": userInfo.name,
    //       "avatar": avatarUrl,
    //       "intro": userInfo.intro,
    //     },
    //   },
    //   "authorization": {
    //     "token": userInfo.token,
    //     "uid": userInfo.uuid,
    //   },
    // };
    // var params = {
    //   "code": '',
    //   "state": '',
    // };
    debugPrint('--------------getUserToken--begin');
    await HttpManager.instance.post(
        url: SUUrl.kGetTokenUrl,
        params: params,
        success: (value) {
          // Map<String, dynamic> data = value['data'];
          // data["token"] = userInfo.token;
          // userInfo.login(data, isLocalSave: true);
          LoadingUtil.success(text: value['msg']);
        },
        failure: (err) {
          LoadingUtil.failure(text: err['msg']);
        });
  }
}
