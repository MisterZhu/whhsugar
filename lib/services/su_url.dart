/// API

class SUUrl {
  /************************* 登录 *************************/

  /// 登录webUrl
  static const String kLoginWebUrl =
      'https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=casdoor';
  //https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=sugar
  //https://casdoor.tigerbot.com/login/oauth/authorize?client_id=931f8237ead11af361c3&response_type=code&redirect_uri=http://localhost:9000/callback&scope=read&state=casdoor
  ///获取token
  static const String kGetTokenUrl = '/login:getToken';

  ///获取账号信息
  static const String kGetUserInfoUrl = '/accounts/';

  /************************* chat相关 *************************/
  ///获取助手列表
  static const String kGetAssListUrl = '/projects/sugar-default/assistants';

  ///创建会话
  static const String kCreateThreadUrl = '/projects/';
  /************************* 用户信息 *************************/

  /// 用户信息url
  static const String kUserInfoUrl = '/web/uc/get_user_info';

  /************************* 新改版 *************************/
}
