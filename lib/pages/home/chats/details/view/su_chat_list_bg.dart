import 'package:flutter/material.dart';
import 'package:sugar/pages/home/chats/details/view/stop_generation.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_intro_cell.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_mine_cell.dart';
import 'package:sugar/pages/home/chats/details/view/su_chat_other_cell.dart';

import '../../../../../su_export_comment.dart';
import '../../../discover/su_discover_logic.dart';
import '../../../discover/su_discover_model.dart';
import '../../../discover/su_discover_state.dart';
import '../su_details_logic.dart';

class SUChatListBg extends StatelessWidget {
  final String bgColor;
  final SUDiscoverLogic logic; // 替换 YourStateType 为实际的状态类
  final List<SUChatContentModel> dataList;
  final bool fromDet;

  const SUChatListBg({
    Key? key,
    required this.bgColor,
    required this.logic,
    required this.dataList,
    required this.fromDet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SUDetailsLogic detLogic = Get.find<SUDetailsLogic>();
    return Stack(
      fit: StackFit.expand, // 让子组件填充整个Stack的空间
      children: [
        Positioned.fill(
          child: ShaderMask(
            blendMode: BlendMode
                .dstIn, // 显示目标图像，但仅显示两个图像重叠的位置。源图像未呈现，仅被视为蒙版。忽略源的颜色通道，只有不透明度才有效。
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00000000),
                  Color(0xe6000000),
                  Color(0xff000000)
                ],
                stops: [0.0, 0.1, 1.0],
                tileMode: TileMode.repeated,
              ).createShader(bounds);
            },
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          // padding: EdgeInsets.zero,
                          padding: EdgeInsets.only(
                            bottom: ((logic.isStreamLoading.value &&
                                        !logic.isStopGeneration.value) ||
                                    (detLogic.isStreamLoadingDet.value &&
                                        !detLogic.isStopGenerationDet.value))
                                ? 52.0
                                : 12.0,
                          ),
                          reverse: true,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          // physics: const ClampingScrollPhysics(),
                          controller: logic.state.scrollController,
                          itemCount: dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index >= (dataList.length ?? 0)) {
                              return SizedBox.fromSize();
                            }
                            // SUMessageModel chatModel =
                            //     logic.assistantModel.metadata!.messages![index];
                            SUChatContentModel chatModel = dataList[index];
                            // debugPrint(
                            //     '--chatModel = ${chatModel.inlineSource?.data ?? ''}');
                            if (chatModel.type == SUChatType.intro) {
                              // debugPrint('--介绍 = ');
                              return SUChatIntroCell(chatModel);
                            } else if (chatModel.type == SUChatType.mine) {
                              // debugPrint('--我的 = ');

                              return SUChatMineCell(chatModel);
                            } else {
                              // debugPrint('--对方 = ');
                              return SUChatOtherCell(chatModel);
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 12.0, // 距离底部的间距
          child: Align(
            alignment: Alignment.bottomCenter,
            child: fromDet ? detStopWidget(detLogic) : disStopWidget(logic),
          ),
        ),
        Align(
          // 使用Align将bottomWidget定位到底部
          alignment: Alignment.bottomCenter,
          child: gradientWidget(bgColor),
        ),
        Align(
          // 使用Align将bottomWidget定位到底部
          alignment: Alignment.bottomCenter,
          child: lineWidget(bgColor),
        ),
      ],
    );
  }

  Widget detStopWidget(SUDetailsLogic login) {
    return Obx(() {
      if (login.isStreamLoadingDet.value && !login.isStopGenerationDet.value) {
        return const StopGeneration();
      } else {
        return const SizedBox();
      }
    });
  }

  Widget disStopWidget(SUDiscoverLogic login) {
    return Obx(() {
      if (login.isStreamLoading.value && !login.isStopGeneration.value) {
        return const StopGeneration();
      } else {
        return const SizedBox();
      }
    });
  }

  Widget gradientWidget(String bgColor) {
    if (bgColor == '') {
      bgColor = SUDefVal.defBgColor;
    }
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

  Widget lineWidget(String bgColor) {
    if (bgColor == '') {
      bgColor = SUDefVal.defBgColor;
    }
    return GetBuilder<SUDiscoverLogic>(
      id: SUDefVal.kChatBottom,
      builder: (state) {
        return Container(
          width: 375.w,
          height: 2.w,
          decoration: BoxDecoration(
              color: Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
              border: Border.all(
                  width: 0,
                  color: Color(int.parse(bgColor.replaceAll('#', '0xFF'))))),
        );
      },
    );
  }
}
