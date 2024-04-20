/// 路由-path

class SURouterPath {
  /// 根目录默认登录页面
  static String home = "/lib/pages/home/su_home_view"; // 根目录

  static String welcomePath = "/lib/pages/welcome_page"; // 欢迎页面

  /// *************************** 登录 *****************************
  /// 登录
  static String loginPath = "/lib/pages/login/su_login_view";

  /// *************************** 我的 *****************************
  /// 我的页面
  static String minePath = "/lib/pages/mine/su_mine_view";

  /// *************************** chat *****************************
  /// chat页面
  static String chatDetPath = "/lib/pages/home/chats/details/su_details_view";

  /// *************************** 搜索页面 *****************************
  /// 搜索页面
  static String searchPath = "/lib/pages/search/su_search_view";

  /// 搜索页面
  static String tabbarPath = "/lib/pages/tabbar/su_search_view";
  /***************************** 通用页 ******************************/
  /// webView
  static String webViewPath = "/root/webView/webViewPage";
  static String wechatRecordPath = "/root/webView/wechatRecordPath";

  ///用户协议和隐私政策弹窗
  static String basePrivacyPath =
      "/lib/pages/login/privacy/sc_privacy_alert_page";

  /// 我的账户
  static String accountPath = "/lib/pages/mine/account_page";
}
