import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sugar/global/user/user_logic.dart';

import '../pages/home/su_home_logic.dart';

/// 首页-binding
class SUGlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserLogic>(() => UserLogic());
    Get.lazyPut<SUHomeLogic>(() => SUHomeLogic());
  }
}
