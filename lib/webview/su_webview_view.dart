import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../su_export_comment.dart';
import 'su_webview_logic.dart';

class SUWebviewPage extends StatelessWidget {
  SUWebviewPage({Key? key}) : super(key: key);

  final logic = Get.put(SUWebviewLogic());
  @override
  Widget build(BuildContext context) {
    return SUCustomScaffold(
      leading: _leading(),
      leadingWidth: 100,
      body: _body(),
      centerTitle: true,
      showBackIcon: true,
      showBackgroundImage: false,
      title: '',
      navBackgroundColor: Colors.white,
    );
  }

  /// leading
  Widget _leading() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 24,
            height: 44,
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 44.0,
                child: Image.asset(
                  "assets/images/common/common_back_icon.png",
                  width: 24.0,
                  height: 24.0,
                ),
                onPressed: () {
                  logic.goBack();
                }),
          ),
        ],
      ),
    );
  }

  /// body
  Widget _body() {
    return WebViewWidget(controller: logic.controller);
  }
}
