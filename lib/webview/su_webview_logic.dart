import 'package:sugar/webview/sc_string_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../su_export_comment.dart';

class SUWebviewLogic extends GetxController {
  late WebViewController controller;

  /// webView title
  String title = "";
  bool needBack = false;

  /// webView url
  String url = "";
  void initController(WebViewController webViewController) {
    controller = webViewController;
  }

  @override
  void onInit() {
    super.onInit();
    dynamic params = Get.arguments;
    debugPrint('webView接收的参数：$params');
    url = StringUtils.isNotNullOrEmpty(params?["url"])
        ? params!["url"]
        : SUUrl.kLoginWebUrl;
    needBack = params?["need_back"] ?? false;
    title = params?["title"] ?? '';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          debugPrint('--------------------onProgress: $progress');
        },
        onPageStarted: (String url) {
          debugPrint('--------------------onPageStarted: ');
        },
        onPageFinished: (String url) {
          debugPrint('--------------------onPageFinished: ');
          // hideScrollBars();
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('--------------------WebResourceError: ');
        },
        onNavigationRequest: (request) {
          debugPrint(
              '------------------------------拦截 webView URL：${request.url}');
          // 检查URL中是否包含需要的参数
          if (request.url.contains('localhost:9000/callback')) {
            // 解析URL中的参数
            Uri uri = Uri.parse(request.url);
            String? code = uri.queryParameters['code'];
            String? state = uri.queryParameters['state'];

            // 判断code是否有值
            if (code != null &&
                code.isNotEmpty &&
                state != null &&
                state.isNotEmpty) {
              // 在这里处理code有值的情况
              debugPrint('--------------------拦截到的code参数: $code');
              var params = {
                "code": code,
                "state": state,
              };
              if (needBack) {
                bus.emit(SUDefVal.kWebBlockCode, params);
                SURouterHelper.back(null);
              } else {
                SURouterHelper.pathOffAllPage(SURouterPath.home, params);
              }

              // 返回NavigationDecision.prevent表示拦截请求
              return NavigationDecision.prevent;
            }
          }
          return NavigationDecision.navigate;
        },
      ));
    // super.initState();
  }
  //
  // void hideScrollBars() async {
  //   // 使用JavaScript来隐藏滚动条
  //   await controller.evaluateJavascript('''
  //     document.body.style.overflowX = 'hidden';
  //     document.body.style.overflowY = 'hidden';
  //   ''');
  // }

  // 后退
  goBack() async {
    if (controller == null) {
      SURouterHelper.back(null);
      return;
    }
    bool goBack = await controller!.canGoBack();
    if (goBack) {
      controller!.goBack();
    } else {
      SURouterHelper.back(null);
    }
  }
}
