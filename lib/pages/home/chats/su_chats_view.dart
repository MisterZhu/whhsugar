import 'package:flutter/services.dart';
import 'package:sugar/su_export_comment.dart';

import '../../../constants/su_default_value.dart';
import '../su_home_logic.dart';
import 'chatted/su_chatted_view.dart';
import 'following/su_following_view.dart';

class SUChatsPage extends StatelessWidget {
  SUChatsPage({Key? key}) : super(key: key);

  final logic = Get.find<SUHomeLogic>();
  final state = Get.find<SUHomeLogic>().state;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return GetBuilder<SUHomeLogic>(
        id: SUDefVal.kChatInput,
        builder: (logic) {
          return Container(
            height: screenHeight - statusBarHeight,
            margin: EdgeInsets.only(top: statusBarHeight),
            child: SUChattedPage(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start, // 设置为从左到右排布
            //   children: [
            //     // Padding(
            //     //   padding: EdgeInsets.only(left: 20.w, top: 12.w),
            //     //   child: Row(
            //     //     mainAxisAlignment: MainAxisAlignment.start, // 设置为从左到右排布
            //     //     mainAxisSize: MainAxisSize.min,
            //     //     children: [
            //     //       buildTabButton(state.isFollow ? 0 : 1, 'chatted'.tr, 0),
            //     //       SizedBox(
            //     //         width: 12.0.w,
            //     //       ),
            //     //       buildTabButton(state.isFollow ? 1 : 0, 'following'.tr, 1),
            //     //     ],
            //     //   ),
            //     // ),
            //     Expanded(
            //       child: !state.isFollow ? SUChattedPage() : SUFollowingPage(),
            //     ),
            //   ],
            // ),
          );
        });
  }

  Widget buildTabButton(
    int index,
    String text,
    int type,
  ) {
    return InkWell(
      onTap: () {
        if (type == 0) {
          state.isFollow = false;
          logic.update([SUDefVal.kChatInput]);
        } else {
          state.isFollow = true;
          logic.update([SUDefVal.kChatInput]);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: (index == 1)
                  ? SUColorSingleton().naviYellowColor
                  : SUColorSingleton().naviGrayColor),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 12.w),
          child: Text(
            text,
            style: TextStyle(
              color: (index == 1)
                  ? SUColorSingleton().naviYellowColor
                  : SUColorSingleton().naviGrayColor,
            ),
          ),
        ),
      ),
    );
  }
}
