import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'su_chat_det_logic.dart';

class SUChatDetPage extends StatelessWidget {
  SUChatDetPage({Key? key}) : super(key: key);

  final logic = Get.put(SUChatDetLogic());
  final state = Get.find<SUChatDetLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
