import 'package:sugar/su_export_comment.dart';

class SUDiscoverState {
  List<ChatDetailModel> dataSource = [];
  var params = {
    "data": [
      {
        "message":
            "Intro. your boyfriend,gives princess treatment, hubby material, (story):he has a best friend named Venessa, you and Venessa hate each so…",
        "type": 1,
        "isSelect": false
      },
      {
        "message": "Carl looks at you angrily as Venessa fake Tony",
        "type": 2,
        "isSelect": false
      },
      {"message": "Hello. Nice to meet you", "type": 0, "isSelect": false},
      {"message": "Nice to meet you, too", "type": 2, "isSelect": false},
      {
        "message":
            "you’re laying in bed, suddenly, the side of the bed sinks. He's back from a mission “Are you awake?”",
        "type": 2,
        "isSelect": false
      },
      {"message": "Hello. Nice to meet you", "type": 0, "isSelect": false},
      {
        "message":
            "you’re laying in bed, suddenly, the side of the bed sinks. He's back from a mission “Are you awake?”",
        "type": 2,
        "isSelect": false
      },
      {"message": "Hello. Nice to meet you", "type": 0, "isSelect": false},
      {"message": "Nice to meet you, too", "type": 2, "isSelect": false},
    ],
  };
  List<String> dataList = [
    'https://qiniu.aimissu.top/temporary/image34.jpg',
    'https://qiniu.aimissu.top/temporary/image39.jpg',
    'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
    'https://qiniu.aimissu.top/temporary/image34.jpg',
    'https://qiniu.aimissu.top/temporary/image39.jpg',
    'https://qiniu.aimissu.top/temporary/WechatIMG535.jpg',
  ];

  ScrollController? scrollController;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late double keywordH;
  late String defColor = '#000000';
  int currentIndex = 0;
  List<Widget> childrenView = <Widget>[];

  SUDiscoverState() {
    keywordH = 0.0;
    scrollController = ScrollController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();

    List list = params['data']!;
    dataSource = List<ChatDetailModel>.from(
        list.map((e) => ChatDetailModel.fromJson(e)).toList().reversed);
  }
}

class ChatDetailModel {
  String? message;
  SUChatType? type;
  bool? isSelect;

  ChatDetailModel({
    this.message,
    this.type,
    this.isSelect,
  });
  ChatDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    switch (json['type']) {
      case 0: //默认
        type = SUChatType.mine;
        break;
      case 1: //联网
        type = SUChatType.intro;
        break;
      default:
        type = SUChatType.others;
        break;
    }
    isSelect = json['isSelect'];
  }
}

enum SUChatType {
  intro,
  mine,
  others,
}
