import 'package:get/get.dart';

class UserModel {
  String? id;
  RxString? name;
  RxString? displayName;
  RxString? avatar;
  Properties? properties;
  String? createdTime;
  String? updatedTime;
  UserModel(
      {this.id,
      this.name,
      this.displayName,
      this.avatar,
      this.properties,
      this.createdTime,
      this.updatedTime});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = RxString(json['name']);
    displayName = RxString(json['displayName']);
    avatar = RxString(json['avatar']);
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name?.value;
    data['displayName'] = displayName?.value;
    data['avatar'] = avatar?.value;
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;

    return data;
  }
}

class Properties {
  String? project;
  String? projectId;

  Properties({this.project, this.projectId});

  Properties.fromJson(Map<String, dynamic> json) {
    project = json['project'];
    projectId = json['project_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project'] = project;
    data['project_id'] = projectId;
    return data;
  }
}
