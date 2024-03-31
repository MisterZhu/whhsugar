import 'package:sugar/su_export_comment.dart';

import '../../su_home_logic.dart';
import '../chatted/su_chatted_state.dart';
import '../chatted/view/su_chatted_item.dart';
import 'su_following_logic.dart';

class SUFollowingPage extends StatelessWidget {
  SUFollowingPage({Key? key}) : super(key: key);

  final logic = Get.put(SUFollowingLogic());
  final state = Get.find<SUFollowingLogic>().state;

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
                // 替换成你的聊天数据模型
                // ChatItemModel chatItem = ChatItemModel(
                //   avatarUrl:
                //       'https://qiniu.aimissu.top/common_img/mine_def_head0.jpeg', // 你的头像链接
                //   name: 'Luca $index', // 你的用户名称
                //   lastMessage:
                //       '(Luca sits down on the bed) "sigh" I am so tire...',
                //   lastTime: 'Yesterday 9:40 AM',
                //   isSelect: (index % 2) == 0 ? true : false, // 你的最后一条消息
                // );

                // return SUChattedItem(chatItem);
                return Align(
                  alignment: Alignment.topCenter,
                  child: SUChattedItem(logic.threadData![index], press: () {
                    debugPrint('点击消息列表');
                    SURouterHelper.pathPage(SURouterPath.chatDetPath, null);
                  }),
                );
              },
            );
          }),
    );
  }
}
