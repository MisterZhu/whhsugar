import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_bottom.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_intro_cell.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_list_bg.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_mine_cell.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_other_cell.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_tip.dart';
import '../../../../su_export_comment.dart';
import '../../discover/su_discover_logic.dart';
import '../../discover/su_discover_state.dart';
import 'su_details_logic.dart';

class SUDetailsPage extends StatelessWidget {
  SUDetailsPage({Key? key}) : super(key: key);

  final state = Get.find<SUDiscoverLogic>().state;

  final logicDet = Get.put(SUDetailsLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SUDetailsLogic>(builder: (logic) {
      return SUCustomScaffold(
          // leading: IconButton(
          //   icon: Image.asset(
          //     Assets.commonBackIconW,
          //     width: 24.w,
          //     height: 24.w,
          //     // color: SUColorSingleton().naviDefColor
          //   ),
          //   onPressed: () {
          //     // 左侧按钮点击事件
          //     SURouterHelper.back(null);
          //   },
          // ),
          title: "Tony",
          centerTitle: true,
          navBackgroundColor: Colors.transparent,
          elevation: 0,
          isTransparent: true,
          body: body());
    });
  }

  /// body
  Widget body() {
    return FutureBuilder<String>(
      future: logicDet.getImageColor('',
          'https://qiniu.aimissu.top/temporary/image39.jpg'), // 调用 getImageColor 方法获取图片主要颜色
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://qiniu.aimissu.top/temporary/image39.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final String bgColor = snapshot.data!;

          return GestureDetector(
            onTap: () {
              // 在点击空白处时收起键盘
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://qiniu.aimissu.top/temporary/image39.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 178.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 57.0.w, right: 57.0.w),
                    child: SUChattedTip('NoticeEverything'.tr),
                  ),
                  Expanded(
                    child: GetBuilder<SUDiscoverLogic>(
                      id: SUDefVal.kChatBottom,
                      builder: (logic) {
                        return SUChatListBg(
                          bgColor: bgColor,
                          logic: logic,
                        );
                      },
                    ),
                  ),
                  bottomWidget(bgColor),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget bottomWidget(String bgColor) {
    return GetBuilder<SUDiscoverLogic>(
      id: SUDefVal.kChatBottom,
      builder: (state) {
        return SUChatBottom(
          'Tony',
          bgColor,
          state,
          sendHandle: (value) async {
            // 列表滑到底部
            // searchRequest(value);
          },
          // backgroundColor: Color(int.parse(backgroundColor.replaceAll('#', '0xFF'))), // 使用颜色字符串设置背景色
        );
      },
    );
  }

  Widget gradientWidget(String bgColor) {
    return GetBuilder<SUDiscoverLogic>(
      id: SUDefVal.kChatBottom,
      builder: (state) {
        return Container(
          width: 375.w,
          height: 23.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(int.parse(bgColor.replaceAll('#', '0x00'))),
                Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
                Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
                // Color(0x0039322A), // 开始颜色
                // Color(0xFF39322A), // 中间颜色
                // Color(0xFF39322A), // 结束颜色，使用16进制颜色值
              ],
              stops: [0.0, 0.8, 1.0], // 渐变的位置
            ),
          ),
        );
      },
    );
  }
}
