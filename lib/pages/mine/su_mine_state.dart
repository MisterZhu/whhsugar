import '../../global/user/user_logic.dart';
import '../../su_export_comment.dart';

class SUMineState {
  var avatar = 'https://qiniu.aimissu.top/temporary/image39.jpg';
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey itemKey = GlobalKey();
  // final UserLogic userLogic = Get.find<UserLogic>();
  final userLogic = Get.put(UserLogic()); // 确保已经初始化 UserLogic

  SUMineState() {
    textEditingController.text = userLogic.user.name?.value ?? '';

    ///Initialize variables
  }
}
