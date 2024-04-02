import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sugar/constants/su_default_value.dart';

class DatabaseHelper {
  // static const String _dbName = "sugar_app_db";
  static const int _dbVersion = 1;
  late Database database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, SUDefVal.kdbName);
    database =
        await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // 公共的方法来获取数据库实例
  // static Database get database => _database;

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${SUDefVal.kSessionList} (
      id INTEGER PRIMARY KEY,
      name TEXT,
      displayName TEXT,
      description TEXT,
      assistant TEXT,
      owner TEXT,
      createTime TEXT,
      updateTime TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${SUDefVal.kChatContent} (
      id INTEGER PRIMARY KEY,
      sessionName TEXT,
      name TEXT,
      contentType TEXT,
      content TEXT,
      author TEXT,
      createTime TEXT,
      updateTime TEXT
    )
    ''');
  }

  Future<void> close() async {
    await database.close();
  }
}
