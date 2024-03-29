import 'package:sugar/su_export_comment.dart';

class SUDiscoverState {
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
    // List list = params['data']!;
    // dataSource = List<ChatDetailModel>.from(
    //     list.map((e) => ChatDetailModel.fromJson(e)).toList().reversed);
  }
}
