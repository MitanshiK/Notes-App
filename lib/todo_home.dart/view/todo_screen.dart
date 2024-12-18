import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/database/todo_db_helper.dart';
import 'package:notes_app/todo_home.dart/controller/todo_controller.dart';
import 'package:notes_app/todo_home.dart/modal/todo_modal.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(todoNotifierProvider.notifier).fetchTodo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoNotif = ref.watch(todoNotifierProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.background,
          title: Row(
            children: [
              const Spacer(),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [const PopupMenuItem(child: Text("edit"))];
                },
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Scrollbar(
            thickness:0 ,
            child: SingleChildScrollView( // Wrap the entire content in a scrollable view
              child: Column(
                children: [
                  
                    ListTile(
                      title: Text(
                        "To-dos",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      subtitle:   
                    Visibility(
                    visible:(todoNotif["pendTodo"].length==0) ? false : true ,
                        child: Text(
                          "To-dos (${todoNotif["pendTodo"].length})",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: todoNotif['pendHeight'] ?? 0,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,  // Makes ListView take only as much space as it needs
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todoNotif["pendTodo"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(bottom: 10),
                           decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                           ),
                          child: CheckboxListTile(
                            value: todoNotif["checkValue"],
                            onChanged: (value) async {
                              todoNotif["checkValue"] = value;
                              TodoModal updateModal = TodoModal(
                                id: todoNotif["pendTodo"][index].id,
                                content: todoNotif["pendTodo"][index].content,
                                done: "$value",
                              );
                              await TodoDbHelper.instance.updateTodo(updateModal);
                              ref.read(todoNotifierProvider.notifier).fetchTodo();
                            },
                            title: Text(todoNotif["pendTodo"][index].content),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        );
                      },
                    ),
                  ),
                    Visibility(
                    visible:( todoNotif["doneTodo"].length==0) ? false : true,
                    child: ListTile(
                      subtitle: Text(
                        "Done (${todoNotif["doneTodo"].length})",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: todoNotif['doneHeight'] ?? 0,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,  // Makes ListView take only as much space as it needs
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todoNotif["doneTodo"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Opacity(
                          opacity: 0.5,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(bottom: 10),
                             decoration: const BoxDecoration(
                              // backgroundBlendMode: BlendMode.overlay,
                              color: Color.fromARGB(255, 191, 191, 191),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                             ),
                            child: CheckboxListTile(
                              value: todoNotif["checkValue2"],
                              onChanged: (value) async {
                                todoNotif["checkValue2"] = value;
                                TodoModal updateModal = TodoModal(
                                  id: todoNotif["doneTodo"][index].id,
                                  content: todoNotif["doneTodo"][index].content,
                                  done: "$value",
                                );
                                await TodoDbHelper.instance.updateTodo(updateModal);
                                ref.read(todoNotifierProvider.notifier).fetchTodo();
                              },
                              title: Text(todoNotif["doneTodo"][index].content),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
