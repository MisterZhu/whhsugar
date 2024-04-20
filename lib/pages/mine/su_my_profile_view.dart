import 'package:sugar/pages/mine/su_mine_logic.dart';

import '../../global/user/user_logic.dart';
import '../../su_export_comment.dart';
import '../../utils/cached_image.dart';

class SUMyProfilePage extends StatelessWidget {
  SUMyProfilePage({Key? key}) : super(key: key);

  final logic = Get.find<SUMineLogic>();

  final state = Get.find<SUMineLogic>().state;
  final UserLogic userLogic = Get.find<UserLogic>();

  @override
  Widget build(BuildContext context) {
    state.textEditingController.text = userLogic.user.name?.value ?? '';

    return GetBuilder<SUMineLogic>(
        id: SUDefVal.kMineFilePage,
        builder: (logic) {
          return SUCustomScaffold(
              title: '我的资料',
              navBackgroundColor: SUColorSingleton().bgBotColor,
              // actions: [
              //   TextButton(
              //     child: Text(
              //       'Save',
              //       style: TextStyle(
              //         fontSize: 16.0.sp,
              //         color: SUColorSingleton().saveBtnBgColor,
              //       ),
              //     ),
              //     onPressed: () {
              //       SURouterHelper.back(null);
              //     },
              //   ),
              // ],
              body: body(context));
        });
  }

  /// body
  Widget body(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 点击屏幕收起键盘
      },
      child: Container(
        color: SCColors.color_1C1D1F,
        child: Column(
          children: [
            //屏幕 距顶距离
            Padding(
              padding: EdgeInsets.only(top: 14.w, left: 129.w, right: 129.w),
              child: SizedBox(
                height: 116.w,
                child: Stack(
                  children: [
                    // 子组件1：在中心
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() => ClipRRect(
                            borderRadius: BorderRadius.circular(8.w),
                            child: SUUtils.imageWidget(
                              width: 64.w,
                              height: 64.w,
                              url: userLogic.user.avatar?.value ?? '',
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    // 子组件2：在中心偏右下角各50像素
                    // Positioned(
                    //   right: 0.0, // 向右偏移50像素
                    //   bottom: 0.0, // 向下偏移50像素
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       logic.showSelectImage(context);
                    //     },
                    //     child: Container(
                    //       height: 48.0.w,
                    //       width: 48.0.w,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white.withOpacity(0.15), // 白色透明度15%
                    //         borderRadius: BorderRadius.circular(24.0.w), // 切圆角
                    //       ),
                    //       child: Center(
                    //         child: Icon(
                    //           Icons.camera_alt_rounded,
                    //           color: SUColorSingleton().naviDefColor,
                    //           size: 30.w,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.w,
            ),
            // SUUtils().gradientWidget('#000000'),
            // Expanded(
            //   child: Container(
            //     color: SUColorSingleton().profileBgColor,
            //   ), // Widget3将沾满剩余的空间
            // ),
            Expanded(
              child: Container(
                width: 375.w,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40000000), // 阴影颜色，透明度设置为25%（即25%的黑色）
                      offset: Offset(0, -2), // 阴影偏移量，X方向为0，Y方向为-2
                      blurRadius: 20, // 模糊半径为20
                      spreadRadius: 10, // 扩散半径为10
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 56.w,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              '昵称',
                              style: TextStyle(
                                  color: SUColorSingleton().textColor,
                                  fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Container(
                              width: 229.w,
                              child: TextField(
                                enabled: false, // 将 enabled 属性设置为 false
                                controller:
                                    state.textEditingController, // 设置默认文本
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  border: InputBorder.none, // 隐藏底部边框
                                  hintText: 'Enter your text here',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 16.w,
                    // ),
                    SizedBox(
                      height: 56.w,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              '性别',
                              style: TextStyle(
                                  color: SUColorSingleton().textColor,
                                  fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                // logic.showPopup();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                key: state.itemKey,
                                children: [
                                  SizedBox(
                                    width: 219.w,
                                    child: Text(
                                      (logic.selectSex == 0) ? '男' : '女',
                                      style: TextStyle(
                                          color: SUColorSingleton().textColor,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.unfold_more_sharp,
                                  //   color: SUDefVal.chatBGColor,
                                  //   size: 24.w,
                                  // ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
