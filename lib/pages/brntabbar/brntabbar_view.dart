import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'brntabbar_logic.dart';

// class BrntabbarPage extends StatelessWidget {
//   BrntabbarPage({Key? key}) : super(key: key);
//
//   final logic = Get.put(BrntabbarLogic());
//   final state = Get.find<BrntabbarLogic>().state;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<BadgeTab> tabs = [
      BadgeTab(text: "需求", topText: '1'),
      BadgeTab(text: "需求", topText: '2'),
      BadgeTab(text: "需求", topText: '3'),
      BadgeTab(text: "需求", topText: '4'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("BrnTabBar Example"),
      ),
      body: Column(
        children: [
          BrnTabBar(
            controller: tabController,
            tabs: tabs,
            hasIndex: true,
            hasDivider: true,
            onTap: (state, index) {
              tabController.animateTo(index); // 切换页面
            },
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Center(child: Text("页面 1")),
                Center(child: Text("页面 2")),
                Center(child: Text("页面 3")),
                Center(child: Text("页面 4")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
