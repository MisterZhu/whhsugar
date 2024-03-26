import 'package:get/get.dart';

class UserState {
  String name;
  int age;
  RxString avatar;
  String token;

  UserState({
    this.name = '',
    this.age = 0,
    RxString? avatar, // 移除默认值，使得该参数可选
    this.token = '',
  }) : avatar = avatar ?? ''.obs; // 初始化avatar参数
  // 将User对象转换为Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'avatar': avatar.value, // 获取RxString的值
      'token': token,
    };
  }

  // 从Map中构建User对象
  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      avatar: RxString(json['avatar'] ?? ''), // 使用RxString包装
      token: json['token'] ?? '',
    );
  }
  // 更新token属性的方法
  void updateToken(String newToken) {
    token = newToken;
  }
}
