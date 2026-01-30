import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._(); // private constructor

  static final DBHelper getInstance = DBHelper._(); // class onbject
  static final String tableName = "notes";
  static final String columnName = "s_no";
  static final String columnTitle = "title";
  static final String columnDesc = "desc";

  Database? myDB; // ? nullable type( it can handle null)

  //db open (path => if exists then open else create db)
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;

    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await openDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory dirPath = await getApplicationDocumentsDirectory();
    String dbPath = join(dirPath.path, "noteDB.db");
    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $tableName($columnName INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, $columnDesc TEXT)",
        );
      },
      version: 1,
    );
  }

  //all queries
  // insertion
  Future<bool> addNote({required String mtitle, required String mdesc}) async {
    var db = await getDB();
    int rowsEffected = await db.insert(tableName, {
      columnTitle: mtitle,
      columnDesc: mdesc,
    });

    return rowsEffected > 0;
  }

  //  reading all data
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(tableName);
    return mData;
  }

  Future<bool> updateData({
    required String title,
    required String desc,
    required int sno,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.update(tableName, {
      columnTitle: title,
      columnDesc: desc,
    }, where: "$columnName = $sno");
    return rowsEffected > 0;
  }

  Future<bool> deleteData({required int sno}) async {
    var db = await getDB();
    int row = await db.delete(
      tableName,
      where: "$columnName = ?",
      whereArgs: [sno],
    );
    return row > 0;
  }
}
