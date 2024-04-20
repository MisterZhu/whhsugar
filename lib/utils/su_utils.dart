import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar/constants/su_default_value.dart';
import 'package:sugar/routes/su_router_path.dart';
import 'package:sugar/su_app.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sugar/utils/shared_preference_util.dart';
import '../generated/assets.dart';

class SUUtils {
  ///获取当前context
  static getCurrentContext(
      {Function(BuildContext context)? completionHandler}) {
    Future.delayed(const Duration(seconds: 0), () async {
      BuildContext context = navigatorKey.currentState!.overlay!.context;
      completionHandler?.call(context);
    });
  }

  ///获取启动路由
  Future<String> getLoginState() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await SharedPreferenceUtil().init();
    String? token = SharedPreferenceUtil().getData(SUDefVal.kToken);
    // String token = preferences.getString(SUDefVal.kToken) ?? "";
    if (token != null) {
      return SURouterPath.home;
    }
    // return SURouterPath.home;
    return SURouterPath.webViewPath;
  }

  ///手机系统是否是中文
  static bool isChineseLan() {
    final deviceLocale = Get.deviceLocale;
    final isChinese = deviceLocale?.languageCode?.toLowerCase() == 'zh' &&
        (deviceLocale?.countryCode == 'CN' ||
            deviceLocale?.countryCode == 'TW' ||
            deviceLocale?.countryCode == 'HK' ||
            deviceLocale?.countryCode == 'MO');

    return isChinese;
  }

  ///图片展示widget
  static Widget imageWidget(
      {required String url,
      double? width,
      double? height,
      BoxFit? fit,
      Widget? placeholder}) {
    if (url.contains('http')) {
      if (url.toLowerCase().endsWith('.svg')) {
        return SvgPicture.network(
          url,
          width: width,
          height: height,
          // fit: fit,
          placeholderBuilder: (context) =>
              placeholder ??
              Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator()),
          // errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else {
        return CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) =>
                placeholder ??
                Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error));
      }
    } else {
      if (url.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          url,
          width: width,
          height: height,
          // fit: fit,
        );
      } else {
        return Image.asset(
          url.isEmpty ? Assets.homeMine : url,
          width: width,
          height: height,
          fit: fit,
        );
      }
    }
  }

  ///返回一个渐变色模块
  Widget gradientWidget(String bgColor) {
    return Container(
      width: 375.w,
      height: 20.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(int.parse(bgColor.replaceAll('#', '0x00'))),
            Color(int.parse(bgColor.replaceAll('#', '0xB3'))),
          ],
          stops: [0.0, 1.0], // 渐变的位置
        ),
      ),
    );
  }

  ///修改状态栏颜色
  changeStatusBarStyle({required SystemUiOverlayStyle style}) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  String dateTimeFormat(String timeStr) {
    DateTime dateTime = DateTime.parse(timeStr);
    DateTime today = DateTime.now();
    Duration difference = today.difference(dateTime);

    if (difference.inDays == 0) {
      return '今天';
    } else if (difference.inDays == 1) {
      return '昨天';
    } else if (difference.inDays < 10) {
      return '${difference.inDays}天前';
    } else {
      String formattedDate =
          "${dateTime.year}/${dateTime.month}/${dateTime.day}";
      return formattedDate;
    }
  }
}
