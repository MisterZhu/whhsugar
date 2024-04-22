import 'package:sugar/pages/home/chats/chatted/su_chatted_state.dart';
import 'package:sugar/pages/home/chats/chatted/view/su_chatted_item.dart';
import 'package:sugar/su_export_comment.dart';

import '../../su_home_logic.dart';
import 'su_chatted_logic.dart';

class SUChattedPage extends StatelessWidget {
  SUChattedPage({Key? key}) : super(key: key);

  final logic = Get.put(SUChattedLogic());
  final state = Get.find<SUChattedLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.w),
      child: GetBuilder<SUHomeLogic>(
        id: SUDefVal.kChatted,
        builder: (logic) {
          if (logic.threadData?.isEmpty ?? true) {
            // 如果列表为空，显示占位页面
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Texts.normal(
                    'No chat Tips'.tr,
                    maxLines: 2,
                    color: SUColorSingleton().textColor,
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        SUColorSingleton().saveBtnBgColor, // 设置背景色为黑色
                  ),
                  onPressed: () {
                    // 点击按钮事件，跳转去搜索
                    // 可根据需要处理跳转逻辑
                    SURouterHelper.pathPage(SURouterPath.searchPath, null);
                  },
                  child: Texts.normal(
                    'Go to Search'.tr,
                    maxLines: 1,
                    color: SUColorSingleton().textColor,
                  ),
                ),
              ],
            );
          } else {
            // 如果列表有数据，显示聊天记录列表
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: logic.threadData!.length,
              itemBuilder: (context, index) {
                final model = logic.threadData![index];
                return Align(
                  alignment: Alignment.topCenter,
                  child: SUChattedItem(model, press: () {
                    debugPrint('点击消息列表');
                    var params = {
                      "title": model.assistantName,
                      "name": model.name,
                      "backgroundImage": model.backgroundImage,
                      "assistantName": ''
                    };
                    SURouterHelper.pathPage(SURouterPath.chatDetPath, params);
                  }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
