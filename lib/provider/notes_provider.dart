import 'package:flutter/material.dart';
import 'package:to_do_app/database/operations/note_operation.dart';

import '../database/db_c.dart';
import '../model/note.dart';

class NoteProvider extends ChangeNotifier {
   List<Note?> notes  = [];


   readData() async {
     notes = await NoteOPerations().read();
     notifyListeners();
   }

   Future<bool> addNote(note) async {
      int rowNumber =  await NoteOPerations().insert( data: note);
      if(rowNumber > 0){
        note.id = rowNumber;
        notes.add(note);
        notifyListeners();
        return true;
      }else {
        return false;
      }

   }

   Future<bool> deleteRow({id}) async {
     int numberOfRow = await NoteOPerations().delete(id: id);
     if(numberOfRow >0 ){
       var deletedNote = notes.firstWhere((element) => element?.id == id);
      notes.remove(deletedNote);
      notifyListeners();
       return true;
     }else {
       return false;
     }
   }
   updateRow({note}){

   }
}