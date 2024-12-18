import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/all_art/view/all_art_screen.dart';
import 'package:notes_app/create_notebook/create_notebook.dart';
import 'package:notes_app/database/notes_db_helper.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:notes_app/drawing_view/cust_painter.dart';
import 'package:notes_app/drawing_view/signature_view.dart';
import 'package:notes_app/editor/view/flutter_quill_editor.dart';

import 'package:intl/intl.dart';
import 'package:notes_app/home/controllers/home_controller.dart';



class Homescreen extends ConsumerStatefulWidget {
const   Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen>     with WidgetsBindingObserver{

 late quill.QuillController controller;
  
 late Delta delta;


  @override
  void initState() {
    super.initState();
    Future.microtask((){
    ref.read(homeNotifierProvider.notifier).fetchNotebooks();
    ref.read(homeNotifierProvider.notifier).fetchNotes();

    });
     WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    ref.read(homeNotifierProvider.notifier).fetchNotebooks();
    ref.read(homeNotifierProvider.notifier).fetchNotes();

    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final homenotif=ref.watch(homeNotifierProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.background,
          title: Row(
            children: [
             
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                     PopupMenuItem(
                      child:  const Row(
                        children: [
                          Text("GridView"),
                          SizedBox(width: 30,),
                          Icon(Icons.grid_on)
                        ],
                      ),
                      onTap: (){
                        ref.read(homeNotifierProvider.notifier).changeViews(true);
                      },),
                     PopupMenuItem(
                        child: const Row(
                          children: [
                           Text("ListView"),
                          SizedBox(width: 30,),
                           Icon(Icons.list)
                           
                           ]),
                        onTap: () {
                          ref
                              .read(homeNotifierProvider.notifier)
                              .changeViews(false);
                        }
                      ),
                    
                       PopupMenuItem(
                        child: const Row(
                          children: [
                           Text("Drawing view"),
                          SizedBox(width: 30,),
                           Icon(Icons.list)
                           
                           ]),
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>  SignatureExample()));
                        }
                      ),
                         PopupMenuItem(
                        child: const Row(
                          children: [
                           Text("All art screen"),
                          SizedBox(width: 30,),
                           Icon(Icons.list)
                           ]),
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>  AllArtScreen()));
                        }
                      ),

                  ];
                },
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: ()async{
                  await ref.read(homeNotifierProvider.notifier).fetchNotebooks();
                 showBottomSheet();
                },
                title: Text(
                  homenotif['notebookName'],
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                subtitle: Text("${homenotif['notesList'].length} notes",
                    style: Theme.of(context).textTheme.titleMedium),
                trailing: const Icon(Icons.arrow_drop_down)),
              


              ///////////////Listview Builder
          Visibility(
                visible: (homenotif['gridView']==true) ? false :true,
                child: Expanded(
                    child: ListView.builder(
                  itemCount: homenotif['notesList'].length,
                  itemBuilder: (BuildContext context, int index) {
                    ////
                   delta = Delta.fromJson(jsonDecode(homenotif['notesList'][index].content));
                  final document = quill.Document.fromDelta(delta);
                  controller= quill.QuillController(
                      document: document,
                      selection: const TextSelection.collapsed(offset: 0));
                      ///////
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlutterQuillEditor(
                                      doc: homenotif['notesList'][index].content,
                                      passedModel: homenotif['notesList'][index],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        height: 115,
                        padding: const EdgeInsets.all(10),
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.timelapse_rounded,
                                  color: Color.fromARGB(255, 159, 159, 159),
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                DateFormat("dd/MM/yyy").format(  DateTime.parse(homenotif['notesList'][index].creationTime) ),
                                  style: Theme.of(context).textTheme.displaySmall )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ///
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  // homenotif['notesList'][index].content,
                                  controller.document.toPlainText()
                                  ,style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing:  PopupMenuButton(
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                            child: const Text("Delete"),
                                            onTap: () async{
                                             await NotesDbHelper.instance.deleteNotes(index);
                                              setState(() {});
                                            },
                                          )
                                        ];
                                 },),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
                            ),
              ),
          ///////////////////ListView Builder
           
           Visibility(
            visible:  (homenotif['gridView']==true) ? true :false,
                child: Expanded(
                  //////////////gridview
                child: GridView.builder(
                  itemCount: homenotif['notesList'].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                    mainAxisExtent: 160,
                    crossAxisCount: 2,
                    childAspectRatio: 0.2),
                itemBuilder: (BuildContext context, int index) {
                       ////
                   delta = Delta.fromJson(jsonDecode(homenotif['notesList'][index].content));
                  final document = quill.Document.fromDelta(delta);
                  controller= quill.QuillController(
                      document: document,
                      selection: const TextSelection.collapsed(offset: 0));
                      ///////
                    return 
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlutterQuillEditor(
                                      doc: homenotif['notesList'][index].content,
                                      passedModel: homenotif['notesList'][index],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        height: 115,
                        padding: const EdgeInsets.all(10),
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.timelapse_rounded,
                                  color: Color.fromARGB(255, 159, 159, 159),
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                DateFormat("dd/MM/yyy").format(  DateTime.parse(homenotif['notesList'][index].creationTime) ),
                                  style: Theme.of(context).textTheme.displaySmall )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ///
                            
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  // homenotif['notesList'][index].content,
                                  controller.document.toPlainText()
                                  ,style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing:  PopupMenuButton(
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                            child: const Text("Delete"),
                                            onTap: () async{
                                             await NotesDbHelper.instance.deleteNotes(index);
                                              setState(() {});
                                            },
                                          )
                                        ];
                                 },),
                            )
                          ],
                        ),
                      ),
                    );
                    ////////////////////////////gridview
                },
              )))
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet() {
    final homenotif=ref.watch(homeNotifierProvider);

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled:
            true, // Set this to true to enable full screen modal
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.25,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
            padding: const EdgeInsets.all(20),
            decoration:  BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20))),
            child:  Column(
              children: <Widget>[
                     
            Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Notebooks" ,style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
              const  SizedBox(height: 20),
                 ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height/3,
                    maxWidth: MediaQuery.sizeOf(context).width
                  ),
                   child: GridView.builder(
                    itemCount: homenotif['notebooks'].length,
                                 gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 200,
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.2,
                                  crossAxisSpacing: 20
                                 ),
                                 itemBuilder: (BuildContext context, int index) {
                                  debugPrint("number of notebooks are ${homenotif['notebooks'].length}");
                                   return  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: (){
                            if(homenotif['notebooks'][index].title =="new Notebook"){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateNotebook()));
                            }
                            else{
                              ref.read(homeNotifierProvider.notifier).changeNotebook(homenotif['notebooks'][index].title);
                               ref.read(homeNotifierProvider.notifier).fetchNotes();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              color:(homenotif['notebooks'][index].background=="null")? Colors.red.shade300 : Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.horizontal(right:  Radius.circular(10)),
                              image:(homenotif['notebooks'][index].title !="new Notebook")? DecorationImage(image: AssetImage(homenotif['notebooks'][index].background),fit: BoxFit.cover):null
                            ),
                            child:
                            (homenotif['notebooks'][index].title=="new Notebook")
                            ? const Center(
                              child: Icon(Icons.add ),
                            )
                            :null
                            ,
                          ),
                        ),
                        Text(homenotif['notebooks'][index].title ,style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    );
                   
                   },),
                 ),
                //  const Text("hello")
      
                      ],
                    )
                  ]));
            },
          );
        });
  }
}
