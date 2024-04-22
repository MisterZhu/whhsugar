import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sugar/constants/su_default_value.dart';

import '../../su_export_comment.dart';

class DatabaseHelper {
  // static const String _dbName = "sugar_app_db";
  static const int _newVersion = 1;

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
    debugPrint('----------------db path : $path');

    database = await openDatabase(
      path, version: _newVersion,
      // onUpgrade: (db, old, newV) {
      //   _oldVersion = old;
      // },
      // 数据库降级时触发的回调
      // onDowngrade: (db, old, newV) {
      //   _oldVersion = old;
      // },
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      readOnly: false, // 确保设置为可写模式
    );
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
      avatarUrl TEXT,
      backgroundImage TEXT,
      lastTime TEXT,
      lastMessage TEXT,
      assistantName TEXT,
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

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('Upgrading database from version $oldVersion to $newVersion');

    ///如果新的版本数据表结构发生变化，请在此处判断对于版本，并进行数据表结构修改，具体修改命令请自行百度
    ///https://www.jb51.net/article/279814.htm
    // // Perform migration based on oldVersion
    // if (oldVersion == 1 && newVersion == 2) {
    //   // Version 2 migration: Add avatarUrl and backgroundImage to kSessionList
    //   await db.execute(
    //       'ALTER TABLE ${SUDefVal.kChatContent} ADD COLUMN avatarUrl TEXT');
    // }
  }

  Future<void> close() async {
    await database.close();
  }
}
