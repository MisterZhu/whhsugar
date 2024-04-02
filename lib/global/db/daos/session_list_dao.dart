import 'package:sqflite/sqflite.dart';

import '../../../constants/su_default_value.dart';

class SessionListDao {
  final Database _db;

  SessionListDao(this._db);

  ///插入
  Future<void> insert(Map<String, dynamic> row) async {
    await _db.insert(SUDefVal.kSessionList, row);
  }

  ///批量插入
  Future<void> batchInsert(List<Map<String, dynamic>> mapValues) async {
    try {
      await _db.transaction((txn) async {
        var batch = txn.batch();
        for (var mapValue in mapValues) {
          batch.insert(SUDefVal.kSessionList, mapValue);
        }
        await batch.commit();
      });
    } catch (e) {
      throw Exception('Batch insert failed: $e');
    }
  }

  Future<void> update(Map<String, dynamic> row) async {
    await _db.update(SUDefVal.kSessionList, row);
  }

  Future<void> delete(int id) async {
    await _db.delete(SUDefVal.kSessionList, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(SUDefVal.kSessionList);
  }
}
