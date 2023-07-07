import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/model/note.dart';

class MyDataBase {
 late  Database database;
  static MyDataBase? _inatcnse;

  MyDataBase._();

  factory MyDataBase(){
    return _inatcnse ??= MyDataBase._();
  }

  Future<void> createDataBase() async {
    Directory d = await getApplicationDocumentsDirectory();
    String path = join(d.path,'mySqlDataBase.sql');
    database = await openDatabase(path,version: 1,onCreate: (db, version) async {
      await db.execute('CREATE TABLE notes ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT NOT NULL,'
          'info TEXT NOT NULL,'
          'user_id INTEGER NOT NULL,'
          'FOREIGN KEY (user_id) references users(id)'
          ')');

      await db.execute('CREATE TABLE users ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'email TEXT NOT NULL,'
          'password TEXT NOT NULL'
          ')');

    },);
  }

}