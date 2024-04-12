import '../su_export_comment.dart';

class SUCustomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final VoidCallback? onLeftButtonPressed;
  final ValueChanged<String>? onSearchSubmit;
  final ValueChanged<String>? onTextChanged;
  const SUCustomSearchBar(this.context,
      {Key? key,
      this.onLeftButtonPressed,
      this.onSearchSubmit,
      this.onTextChanged})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: SCColors.color_1C1D1F,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset(
                    Assets.commonBackIconW,
                    width: 24.w,
                    height: 24.w,
                    color: Colors.white, // 图标颜色
                  ),
                  onPressed: () {
                    if (onLeftButtonPressed != null) {
                      onLeftButtonPressed!();
                    } else {
                      SURouterHelper.back(null);
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    height: 40.w,
                    margin: EdgeInsets.only(right: 14.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[700], // 背景颜色
                      borderRadius: BorderRadius.circular(20.w), // 圆角
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w), // 左侧间距
                        Icon(Icons.search, color: Colors.white), // 搜索图标
                        SizedBox(width: 10.w), // 图标和文本之间的间距
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white), // 字体颜色
                            decoration: InputDecoration(
                              hintText: 'search_Talker'.tr, // 占位文本
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp), // 占位文本样式
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              // 处理搜索文本变化事件
                              if (onTextChanged != null) {
                                onTextChanged!(value);
                              }
                            },
                            onSubmitted: (value) {
                              // 处理搜索提交事件
                              if (onSearchSubmit != null) {
                                onSearchSubmit!(value);
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10), // 右侧间距
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
