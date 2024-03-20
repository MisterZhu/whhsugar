import 'package:get/get.dart';
import 'package:sugar/su_export_comment.dart';

import 'su_discover_state.dart';

class SUDiscoverLogic extends GetxController with WidgetsBindingObserver {
  final SUDiscoverState state = SUDiscoverState();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    final bool isKeyboardOpen =
        WidgetsBinding.instance.window.viewInsets.bottom > 0;
    Future.delayed(const Duration(milliseconds: 10), () async {
      SUUtils.getCurrentContext(completionHandler: (context) async {
        state.keywordH = MediaQuery.of(context).viewInsets.bottom;
        print("bottomInset = ${state.keywordH}");
      });
      if (isKeyboardOpen) {
        // 键盘弹出时的操作
        print('Keyboard opened');
        update([SUDefVal.kChatInput]);
      } else {
        // 键盘收回时的操作
        print('Keyboard closed');
        update([SUDefVal.kChatInput]);
      }
    });
  }
}
