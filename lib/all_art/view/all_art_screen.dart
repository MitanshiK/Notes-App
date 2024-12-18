import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/all_art/controller/all_art_controller.dart';
import 'package:notes_app/database/art_db_helper.dart';
import 'package:notes_app/drawing_view/signature_view.dart';

class AllArtScreen extends ConsumerStatefulWidget {
  const AllArtScreen({super.key});

  @override
  ConsumerState<AllArtScreen> createState() => _AllArtScreenState();
}

class _AllArtScreenState extends ConsumerState<AllArtScreen> {
  @override
  Widget build(BuildContext context) {
  final artNotifProvider=ref.watch(allArtNotifierProvider);

    debugPrint("artlist length is ${artNotifProvider['artList'].length}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("All art"),),
        body: Padding(padding: const EdgeInsets.all(10),
        child: Column(
           children: [
            Expanded(
                  //////////////gridview
                child: GridView.builder(
                  itemCount: artNotifProvider['artList'].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                    mainAxisExtent: 160,
                    crossAxisCount: 2,
                    childAspectRatio: 0.2),
                itemBuilder: (BuildContext context, int index) {
                    return  
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignatureExample()
                                    
                                    ));
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
                            const Row(
                              children: [
                                Icon(
                                  Icons.timelapse_rounded,
                                  color: Color.fromARGB(255, 159, 159, 159),
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                // Text(
                                // DateFormat("dd/MM/yyy").format(  DateTime.parse(artNotifProvider['notesList'][index].creationTime) ),
                                //   style: Theme.of(context).textTheme.displaySmall )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ///
                            
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  // artNotifProvider['notesList'][index].content,
                                  artNotifProvider["artList"][index].artName
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
                                             await ArtDbHelper.instance.deleteArt(index);
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
              ))
           ],
        ),),
      ),
    );
  }
}