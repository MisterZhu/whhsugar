import 'package:get/get.dart';

import '../../su_export_comment.dart';
import 'su_home_state.dart';

class SUHomeLogic extends GetxController {
  final SUHomeState state = SUHomeState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // bus.on(SUDefVal.kWebBlockCode, onEventCallback);
  }

  // void onEventCallback(dynamic arg) {
  //   debugPrint('--------------Event callback triggered with argument: $arg');
  //
  // }
}
