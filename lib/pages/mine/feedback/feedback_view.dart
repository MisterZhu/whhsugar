import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/su_router_helper.dart';
import '../../../skin/su_custom_scaffold.dart';
import '../../../utils/colors/su_color_singleton.dart';
import 'feedback_logic.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({Key? key}) : super(key: key);

  final logic = Get.put(FeedbackLogic());
  final state = Get.find<FeedbackLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SUCustomScaffold(
        title: '反馈',
        navBackgroundColor: SUColorSingleton().bgBotColor,
        body: buildGestureDetector(context));
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击页面其他地方，隐藏键盘
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '感谢您对Sugar的使用，您提出的宝贵建议，我们将在3个工作日内进行处理！',
                style: TextStyle(
                    fontSize: 16.0.sp,
                    // fontWeight: FontWeight.bold,
                    color: SUColorSingleton().textColor),
              ),
              SizedBox(height: 16.0),
              Text(
                '请在下方描述您的建议或问题：',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Container(
                padding:
                    EdgeInsets.all(10.0), // Optional padding for the border
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Customize border color
                    width: 1.0, // Customize border width
                  ),
                  borderRadius:
                      BorderRadius.circular(5.0), // Customize border radius
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 100.0, // Set the minimum height
                    maxHeight: 100.0, // Set the maximum height
                  ),
                  child: TextField(
                    controller: state.inputController,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                      hintText: '请输入您的反馈意见...',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26.0),
              ElevatedButton(
                onPressed: () {
                  print(state.inputController.text);
                  logic.feedbackRequest();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SUColorSingleton().saveBtnBgColor, // 设置背景色
                  fixedSize: Size.fromHeight(45),
                  // 设置按钮的高度
                ),
                child: Text(
                  '提交',
                  style: TextStyle(
                      fontSize: 16.0.sp,
                      color: SUColorSingleton().textColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(
      color: SUColorSingleton().textDEColor,
    ),
  );
}
