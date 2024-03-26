import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sugar/utils/colors/sc_color_hex.dart';
import 'package:sugar/utils/colors/sc_colors.dart';

class SUCustomScaffoldLogic extends GetxController {
  /*导航栏背景色*/
  Color primaryColor = SCHexColor("#FF000000");
  /*title颜色*/
  Color titleColor = SCHexColor("#FFFFFFFF");
  /*返回按钮颜色*/
  Color backIconColor = SCHexColor("#FFFFFFFF");
  /*状态栏颜色,黑色或白色,默认白色*/
  SystemUiOverlayStyle statusBarStyle = SystemUiOverlayStyle.light;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /*设置导航栏背景色*/
  void setPrimaryColor(Color color) {
    primaryColor = color;
    update();
  }

  /*设置title颜色*/
  void setTitleColor(Color color) {
    titleColor = color;
    update();
  }

  /*设置返回按钮颜色*/
  void setBackIconColor(Color color) {
    backIconColor = color;
    update();
  }

  /*设置状态栏颜色*/
  void setStatusBarStyle(SystemUiOverlayStyle systemUiOverlayStyle) {
    statusBarStyle = systemUiOverlayStyle;
    update();
  }
}
