import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sugar/routes/su_router_pages.dart';
import 'package:sugar/su_export_comment.dart';
import '../../global/user/user_logic.dart';
import '../mine/su_mine_logic.dart';
import '../mine/su_mine_view.dart';
import '../mine/su_my_profile_view.dart';
import 'chats/su_chats_view.dart';
import 'discover/su_discover_view.dart';
import 'su_home_logic.dart';

class SUHomePage extends StatelessWidget {
  SUHomePage({Key? key}) : super(key: key);

  final logicMine = Get.put(SUMineLogic());
  final logic = Get.put(SUHomeLogic());
  final state = Get.find<SUHomeLogic>().state;
  final userLogic = Get.find<UserLogic>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SUHomeLogic>(builder: (logic) {
      return SUCustomScaffold(
          keyValue: _scaffoldKey, // Set the key here
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Image.asset(
                Assets.homeMine,
                width: 28.w,
                height: 28.w,
              ),
              // const CircleAvatar(
              //   radius: 20.0,
              //   backgroundImage: AssetImage("assets/images/su_home_mine.png"),
              // ),
              // icon: Icon(Icons.menu,
              //     color: state.isDiscover
              //         ? SUColorSingleton().naviDisDefColor
              //         : SUColorSingleton().naviDefColor),
              onPressed: () {
                // 左侧按钮点击事件
                FocusScope.of(context).requestFocus(FocusNode());

                _scaffoldKey.currentState?.openDrawer();
              },
            );
          }),
          actions: [
            IconButton(
              icon: Icon(Icons.search,
                  color: state.isDiscover
                      ? SUColorSingleton().naviDisDefColor
                      : SUColorSingleton().naviDefColor),
              onPressed: () {
                // 右侧按钮点击事件
                FocusScope.of(context).requestFocus(FocusNode());
                // SURouterHelper.pathPage(SURouterPath.searchPath, null);

                var params = {"title": '登录', "url": SUUrl.kLoginWebUrl};
                SURouterHelper.pathPage(SURouterPath.webViewPath, params);
                // X5Sdk.openWebActivity(
                //     "https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=sugar",
                //     title: "web页面");
              },
            ),
          ],
          customTitleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // 中间左侧按钮点击事件
                  print('Discover Button Clicked');
                  state.isDiscover = true;
                  logic.update();
                },
                child: Text(
                  'discover'.tr,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: state.isDiscover
                        ? SUColorSingleton().naviDisDefColor
                        : SUColorSingleton().naviSecColor,
                    shadows: const [Shadow(color: Colors.white, blurRadius: 1)],
                  ),
                ),
              ),
              const SizedBox(width: 10), // 可以根据需要调整间距
              TextButton(
                onPressed: () {
                  // 中间右侧按钮点击事件
                  print('Chats Button Clicked');
                  state.isDiscover = false;
                  logic.update();
                },
                child: Text(
                  'chats'.tr,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: state.isDiscover
                        ? SUColorSingleton().naviDisSecColor
                        : SUColorSingleton().naviDefColor,
                    shadows: const [Shadow(color: Colors.white, blurRadius: 1)],
                  ),
                ),
              ),
            ],
          ),
          // title: "优惠券",
          centerTitle: true,
          navBackgroundColor: Colors.transparent,
          elevation: 0,
          isTransparent: true,
          body: body(),
          drawer: GetBuilder<SUMineLogic>(
              id: SUDefVal.kChatSession, // 添加id绑定，update时只当前GetBuilder会刷新
              builder: (state) {
                return SUMinePage(
                  logicDet: state,
                  doSelect: (value) {
                    SURouterHelper.back(null);

                    /// 选择
                    SURouterHelper.pathPage(SURouterPath.minePath, null);
                    // Get.to(SUMyProfilePage(),
                    //     transition: Transition.rightToLeft);
                  },
                );
              }));
    });
  }

  /// body
  Widget body() {
    return IndexedStack(
      index: state.isDiscover ? 0 : 1,
      children: [
        SUDiscoverPage(), // 第一个小部件
        chatsWidget(), // 第二个小部件
      ],
    );
  }

  Widget chatsWidget() {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: 375.w,
            width: 812.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                SUColorSingleton().bgTopColor,
                SUColorSingleton().bgBotColor
              ],
            )),
            child: SUChatsPage(),
          ),
        ),
      ],
    );
  }
}
