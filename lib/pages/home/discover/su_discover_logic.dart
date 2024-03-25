import 'package:get/get.dart';
import 'package:sugar/su_export_comment.dart';

import 'su_discover_state.dart';

class SUDiscoverLogic extends GetxController with WidgetsBindingObserver {
  final SUDiscoverState state = SUDiscoverState();
  late List<Widget> childrenView = []; // 初始化为一个空的列表
  int currentIndex = 0;
  final PageController pageController = PageController();
  List<String> imageUrls = [
    'https://qiniu.aimissu.top/temporary/image34.jpg',
    'https://qiniu.aimissu.top/temporary/image39.jpg',
    'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
    'https://qiniu.aimissu.top/temporary/image34.jpg',
    'https://qiniu.aimissu.top/temporary/image39.jpg',
    'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // state.pageController.addListener(_handlePageScroll);
  }

  void onPageChanged(int index) async {
    if (index == 0) {
      // 当前选中的是第一个位置，自动选中倒数第二个位置
      currentIndex = childrenView.length - 2;
      await Future.delayed(const Duration(milliseconds: 300));
      pageController.jumpToPage(currentIndex);
    } else if (index == childrenView.length - 1) {
      // 当前选中的是倒数第一个位置，自动选中第二个索引
      currentIndex = 1;
      await Future.delayed(const Duration(milliseconds: 300));
      pageController.jumpToPage(currentIndex);
    } else {
      currentIndex = index;
    }
    // setState(() {});
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
