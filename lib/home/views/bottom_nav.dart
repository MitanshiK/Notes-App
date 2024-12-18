import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/database/todo_db_helper.dart';
import 'package:notes_app/editor/view/flutter_quill_editor.dart';
import 'package:notes_app/home/views/home_screen.dart';
import 'package:notes_app/todo_home.dart/controller/todo_controller.dart';
import 'package:notes_app/todo_home.dart/modal/todo_modal.dart';
import 'package:notes_app/todo_home.dart/view/todo_screen.dart';

int myIndex = 0;

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageView.builder(
        controller: pageController,
        onPageChanged: (value) => {
          setState(() {
            myIndex = value;
          })
        },
        itemBuilder: (BuildContext context, int index) {
          return (myIndex == 0) ? Homescreen() : const TodoScreen();
        },
        itemCount: 2,
      )
      // // screenList[myIndex],
      ,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
            onTap: (value) {
              pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut);
              // pageController.animateToPage(page, duration: duration, curve: curve)
              setState(() {
                myIndex = value;
              });
            },
            selectedItemColor:  Theme.of(context).colorScheme.primary,
            unselectedItemColor: const Color.fromARGB(255, 118, 118, 118),
            currentIndex: myIndex,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 3,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.note_sharp),
                  label: "Notes",
                  tooltip: "Notes"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  label: "Todo",
                  tooltip: "Todo"),
            ]),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () async {
          if (myIndex == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FlutterQuillEditor()));
          } else {
           showDialog(
            context: context,
            builder: (BuildContext context) { 
              TextEditingController todoController=TextEditingController();

              return AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                // title: Text("Add a Todo" ,style: Theme.of(context).textTheme.titleSmall,),
                content: TextField(
                  autofocus: true,
                  controller: todoController,
                 decoration: InputDecoration(
                  hintText: "New To-do",
                  hintStyle: TextStyle(color: Colors.grey.shade500 ,fontFamily: "Euclid" ,fontSize: 14),
                  border: InputBorder.none
                 ),
                ),
                actions: [
                  TextButton(
                  onPressed: () async{
                     Navigator.pop(context);
                     await TodoDbHelper.instance.insertTodo(TodoModal(content: todoController.text.trim(),done: "false"));
                     ref.read(todoNotifierProvider.notifier).fetchTodo(); 
                       
                  }, child:const Text("Save"))
                ],
              );
             },);
           //////////////
          }
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary
                    ),
            child: const Icon(Icons.add)),
      ),
    );
  }
}
