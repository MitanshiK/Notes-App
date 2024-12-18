import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/create_notebook/create_book_controller.dart';
import 'package:notes_app/database/notebook_db_helper.dart';
import 'package:notes_app/home/modals/noteBook_modal.dart';

class CreateNotebook extends StatefulWidget {
  const CreateNotebook({super.key});

  @override
  State<CreateNotebook> createState() => _CreateNotebookState();
}

class _CreateNotebookState extends State<CreateNotebook> {


  List<String> bookCovers=[
    "assets/moonTower2.webp",
    "assets/stAlbum.webp",
     "assets/stAlbum3.png",
     "assets/StAlbum2.jpg",
     "assets/verticleBg.png",
     "assets/wp2682156-steven-universe-hd-wallpapers.jpg",
     "assets/wp2682206-steven-universe-hd-wallpapers.jpg",
    ];

  @override
  Widget build(BuildContext context) {
    final createBookController = Get.find<CreateBookController>();

    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.close)),
            title: Row(
              children: [
                Text("New Notebook",style: Theme.of(context).textTheme.titleSmall,),
                const Spacer(),
                Obx(
                    ()=> IconButton(
                   onPressed:(){
                    NotebookDbHelper.instance.createNotebook(NotebookModal(background: createBookController.selected.value, title: createBookController.notebookController.value.text.trim()));
                    Navigator.pop(context);
                   },
                  icon:  Icon(
                      Icons.done,color:  (createBookController.notebookController.value.text.trim().isEmpty) ? Colors.grey.shade400 :null,
                      ),
                  ))
              ],
            ),
        ),
        body:  Padding(padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Expanded(
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 200
                      ),
                      child: Obx(
                        ()=> TextField(
                          autofocus: false,
                          controller: createBookController.notebookController.value,
                          minLines: 1,
                        decoration: InputDecoration(
                          suffix: IconButton(
                            onPressed: (){
                            createBookController.notebookController.value.clear();
                          }, icon: const Icon(Icons.close)),
                        hintText: "Notebook Title",
                        hintStyle: TextStyle(color: Colors.grey.shade500 ,fontFamily: "Euclid" ,fontSize: 18),
                        
                        ),
                        ),
                      ),
                    ),
                      const SizedBox(height: 50,),
                      Obx(
                        ()=> Container(
                          width: 190,
                          height: 300,
                         decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(createBookController.selected.value),fit: BoxFit.cover),
                          color: Colors.red.shade400,
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(20))
                         ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text("Select a cover",style:Theme.of(context).textTheme.titleMedium),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: MediaQuery.sizeOf(context).width
              ),
              
              child: Expanded(
                child: ListView.builder(
                  itemCount: bookCovers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                        ()=>  GestureDetector(
                                  onTap: (){
                                    // setState(() {
                                   createBookController.getCover(bookCovers[index]);
                                      
                                    // });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 100,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: (createBookController.selected.value ==bookCovers[index])?Colors.purple : Colors.transparent,width: 3,strokeAlign: BorderSide.strokeAlignOutside),
                                      color: Theme.of(context).colorScheme.background,
                                      borderRadius: const BorderRadius.horizontal(right:  Radius.circular(10)),
                                      image: DecorationImage(image: AssetImage(bookCovers[index]),fit: BoxFit.cover)
                                    ),
                                  ),
                                ),
                      );
                    },
                  ),
              ),
            )
          ],
        ),),
      ),
    );
  }
}