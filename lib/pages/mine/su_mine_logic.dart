import 'package:bruno/bruno.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sugar/pages/mine/view/su_sex_select_view.dart';

import '../../services/sc_upload_utils.dart';
import '../../su_export_comment.dart';
import 'su_mine_state.dart';

class SUMineLogic extends GetxController {
  final SUMineState state = SUMineState();
  ImagePicker _picker = ImagePicker();
  late int selectSex = 0;

  ///-------------------------------修改性别弹框-------------------------------
  void showPopup() {
    BuildContext context = Get.context!;
    // // BrnPopupListWindow.showPopListWindow(context, state.itemKey);
    // BrnPopupListWindow.showPopListWindow(context, state.itemKey,
    //     data: ['选项一', '选项二', '选项三'], onItemClick: (index, item) {
    //   BrnToast.show(item, context);
    //   return false;
    // });
    BrnPopupWindow.showPopWindow(
      context,
      "",
      state.itemKey,
      hasCloseIcon: true,
      dismissCallback: () {},
      backgroundColor: SCColors.color_454545,
      offset: 10.w,
      arrowOffset: -74.w,
      paddingInsets:
          const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      widget: GetBuilder<SUMineLogic>(
          id: SUDefVal.kChatInput,
          builder: (context) {
            return SUSexSelectView(
              context,
              selectSex,
              sendHandle: (value) async {
                // 列表滑到底部
                debugPrint('选择性别：$value');
                selectSex = value;
                update([SUDefVal.kMineFilePage]);
              },
            );
          }),
    );
  }

  ///-------------------------------选择照片-------------------------------

  showSelectImage(BuildContext context) {
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(BrnCommonActionSheetItem(
      '拍照',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    actions.add(BrnCommonActionSheetItem(
      '相册中选取',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BrnCommonActionSheet(
            actions: actions,
            cancelTitle: "取消",
            clickCallBack: (int index, BrnCommonActionSheetItem actionEle) {
              // if (index == 0) {
              //   _picker.pickImage(source: ImageSource.camera);
              // } else {
              //   _picker.pickImage(source: ImageSource.gallery);
              // }
              if (index == 0) {
                _pickImage(ImageSource.camera);
              } else {
                _pickImage(ImageSource.gallery);
              }
            },
          );
        });
  }

  ///-------------------------------Network Request-------------------------------

  Future<void> _pickImage(ImageSource source) async {
    final XFile? imageFile = await _picker.pickImage(source: source);
    String imagePath = imageFile?.path ?? '';

    debugPrint('选择图片路径imagePath：$imagePath');

    // if (imagePath != '' && imagePath.isNotEmpty) {
    //   LoadingUtil.show();
    //   SCUploadUtils.uploadHeadPic(
    //       imagePath: imagePath,
    //       successHandler: (value) {
    //         LoadingUtil.hide();
    //         Map<String, dynamic> data = value['data'];
    //         String avatarUrl = data['data'];
    //         print('------------------------data : $avatarUrl');
    //         if (avatarUrl != null && avatarUrl.isNotEmpty) {
    //           //_saveUserAvatar(avatarUrl);
    //         }
    //       },
    //       failureHandler: (value) {
    //         LoadingUtil.hide();
    //         LoadingUtil.failure(text: value['msg']);
    //       });
    // }
  }
  // Future<void> _saveUserAvatar(String avatarUrl) async {
  //   UserInfoProvider userInfo =
  //   Provider.of<UserInfoProvider>(context, listen: false);
  //
  //   var params = {
  //     "params": {
  //       "user": {
  //         "account": userInfo.account,
  //         "name": userInfo.name,
  //         "avatar": avatarUrl,
  //         "intro": userInfo.intro,
  //       },
  //     },
  //     "authorization": {
  //       "token": userInfo.token,
  //       "uid": userInfo.uuid,
  //     },
  //   };
  //   print('--------------CreateSession--begin');
  //   await SCHttpManager.instance.post(
  //       url: TBUrl.kSaveIntroUrl,
  //       params: params,
  //       success: (value) {
  //         Map<String, dynamic> data = value['data'];
  //         data["token"] = userInfo.token;
  //         userInfo.login(data, isLocalSave: true);
  //         TBLoadingUtils.success(text: value['msg']);
  //       },
  //       failure: (err) {
  //         TBLoadingUtils.failure(text: err['msg']);
  //       });
  // }
}
