import 'package:sugar/pages/search/view/su_search_item.dart';
import 'package:sugar/skin/su_search_bar.dart';

import '../../su_export_comment.dart';
import '../home/discover/su_discover_model.dart';
import '../mine/su_mine_logic.dart';
import 'su_search_logic.dart';

class SUSearchPage extends StatelessWidget {
  SUSearchPage({Key? key}) : super(key: key);

  final searchLogic = Get.put(SUSearchLogic());
  @override
  // Widget build(BuildContext context) {
  //   return listView();
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SUSearchLogic>(
        id: SUDefVal.kChatInput,
        builder: (logic) {
          return Scaffold(
              appBar: SUCustomSearchBar(
                context,
                onTextChanged: (value) {
                  logic.filtrateAssistantsList(value);
                },
              ),
              // navBackgroundColor: SUColorSingleton().bgBotColor,
              body: body(context));
        });
  }

  Widget body(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // 在点击空白处时收起键盘
          FocusScope.of(context).unfocus();
        },
        child: listView(context));
  }

  Widget listView(BuildContext context) {
    return GetBuilder<SUSearchLogic>(builder: (state) {
      if (state.isSearch) {
        if (state.searchData == null || state.searchData!.isEmpty) {
          // 搜索结果为空时显示占位页面
          return _buildEmptyPlaceholder('No search results found'.tr);
        } else {
          // 显示搜索结果列表
          return _buildGridView(state.searchData!);
        }
      } else {
        if (state.dataSource == null || state.dataSource!.isEmpty) {
          // 数据源为空时显示占位页面
          return _buildEmptyPlaceholder('No data available'.tr);
        } else {
          // 显示数据源列表
          return _buildGridView(state.dataSource!);
        }
      }
    });
  }

  Widget _buildEmptyPlaceholder(String message) {
    return Container(
      color: SUColorSingleton().bgBotColor,
      child: Center(
        child: Texts.custom(message,
            fontSize: 16.sp, color: SUColorSingleton().textColor),
      ),
    );
  }

  Widget _buildGridView(List<SUAssistantModel> items) {
    return Container(
      color: SUColorSingleton().bgBotColor,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 20.0.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            crossAxisSpacing: 2.0.w,
            mainAxisSpacing: 2.0.w,
            mainAxisExtent: 160.h, // 设置主轴方向上的item高度
            childAspectRatio: 96 / 160, // 设置子项的宽高比
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // Handle item tap
              },
              child: SUSearchItem(items[index]),
            );
          },
        ),
        //         // ListView.builder(
        //         //   itemCount: logic.yourData.length, // 分组数
        //         //   itemBuilder: (context, index) {
        //         //     return SUSearchList(index:index, logic: state,);
        //         //   },
        //         // ),
        //         );
      ),
    );
  }
}
