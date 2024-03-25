import 'dart:ui';

/// 常用的默认值

class SUDefVal {
  const SUDefVal._();

  /// APP名称
  static const String appName = 'TigerBot';

  /// 用户协议
  static const String userAgreementUrl =
      'https://tigerbot.com/user-agreement.html';

  /// 隐私政策
  static const String privacyProtocolUrl =
      'https://tigerbot.com/private-agreement.html';

  /// 关于
  static const String aboutUSUrl = "";

  /************************* 宽度/距离 *************************/

  /// （设计图）屏幕默认宽度
  static const double screenWidth = 375.0;

  /// （设计图）屏幕默认高度
  static const double screenHeight = 812.0;

  /// 默认边距
  static const double margin = 20.0;

  /// 聊天头像默认宽高
  static const double chatHeaderWidth = 32.0;

  /// 聊天气泡左/右边框距离
  static const double chatLRMargin = chatHeaderWidth + 2 * margin;

  /// 聊天气泡最大宽度
  static const double chatBoxMaxWidth = 247.0;

  /// 聊天气泡文件宽度
  static const double chatFileBoxMaxWidth = 190.0;

  /// 聊天输入框宽度
  static const double chatTextWidth = 303.0;

  /************************* 字体大小/颜色 *************************/

  /// 聊天常规字体大小
  static const double chatRegularFont = 14;

  /// 聊天代码字体大小
  static const double chatCodeFont = 15;

  /// 聊天提示语字体大小
  static const double chatTipsFont = 13;

  /// 聊天字体竖向比例
  static const double chatFontSpanHeight = 1.3;

  /// 聊天字间距
  static const double chatWordSpacing = 1;

  /// 聊天常规字体颜色
  static const Color chatRegularColor = Color(0xff4a4a4a);

  /// 聊天背景色
  static const Color chatBGColor = Color(0xfff3f6fb);

  /// 主色-粉
  static const Color chatThemePinkColor = Color(0xFFFF98AC);
  /************************* 常量配置 *************************/

  /// APP名称
  static const String shareQrImageStr = 'https://tigerbot.com/chat';

  /// 网络超时时间
  static const int timeOut = 30000;

  /// 透明度80%
  static const double opacity80 = 0.8;
  /************************* 第三方配置 *************************/

  /// 微信appId
  static const String kWeChatAppId = "wx61d3970bb819f20c";

  /// 微信appKey
  static const String kWeChatAppKey = "f3efd17386b3a55753e4f565a76bb107";

  /// 微信universalLink
  static const String kWeChatUniversalLink = "https://www.tigerbot.com/app/";

  /// 极光appKey
  static const String kJPushAppKey = "b4f24d7e5726088ee24b1686";

  /// 极光channel
  static const String kJPushChannel = "AppStore";

  /// 未安装微信
  static const String unInstallWeChatTip = "请安装微信";

  /// 相机无权限提示
  static const String noCameraPermis = "相机权限受限，请在设置中开启相机权限";

  /// 相册无权限提示
  static const String noAlbumPermis = "相册权限受限，请在设置中开启相册权限";

  /// 麦克风无权限提示
  static const String noMicroPermis = "麦克风权限受限，请在设置中开启麦克风权限";

  /// 同意协议才可以使用APP
  static const String canUseAppMessage = '同意协议后才可以使用!';

  /// 同意用户协议
  static const String agreeUserAgreementMessage = '请先同意用户协议和隐私政策！';

/************************* shared_preferences KEY *************************/

  /// 隐私政策key
  static const String isShowPrivacyAlert = "isShowPrivacyAlert";

  /// token
  static const String kToken = "token";

  /// token
  static const String kUserInfo = "userInfo";

  ///
  static const String kApplyStatus = "applyStatus";

  /// 网络加载中
  static const String loadingMessage = '加载中...';

  /// 网络加载失败
  static const String errorMessage = '加载失败，请稍后重试！';

  /// 网络不稳定
  static const String netErrorMessage = '网络不稳定，请稍后重试！';

/************************* get_builder KEY *************************/

  /// 刷新聊天页面
  static const String kChatInput = "ChatInput";
  static const String kChatBottom = "ChatBottom";
  static const String kDiscover = "Discover";

  static const String kChatSession = "ChatSession";
  static const String kChatMsgList = "ChatMsgList";
  static const String kChatLikeTool = "ChatLikeTool";
  static const String kChatInputFile = "ChatInputFile";
  static const String kChatLoading = "ChatLoading";

  /************************* event_bus KEY *************************/

  /// 登录回调
  static const String kWebBlockCode = "WebBlockCode";
}
