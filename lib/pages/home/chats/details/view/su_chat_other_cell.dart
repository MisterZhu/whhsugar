import 'package:sugar/su_export_comment.dart';

import '../../../discover/su_discover_model.dart';

class SUChatOtherCell extends StatelessWidget {
  final SUChatContentModel? model;

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
                  Text(model?.content ?? '',
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
  // Widget get _loadingContent {
  //   ChatResponseModel? model = this.widget.model;
  //   bool isFold = model?.isFold ?? false;
  //   double progress = (model?.progressP ?? 0) / 100.0;
  //   double imgProgress = logicDet.percentage / 100.0;
  //
  //   print('-----------------------展示loading ${logicDet.percentage}');
  //   logicDet.startTimer();
  //   return Container(
  //     padding: EdgeInsets.only(left: 4.w, right: 12.w, bottom: 12.w, top: 12.w),
  //     clipBehavior: Clip.hardEdge,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(15.r),
  //           bottomLeft: Radius.circular(15.r),
  //           bottomRight: Radius.circular(15.r),
  //         ),
  //         color: Colors.white),
  //     child: GetBuilder<TBChatDetailLogic>(
  //         id: TBDefVal.kChatLoading, // 添加id绑定，update时只当前GetBuilder会刷新
  //         // global: true, // 添加 global 参数，使其全局监听 影响性能
  //         builder: (state) {
  //           return Column(
  //             // mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               model?.isOperation ?? false
  //                   ? CustomProgressWidget(
  //                 progress: progress, // 0.0 to 1.0
  //                 upperText: '${model?.progressP ?? 0} %',
  //                 lowerText: '答案生成中...',
  //                 imagePath:
  //                 'assets/images/chat/chat_search_document_s.png',
  //               )
  //                   : model?.isPainting ?? false
  //                   ? CustomProgressWidget(
  //                 progress: imgProgress, // 0.0 to 1.0
  //                 upperText: '${logicDet.percentage.toInt()} %',
  //                 lowerText: '图片生成中...',
  //                 imagePath:
  //                 'assets/images/chat/chat_search_picture_s.png',
  //               )
  //                   : SpinKitThreeBounce(
  //                 color: Colors.black,
  //                 size: 15,
  //               ),
  //             ],
  //           );
  //         }),
  //   );
  // }
}
