import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart' ;
import 'package:to_do_app/database/db_c.dart';
import 'package:to_do_app/provider/notes_provider.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:to_do_app/screens/launch_screen.dart';
import 'package:to_do_app/screens/login.dart';
import 'package:to_do_app/screens/note_screen.dart';
import 'package:to_do_app/screens/register_screen.dart';
import 'package:to_do_app/shared_pref/shared_prefrance.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().getInit();
  await MyDataBase().createDataBase();
  // await DBContoller().initDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>NoteProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/login_screen': (context) =>  Login(),
            '/register_screen': (context) => const RegisterScreen(),
            '/home_screen': (context) => /*const*/ HomeScreen(),
            '/add_screen': (context) =>  NoteScreen(),
          },
      ),
    );
  }
}