import 'package:sugar/su_export_comment.dart';

import '../../../discover/su_discover_model.dart';

class SUChatIntroCell extends StatelessWidget {
  final SUChatContentModel? model;

  const SUChatIntroCell(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: SUDefVal.margin.w,
          ),

          // SizedBox(
          //   width: TBDefVal.margin.w,
          // ),
          Container(
              constraints: BoxConstraints(maxWidth: SUDefVal.chatBoxMaxWidth.w),

              // width: SUDefVal.chatBoxMaxWidth.w,
              // height: 135.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  color: SUColorSingleton().introBgColor),
              child: Column(
                children: [
                  Text(model?.content ?? 'Hello. Nice to meet you',
                      style: TextStyle(
                          color: SUColorSingleton().introTextColor,
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
