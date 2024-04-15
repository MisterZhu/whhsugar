/// 上传图片
import 'package:dio/dio.dart' as DIO;
import 'package:http_parser/http_parser.dart';
import 'package:sugar/services/su_url.dart';

import 'http_manager.dart';

class SCUploadUtils {
  static uploadHeadPic(
      {required String imagePath,
      Function? successHandler,
      Function? failureHandler}) async {
    List fileList = [];
    String imageName =
        imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
    var file = await DIO.MultipartFile.fromFile(imagePath,
        filename: imageName, contentType: MediaType('image', 'jpeg'));
    fileList.add(file);
    DIO.FormData formData = DIO.FormData.fromMap({'file': fileList});
    HttpManager.instance.post(
        url: SUUrl.kUserHeadUrl,
        params: formData,
        success: (value) {
          successHandler?.call(value);
        },
        failure: (value) {
          failureHandler?.call(value);
        });
  }
}
