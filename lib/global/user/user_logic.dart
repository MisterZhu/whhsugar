import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/home/discover/su_discover_model.dart';
import '../../su_export_comment.dart';
import 'user_state.dart';

class UserLogic extends GetxController {
  UserModel user = UserModel();
  late String name = '';
  List<SUAssistantModel>? dataSource;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // 更新用户信息
  void updateUser(UserModel newUser) async {
    // 更新用户信息
    user = newUser;
    // user.refresh();
    // 保存用户信息到SharedPreferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharedPreferenceUtil()
        .saveData(SUDefVal.kUserInfo, jsonEncode(newUser.toJson()));
  }

  // 从SharedPreferences中获取用户信息
  Future<void> getUserInfoFromSharedPreferences() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfoString = SharedPreferenceUtil().getData(SUDefVal.kUserInfo);
    if (userInfoString != null) {
      Map<String, dynamic> userInfoMap = jsonDecode(userInfoString);
      user = UserModel.fromJson(userInfoMap);
    }
  }
}
