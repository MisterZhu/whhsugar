import 'package:sugar/su_export_comment.dart';

import '../../../discover/su_discover_state.dart';

class SUChatOtherCell extends StatelessWidget {
  final ChatDetailModel? model;

  const SUChatOtherCell(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: SUDefVal.margin.w,
          ),
          Container(
              // width: SUDefVal.chatBoxMaxWidth.w,
              // height: 135.w,
              padding: EdgeInsets.all(10.w),
              constraints: BoxConstraints(
                maxWidth: SUDefVal.chatBoxMaxWidth.w,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  color: SUColorSingleton().otherBgColor),
              child: Column(
                children: [
                  Text(model?.message ?? '',
                      style: TextStyle(
                          color: SUColorSingleton().otherTextColor,
                          fontSize: SUDefVal.chatRegularFont.sp,
                          letterSpacing:
                              SUDefVal.chatWordSpacing, // 调整字符间距的值，可以为负数以减小间距
                          fontWeight: FontWeight.w400,
                          height: SUDefVal.chatFontSpanHeight))
                ],
              ))
        ]),
      ),
    );
  }
}
