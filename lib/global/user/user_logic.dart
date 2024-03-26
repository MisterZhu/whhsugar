import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../su_export_comment.dart';
import 'user_state.dart';

class UserLogic extends GetxController {
  // final UserState model = UserState();
  UserState user = UserState();
  late String name = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bus.on(SUDefVal.kWebBlockCode, onEventCallback);
    // user = UserState.fromJson({
    //   'name': 'Lisa',
    //   'age': 18,
    //   'avatar': 'https://qiniu.aimissu.top/temporary/image34.jpg',
    //   'token': '123456',
    // });

    updateUser(user);
    // testLogin();
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
    //   "code": '2894b1a248d09fea0bee',
    //   "state": 'casdoor',
    // };
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.post(
        url: SUUrl.kGetTokenUrl,
        params: params,
        success: (value) {
          // Map<String, dynamic> data = value['data'];
          // data["token"] = userInfo.token;
          // userInfo.login(data, isLocalSave: true);
          // LoadingUtil.success(text: value['msg']);

          String token = value['accessToken'];
          user.updateToken(token);
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          log('decodedToken : \n ${decodedToken['name']}');

          name = decodedToken['name'];
          SharedPreferences.getInstance().then((preferences) {
            preferences.setString(SUDefVal.kToken, token);
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

  /*
Future<void> saveTokenAndExecute() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(SUDefVal.kToken, token);

  // 在这里执行后续代码
  if (name.isNotEmpty && name != '') {
    getUserInfo();
  }
}

// 在需要执行的地方调用这个异步函数
await saveTokenAndExecute();
* */
  Future<void> getUserInfo() async {
    // var params = {
    //   "account_id": name,
    // };
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.get(
        url: '${SUUrl.kGetUserInfoUrl}$name/userInfo',
        params: null,
        success: (value) {
          // Map<String, dynamic> data = value['data'];
          // data["token"] = userInfo.token;
          // userInfo.login(data, isLocalSave: true);
          // LoadingUtil.success(text: value['msg']);
          log('response : \n $value');
          /*
{
  "id": "81172d1a-4dc4-4dac-b859-0ab07d472fb1",
  "name": "admin",
  "displayName": "Admin",
  "avatar": "https://cdn.casbin.org/img/casbin.svg",
  "properties": {
    "project": "test-project",
    "project_id": "user-81172d1a-4dc4-4dac-b859-0ab07d472fb1"
  },
  "createdTime": "2024-03-11T06:25:07Z",
  "updatedTime": "2024-03-26T07:46:51Z"
}
          * */
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  Future<void> testLogin() async {
    var params = {
      "code": '2894b1a248d09fea0bee',
      "state": 'casdoor',
    };
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
