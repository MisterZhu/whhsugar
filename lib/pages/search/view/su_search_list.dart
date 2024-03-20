import '../../../su_export_comment.dart';
import '../su_search_logic.dart';

class SUSearchList extends StatelessWidget {
  final SUSearchLogic logic; // 替换 YourStateType 为实际的状态类
  final int index;

  const SUSearchList({super.key, required this.logic, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowHeader(index),
        rowListView(index),
      ],
    );
  }

  Widget rowHeader(int index) {
    return Padding(
      padding:
          EdgeInsets.only(top: 24.0.w, left: 20.w, right: 20.w, bottom: 10.w),
      child: Row(
        children: [
          Image.asset(
            'assets/images/su_search_head.png',
            width: 40.w,
            height: 40.w,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'fantasy',
                    style: TextStyle(
                        color: SUColorSingleton().textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    '2,001 participants | 7M connectors',
                    style: TextStyle(
                        color: SUColorSingleton().inputTextColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          Icon(
            Icons.chevron_right_sharp,
            color: SUColorSingleton().naviSecColor,
          ),
        ],
      ),
    );
  }

  Widget rowListView(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Container(
        height: 200, // 卡片高度
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: logic.yourData[index].length, // 每组中卡片数量
          itemBuilder: (context, cardIndex) {
            return _rowListItem();
          },
        ),
      ),
    );
  }

  Padding _rowListItem() {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: 150, // 卡片宽度
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  'https://qiniu.aimissu.top/temporary/image34.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color(0xBF212125),
                        Color(0xF2292A2E),
                      ],
                      stops: [0.0, 0.7539, 0.95],
                    ),
                  ),
                  padding: EdgeInsets.all(8.0),
                  // color: Colors.black.withOpacity(0.5),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Text',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'Second Text',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
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
