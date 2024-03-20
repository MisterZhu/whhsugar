import 'package:bruno/bruno.dart';
import 'package:get/get.dart';
import 'package:sugar/pages/mine/view/su_sex_select_view.dart';

import '../../su_export_comment.dart';
import 'su_mine_state.dart';

class SUMineLogic extends GetxController {
  final SUMineState state = SUMineState();

  void showPopup() {
    BuildContext context = Get.context!;
    // // BrnPopupListWindow.showPopListWindow(context, state.itemKey);
    // BrnPopupListWindow.showPopListWindow(context, state.itemKey,
    //     data: ['选项一', '选项二', '选项三'], onItemClick: (index, item) {
    //   BrnToast.show(item, context);
    //   return false;
    // });
    BrnPopupWindow.showPopWindow(
      context,
      "",
      state.itemKey,
      hasCloseIcon: true,
      dismissCallback: () {},
      backgroundColor: SCColors.color_454545,
      offset: 10.w,
      arrowOffset: -74.w,
      paddingInsets:
          const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      widget: GetBuilder<SUMineLogic>(
          id: SUDefVal.kChatInput,
          builder: (context) {
            return SUSexSelectView(
              context,
              sendHandle: (value) async {
                // 列表滑到底部
              },
            );
          }),
    );
  }
}
