
import 'package:notes_app/database/notebook_db_helper.dart';
import 'package:notes_app/database/notes_db_helper.dart';
import 'package:notes_app/home/modals/noteBook_modal.dart';
import 'package:notes_app/home/modals/notes_modal.dart';
import 'package:riverpod/riverpod.dart';

final homeNotifierProvider =
    NotifierProvider<HomeNotifier, Map<String, dynamic>>(() {
  return HomeNotifier();
});


class HomeNotifier extends Notifier<Map<String,dynamic>>{
  String notebookName="All notes";
  List<NotebookModal> notebooks=[];
  List<NotesModal> notesList = [];
  bool? gridView=false;

  @override
  Map<String, dynamic> build() {
   return {
     "notebookName":notebookName,
     "notebooks":notebooks,
     "notesList": notesList,
     "gridView":gridView
        };
  }

  void update(){
   state={
    ...state,
    "notebookName":notebookName,
    "notebooks":notebooks,
    "notesList": notesList,
    "gridView":gridView
   };
  }

    fetchNotes() async {
    final notesMaps = await NotesDbHelper.instance.queryAllNotes();
    var list;
      list = notesMaps.map((userMap) => NotesModal.fromMap(userMap)).toList(); 
      notesList.clear();
      for(NotesModal item in list){
        if(item.notebookName==state["notebookName"]){
          notesList.add(item);
        }
      }
      update();
  }
  // get List of notebooks
   fetchNotebooks() async {
    final notebookMaps = await NotebookDbHelper.instance.queryAllNotebooks();
      notebooks = notebookMaps.map((userMap) => NotebookModal.fromMap(userMap)).toList(); 
      update();
  }
 
 void changeNotebook(String name){
  notebookName=name;
  update();
 }

void changeViews(bool value){
  gridView =value;
  update();
}

}