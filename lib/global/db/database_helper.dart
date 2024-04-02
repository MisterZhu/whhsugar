import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sugar/constants/su_default_value.dart';

class DatabaseHelper {
  // static const String _dbName = "sugar_app_db";
  static const int _dbVersion = 1;
  late Database database;
/*
1.初始化数据库：
await DatabaseHelper.instance.open();
2.获取会话列表Dao和聊天内容Dao：
final sessionListDao = SessionListDao(DatabaseHelper.instance._database);
final chatContentDao = ChatContentDao(DatabaseHelper.instance._database);
3.添加数据到会话列表：
await sessionListDao.insert({
  'name': 'Session 1',
  'description': 'Description for Session 1'
});
4.查询会话列表：
final sessionList = await sessionListDao.getAll();
5.关闭数据库：
await DatabaseHelper.instance.close();

* */
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, SUDefVal.kdbName);
    database =
        await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

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
