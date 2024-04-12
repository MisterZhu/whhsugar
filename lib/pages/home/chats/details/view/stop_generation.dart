import '../../../../../su_export_comment.dart';
import '../../../discover/su_discover_logic.dart';
import '../su_details_logic.dart';

class StopGeneration extends StatelessWidget {
  const StopGeneration({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final SUDiscoverLogic disLogic = Get.find<SUDiscoverLogic>();
        final SUDetailsLogic detLogic = Get.find<SUDetailsLogic>();
        if (!disLogic.isStopGeneration.value) {
          disLogic.isStopGeneration.value = true;
          disLogic.isStreamLoading.value = false;
        }
        if (!detLogic.isStopGenerationDet.value) {
          detLogic.isStopGenerationDet.value = true;
          detLogic.isStreamLoadingDet.value = false;
        }
      },
      child: Container(
        width: SUUtils.isChineseLan() ? 106.w : 146.w,
        height: 28.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(14.r))),
        child: Row(
          children: [
            SizedBox(
              width: 12.w,
            ),
            Image.asset(
              Assets.chatChatDetailStop,
              width: 12.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'Stop generation…'.tr,
              style: TextStyle(fontSize: 12.sp, color: SCColors.color_6B6B6B),
            )
          ],
        ),
      ),
    );
  }
}
