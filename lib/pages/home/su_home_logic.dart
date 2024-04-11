import 'dart:developer';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/db/daos/chat_content_dao.dart';
import '../../global/db/daos/session_list_dao.dart';
import '../../global/db/database_helper.dart';
import '../../global/user/user_logic.dart';
import '../../global/user/user_state.dart';
import '../../su_export_comment.dart';
import 'discover/su_discover_logic.dart';
import 'discover/su_discover_model.dart';
import 'su_home_state.dart';

class SUHomeLogic extends GetxController {
  final SUHomeState state = SUHomeState();
  late String code = '';
  late String stateStr = '';
  late String name = '';
  late int pageIndex = 0;

  List<SUAssistantModel>? dataSource;
  List<SUSessionModel>? threadData;
  // List<SUSessionModel>? dataList;

  final userLogic = Get.find<UserLogic>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final chatContentDao = ChatContentDao(DatabaseHelper.instance.database);

    bus.on(SUDefVal.kPushNeedLogin, onEventCallback);
    bus.on(SUDefVal.kWebBlockCode, onLoginFinishBack);
    dataSource = <SUAssistantModel>[];
    threadData = <SUSessionModel>[];

    dynamic params = Get.arguments;
    code = StringUtils.isNotNullOrEmpty(params?["code"]) ? params!["code"] : '';
    stateStr =
        StringUtils.isNotNullOrEmpty(params?["state"]) ? params!["state"] : '';
    if (code.isNotEmpty && stateStr.isNotEmpty) {
      getUserToken(params);
    } else {
      getLocalToken();
    }
  }

  Future<void> getLocalToken() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = SharedPreferenceUtil().getData(SUDefVal.kToken);
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      log('decodedToken : \n ${decodedToken['name']}');
      name = decodedToken['name'];
      if (name.isNotEmpty && name != '') {
        HttpManager.instance.updateHeaders({
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token'
        });
        getUserInfo();
      }
    } else {
      var params = {
        "title": '登录',
        "url": SUUrl.kLoginWebUrl,
        "need_back": false
      };
      // SURouterHelper.pathPage(SURouterPath.webViewPath, params);
      SURouterHelper.pathOffAllPage(SURouterPath.webViewPath, params);
    }
  }

  ///监听跳转登录页面
  void onEventCallback(dynamic arg) {
    var params = {"title": '登录', "url": SUUrl.kLoginWebUrl, "need_back": false};
    // SURouterHelper.pathPage(SURouterPath.webViewPath, params);
    SURouterHelper.pathOffAllPage(SURouterPath.webViewPath, params);
  }

  ///监听登录
  void onLoginFinishBack(dynamic arg) {
    getUserToken(arg);
  }

  ///监听翻页
  void changePageIndex(int index) {
    if (pageIndex == index) {
      return;
    }
    pageIndex = index;

    SUUtils.getCurrentContext(completionHandler: (context) async {
      FocusScope.of(context).requestFocus(FocusNode());
    });
    final logicDis = Get.find<SUDiscoverLogic>();

    if ((dataSource?.length ?? 0) > index) {
      final listModel = dataSource![pageIndex];
      logicDis.assistantId = listModel.name!;
      List<SUSessionModel>? adults = threadData
          ?.where((user) => user.assistant == logicDis.assistantId)
          .toList();
      debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>-----debug = ${adults?.length}');
      debugPrint(
          '>>>>>>>>>>>>>>>>>>>>>>>>>>-----logicDis.assistantId = ${logicDis.assistantId}');

      if ((adults?.length ?? 0) > 0) {
        logicDis.threadName = adults?.last?.name ?? '';
        logicDis.assistantModel = dataSource![index];
        if (logicDis.assistantModel.metadata?.needRefresh == true) {
          logicDis.getMessagesList();
        } else {
          logicDis.update([SUDefVal.kChatBottom]);
        }
      } else {
        logicDis.threadName = '';
        logicDis.assistantModel = dataSource![index];
        logicDis.update([SUDefVal.kChatBottom]);
      }
    }
  }

  ///-------------------------------Network Request-------------------------------
  ///获取用户token
  Future<void> getUserToken(Map<String, String> params) async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.post(
        url: SUUrl.kGetTokenUrl,
        params: params,
        success: (value) {
          String token = value['accessToken'];
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          log('decodedToken : \n ${decodedToken['name']}');

          name = decodedToken['name'];
          SharedPreferences.getInstance().then((preferences) {
            preferences.setString(SUDefVal.kToken, token);
            HttpManager.instance.updateHeaders({
              'Content-Type': 'application/json; charset=utf-8',
              'Authorization': 'Bearer $token'
            });
            // 在这里执行后续代码
            if (name.isNotEmpty && name != '') {
              getUserInfo();
            }
          });
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///获取用户信息
  Future<void> getUserInfo() async {
    // var params = {
    //   "account_id": name,
    // };
    LoadingUtil.show();
    await HttpManager.instance.get(
        url: '${SUUrl.kGetUserInfoUrl}$name/userInfo',
        params: null,
        success: (value) {
          LoadingUtil.hide();
          log('response : \n $value');
          userLogic.user = UserModel.fromJson(value);
          userLogic.updateUser(userLogic.user);
          LoadingUtil.info(text: '登录成功');
          getThreadsList();
        },
        failure: (err) {
          LoadingUtil.hide();
          LoadingUtil.info(text: '登录失败');
        });
  }

  ///获取所有会话列表
  Future<void> getThreadsList() async {
    final sessionListDao = SessionListDao(DatabaseHelper.instance.database);
    // final data = await sessionListDao.query('sessionName', '');

    final data = await sessionListDao.getAll();
    debugPrint('------------session  item 表中的数据: $data');

    await HttpManager.instance.get(
        url:
            '${SUUrl.kCreateThreadUrl}/${userLogic.user.properties?.projectId}/threads',
        params: null,
        success: (response) {
          debugPrint('--------------------获取会话列表response : $response');
          if (response['threads'] != null) {
            List<Map<String, dynamic>> mapValues = [];

            response['threads'].forEach((v) {
              SUSessionModel messageModel = SUSessionModel.fromJson(v);
              mapValues.add({
                'assistant': messageModel.assistant,
                'name': messageModel.name,
                'displayName': messageModel.displayName,
                'description': messageModel.description,
                'owner': messageModel.owner,
                'createTime': messageModel.createTime,
                'updateTime': messageModel.updateTime
              });
              // threadData!.add(SUSessionModel.fromJson(v));
              // threadData!.add(messageModel);
            });
            sessionListDao.batchInsert(mapValues);
            fetchTableData();
          }
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
          getAssistantsList();
        });
  }

  // 查询表数据
  Future<void> fetchTableData() async {
    try {
      final sessionDao = SessionListDao(DatabaseHelper.instance.database);
      // final data = await chatContentDao.getAll();

      final data = await sessionDao.getAll();
      //List<SUChatContentModel> chatContentList = data.map((json) => SUChatContentModel.fromJson(json)).toList();
      threadData = <SUSessionModel>[];

      debugPrint('sessionDao 表中的数据: $data');
      for (var json in data) {
        SUSessionModel chatContent = SUSessionModel.fromJson(json);
        threadData?.add(chatContent);
      }
      // dataList = dataList!.reversed.toList();
      getAssistantsList();
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

  // 仅查询表数据
  Future<void> fetchTableDataOnly() async {
    try {
      final sessionDao = SessionListDao(DatabaseHelper.instance.database);
      // final data = await chatContentDao.getAll();

      final data = await sessionDao.getAll();
      //List<SUChatContentModel> chatContentList = data.map((json) => SUChatContentModel.fromJson(json)).toList();
      debugPrint('-----------------------sessionDao 表中的数据: $data');
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

  ///获取助手列表
  Future<void> getAssistantsList() async {
    final logicDis = Get.find<SUDiscoverLogic>();

    await HttpManager.instance.get(
        url: SUUrl.kGetAssListUrl,
        params: null,
        success: (response) async {
          if (response['assistants'] != null) {
            response['assistants'].forEach((v) {
              dataSource!.add(SUAssistantModel.fromJson(v));
            });
            // logicDis.update();
// 构建 dataSource 的 name 到对象的映射
            Map<String, SUAssistantModel> aMap = {};
            for (var aObj in dataSource!) {
              aMap[aObj?.name ?? 'a'] = aObj;
            }

// 遍历 threadData，直接查找并更新
            final sessionListDao =
                SessionListDao(DatabaseHelper.instance.database);

            List<Map<String, dynamic>> mapValues = [];

            for (var bObj in threadData!) {
              String? assistantName = bObj.assistant;
              if (aMap.containsKey(assistantName)) {
                // 找到匹配的对象，更新属性
                bObj.avatarUrl = aMap[assistantName]?.metadata?.avatar;
                bObj.backgroundImage =
                    aMap[assistantName]?.metadata?.backgroundImage;
                bObj.displayName = aMap[assistantName]?.displayName;
                bObj.description = aMap[assistantName]?.description;
                bObj.lastMessage =
                    aMap[assistantName]?.metadata?.greetings?.last ?? '';
                bObj.lastTime = aMap[assistantName]?.createTime;
                bObj.assistantName = aMap[assistantName]?.displayName;

                mapValues.add({
                  'assistant': bObj.assistant,
                  'name': bObj.name,
                  'displayName': bObj.displayName,
                  'description': bObj.description,
                  'owner': bObj.owner,
                  'createTime': bObj.createTime,
                  'avatarUrl': bObj.avatarUrl,
                  'backgroundImage': bObj.backgroundImage,
                  'displayName': bObj.displayName,
                  'assistantName': bObj.displayName,
                  'assistantName': bObj.assistantName,
                  'lastMessage': bObj.lastMessage,
                  'lastTime': bObj.lastTime,
                  'updateTime': bObj.updateTime
                });
              }
            }
            await sessionListDao.batchInsert(mapValues);
            // fetchTableDataOnly();

            if ((dataSource?.length ?? 0) > 0) {
              final listModel = dataSource![0];
              logicDis.assistantId = listModel.name!;
              // Iterable<SUSessionModel>? adults = threadData
              //     ?.where((user) => user.assistant == logicDis.assistantId);
              List<SUSessionModel>? adults = threadData
                  ?.where((user) => user.assistant == logicDis.assistantId)
                  .toList();
              debugPrint(
                  '---------------backgroundImage: ${adults?.last.backgroundImage}');
              debugPrint(
                  '---------------assistantName: ${adults?.last.assistantName}');

              if ((adults?.length ?? 0) > 0) {
                logicDis.threadName = adults?.last?.name ?? '';
                logicDis.assistantModel = dataSource![0];
                logicDis.getMessagesList();
              } else {
                logicDis.threadName = '';
              }
            }
            logicDis.update([SUDefVal.kDiscover]);
            // if ((dataSource?.length ?? 0) > 1) {
            //   logicDis.canSlide.value = true;
            // } else {
            //   logicDis.canSlide.value = false;
            // }
          }
          log('----------------------dataSource : \n ${dataSource?.length}');
        },
        failure: (err) {
          LoadingUtil.failure(text: err['msg']);
        });
  }
}
