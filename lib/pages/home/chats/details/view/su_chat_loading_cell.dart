import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../su_export_comment.dart';

class SUChatLoadingCell extends StatelessWidget {
  SUChatLoadingCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SpinKitWave(
              color: Color(0xffFF98AC),
              size: 15.0.r,
              itemCount: 6,
            ),
            SizedBox(
              height: 6.w,
            ),
            Text(
              'Thinking, please wait a moment'.tr,
              style: TextStyle(color: Color(0xff6B6B6B), fontSize: 12.sp),
            )
          ],
        ),
      ),
    );
  }
}
