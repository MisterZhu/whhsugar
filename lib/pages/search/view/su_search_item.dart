import 'package:sugar/su_export_comment.dart';

import '../../home/discover/su_discover_model.dart';

class SUSearchItem extends StatelessWidget {
  final SUAssistantModel? model;

  const SUSearchItem(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _rowListItem(),
    );
  }

  Widget _rowListItem() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: 96.w, // 卡片宽度
        height: 160.h,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(8.0), // 添加圆角
        // ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                // 使用ClipRRect裁剪图片以显示圆角
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  model?.metadata?.avatar ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // width: 96.w, // 卡片宽度
                // height: 54.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00000000),
                      Color(0xBF212125),
                      Color(0xF2292A2E),
                    ],
                    stops: [0.0, 0.4, 1],
                  ),
                ),
                padding: EdgeInsets.only(
                    top: 5.w, left: 10.w, right: 10.w, bottom: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        model?.displayName ?? '',
                        style: TextStyle(
                          color: SUColorSingleton().textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      model?.description ?? '',
                      style: TextStyle(
                        color: SUColorSingleton().textDEColor,
                        fontSize: 10.0.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
