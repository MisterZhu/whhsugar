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
        return "https://pai-test.tigerobo.com/x-pai-biz";
      case SUEnvironment.production:
        return "https://pai.tigerobo.com/x-pai-biz";
      default:
        return "https://pai.tigerobo.com/x-pai-biz";
    }
  }
}
