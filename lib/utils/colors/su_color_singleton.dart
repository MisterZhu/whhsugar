import 'dart:ffi';
import 'package:sugar/su_export_comment.dart';

class SUColorSingleton {
  factory SUColorSingleton() => _instance;

  SUColorSingleton._();

  static final SUColorSingleton _instance = SUColorSingleton._();

  Color primaryColor = Colors.blue;
  Color buttonColor = Colors.blue;
  Color naviDefColor = const Color(0xFFFFFFFF);
  Color naviSecColor = const Color(0xFF9D9D9D);
  Color naviYellowColor = const Color(0xFFFEDA82);
  Color naviGrayColor = const Color(0xFF9D9D9D);

  Color naviDisDefColor = const Color(0xFF333333);
  Color naviDisSecColor = const Color(0xFF555555);

  Color bgTopColor = const Color(0xFF111112);
  Color bgBotColor = const Color(0xFF1C1D21);

  Color textColor = const Color(0xFFFFFFFF);
  Color textSecColor = const Color(0xFFE8E8E8);
  Color textTimeColor = const Color(0xFF646567);

  Color tipBgColor = const Color(0xFF969696);

  Color introTextColor = const Color(0xD9FFFFFF); //85%透明度-白色
  Color introBgColor = const Color(0xE6000000); //90%透明度-黑色

  Color otherTextColor = const Color(0xA6FFFFFF); //65%透明度-白色
  Color otherBgColor = const Color(0xFFA5755D); //90%透明度-黑色

  Color mineTextColor = const Color(0xD92C2C3C); //85%透明度-深蓝
  Color mineBgColor = const Color(0xD9FFFFFF); //85%透明度-白色

  Color inputBgColor = const Color(0x4DFFFFFF); //30%透明度-白色
  Color inputTextColor = const Color(0xFFE8E8E8); //白色

  Color btnBgColor = const Color(0x1AFFFFFF); //10%透明度-白色

  Color saveBtnBgColor = const Color(0xFFEBBA87); //保存按钮

  Color profileBgColor = const Color(0x40000000); //25%透明度-黑色

  Color textDEColor = const Color(0xFFDEDEDE);

  double textFont20 = 16.sp;
  double textFont16 = 16.sp;
  double textSecFont12 = 12.sp;
  double textTimeFont10 = 10.sp;

  // 更新状态的方法
  void changeTheme() {
    // 简单示例，实际项目可能需要更复杂的处理
    primaryColor = Colors.black;
  }
}
