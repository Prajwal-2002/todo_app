import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/task.dart';

class DbHelper {
  static Database? _db;
  static final String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) return;

    try {
      _db = await openDatabase(
        join(await getDatabasesPath(), 'tasks.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,note TEXT, date STRING,startTime STRING,endTime STRING,remind INTEGER,repeat STRING,color INTEGER,isCompleted INTEGER)');
        },
        version: 1,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  static Future<int?> insertTask(TaskModel task) async {
    //final db = await _db;
    return await _db?.insert(
          _tableName,
          task.toJson(),
        ) ??
        1;
  }

  static Future<List<Map<String, dynamic>>> tasks() async {
    return await _db!.query(_tableName);
  }

  static delete(TaskModel task) async {
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    await _db!.rawUpdate('''
        UPDATE tasks
        SET isCompleted = ?
        WHERE id = ?
        ''', [1, id]);
  }
}
