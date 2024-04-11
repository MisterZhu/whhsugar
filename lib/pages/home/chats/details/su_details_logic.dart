import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sugar/pages/home/chats/details/su_reply_model.dart';
import '../../../../global/db/daos/chat_content_dao.dart';
import '../../../../global/db/daos/session_list_dao.dart';
import '../../../../global/db/database_helper.dart';
import '../../../../global/user/user_logic.dart';
import '../../../../su_export_comment.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../discover/su_discover_logic.dart';
import '../../discover/su_discover_model.dart';

class SUDetailsLogic extends GetxController {
  late Uint8List imageBytes;
  late PaletteGenerator paletteGenerator;
  late Size imageSize;
  late String title = '';
  late String name = '';
  late String bgUrl = '';
  RxBool isStreamLoadingDet = false.obs;

  List<SUChatContentModel>? dataList;
  final UserLogic userLogic = Get.find<UserLogic>();

  @override
  void onInit() {
    super.onInit();
    dataList = <SUChatContentModel>[];
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///-------------------------------网络请求操作-------------------------------
  ///发送消息
  Future<void> sendMessages(Map<String, dynamic> params, String content) async {
    debugPrint('--------------getUserToken--begin');
    addMineMessage(content);
    await HttpManager.instance.post(
        url: '$name/messages',
        params: params,
        success: (response) {
          getMessage(response['name']);
          debugPrint('--------------------发送消息response1 : $response');
          aiReplyMessages(response['name']);
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///AI 助手回复消息
  Future<void> aiReplyMessages(String name) async {
    debugPrint('--------------getUserToken--begin');
    List<String> substrings = name.split("/messages/");
    late String paraUrl = '';
    if (substrings.isNotEmpty) {
      paraUrl = substrings[0];
    }
    await HttpManager.instance.post(
        url: '$paraUrl:reply',
        params: null,
        success: (response) {
          debugPrint('--------------------AI 助手回复消息response : $response');
          Future.delayed(const Duration(seconds: 1), () {
            if (response['name'] != null) {
              addReplyMessage('');
              getReplyMessages(response['name']);
            }
          });
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///轮训获取AI回复
  Future<void> getReplyMessages(String name) async {
    await HttpManager.instance.get(
        url: name,
        params: null,
        success: (response) {
          debugPrint('--------------------轮训获取AI回复response : $response');
          if (response != null) {
            final SUAIReplyModel replayModel =
                SUAIReplyModel.fromJson(response);
            final ReMetadata? metaModel = replayModel.metadata;
            final List<ReMessages>? messages = metaModel?.partialResult?.msg;
            if (messages != null && messages.isNotEmpty) {
              final ReMessages firstMessage = messages[0];
              debugPrint(
                  '--------------------replayModel : ${firstMessage?.conte?.inlineSource?.data ?? ""}');
              replaceMessage(firstMessage?.conte?.inlineSource?.data ?? "");
            }
            if ((replayModel?.done ?? false)) {
              isStreamLoadingDet.value = false;
              getMessage(replayModel.response?.messages?.last ?? '');
            } else {
              isStreamLoadingDet.value = true;
              Future.delayed(const Duration(seconds: 1), () async {
                await getReplyMessages(name);
              });
            }
          } else {
            debugPrint('--------------------replayModel :');
          }
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///-------------------------------数据操作-------------------------------

  ///添加我的消息
  void addMineMessage(String content) {
    SUChatContentModel messageModel = SUChatContentModel();
    messageModel.name = '';
    messageModel.type = SUChatType.mine;
    messageModel.isFold = false;
    messageModel.content = content;
    dataList!.insert(0, messageModel);

    final SUDiscoverLogic disLogic = Get.find<SUDiscoverLogic>();
    disLogic.update([SUDefVal.kChatDetList]);
  }

  ///添加回复消息
  void addReplyMessage(String content) {
    SUChatContentModel messageModel = SUChatContentModel();
    messageModel.name = '';
    messageModel.type = SUChatType.others;
    messageModel.isFold = false;
    messageModel.content = content;
    // messageData!.add(messageModel);
    dataList!.insert(0, messageModel);
    final SUDiscoverLogic disLogic = Get.find<SUDiscoverLogic>();
    disLogic.update([SUDefVal.kChatDetList]);
  }

  ///替换消息
  void replaceMessage(String content) {
    if ((dataList?.length ?? 0) > 0) {
      final model = dataList![0];
      model.content = content;
      dataList![0] = model;
      final SUDiscoverLogic disLogic = Get.find<SUDiscoverLogic>();
      disLogic.update([SUDefVal.kChatDetList]);
    }
  }

  // 添加聊天数据
  void insertChatDB(SUMessageModel messageModel) async {
    try {
      final chatContentDao = ChatContentDao(DatabaseHelper.instance.database);
      await chatContentDao.insertOrUpdate({
        'sessionName': name,
        'name': messageModel.name,
        'contentType': messageModel.inlineSource?.contentType,
        'content': messageModel.inlineSource?.data,
        'author': messageModel.author,
        'createTime': messageModel.createTime,
        'updateTime': messageModel.updateTime
      });
      final sessionListDao = SessionListDao(DatabaseHelper.instance.database);
      // final sessionList = await sessionListDao.getAll();
      final data = await sessionListDao.query('name', name);
      final lastModel = data.last;
      lastModel['lastTime'] = messageModel.createTime;
      lastModel['lastMessage'] = messageModel.inlineSource?.data;
      sessionListDao.insertOrUpdate(lastModel);
      debugPrint('查询到的  session数据: $data');
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

  ///获取某条消息
  Future<void> getMessage(String name) async {
    debugPrint('--------------getUserToken--begin');

    await HttpManager.instance.get(
        url: name,
        params: null,
        success: (response) {
          debugPrint('--------------------获取某条消息 response : $response');
          SUMessageModel messageModel = SUMessageModel.fromJson(response);
          insertChatDB(messageModel);
        },
        failure: (err) {
          // LoadingUtil.failure(text: err['msg']);
        });
  }

  ///-------------------------------数据库查询 条件sessionName查询聊天表数据-------------------------------

  Future<void> fetchTableData() async {
    try {
      final chatContentDao = ChatContentDao(DatabaseHelper.instance.database);
      // final data = await chatContentDao.getAll();

      final data = await chatContentDao.query('sessionName', name);
      //List<SUChatContentModel> chatContentList = data.map((json) => SUChatContentModel.fromJson(json)).toList();
      dataList = <SUChatContentModel>[];

      debugPrint('item 表中的数据: $data');
      data.forEach((json) {
        SUChatContentModel chatContent = SUChatContentModel.fromJson(json);
        chatContent.type = (chatContent.author == userLogic.user.name?.value)
            ? SUChatType.mine
            : SUChatType.others;

        dataList?.add(chatContent);
      });
      dataList = dataList!.reversed.toList();
      update();
      debugPrint('---------------chatContent: 刷新');
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

  ///-------------------------------颜色处理-------------------------------

  Future<String> getImageColor(String color, String imageUrl) async {
    if (color != '') {
      return color;
    }
    await _loadImageBytes(imageUrl);
    await _updatePalette();
    return _getPreferredColorHex();
  }

  Future<void> _loadImageBytes(String imageUrl) async {
    imageBytes = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
        .buffer
        .asUint8List();
    final image = await loadImage(Uint8List.fromList(imageBytes!));
    imageSize = Size(image.width.toDouble(), image.height.toDouble());
  }

  Future<void> _updatePalette() async {
    final imageProvider = MemoryImage(imageBytes);
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
      size: imageSize, // Size of the image to analyze
      region: Rect.fromCenter(
        center: Offset(imageSize.width / 2, imageSize.height / 2),
        width: imageSize.width / 3,
        height: imageSize.height / 3,
      ), // Region to analyze
    );
  }

  Future<ui.Image> loadImage(Uint8List list) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(list, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  String _getPreferredColorHex() {
    print(
        '------------------dominantColor : ${paletteGenerator.dominantColor?.color.value.toRadixString(16).substring(2)}');
    if (paletteGenerator.darkMutedColor != null &&
        paletteGenerator.darkMutedColor!.color != Colors.transparent) {
      return '#${paletteGenerator.darkMutedColor!.color.value.toRadixString(16).substring(2)}';
    } else {
      return '#${paletteGenerator.dominantColor!.color.value.toRadixString(16).substring(2)}';
    }
  }
}
