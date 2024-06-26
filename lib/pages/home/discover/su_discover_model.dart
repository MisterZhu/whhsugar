class SUAssistantModel {
  String? name;
  String? displayName;
  String? description;
  String? createTime;
  String? updateTime;
  Metadata? metadata;

  SUAssistantModel(
      {this.name,
      this.displayName,
      this.description,
      this.metadata,
      this.createTime,
      this.updateTime});

  SUAssistantModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['displayName'] = displayName;
    data['description'] = description;
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? avatar;
  String? backgroundImage;
  String? backgroundColor;
  bool? needRefresh;

  List<String>? greetings;
  List<SUMessageModel>? messages;

  Metadata(
      {this.avatar,
      this.backgroundImage,
      this.greetings,
      this.messages,
      this.backgroundColor,
      this.needRefresh});

  Metadata.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    backgroundImage = json['backgroundImage'];
    backgroundColor = '';
    needRefresh = true;
    greetings = List<String>.from(json['greetings'] ?? []);
    // messages = <SUMessageModel>[];
    // if (json['messages'] != null) {
    //   json['messages'].forEach((v) {
    //     messages!.add(SUMessageModel.fromJson(v));
    //   });
    // }

    // response['messages'].forEach((v) {
    //   SUMessageModel messageModel = SUMessageModel.fromJson(v);
    //
    //   // 在这里进行单独处理，比如修改参数值
    //
    //   // 将空的SUMessageModel插入数组最前面
    //   if (messageModel.name == null) {
    //     messageData!.insert(0, messageModel);
    //   } else {
    //     messageData!.add(messageModel);
    //   }
    // });
    messages = <SUMessageModel>[];
    if (greetings != null && ((greetings?.length ?? 0) > 0)) {
      SUMessageModel messageModel = SUMessageModel();
      messageModel.name = '';
      messageModel.type = SUChatType.intro;
      messageModel.isFold = true;
      messageModel.inlineSource?.data = greetings?.last;
      messageModel.inlineSource?.contentType = 'text/plain';
      messages!.add(messageModel);
    }
    // messages = List<SUMessageModel>.from(json['messages'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['backgroundImage'] = backgroundImage;
    data['backgroundColor'] = backgroundColor;
    data['needRefresh'] = needRefresh;
    data['greetings'] = greetings;
    // data['messages'] = messages;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SUSessionModel {
  String? name;
  String? displayName;
  String? description;
  String? assistant;
  String? owner;
  String? createTime;
  String? updateTime;

  SUSessionModel(
      {this.name,
      this.displayName,
      this.description,
      this.assistant,
      this.owner,
      this.createTime,
      this.updateTime});

  SUSessionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    assistant = json['assistant'];
    owner = json['owner'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['displayName'] = displayName;
    data['description'] = description;
    data['assistant'] = assistant;
    data['owner'] = owner;
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    return data;
  }
}

class SUMessageModel {
  String? name;
  String? author;
  DisInlineSource? inlineSource;
  String? createTime;
  String? updateTime;
  SUChatType? type;
  bool? isFold;

  SUMessageModel(
      {this.name,
      this.author,
      this.type,
      this.isFold,
      this.inlineSource,
      this.createTime,
      this.updateTime});

  SUMessageModel.fromJson(Map<String, dynamic> json) {
    // final userLogic = Get.find<UserLogic>(); // 在这里查找UserLogic实例

    name = json['name'];
    author = json['author'];
    type = SUChatType.intro;
    isFold = false;
    inlineSource = json['inlineSource'] != null
        ? DisInlineSource.fromJson(json['inlineSource'])
        : null;
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['author'] = author;
    if (inlineSource != null) {
      data['inlineSource'] = inlineSource!.toJson();
    }
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    return data;
  }
}

class DisInlineSource {
  String? contentType;
  String? data;

  DisInlineSource({this.contentType, this.data});

  DisInlineSource.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contentType'] = contentType;
    data['data'] = this.data;
    return data;
  }
}

enum SUChatType {
  intro,
  mine,
  others,
}
