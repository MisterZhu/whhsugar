import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static final SharedPreferenceUtil _instance =
      SharedPreferenceUtil._internal();

  factory SharedPreferenceUtil() {
    return _instance;
  }

  SharedPreferenceUtil._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 示例方法，用于保存数据到SharedPreferences
  Future<void> saveData(String key, dynamic value) async {
    switch (value.runtimeType) {
      case String:
        await _prefs.setString(key, value);
        break;
      case int:
        await _prefs.setInt(key, value);
        break;
      case double:
        await _prefs.setDouble(key, value);
        break;
      case bool:
        await _prefs.setBool(key, value);
        break;
      case const (List<String>):
        await _prefs.setStringList(key, value);
        break;
      default:
        throw Exception('Unsupported value type.');
    }
    // if (value is String) {
    //   await _prefs.setString(key, value);
    // } else if (value is int) {
    //   await _prefs.setInt(key, value);
    // } else if (value is double) {
    //   await _prefs.setDouble(key, value);
    // } else if (value is bool) {
    //   await _prefs.setBool(key, value);
    // } else if (value is List<String>) {
    //   await _prefs.setStringList(key, value);
    // } else {
    //   throw Exception('Unsupported value type.');
    // }
  }

  // 示例方法，用于从SharedPreferences获取数据
  dynamic getData(String key) {
    if (!_prefs.containsKey(key)) {
      // throw Exception('Key does not exist in SharedPreferences.');
      return null;
    }
    return _prefs.get(key);
  }

  dynamic getString(String key) {
    if (!_prefs.containsKey(key)) {
      // throw Exception('Key does not exist in SharedPreferences.');
      return '';
    }
    return _prefs.getString(key);
  }

  // 示例方法，用于移除数据从SharedPreferences
  Future<void> removeData(String key) async {
    if (!_prefs.containsKey(key)) {
      throw Exception('Key does not exist in SharedPreferences.');
    }
    await _prefs.remove(key);
  }

  // 示例方法，用于清除所有数据从SharedPreferences
  Future<void> clearAllData() async {
    await _prefs.clear();
  }
}
