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
            return ListView.builder(
              padding: EdgeInsets.zero, // 设置顶部间距为零
              itemCount: logic.threadData?.length ?? 0, // 你的聊天列表项数量
              itemBuilder: (context, index) {
                final model = logic.threadData![index];
                return Align(
                  alignment: Alignment.topCenter,
                  child: SUChattedItem(model, press: () {
                    debugPrint('点击消息列表');
                    var params = {
                      "title": model.assistantName,
                      "name": model.name,
                      "backgroundImage": model.backgroundImage
                    };
                    SURouterHelper.pathPage(SURouterPath.chatDetPath, params);
                  }),
                );
              },
            );
          }),
    );
  }
}
