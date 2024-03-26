/// 网络请求
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar/services/su_config.dart';

import '../global/user/user_logic.dart';
import '../su_export_comment.dart';

class HttpManager {
  factory HttpManager() => _getInstance();

  static HttpManager get instance => _getInstance();

  static HttpManager? _instance;

  late Dio _dio;

  late BaseOptions _baseOptions;

  late Map<String, dynamic> _headers;

  Dio get dio => _dio;

  BaseOptions get baseOptions => _baseOptions;

  Map<String, dynamic> get headers => _headers;

  HttpManager._internal() {
    _init();
  }
// 添加一个静态方法用于初始化
  static Future<void> init() async {
    HttpManager instance = _getInstance();
    await instance._init();
  }

  Future<void> _init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // final userLogic = Get.find<UserLogic>();

    _headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    // String? token = userLogic.user.token;
    String? token = sharedPreferences.getString(SUDefVal.kToken);

    if (token != null) {
      _headers['token'] = token;
    }
    print('----------- token: $token');
    _baseOptions = BaseOptions(
      baseUrl: SUConfig.BASE_URL,
      connectTimeout: Duration(milliseconds: SUDefVal.timeOut),
      receiveTimeout: Duration(milliseconds: SUDefVal.timeOut),
      sendTimeout: Duration(milliseconds: SUDefVal.timeOut),
      headers: _headers,
    );

    _dio = Dio(_baseOptions);
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  static HttpManager _getInstance() {
    _instance ??= HttpManager._internal();
    return _instance!;
  }

  void updateHeaders(Map<String, dynamic> headers) {
    _headers = headers;
    _baseOptions.headers = _headers;
    _dio.options = _baseOptions;
  }

