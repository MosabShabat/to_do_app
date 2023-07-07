import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/provider/notes_provider.dart';
import 'package:to_do_app/shared_pref/shared_prefrance.dart';
import 'package:to_do_app/utils/helpers.dart';

import '../database/db_c.dart';
import '../model/note.dart';

class HomeScreen extends StatefulWidget{
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helpers{

  bool isLoading = false;
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData() async {

    setState((){
      isLoading = true;
    });
    Provider.of<NoteProvider>(context,listen: false).readData();
    // Future.delayed(Duration(seconds: 5),() {
    //
    // },);
    setState((){
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: ()  async {
              await SharedPrefController().clear();
              Navigator.pushNamedAndRemoveUntil(context, '/login_screen', (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_screen');
            },

            icon: const Icon(Icons.note_add),
          ),
        ],
      ),
      body: isLoading ?
          Center(child: CircularProgressIndicator(),)
          :Consumer<NoteProvider>(
            builder: (context, controller, _) {
              return ListView.builder(
                itemCount:controller.notes.length ,
                itemBuilder: (context, index) {
                  return CheckboxListTile(value: selectedIndex == index, onChanged: (value) {

                    setState(() {
                      selectedIndex = index;
                    });

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                              setState(() {
                                selectedIndex = -1;
                              });
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              bool isSuccess = await controller.deleteRow(id:Provider.of<NoteProvider>(context,listen: false).notes[selectedIndex]?.id);
                              if(isSuccess){
                                showSnackBar(context, message: "yes");
                              }else {
                                showSnackBar(context, message: "no",error: true);
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                    title: Text(controller.notes[index]!.title),
                    subtitle: Text(controller.notes[index]!.info),
                  );
                },);
            },
            child: Container()
          ),
    );
  }
}
