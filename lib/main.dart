import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:notes_app/create_notebook/binding_class.dart';
import 'package:notes_app/database/databasehelper.dart';
import 'package:notes_app/database/notebook_db_helper.dart';
import 'package:notes_app/home/views/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDb();
  _initializeBooksOnce();
  // await NotebookDbHelper.instance.initializeNoteBook();
  // await NotesDbHelper.instance.initializeNotes();
  runApp( const ProviderScope(child: MyApp()));
}

 _initializeBooksOnce() async{
  final prefs=await SharedPreferences.getInstance();
    
   bool isFirstRun=  prefs.getBool("isFirstRun") ?? true;

   if(isFirstRun){
   await NotebookDbHelper.instance.initializeNoteBook();
   prefs.setBool("isFirstRun", false);
   }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingClass(),
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          displayLarge:  TextStyle(
            fontFamily: "Euclid",
            fontSize: 35,
            fontWeight: FontWeight.w300
          ),
          titleMedium: TextStyle(
            fontFamily: "Euclid",
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 104, 104, 104)
          ),
          displaySmall:  TextStyle(
            fontFamily: "Euclid",
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 159, 159, 159)
          ),
          titleSmall: TextStyle(
            fontFamily: "Euclid",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Euclid",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        colorScheme:  const ColorScheme.dark(
          background: Colors.black,
          primary: Color.fromARGB(255, 214, 176, 220),
          secondary: Color.fromARGB(255, 55, 55, 55)
        ),
        useMaterial3: true,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
          displayLarge:  TextStyle(
            fontFamily: "Euclid",
            fontSize: 35,
            fontWeight: FontWeight.w300
          ),
          titleMedium: TextStyle(
            fontFamily: "Euclid",
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 107, 107, 107)
          ),
          displaySmall:  TextStyle(
            fontFamily: "Euclid",
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 159, 159, 159)
          ),
          titleSmall: TextStyle(
            fontFamily: "Euclid",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Euclid",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(255, 237, 237, 237),
          primary: Color.fromARGB(255, 214, 176, 220),
          secondary: Colors.white
        ),
        useMaterial3: true,
      ),
      home: const BottomNav(),
    );
  }
}
