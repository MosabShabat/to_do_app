import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/database/operations/operation.dart';
import 'package:to_do_app/model/note.dart';

import '../db_c.dart';

class NoteOPerations extends DBOperation<Note?>{
  Database database = MyDataBase().database;
  @override
  Future<int> delete({int? id}) async {
    int numberOfRow = await database.delete('notes',where: 'id = ?',whereArgs: [id]);
    return numberOfRow;
  }

  @override
  Future<int> insert({Note? data}) async {
    int rowNumber = await database.insert('notes', {
      'title':data?.title,
      'info':data?.info
    });
    return rowNumber;
  }

  @override
  Future<List<Note?>> read() async {
    List<Map<String, dynamic>> data = await database.rawQuery("select * from notes");
    List<Note> notes = data.map((e) {
      return Note.fromMap(e);
    }).toList();

    return notes;
  }

  @override
  Future<bool> update({Note? data}) async {
    int numberOfRow = await database.update('notes',  {
      'title':data?.title,
      'info':data?.info,
    },where: 'id = ?',whereArgs: [data?.id]);

    if(numberOfRow >0 ){
      return true;
    }else {
      return false;
    }
  }



}