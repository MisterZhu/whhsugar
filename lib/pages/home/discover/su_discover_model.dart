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
  List<String>? greetings;

  Metadata({this.avatar, this.backgroundImage, this.greetings});

  Metadata.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    backgroundImage = json['backgroundImage'];
    greetings = List<String>.from(json['greetings'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['backgroundImage'] = backgroundImage;
    data['greetings'] = greetings;
    return data;
  }
}
