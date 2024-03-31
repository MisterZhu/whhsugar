import '../../../../../su_export_comment.dart';
import '../../../discover/su_discover_model.dart';

class SUChattedItem extends StatelessWidget {
  final SUSessionModel? model;
  final Function()? press;

  const SUChattedItem(this.model, {this.press, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: model?.isSelect ?? false
            ? const Color(0xFFFFFFFF).withOpacity(0.1)
            : Colors.transparent, // 背景色为白色，透明度为10%
      ),
      child: InkWell(
        onTap: press,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 23.0.w, // 设置头像大小
                    // backgroundImage: NetworkImage(model!.avatarUrl),
                    backgroundImage: NetworkImage(model?.assistant ?? ''),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            model?.name ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: SUColorSingleton().textColor,
                                fontSize: SUColorSingleton().textFont16),
                          ),
                          Spacer(), // 让左右两侧的 Text 分散布局
                          Text(
                            model?.description ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: SUColorSingleton().textTimeColor,
                                fontSize: SUColorSingleton().textTimeFont10),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0.w,
                      ),
                      Row(
                        children: [
                          Text(
                            model?.createTime ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: SUColorSingleton().textSecColor,
                                fontSize: SUColorSingleton().textSecFont12),
                          ),
                          Spacer(), // 让左右两侧的 Text 分散布局
                          // Image.network('Your Image URL'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
