import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../routes/su_router_helper.dart';
import '../../../widgets/loading/loading_util.dart';
import 'feedback_state.dart';

class FeedbackLogic extends GetxController {
  final FeedbackState state = FeedbackState();

  /// 提交反馈
  feedbackRequest() {
    if (state.inputController.text.isEmpty) {
      LoadingUtil.info(text: '请输入反馈内容');
      return;
    }
    LoadingUtil.show();
    Future.delayed(Duration(seconds: 1), () async {
      LoadingUtil.hide();
      LoadingUtil.success(text: "反馈提交成功");
      SURouterHelper.back(null);
    });

    // TBLoadingUtils.show();
    // TBUtils.getCurrentContext(completionHandler: (context) async {
    //   TBHttpResponse response = await TBHttpRequest.post(
    //       TBUrl.kIssuesUrl, context,
    //       params: {"type": "report", "content": state.inputController.text})
    //   as TBHttpResponse;
    //   if (response.code == 0) {
    //     TBLoadingUtils.hide();
    //     TBLoadingUtils.success(text: "反馈提交成功");
    //     TBRouterHelper.back(null);
    //   } else {
    //     TBLoadingUtils.hide();
    //   }
    // });
  }
}
