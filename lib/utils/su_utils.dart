import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sugar/routes/su_router_path.dart';
import 'package:sugar/su_app.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/assets.dart';

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
    // bool isShowPrivacy =
    //     preferences.getBool(TBDefVal.isShowPrivacyAlert) ?? true;
    // String basePath = TBRouterPath.chatDetPath;
    // if (Platform.isAndroid) {
    //   if (isShowPrivacy == true) {
    //     basePath = TBRouterPath.basePrivacyPath;
    //   } else {
    //     basePath = TBRouterPath.chatDetPath;
    //   }
    // }

    // return SURouterPath.home;
    return SURouterPath.home;
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
      return CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => placeholder ?? const SizedBox(),
          errorWidget: (context, url, error) => const Icon(Icons.error));
    } else {
      return Image.asset(
        url.isEmpty ? Assets.homeMine : url,
        width: width,
        height: height,
        fit: fit,
      );
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
}
