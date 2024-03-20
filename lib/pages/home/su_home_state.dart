import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SUHomeState {
  late double keywordH;
  late RxInt count1;
  late bool isFollow;
  late bool isDiscover;

  SUHomeState() {
    keywordH = 0.0;
    count1 = 0.obs;
    isFollow = false;
    isDiscover = true;
  }
}
