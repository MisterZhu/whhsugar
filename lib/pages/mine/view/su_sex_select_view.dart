import 'package:sugar/su_export_comment.dart';

import '../su_mine_logic.dart';

class SUSexSelectView extends StatelessWidget {
  final SUMineLogic? logic;
  final int? selectI;
  final Function(int)? sendHandle;

  const SUSexSelectView(this.logic, this.selectI, {this.sendHandle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62.h,
      width: 260.w,
      // padding: EdgeInsets.all(8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0), // 在子项中裁剪圆角
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  if (sendHandle != null) {
                    sendHandle!(0);
                    SURouterHelper.back(null);
                  }
                },
                child: Container(
                  color: (selectI == 0)
                      ? SCColors.color_454545
                      : SCColors.color_252525, // 第一个Text的背景色
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '男',
                        style: TextStyle(
                          color: SUColorSingleton().textColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (sendHandle != null) {
                    sendHandle!(1);
                    SURouterHelper.back(null);
                  }
                },
                child: Container(
                  color: (selectI == 0)
                      ? SCColors.color_252525
                      : SCColors.color_454545, // 第二个Text的背景色
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '女',
                        style: TextStyle(
                          color: SUColorSingleton().textColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
