import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar/pages/home/chats/details/view/stop_generation.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_bottom.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_list_bg.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_tip.dart';
import '../../../../su_export_comment.dart';
import '../../discover/su_discover_logic.dart';
import 'su_details_logic.dart';

class SUDetailsPage extends StatelessWidget {
  SUDetailsPage({Key? key}) : super(key: key);

  final logicDet = Get.put(SUDetailsLogic());

  @override
  Widget build(BuildContext context) {
    // 通过 Get.arguments 获取传递的参数
    var received = Get.arguments;
    logicDet.title = received['title'];
    logicDet.name = received['name'];
    logicDet.bgUrl = received['backgroundImage'];
    logicDet.fetchTableData();
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
          title: logicDet.title,
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
      future: logicDet.getImageColor(
          '', logicDet.bgUrl), // 调用 getImageColor 方法获取图片主要颜色
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(logicDet.bgUrl),
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(logicDet.bgUrl),
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
                      id: SUDefVal.kChatDetList,
                      builder: (logic) {
                        return SUChatListBg(
                          bgColor: bgColor,
                          logic: logic,
                          dataList: logicDet.dataList!,
                          fromDet: true,
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
          logicDet.title,
          bgColor,
          state,
          sendHandle: (value) async {
            var params1 = {
              "inlineSource": {"data": value, "contentType": "text/plain"},
            };
            logicDet.sendMessages(params1, value);
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
