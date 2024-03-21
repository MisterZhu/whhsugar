import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar/su_export_comment.dart';

import '../../utils/cached_image.dart';
import 'su_mine_logic.dart';

class SUMinePage extends StatelessWidget {
  final SUMineLogic logicDet;
  final Function(SUMineTypeEnum) doSelect;

  const SUMinePage({
    required this.logicDet,
    required this.doSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: SCColors.color_1C1D1F,
        child: Column(
          children: [
            //屏幕 距顶距离
            SizedBox(height: 100.w),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 12.w),
              child: GestureDetector(
                onTap: () {
                  // TBRouterHelper.back(null);
                  // TBRouterHelper.pathPage(TBRouterPath.minePath, null);
                },
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 20.w,
                    // ),
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: CachedImage(
                          width: 64.w,
                          height: 64.w,
                          imageUrl: logicDet.state.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, 你好啊 ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Text(
                          "Hi, Tony👋 ",
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.w),
              // 调整这里的值来设置左右边距
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // 按钮1点击事件
                        if (doSelect != null) {
                          doSelect!(SUMineTypeEnum.profile); // 调用回调函数，并传递参数data
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: SUColorSingleton().textColor,
                        backgroundColor:
                            SUColorSingleton().btnBgColor, // 文本颜色为白色
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.w), // 设置圆角
                        ),
                      ),
                      child: Text(
                        'profile'.tr,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: SUColorSingleton().textColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w), // 间距
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // 按钮2点击事件
                        if (doSelect != null) {
                          doSelect!(SUMineTypeEnum.edit); // 调用回调函数，并传递参数data
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: SUColorSingleton().textColor,
                        backgroundColor:
                            SUColorSingleton().btnBgColor, // 文本颜色为白色
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // 设置圆角
                        ),
                      ),
                      child: Text(
                        'edit'.tr,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: SUColorSingleton().textColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  // + icon
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 0.w),
              // 调整这里的值来设置左右边距
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Buttons.doubleText(
                      topText: '9',
                      bottomText: 'chatted'.tr,
                      onPressed: () {
                        // 按钮点击事件
                        if (doSelect != null) {
                          doSelect!(SUMineTypeEnum.chatted); // 调用回调函数，并传递参数data
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20.w), // 间距
                  Expanded(
                    child: Buttons.doubleText(
                      topText: '2',
                      bottomText: 'following'.tr,
                      onPressed: () {
                        // 按钮点击事件
                        if (doSelect != null) {
                          doSelect!(
                              SUMineTypeEnum.following); // 调用回调函数，并传递参数data
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20.w), // 间距
                  Expanded(
                    child: Buttons.doubleText(
                      topText: '1',
                      bottomText: 'subscribing'.tr,
                      onPressed: () {
                        // 按钮点击事件
                        if (doSelect != null) {
                          doSelect!(
                              SUMineTypeEnum.subscribing); // 调用回调函数，并传递参数data
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
