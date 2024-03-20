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
    return Container(
      color: SUColorSingleton().bgBotColor,
      child: ListView.builder(
        itemCount: yourData.length, // 分组数
        itemBuilder: (context, index) {
          return rowItem(index);
        },
      ),
    );
  }

  Widget rowItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowHeader(index),
        rowListView(index),
      ],
    );
  }

  Widget rowHeader(int index) {
    return Padding(
      padding:
          EdgeInsets.only(top: 24.0.w, left: 20.w, right: 20.w, bottom: 10.w),
      child: Text(
        'Group ${index + 1}',
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: SUColorSingleton().textColor),
      ),
    );
  }

  Widget rowListView(int index) {
    return Container(
      height: 200, // 卡片高度
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: yourData[index].length, // 每组中卡片数量
        itemBuilder: (context, cardIndex) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Card(
              child: Container(
                width: 150, // 卡片宽度
                color: Colors.grey,
                child: Center(
                  child: Text(yourData[index][cardIndex]), // 根据数据显示内容
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 模拟数据
List<List<String>> yourData = [
  [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
    'Card 6',
    'Card 7'
  ], // 第一组数据
  [
    'Card 5',
    'Card 6',
    'Card 7',
    'Card 8',
    'Card 9',
    'Card 10',
    'Card 11',
    'Card 12'
  ], // 第二组数据
  [
    'Card 8',
    'Card 9',
    'Card 10',
    'Card 11',
    'Card 12',
    'Card 8',
    'Card 9',
    'Card 10',
    'Card 11',
    'Card 12'
  ],
  [
    'Card 51',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
    'Card 6',
    'Card 7'
  ], // 第一组数据
  [
    'Card 35',
    'Card 6',
    'Card 7',
    'Card 8',
    'Card 9',
    'Card 10',
    'Card 11',
    'Card 12'
  ], // 第二组数据
  [
    'Card 48',
    'Card 9',
    'Card 10',
    'Card 11',
    'Card 12',
    'Card 8',
    'Card 9',
    'Card 10',
    'Card 11',
    'Card 12'
  ], // 第三组数据
  // 其他组数据
];
