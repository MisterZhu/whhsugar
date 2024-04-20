import 'package:sugar/pages/chat_det/su_chat_det_view.dart';
import 'package:sugar/pages/home/su_home_view.dart';
import 'package:sugar/pages/login/su_login_view.dart';
import 'package:sugar/pages/mine/su_mine_view.dart';
import 'package:sugar/pages/search/su_search_view.dart';
import 'package:sugar/routes/su_router_path.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/brntabbar/brntabbar_view.dart';
import '../pages/home/chats/details/su_details_view.dart';
import '../pages/mine/account_page.dart';
import '../pages/mine/feedback/feedback_view.dart';
import '../pages/mine/su_my_profile_view.dart';
import '../webview/su_webview_view.dart';

/// 路由-pages
class SURouterPages {
  /*根据path使用路由*/
  static final List<GetPage> getPages = [
    /// 首页
    GetPage(name: SURouterPath.home, page: () => SUHomePage()),

    /// welcome
    // GetPage(name: SURouterPath.welcomePath, page: () => WelcomePage()),

    /// 登录
    GetPage(name: SURouterPath.loginPath, page: () => SULoginPage()),

    /// 我的资料页面
    GetPage(name: SURouterPath.minePath, page: () => SUMyProfilePage()),

    /// 聊天详情页
    GetPage(name: SURouterPath.chatDetPath, page: () => SUDetailsPage()),

    /// 搜索页
    GetPage(name: SURouterPath.searchPath, page: () => SUSearchPage()),

    /// 搜索页
    GetPage(name: SURouterPath.tabbarPath, page: () => MyHomePage()),

    ///webView
    GetPage(name: SURouterPath.webViewPath, page: () => SUWebviewPage()),

    /// 我的账户
    GetPage(name: SURouterPath.accountPath, page: () => AccountPage()),

    ///反馈
    GetPage(name: SURouterPath.userFeedback, page: () => FeedbackPage()),
    // /*首次的用户协议和隐私政策弹窗*/
    // GetPage(
    //     name: SURouterPath.basePrivacyPath, page: () => SCPrivacyAlertPage()),
  ];
}
