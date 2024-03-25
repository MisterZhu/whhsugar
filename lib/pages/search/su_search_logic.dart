import 'dart:convert';

import 'package:get/get.dart';

import 'su_search_state.dart';

class SUSearchLogic extends GetxController {
  // 模拟数据
  List<dynamic> yourData = [
    {
      "name": 'tony1',
      "avatar": 'https://qiniu.aimissu.top/temporary/image39.jpg',
      "info": 'He’s the school bad boy,domisss'
    },
    {
      "name": 'tony2',
      "avatar": 'https://qiniu.aimissu.top/temporary/image34.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony3',
      "avatar": 'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony4',
      "avatar": 'https://qiniu.aimissu.top/temporary/image39.jpg',
      "info": 'He’s the school bad boy,domisss'
    },
    {
      "name": 'tony5',
      "avatar": 'https://qiniu.aimissu.top/temporary/image34.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony6',
      "avatar": 'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony2',
      "avatar": 'https://qiniu.aimissu.top/temporary/image34.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony3',
      "avatar": 'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony4',
      "avatar": 'https://qiniu.aimissu.top/temporary/image39.jpg',
      "info": 'He’s the school bad boy,domisss'
    },
    {
      "name": 'tony5',
      "avatar": 'https://qiniu.aimissu.top/temporary/image34.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony6',
      "avatar": 'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony2',
      "avatar": 'https://qiniu.aimissu.top/temporary/image34.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony3',
      "avatar": 'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony4',
      "avatar": 'https://qiniu.aimissu.top/temporary/image39.jpg',
      "info": 'He’s the school bad boy,domisss'
    },
    {
      "name": 'tony5',
      "avatar": 'https://qiniu.aimissu.top/temporary/image34.jpg',
      "info": 'He’s the school bad boy,miss'
    },
    {
      "name": 'tony6',
      "avatar": 'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
      "info": 'He’s the school bad boy,miss'
    },
  ];

  final SUSearchState state = SUSearchState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {}
}
