import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {

  static Future<Database> database() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'places.db'),
        onCreate: _createDb, version: 1);
  }

  static Future<void> _createDb(sql.Database db, int version) async {
    await db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY , title TEXT,image TEXT);');
  }

  static Future<void> insertPlace(
      String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    final response = await db.query(table);
    return response;
  }

}
