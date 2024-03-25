import 'package:sugar/pages/search/view/su_search_item.dart';
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
              title: '搜索资料',
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
          child: Padding(
            padding:
                EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 20.0.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 2.0.w,
                mainAxisSpacing: 2.0.w,
                mainAxisExtent: 160.h, // 设置主轴方向上的item高度
                childAspectRatio: 96 / 160, // 设置子项的宽高比
              ),
              itemCount: logic.yourData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Handle item tap
                    print("Item ${logic.yourData[index]['name']} tapped.");
                  },
                  child: SUSearchItem(logic.yourData[index]),
                );
              },
            ),
          )
          // ListView.builder(
          //   itemCount: logic.yourData.length, // 分组数
          //   itemBuilder: (context, index) {
          //     return SUSearchList(index:index, logic: state,);
          //   },
          // ),
          );
    });
  }
}
