import 'package:sugar/pages/search/view/su_search_list.dart';

import '../../su_export_comment.dart';
import '../mine/su_mine_logic.dart';
import 'su_search_logic.dart';

class SUSearchPage extends StatelessWidget {
  SUSearchPage({Key? key}) : super(key: key);

  final logic = Get.put(SUSearchLogic());
  final state = Get.find<SUSearchLogic>().state;
  @override
  // Widget build(BuildContext context) {
  //   return listView();
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SUMineLogic>(
        id: SUDefVal.kChatInput,
        builder: (logic) {
          return SUCustomScaffold(
              title: '我的资料',
              navBackgroundColor: SUColorSingleton().bgBotColor,
              body: body(context));
        });
  }

  Widget body(BuildContext context) {
    return listView(context);
  }
  Widget listView(BuildContext context) {
    return GetBuilder<SUSearchLogic>(builder: (state) {
      return Container(
        color: SUColorSingleton().bgBotColor,
        child: ListView.builder(
          itemCount: logic.yourData.length, // 分组数
          itemBuilder: (context, index) {
            return SUSearchList(index:index, logic: state,);
          },
        ),
      );
    });
  }
}

