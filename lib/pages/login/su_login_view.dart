import 'package:sugar/su_export_comment.dart';

import 'su_login_logic.dart';

class SULoginPage extends StatelessWidget {
  SULoginPage({Key? key}) : super(key: key);

  final logic = Get.put(SULoginLogic());
  final state = Get.find<SULoginLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // 左侧按钮点击事件
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 右侧按钮点击事件
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                // 中间左侧按钮点击事件
                print('1111111111');
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // 中间右侧按钮点击事件
                print('222222222222');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              children: [
                // 页面1
                buildPage('Page 1', Colors.blue,
                    'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg'),

                // 页面2
                buildPage('Page 2', Colors.green,
                    'https://qiniu.aimissu.top/temporary/image34.jpg'),

                // 页面3
                buildPage('Page 3', Colors.orange,
                    'https://qiniu.aimissu.top/temporary/image39.jpg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String title, Color color, String imagePath) {
    return Container(
      color: color,
      child: Center(
        child: SUUtils.imageWidget(
          url: imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