  /// 通用的GET请求
  Future get(
      {required String url,
      dynamic params,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;
    print('------------------------------Get请求URL: $url');
    print('------------------------------Get请求参数: $params');
    try {
      response = await _dio!.get(url,
          queryParameters: params, options: headers == null ? null : options);
      status = true;
    } catch (e) {
      status = false;
      exception = e;
    } finally {
      print('--------------finally');

      // print('----------- response: $response');

      if (status) {
        print('----------- status');

        var data = doResponse(response);
        print('----------- dataonse: $data');

        success?.call(data);
      } else {
        print('----------- else');

        var data = doError(exception);
        print('----------- data: $data');

        var code = data['code'];
        // if (code != 401) {
        //   failure?.call(data);
        // }
        failure?.call(data);
      }
    }

    return Future(() => status);
  }

  /// 通用的POST请求
  Future post(
      {required String url,
      dynamic params,
      bool? isQuery,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;
    bool query = isQuery ?? false;
    // 打印请求参数和请求链接
    print('------------------------------POST请求URL: $url');
    print('------------------------------POST请求参数: $params');

    try {
      response = await _dio!.post(url,
          queryParameters: query ? params : {},
          data: params,
          options: headers == null ? null : options);
      status = true;
    } catch (e) {
      status = false;
      exception = e;
    } finally {
      if (status) {
        var data = doResponse(response);
        checkLogin(url: url, headers: response.headers.map, data: data);
        success?.call(data);
      } else {
        var data = doError(exception);
        print('----------- post response: $data');

        var code = data['code'];
        if (code != 401) {
          Fluttertoast.showToast(
            msg: data['message'] ?? '',
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
          );
          failure?.call(data);
        }
      }
    }
    return Future(() => status);
  }

  /// 通用的PUT请求
  put(
      {required String url,
      dynamic params,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;

    try {
      response = await _dio!.put(url,
          queryParameters: params,
          data: params,
          options: headers == null ? null : options);
      status = true;
    } catch (e) {
      status = false;
      exception = e;
    } finally {
      if (status) {
        var data = doResponse(response);
        success?.call(data);
      } else {
        var data = doError(exception);
        var code = data['code'];
        if (code != 401) {
          failure?.call(data);
        }
      }
    }
  }

  /// 通用的DELETE请求
  delete(
      {required String url,
      dynamic params,
      Map<String, dynamic>? headers,
      Function(dynamic value)? success,
      Function(dynamic value)? failure}) async {
    Options options = Options(headers: headers);
    late Response response;
    late Object exception;
    bool status = false;

    try {
      response = await _dio!.delete(url,
          queryParameters: params,
          data: params,
          options: headers == null ? null : options);
      status = true;
    } catch (e) {
      print('----------- response: $e');

      status = false;
      exception = e;
    } finally {
      print('----------- response: $response');
      print('----------- response status: $status');

      if (status) {
        var data = doResponse(response);
        success?.call(data);
      } else {
        var data = doError(exception);
        var code = data['code'];
        if (code != 401) {
          failure?.call(data);
        }
      }
    }
  }

  /// 校验登录
  checkLogin({required String url, dynamic headers, dynamic data}) {
    // if (url == SCUrl.kPhoneCodeLoginUrl || url == SCUrl.kPhoneCodeLoginWithNameUrl) {
    //   String token = '';
    //
    //   var list = headers['authorization'];
    //   if (list != null) {
    //     int count = list.length;
    //     if (count > 0) {
    //       token = list[0];
    //       _headers!['Authorization'] = token;
    //       HttpManager.instance._baseOptions?.headers = _headers;
    //     }
    //   }
    //   if (data['userInfoV'] != null) {
    //     var userData = data['userInfoV'];
    //     userData['token'] = token;
    //     if (token != '') {
    //       SCScaffoldManager.instance.cacheUserIsLogin(true);
    //     }
    //     SCScaffoldManager.instance.cacheUserData(userData);
    //   }
    // }
  }
}

/// 处理dio请求成功后,网络数据解包
doResponse(Response response) {
  if (response.statusCode == 200) {
    LoadingUtil.hide();
    log('成功：${response.data}');

    return response.data;
  } else {
    LoadingUtil.hide();
    log('失败：${response.data}');
    return response.data;
  }
}

/// 处理dio请求异常
doError(e) {
  LoadingUtil.hide();

  /// 错误码
  int code = 0;

  /// message
  String message = SUDefVal.errorMessage;
  debugPrint("-------------error 网络请求异常 ");
  debugPrint(' --------------- e : $e');

  if (e is DioException) {
    DioException error = e;
    debugPrint(' --------------- error : $error');
    debugPrint(
        ' --------------- statusCode : ${error.response?.statusCode ?? 500}');

    if (e.error is SocketException) {
      code = 500;
      message = SUDefVal.netErrorMessage;
    } else {
      code = error.response?.statusCode ?? 500;
      print("-------------error code : $code");
      switch (error.response?.statusCode) {
        case 201:
          {}
          break;
        case 300:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;
        case 400:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
              // final custom_code = errorData['code'] ?? 0;

              debugPrint("-------------error message : $message");
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;

        case 401:
          {
            /// 登录失效
            accountExpired();
          }
          break;
        case 402:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;
        case 403:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;

        case 404:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;

        case 405:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;

        case 500:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;
        case 503:
          {
            if (error.response?.data is Map) {
              var errorData = error.response?.data;
              message = errorData['message'] ?? SUDefVal.errorMessage;
            } else {
              message =
                  error.response?.data.toString() ?? SUDefVal.errorMessage;
            }
          }
          break;
      }
    }
  } else {
    code = 500;
    message = SUDefVal.errorMessage;
  }

  var params = {
    'code': code,
    'message': message,
  };
  return params;
}

/// token失效
accountExpired() {
  log('登陆已失效，清空用户数据，刷新本地缓存用户数据');
  //退出登录， 弹出登录框
  SUUtils.getCurrentContext(completionHandler: (context) async {
    // UserInfoProvider userInfoProvider = Provider.of(context, listen: false);
    // userInfoProvider.logout();
    // Navigator.of(context).pushNamed(TBRouterPath.loginPath);
  });
}
