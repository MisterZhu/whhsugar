import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../services/http_manager.dart';
import '../../services/su_url.dart';
import '../../su_export_comment.dart';
import '../../widgets/loading/loading_util.dart';
import '../home/discover/su_discover_model.dart';
import '../home/su_home_logic.dart';
import 'su_search_state.dart';

class SUSearchLogic extends GetxController {
  final SUSearchState state = SUSearchState();
  List<SUAssistantModel>? dataSource;
  List<SUAssistantModel>? searchData;

  late bool isSearch = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dataSource = <SUAssistantModel>[];
    searchData = <SUAssistantModel>[];
    getAssistantsList();
  }

  void clickItemAction(int index) {
    final SUHomeLogic homeLogic = Get.find<SUHomeLogic>();

    final listModel = dataSource![index];
    final assistantId = listModel.name!;
    // Iterable<SUSessionModel>? adults = threadData
    //     ?.where((user) => user.assistant == logicDis.assistantId);
    List<SUSessionModel>? adults = homeLogic.threadData
        ?.where((user) => user.assistant == assistantId)
        .toList();

    if ((adults?.length ?? 0) > 0) {
      debugPrint('点击消息列表--有会话');

      final sessionModel = adults?.last;
      var params = {
        "title": sessionModel?.assistantName,
        "name": sessionModel?.name,
        "backgroundImage": sessionModel?.backgroundImage,
        "assistantName": sessionModel?.name
      };
      SURouterHelper.pathPage(SURouterPath.chatDetPath, params);
    } else {
      debugPrint('点击消息列表--无会话');

      var params = {
        "title": listModel.displayName,
        "name": '',
        "intro": listModel.metadata?.greetings?.last ?? '',
        "backgroundImage": listModel.metadata?.backgroundImage,
        "assistantName": listModel.name
      };
      SURouterHelper.pathPage(SURouterPath.chatDetPath, params);
    }
  }

  ///获取助手列表
  Future<void> getAssistantsList() async {
    await HttpManager.instance.get(
        url: SUUrl.kGetAssListUrl,
        params: null,
        success: (response) async {
          if (response['assistants'] != null) {
            response['assistants'].forEach((v) {
              dataSource!.add(SUAssistantModel.fromJson(v));
            });
            update();
          }
          log('----------------------dataSource : \n ${dataSource?.length}');
        },
        failure: (err) {
          LoadingUtil.failure(text: err['msg']);
        });
  }

  /// 搜索助手列表
  Future<void> filtrateAssistantsList(String name) async {
    if (name.isEmpty) {
      isSearch = false;
      searchData!.clear(); // 清空搜索结果数组
      update();
    } else {
      isSearch = true;
      searchData!.clear(); // 清空搜索结果数组
      // 根据名称进行筛选
      dataSource!.forEach((assistant) {
        final disName = assistant.displayName ?? '';
        if (disName.contains(name)) {
          searchData!.add(assistant); // 将符合条件的助手对象添加到搜索结果数组
        }
      });
      update();
    }
  }
}
