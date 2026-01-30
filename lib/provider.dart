import 'package:database_wscube/db_helper.dart';
import 'package:flutter/material.dart';

// VIEW MODEL

class DBProvider extends ChangeNotifier {
  DBHelper
  dbHelper; // DBHelper: This is likely a class created to manage SQLite database operations (Open, Insert, Query, Update, Delete).
  // dbHelper: This variable holds an instance of your database helper class, allowing the provider to call functions like dbHelper.insertUser(user).

  DBProvider({required this.dbHelper});
  // this.dbHelper: This assigns the passed DBHelper instance to the class variable dbHelper. This is dependency injection, ensuring the provider has access to the database handler.
  List<Map<String, dynamic>> _mData = [];

  void addNote(String title, String desc) async {
    bool check = await dbHelper.addNote(mtitle: title, mdesc: desc);
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  void updateNote(int sno, String title, String desc) async {
    bool check = await dbHelper.updateData(sno: sno, title: title, desc: desc);
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() => _mData;

  void getInitialNotes() async {
    _mData = await dbHelper.getAllNotes();
    notifyListeners();
  }

  void deleteNote(int sno) async {
    bool check = await dbHelper.deleteData(sno: sno);
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }
}
// data related tasks which we were initially doing in the HomePage is now here in the provider page .