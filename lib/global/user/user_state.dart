class UserState {
  String name;
  int age;
  String avatar;
  String token;

  UserState({this.name = '', this.age = 0, this.avatar = '', this.token = ''});
  // 将User对象转换为Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'avatar': avatar,
      'token': token,
    };
  }

  // 从Map中构建User对象
  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      avatar: json['avatar'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
