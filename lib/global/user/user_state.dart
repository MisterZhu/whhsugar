import 'package:get/get.dart';

import 'package:get/get.dart';

class UserState {
  String id;
  RxString name;
  String displayName;
  RxString avatar;
  // UserProperties properties;
  String createdTime;
  String updatedTime;
  String token;

  UserState({
    this.id = '',
    this.displayName = '',
    RxString? avatar,
    RxString? name,
    // required this.properties,
    this.createdTime = '',
    this.updatedTime = '',
    this.token = '',
  })  : avatar = avatar ?? ''.obs,
        name = name ?? ''.obs;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.value,
      'displayName': displayName,
      'avatar': avatar.value,
      // 'properties': properties.toJson(),
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'token': token,
    };
  }

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      id: json['id'] ?? '',
      name: RxString(json['name'] ?? ''),
      displayName: json['displayName'] ?? '',
      avatar: RxString(json['avatar'] ?? ''),
      // properties: UserProperties.fromJson(json['properties'] ?? {}),
      createdTime: json['createdTime'] ?? '',
      updatedTime: json['updatedTime'] ?? '',
      token: json['token'] ?? '',
    );
  }

  void updateToken(String newToken) {
    token = newToken;
  }
}

class UserProperties {
  final String project;
  final String projectId;

  UserProperties({
    required this.project,
    required this.projectId,
  });

  factory UserProperties.fromJson(Map<String, dynamic> json) {
    return UserProperties(
      project: json['project'] ?? '',
      projectId: json['projectId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project': project,
      'projectId': projectId,
    };
  }
}
