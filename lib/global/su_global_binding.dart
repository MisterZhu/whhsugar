import 'package:get/get.dart';
import 'package:sugar/global/user/user_logic.dart';
import 'package:sugar/pages/mine/su_mine_logic.dart';
import '../pages/home/discover/su_discover_logic.dart';
import '../pages/home/su_home_logic.dart';

/// 首页-binding
class SUGlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserLogic>(() => UserLogic());
    Get.lazyPut<SUHomeLogic>(() => SUHomeLogic());
    Get.lazyPut<SUDiscoverLogic>(() => SUDiscoverLogic());
    Get.lazyPut<SUMineLogic>(() => SUMineLogic());
  }
}
