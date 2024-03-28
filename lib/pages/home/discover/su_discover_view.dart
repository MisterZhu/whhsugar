import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:sugar/pages/home/discover/su_discover_model.dart';
import 'package:sugar/pages/home/discover/su_discover_state.dart';
import 'package:sugar/pages/home/su_home_logic.dart';
import 'package:sugar/su_export_comment.dart';

import '../chats/details/su_details_logic.dart';
import '../chats/details/view/su_chat_bottom.dart';
import '../chats/details/view/su_chat_intro_cell.dart';
import '../chats/details/view/su_chat_list_bg.dart';
import '../chats/details/view/su_chat_mine_cell.dart';
import '../chats/details/view/su_chat_other_cell.dart';
import '../chats/details/view/su_chat_tip.dart';
import 'su_discover_logic.dart';

class SUDiscoverPage extends StatelessWidget {
  SUDiscoverPage({Key? key}) : super(key: key);

  final logic = Get.put(SUDiscoverLogic());
  final logicDet = Get.put(SUDetailsLogic());
  final logicHome = Get.find<SUHomeLogic>();

  final state = Get.find<SUDiscoverLogic>().state;

  // void initWidget() {
  //   logic.currentIndex = logic.pageController.initialPage;
  //
  //   // 准备新的数据源
  //   logic.childrenView = [];
  //   final context = Get.context;
  //   for (int i = 0; i < logic.imageUrls.length; i++) {
  //     logic.childrenView.add(buildPage(
  //       context!,
  //       'Page ${i + 1}',
  //       Colors.white,
  //       logic.imageUrls[i],
  //     ));
  //   }
  //   logic.childrenView.insert(0, logic.childrenView.last);
  //   logic.childrenView.add(logic.childrenView[1]);
  //   logic.update([SUDefVal.kDiscover]);
  //   debugPrint('-------logic.childrenView:${logic.childrenView.length}');
  // }

  @override
  Widget build(BuildContext context) {
    // initWidget();
    // state.pageController.addListener(() {
    //   int currentPage = state.pageController.page?.round() ?? 0;
    //   print('~~~~~~~~~~~~~~~~~~~Current Page: $currentPage');
    // });
    return
        // GestureDetector(
        // onHorizontalDragUpdate: (details) {
        //   // Handle horizontal swipe gestures
        //   // You can implement your logic here
        //   if (details.primaryDelta! > 0) {
        //     // Swipe to the right
        //     state.pageController.previousPage(
        //       duration: const Duration(milliseconds: 300),
        //       curve: Curves.easeInOut,
        //     );
        //     print("--------------------1111-object${details.primaryDelta}");
        //   } else if (details.primaryDelta! < 0) {
        //     // Swipe to the left
        //     state.pageController.nextPage(
        //       duration: const Duration(milliseconds: 300),
        //       curve: Curves.easeInOut,
        //     );
        //     print("--------------------22222-object${details.primaryDelta}");
        //   }
        // },
        // child:
        GetBuilder<SUDiscoverLogic>(
            id: SUDefVal.kDiscover,
            builder: (logic) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Obx(() => Swiper(
                          autoplay: false,
                          itemCount: logicHome.dataSource?.length ?? 0,
                          viewportFraction: 1.0,
                          scale: 1.0,
                          loop: true,
                          onIndexChanged: (int index) {
                            debugPrint('Swiper scrolled to page $index');
                          },
                          physics: logic.canSlide.value
                              ? AlwaysScrollableScrollPhysics()
                              : NeverScrollableScrollPhysics(),
                          controller: SwiperController(),
                          itemBuilder: (BuildContext context, int index) {
                            return buildPage(
                                context, index, logicHome.dataSource![index]);
                          },
                        )),
                    // Obx(() => PageView(
                    //       physics: logic.canSlide.value
                    //           ? AlwaysScrollableScrollPhysics()
                    //           : NeverScrollableScrollPhysics(),
                    //       controller: logic.pageController,
                    //       onPageChanged: logic.onPageChanged,
                    //       children: logic.childrenView,
                    //     )),
                  ),
                ],
              );
            });
    // );
  }

  Widget buildPage(BuildContext context, int index, SUAssistantModel model) {
    debugPrint('-------------buildPage');
    return FutureBuilder<String>(
      future: logicDet.getImageColor(model.metadata?.backgroundColor ?? '',
          model.metadata?.backgroundImage ?? ''), // 调用 getImageColor 方法获取图片主要颜色
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return discoverWidget(
              context, model, model.metadata?.backgroundColor ?? '');
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final String bgColor = snapshot.data!;
          model.metadata?.backgroundColor = bgColor;
          logicHome.dataSource![index] = model;
          logic.state.defColor = bgColor;
          return discoverWidget(context, model, bgColor);
        }
      },
    );
  }

  Widget discoverWidget(
      BuildContext context, SUAssistantModel model, String bgColor) {
    return GestureDetector(
      onTap: () {
        // 在点击空白处时收起键盘
        FocusScope.of(context).unfocus();
      },
      child: Container(
        // color: Color(int.parse(bgColor.replaceAll('#', '0xFF'))),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                model.metadata?.backgroundImage ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        child: GetBuilder<SUDiscoverLogic>(
          id: SUDefVal.kChatInput,
          builder: (state) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      model.metadata?.backgroundImage ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 308.h,
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
                          bgColor: model.metadata?.backgroundColor ?? '',
                          logic: logic,
                        );
                      },
                    ),
                  ),
                  bottomWidget(model.metadata?.backgroundColor ?? '',
                      model?.displayName ?? '', model),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bottomWidget(String bgColor, String title, SUAssistantModel model) {
    if (bgColor == '') {
      bgColor = SUDefVal.defBgColor;
    }
    return GetBuilder<SUDiscoverLogic>(
      id: SUDefVal.kChatBottom,
      builder: (state) {
        return SUChatBottom(
          title,
          bgColor,
          state,
          sendHandle: (value) async {
            // 列表滑到底部
            // searchRequest(value);
            var params = {
              "assistant": model.name,
              "displayName": value,
              "description": value,
            };
            logic.createThreads(params);
          },
          // backgroundColor: Color(int.parse(backgroundColor.replaceAll('#', '0xFF'))), // 使用颜色字符串设置背景色
        );
      },
    );
  }
}
