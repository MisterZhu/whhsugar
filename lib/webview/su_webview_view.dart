import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:x5_webview/x5_webview.dart';

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
    if (!logic.needBack) {
      return const SizedBox(width: 24, height: 44);
    }
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
                  Assets.commonBackIcon,
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

  Widget _body() {
    return WebViewWidget(controller: logic.controller);
  }

  /// body
  // Widget _body() {
  //   return Platform.isIOS
  //       ? WebViewWidget(controller: logic.controller)
  //       : X5WebView(
  //           url:
  //               "https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=sugar",
  //           javaScriptEnabled: true,
  //           header: {"TestHeader": "测试"},
  //           userAgentString: "my_ua",
  //           //Url拦截，传null不会拦截会自动跳转
  //           onUrlLoading: (willLoadUrl) {
  //             // _controller.loadUrl(willLoadUrl);
  //           }
  //           //     onWebViewCreated: (control) {
  //           //   _controller = control;
  //           // },
  //           // onPageFinished: () async {
  //           // var url = await _controller.currentUrl();
  //           // print(url);
  //           // var body = await _controller
  //           //     .evaluateJavascript('document.body.innerHTML');
  //           // print(body);
  //           // },
  //           );
  // }

  // Widget _body() {
  //   return InAppWebView(
  //     initialUrlRequest: URLRequest(
  //       url: WebUri(
  //           'https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=sugar'),
  //     ),
  //     initialSettings: InAppWebViewSettings(
  //       mediaPlaybackRequiresUserGesture: false,
  //       useHybridComposition: true,
  //       allowsInlineMediaPlayback: true,
  //     ),
  //     onLoadStop: (controller, url) async {},
  //   );
  // }
}
