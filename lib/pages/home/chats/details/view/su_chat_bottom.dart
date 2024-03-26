import 'package:sugar/su_export_comment.dart';

import '../../../discover/su_discover_logic.dart';

class SUChatBottom extends StatelessWidget {
  final String? model;
  final String bgColor;
  final SUDiscoverLogic? logic;
  final Function(String)? sendHandle;

  const SUChatBottom(this.model, this.bgColor, this.logic,
      {this.sendHandle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(); // 创建 ScreenUtil 实例
    double screenHeight =
        screenUtil.bottomBarHeight; // 使用实例访问 bottomBarHeight 属性
    // print('---------------------------screenUtil = $screenHeight');
// 获取屏幕底部的安全高度
    double bottomBarHeight = Get.bottomBarHeight;
    // print('---------------------------Get = $bottomBarHeight');

    double bottomPadding = MediaQuery.of(context).padding.bottom;
    // print('---------------------------MediaQuery = $bottomPadding');

    return Container(
      // color: Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
      width: 375.w,
      height: 109.w,
      padding: EdgeInsets.only(left: 16.0.w),
      decoration: BoxDecoration(
          color: Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
          //边框
          border: Border.all(
              width: 0,
              color: Color(int.parse(bgColor.replaceAll('#', '0xFF'))))),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [
      //       Color(int.parse(bgColor.replaceAll('#', '0x00'))),
      //       Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
      //       Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
      //       // Color(0x0039322A), // 开始颜色
      //       // Color(0xFF39322A), // 中间颜色
      //       // Color(0xFF39322A), // 结束颜色，使用16进制颜色值
      //     ],
      //     stops: [0.0, 0.15, 1.0], // 渐变的位置
      //   ),
      // ),
      child: bottomImage(),
    );
  }

  Widget bottomImage() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 5.0.w,
      ),
      Text(
        model ?? '',
        style: TextStyle(
          fontSize: SUColorSingleton().textFont20,
          fontWeight: FontWeight.w500,
          color: SUColorSingleton().introTextColor,
        ),
      ),
      SizedBox(
        height: 4.0.w,
      ),
      Text(
        '13,721 Followers 236,152 Connector',
        style: TextStyle(
          fontSize: SUColorSingleton().textTimeFont10,
          fontWeight: FontWeight.w400,
          color: SUColorSingleton().introTextColor,
        ),
      ),
      SizedBox(
        height: 12.w,
      ),
      Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 12.w),
            width: SUDefVal.chatTextWidth.w,
            height: 42.w,
            decoration: BoxDecoration(
                // border: Border.all(
                //     color: SUColorSingleton().inputBgColor, width: 1),
                color: SUColorSingleton().inputBgColor,
                borderRadius: BorderRadius.circular(10.r)),
            child: TextField(
                minLines: 1,
                maxLines: 5,
                focusNode: logic?.state.focusNode,
                onChanged: (value) {
                  // if (widget.changeHandle != null) {
                  //   widget.changeHandle!(value);
                  // }
                },
                controller: logic?.state.textEditingController,
                onSubmitted: (value) {
                  sendMessageAction();
                },
                style: TextStyle(
                  color: SUColorSingleton().inputTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  // 设置字体颜色
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10.w),
                  // contentPadding:
                  //                   EdgeInsets.symmetric(vertical: 10.0.w), // 调整水平内边距
                  hintText: 'Enter'.tr,
                  hintStyle: TextStyle(
                      color: SUColorSingleton().inputBgColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                )),
          ),
          IconButton(
            icon: Icon(Icons.send_rounded,
                color: SUColorSingleton().naviDefColor),
            onPressed: () {
              // 左侧按钮点击事件
              sendMessageAction();
            },
          )
          // GestureDetector(
          //     child: Image.asset(
          //       "assets/images/chat/chat_input_send.png",
          //       width: 24.w,
          //     ),
          //     onTap: () {
          //
          //     })
        ],
      ),
    ]);
  }

  sendMessageAction() {
    String content = logic?.state.textEditingController.value.text ?? '';
    if (content.isEmpty) {
      print('content = $content');

      Fluttertoast.showToast(
          msg: 'no content'.tr, gravity: ToastGravity.CENTER);
    } else {
      if (sendHandle != null) {
        print('send');
        SUUtils.getCurrentContext(completionHandler: (context) async {
          FocusScope.of(context).requestFocus(FocusNode());
        });
        sendHandle!(content);
        logic?.state.textEditingController.clear();
      }
    }
  }
}
