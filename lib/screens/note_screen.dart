import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/database/db_c.dart';
import 'package:to_do_app/main.dart';
import '../model/note.dart';
import '../provider/notes_provider.dart';
import '../shared_pref/shared_prefrance.dart';
import '../utils/helpers.dart';
import '../widgets/app_text_field.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers {
  late TextEditingController _titleTextController;
  late TextEditingController _infoTextController;

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController(text: widget.note?.title);
    _infoTextController = TextEditingController(text: widget.note?.info);
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _infoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
             'note hint',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
              textController: _titleTextController,
              hint: 'title',
              prefixIcon: Icons.title,
            ),
            SizedBox(height: 10),
            AppTextField(
              textController: _infoTextController,
              hint: 'info',
              prefixIcon: Icons.info,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async => await _performSave(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text('save'),
            ),
          ],
        ),
      ),
    );
  }

  String get title {
    return 'new note';
  }

  bool get isNewNote => widget.note == null;

  Future<void> _performSave() async {
    if (_checkData()) {
      await _save();
    }
  }

  bool _checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _infoTextController.text.isNotEmpty) {
      return true;
    }
    // showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _save() async {
    bool isAddedCorrectlley = await Provider.of<NoteProvider>(context,listen: false).addNote(note);
    if(isAddedCorrectlley){
      Navigator.pop(context);
    } else {
      showSnackBar(context, message: 'problem', error: true);
    }

    ////////////////////////

    // int rowNumber = await database.insert('notes', {
    //   'title':'huda',
    //   'info':'info'
    // });
    //
    // print(rowNumber);
    // if(rowNumber > 0){
    //   Navigator.pop(context);
    // }else {
    //   showSnackBar(context, message: 'problem', error: true);
    // }

  }

  Note get note {
    Note note =  Note();
    note.title = _titleTextController.text;
    note.info = _infoTextController.text;
    return note;
  }

  void clear() {
    _titleTextController.clear();
    _infoTextController.clear();
  }
}
