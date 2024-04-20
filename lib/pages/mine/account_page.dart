import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../constants/su_default_value.dart';
import '../../global/db/daos/chat_content_dao.dart';
import '../../global/db/daos/session_list_dao.dart';
import '../../global/db/database_helper.dart';
import '../../routes/su_router_helper.dart';
import '../../routes/su_router_path.dart';
import '../../services/su_url.dart';
import '../../skin/su_custom_scaffold.dart';
import '../../utils/colors/su_color_singleton.dart';
import '../../utils/shared_preference_util.dart';
import '../../widgets/loading/loading_util.dart';

class AccountPage extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  cancellationRequest(BuildContext context) async {
    if (_textEditingController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please fill in the reason for cancellation'.tr);
      return;
    }
    LoadingUtil.show();
    Future.delayed(Duration(seconds: 1), () async {
      LoadingUtil.hide();

      await SharedPreferenceUtil().removeData(SUDefVal.kToken);
      final sessionListDao = SessionListDao(DatabaseHelper.instance.database);
      await sessionListDao.deleteAll();
      final chatContentDao = ChatContentDao(DatabaseHelper.instance.database);
      await chatContentDao.deleteAll();
      Fluttertoast.showToast(
          msg: 'Cancellation successful'.tr, gravity: ToastGravity.CENTER);

      var params = {
        "title": '登录',
        "url": SUUrl.kLoginWebUrl,
        "need_back": false
      };
      // SURouterHelper.pathPage(SURouterPath.webViewPath, params);
      SURouterHelper.pathOffAllPage(SURouterPath.webViewPath, params);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SUCustomScaffold(
        title: '账户',
        navBackgroundColor: SUColorSingleton().bgBotColor,
        // actions: [
        //   TextButton(
        //     child: Text(
        //       'Save',
        //       style: TextStyle(
        //         fontSize: 16.0.sp,
        //         color: SUColorSingleton().saveBtnBgColor,
        //       ),
        //     ),
        //     onPressed: () {
        //       SURouterHelper.back(null);
        //     },
        //   ),
        // ],
        body: buildCenterWidget(context));
  }

  Center buildCenterWidget(BuildContext context) {
    return Center(
      child: Container(
        color: SUColorSingleton().textColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 155.w + MediaQuery.of(context).padding.top,
            ),
            Padding(
              padding: EdgeInsets.all(15.r),
              child: Text(
                'Logout warning prompt'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: SUColorSingleton().bgTopColor),
              ),
            ),
            SizedBox(
              height: 55.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              'Account cancellation'.tr,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          content: Container(
                            height: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Are you sure to cancel your account?'.tr),
                                SizedBox(
                                  height: 20.w,
                                ),
                                Container(
                                  height: 100.w,
                                  child: TextField(
                                      // minLines: 1,
                                      maxLines: 10,
                                      controller: _textEditingController,
                                      onSubmitted: (value) {
                                        // searchHandle(userInfo.isLogin, value);
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Write your message'.tr,
                                        hintStyle: TextStyle(
                                            color: Color(0xffD4D4D4),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.r)),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1, //宽度为5
                                            )),
                                      )),
                                )
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Cancel'.tr)),
                            TextButton(
                                onPressed: () async {
                                  cancellationRequest(context);
                                },
                                child: Text(
                                  'Confirm'.tr,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        );
                      });
                },
                child: Container(
                  height: 46.w,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: SUColorSingleton().saveBtnBgColor),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'Account cancellation'.tr,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            backgroundColor: SUColorSingleton().saveBtnBgColor,
                            color: Colors.white),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
