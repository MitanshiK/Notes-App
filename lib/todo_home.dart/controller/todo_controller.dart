
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/database/todo_db_helper.dart';
import 'package:notes_app/todo_home.dart/modal/todo_modal.dart';

final todoNotifierProvider =
    NotifierProvider<TodoNotifier, Map<String, dynamic>>(() {
  return TodoNotifier();
});


class TodoNotifier extends Notifier<Map<String,dynamic>>{
List<TodoModal> pendTodo=[];
List<TodoModal> doneTodo=[];
bool? checkValue=false;
bool? checkValue2=true;
double? pendHeight;
double? doneHeight;




  @override
  Map<String, dynamic> build() {
  return {
  "pendTodo":pendTodo,
  "doneTodo":doneTodo,
  "checkValue":checkValue,
  "checkValue2":checkValue2,
  "pendHeight":pendHeight,
  "doneHeight":doneHeight,
   };
  }
  
  void update(){
    state={
    ...state,
    "pendTodo":pendTodo,
    "doneTodo":doneTodo,
    "checkValue":checkValue,
    "checkValue2":checkValue2,
  "pendHeight":pendHeight,
    "doneHeight":doneHeight,
    };
  }

    fetchTodo() async {
    final notesMaps = await TodoDbHelper.instance.queryAllTodo();
    var list;
      list = notesMaps.map((userMap) => TodoModal.fromMap(userMap)).toList(); 
      pendTodo.clear();
      doneTodo.clear();
      for(TodoModal item in list){
        if(item.done == "false"){
          pendTodo.add(item);
        }
        else{
          doneTodo.add(item);
        }
        pendHeight=pendTodo.length * 85;
         doneHeight=doneTodo.length * 85;
      }
      debugPrint("items in todo list are $pendTodo");
      update();
  }

  // void changeCheck(bool check){
  //   checkValue=check;
  //   update();
  // }
}