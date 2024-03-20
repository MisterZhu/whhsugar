import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sugar/routes/su_router_pages.dart';
import 'package:sugar/utils/custom_material_color.dart';
import 'package:sugar/utils/su_utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constants/su_default_value.dart';
import 'constants/su_translation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保Flutter初始化完毕

  RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  // 异步初始化
  await SharedPreferences.getInstance();

  /// 路由的basePath
  String basePath = await SUUtils().getLoginState();
  // 初始化
  ScreenUtil.ensureScreenSize();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  // Android设备设置沉浸式
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
  }
  runApp(ScreenUtilInit(
    designSize: const Size(SUDefVal.screenWidth, SUDefVal.screenHeight),
    builder: (ctx, child) => GetMaterialApp(
      theme: ThemeData(
        primarySwatch: customMaterialColor(Colors.black),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // defaultTransition: Transition.rightToLeft, // 转场动画
      getPages: SURouterPages.getPages,
      initialRoute: basePath,
      builder: EasyLoading.init(
        builder: (context, widget) {
          return MediaQuery(
            // 设置文字大小不随系统设置改变
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget ?? const SizedBox(),
          );
        },
      ),
      navigatorObservers: [routeObserver],
      translations: SUTranslations(),
      locale: SUUtils.isChineseLan()
          ? const Locale('zh', 'CN')
          : const Locale('en', 'US'),
      // //设置默认语言
      fallbackLocale: const Locale("zh", "CN"),
      //在配置错误的情况下,使用的语言
    ),
  ));
}
