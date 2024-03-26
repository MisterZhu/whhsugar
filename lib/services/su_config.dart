import '../constants/su_enum.dart';

class SUConfig {
  /// 环境
  static SUEnvironment env = SUEnvironment.production;

  static bool isSupportProxyForProduction = false;

  /// iOS是否支持平方SC字体
  static bool isSupportPFSCForIOS = true;

  /// base url
  static String get BASE_URL {
    switch (env) {
      case SUEnvironment.develop:
        return "https://sugar.tigerbot.com/v1alpha1";
      case SUEnvironment.production:
        return "https://sugar.tigerbot.com/v1alpha1";
      default:
        return "https://sugar.tigerbot.com/v1alpha1";
    }
  }
}
