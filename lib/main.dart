import 'package:sugar/services/su_config.dart';
import 'package:sugar/su_app.dart';

import 'constants/su_enum.dart';

void main() {
  SUConfig.env = SUEnvironment.production;
  startApp();
}
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyPageView(),
//     );
//   }
// }
//
// class MyPageView extends StatefulWidget {
//   @override
//   _MyPageViewState createState() => _MyPageViewState();
// }
//
// class _MyPageViewState extends State<MyPageView> {
//   // 控制PageView是否允许滚动，默认为true
//   bool canScroll = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PageView Scroll Control Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // 切换canScroll的值，从而动态改变PageView是否允许滚动
//                 setState(() {
//                   canScroll = !canScroll;
//                 });
//               },
//               child: Text(canScroll ? '禁止滚动' : '允许滚动'),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: PageView(
//                 // 根据canScroll的值选择合适的ScrollPhysics
//                 physics: canScroll
//                     ? AlwaysScrollableScrollPhysics()
//                     : NeverScrollableScrollPhysics(),
//                 children: <Widget>[
//                   Container(
//                     color: Colors.blue,
//                     child: Center(
//                       child: Text(
//                         'Page 1',
//                         style: TextStyle(color: Colors.white, fontSize: 24),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.green,
//                     child: Center(
//                       child: Text(
//                         'Page 2',
//                         style: TextStyle(color: Colors.white, fontSize: 24),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.orange,
//                     child: Center(
//                       child: Text(
//                         'Page 3',
//                         style: TextStyle(color: Colors.white, fontSize: 24),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
