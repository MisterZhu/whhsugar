import 'package:sugar/su_export_comment.dart';

import '../../../discover/su_discover_model.dart';

class SUChatMineCell extends StatelessWidget {
  final SUChatContentModel? model;

  const SUChatMineCell(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Container(
              constraints: BoxConstraints(maxWidth: SUDefVal.chatBoxMaxWidth.w),
              padding: EdgeInsets.only(
                  left: 10.r, top: 10.r, bottom: 10.r, right: 10.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  color: SUColorSingleton().mineBgColor),
              child: Text(
                model?.content ?? "",
                style: TextStyle(
                    color: SUColorSingleton().mineTextColor,
                    fontSize: SUDefVal.chatRegularFont.sp,
                    letterSpacing:
                        SUDefVal.chatWordSpacing, // 调整字符间距的值，可以为负数以减小间距
                    fontWeight: FontWeight.w400,
                    height: SUDefVal.chatFontSpanHeight),
              ),
            ),
            SizedBox(
              width: SUDefVal.margin.w,
            ),
          ],
        ),
      ),
    );
  }
}
