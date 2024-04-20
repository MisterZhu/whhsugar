import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constants/su_default_value.dart';

class SessionListDao {
  final Database _db;

  SessionListDao(this._db);

  ///插入
  Future<void> insertOrUpdate(Map<String, dynamic> row) async {
    try {
      String name = row['name'];
      List<Map<String, dynamic>> existingRows = await _db.query(
        SUDefVal.kSessionList,
        where: 'name = ?',
        whereArgs: [name],
      );
      if (existingRows.isNotEmpty) {
        //如果存在相同name的记录，则更新数据
        await _db.update(
          SUDefVal.kSessionList,
          row,
          where: 'name = ?',
          whereArgs: [name],
        );
      } else {
        // 否则插入新记录
        await _db.insert(SUDefVal.kSessionList, row);
      }
    } catch (e) {
      debugPrint('Insert or update failed: $e');
    }
    // await _db.insert(SUDefVal.kSessionList, row);
  }

  ///批量插入
  Future<void> batchInsert(List<Map<String, dynamic>> mapValues) async {
    try {
      await _db.transaction((txn) async {
        for (var mapValue in mapValues) {
          String name = mapValue['name'];
          List<Map<String, dynamic>> existingRows = await txn.query(
            SUDefVal.kSessionList,
            where: 'name = ?',
            whereArgs: [name],
          );
          if (existingRows.isNotEmpty) {
            // 如果存在相同name的记录，则更新数据
            await txn.update(
              SUDefVal.kSessionList,
              mapValue,
              where: 'name = ?',
              whereArgs: [name],
            );

            ///如果不覆盖，放开continue，注释掉update代码
            // continue;
          } else {
            // 否则插入新记录
            await txn.insert(SUDefVal.kSessionList, mapValue);
          }
        }
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

  Future<void> deleteAll() async {
    await _db.delete(SUDefVal.kSessionList);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(SUDefVal.kSessionList);
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
