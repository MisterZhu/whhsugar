/// API

class SUUrl {
  /************************* URL *************************/

  /// 发送验证码
  static const String kASRCloudUrl =
      'https://asr-cloud.tigerbot.com/recognition';

  /************************* 登录 *************************/

  /// 登录webUrl
  static const String kLoginWebUrl =
      'https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=sugar';
  //https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=sugar
  //https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=casdoor

  /// 注册webUrl
  static const String kRegisterWebUrl =
      'https://casdoor.tigerbot.com/signup/sugar';

  /// 验证码登录
  static const String kLoginCodeUrl = '/web/uc/login_by_mobile';

  /// 密码登录
  static const String kLoginPasswordUrl = '/web/uc/login_by_password';

  /// 注销
  static const String kIssuesUrl = '/issues';

  /************************* chat相关 *************************/

  /// chat点赞url
  static const String kChatFeedBackUrl = '/chatGpt/feedback';

  /// 咨询chat问题url
  static const String kChatConsultUrl = '/chatGpt/stream/execute';

  ///灵感
  static const String kKeyViewUrl = '/key-value/view';

  /************************* 用户信息 *************************/

  /// 用户信息url
  static const String kUserInfoUrl = '/web/uc/get_user_info';

  /// 上传头像url
  static const String kUserHeadUrl = '/common/upload';

  /// 保存信息url
  static const String kSaveIntroUrl = '/web/user/modify';

  ///用户权限
  static const String kApplyInfoUrl = '/ai/apply/getApplyInfo';

  ///邀请码申请
  static const String kInviteCodeUrl = '/ai/apply/applyByCode';

  ///邀请码申请
  static const String kTestApplyUrl = '/ai/apply/apply';

  ///开启青少年模式
  static const String kOpenTeenModeUrl = '/user/teen/startMode';

  ///关闭青少年模式
  static const String kCloseTeenModeUrl = '/user/teen/closeMode';

  ///查询青少年模式状态
  static const String kSearchTeenModeUrl = '/user/teen/inMode';

  /************************* 新改版 *************************/

  /// 新建会话、获取会话列表（/id 拼接ID是获取指定一条）、删除会话
  static const String kCreateSession = '/chat-backend/sessions';

  /// 获取消息列表（/id 拼接ID是获取指定一条）
  static const String kGetMessages = '/chat-backend/messages';

  /// 普通post咨询chat问题url
  static const String kChatUrl = '/chat-backend/chat';

  /// 流式咨询chat问题url
  static const String kChatStreamUrl = '/chat-backend/chatStream';

  /// 获取 Assistant 列表
  static const String kGetAssistantUrl = '/chat-backend/assistants';
}
