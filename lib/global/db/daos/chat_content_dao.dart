import 'package:sqflite/sqflite.dart';

import '../../../constants/su_default_value.dart';

class ChatContentDao {
  final Database _db;

  ChatContentDao(this._db);

  Future<void> insert(Map<String, dynamic> row) async {
    await _db.insert(SUDefVal.kChatContent, row);
  }

  ///批量插入
  Future<void> batchInsert(List<Map<String, dynamic>> mapValues) async {
    try {
      await _db.transaction((txn) async {
        for (var mapValue in mapValues) {
          String name = mapValue['name'];
          List<Map<String, dynamic>> existingRows = await txn.query(
            SUDefVal.kChatContent,
            where: 'name = ?',
            whereArgs: [name],
          );
          if (existingRows.isNotEmpty) {
            // 如果存在相同name的记录，则更新数据
            // await txn.update(
            //   SUDefVal.kChatContent,
            //   mapValue,
            //   where: 'name = ?',
            //   whereArgs: [name],
            // );

            ///如果不覆盖，放开continue，注释掉update代码
            continue;
          } else {
            // 否则插入新记录
            await txn.insert(SUDefVal.kChatContent, mapValue);
          }
        }
      });
    } catch (e) {
      throw Exception('Batch insert failed: $e');
    }
  }

  Future<void> update(Map<String, dynamic> row) async {
    await _db.update(SUDefVal.kChatContent, row);
  }

  Future<void> delete(int id) async {
    await _db.delete(SUDefVal.kChatContent, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(SUDefVal.kChatContent);
  }

  Future<List<Map<String, dynamic>>> query(
      String columnName, dynamic value) async {
    return await _db.query(
      SUDefVal.kChatContent,
      where: '$columnName = ?',
      whereArgs: [value],
    );
  }
}
