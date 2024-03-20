import 'package:get/get.dart';

import 'su_search_state.dart';

class SUSearchLogic extends GetxController {
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

  final SUSearchState state = SUSearchState();
}
