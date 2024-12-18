import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/database/notes_db_helper.dart';
import 'package:notes_app/home/controllers/home_controller.dart';
import 'package:notes_app/home/modals/notes_modal.dart';

// ignore: must_be_immutable
class FlutterQuillEditor extends ConsumerStatefulWidget {
   NotesModal? passedModel;
   dynamic doc;
   FlutterQuillEditor({super.key, this.doc ,this.passedModel});

  @override
  ConsumerState<FlutterQuillEditor> createState() => _FlutterQuillEditorState();
}

class _FlutterQuillEditorState extends ConsumerState<FlutterQuillEditor> {

  quill.QuillController controller = quill.QuillController.basic();
  dynamic docc;
  String? getData;
  late Delta delta;
// controller = quill.QuillController(
//   document: quill.Document.fromDelta(delta),
//   selection: TextSelection.collapsed(offset: 0),
// );
//  quill.QuillController controllerrr =quill.QuillController.basic();

@override
  void initState() {
    if(widget.doc!=null){
          docc=widget.doc; //////////////
     delta = Delta.fromJson(jsonDecode(widget.doc));

            final document = quill.Document.fromDelta(delta);
            controller= quill.QuillController(
                    document: document,
                    selection: const TextSelection.collapsed(offset: 0));}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   
          floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 204, 159, 212),
          child: const Text("save"),
          onPressed: () async {
            // saving and converting into json
            doc = await jsonEncode(controller.document.toDelta().toJson());
            debugPrint("doc data is $doc");
            
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2(doc: doc)));
          }),
      */
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
          title: Row(
            children: [
          
          const Spacer(),
          IconButton(
          onPressed: (){},
          icon: const Icon(Icons.share_outlined)),
          PopupMenuButton(itemBuilder: (BuildContext context) { 
            return [
              const PopupMenuItem(child: Text("hello"))
            ];
           },)
        ],
       )
      ),

      body: PopScope(
        onPopInvoked: (value) async{
            debugPrint("length of this doc is ${controller.document.length} and data is ${controller.document.toDelta().toString()}");
          
          if(controller.document.length>1){
          if(widget.doc==null){
          docc =  jsonEncode(controller.document.toDelta().toJson());
          await NotesDbHelper.instance.insertNote(NotesModal(creationTime: DateTime.now().toString(), content: docc, notebookName: ref.watch(homeNotifierProvider)["notebookName"]));

          }else{
            docc =  jsonEncode(controller.document.toDelta().toJson());
            debugPrint("new docc id $docc \n");
            NotesModal updateModal=NotesModal(id: widget.passedModel!.id,creationTime: widget.passedModel!.creationTime,content: docc, notebookName: ref.watch(homeNotifierProvider)["notebookName"]);
            await NotesDbHelper.instance.updateNotes(updateModal);
          } 
           ref.read(homeNotifierProvider.notifier).fetchNotes();      ////////
      }
        },
        child: Column(
          children: [
              Container(
              decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: quill.QuillToolbar.simple(
                  controller: controller,
                  configurations: const QuillSimpleToolbarConfigurations(
                
                    // decoration: BoxDecoration(),
                      showInlineCode: false,
                      showCodeBlock: false,
                      showFontFamily: false,
                      showListBullets: false,
                      showUndo: false,
                      showFontSize: false,
                      showRedo: false,
                      showClipboardCut: false,
                      toolbarSectionSpacing: 0,
                      showDividers: false,
                      toolbarIconAlignment: WrapAlignment.start,
                      toolbarIconCrossAlignment: WrapCrossAlignment.end,
                      buttonOptions: QuillSimpleToolbarButtonOptions(
                        
                          bold: QuillToolbarToggleStyleButtonOptions(
                              iconSize: 12),
                          italic: QuillToolbarToggleStyleButtonOptions(
                              iconSize: 12),
                          underLine: QuillToolbarToggleStyleButtonOptions(
                              iconSize: 12),
                          strikeThrough: QuillToolbarToggleStyleButtonOptions(
                              iconSize: 12),
                          subscript: quill.QuillToolbarToggleStyleButtonOptions(
                              iconSize: 12),
                          superscript: quill.QuillToolbarToggleStyleButtonOptions(
                              iconSize: 12),
                          color: quill.QuillToolbarColorButtonOptions(
                              iconSize: 12),
                          backgroundColor: quill.QuillToolbarColorButtonOptions(
                              iconSize: 12),
                          listNumbers:
                              quill.QuillToolbarToggleStyleButtonOptions(
                                  iconSize: 12),
                          toggleCheckList:
                              quill.QuillToolbarToggleCheckListButtonOptions(
                                  iconSize: 12),
                          selectHeaderStyleDropdownButton:
                              quill.QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                                  iconSize: 12),
                          quote: quill.QuillToolbarToggleStyleButtonOptions(iconSize: 12),
                          indentDecrease: quill.QuillToolbarIndentButtonOptions(iconSize: 12),
                          indentIncrease: quill.QuillToolbarIndentButtonOptions(iconSize: 12),
                          search: quill.QuillToolbarSearchButtonOptions(iconSize: 12),
                          clipboardCopy: quill.QuillToolbarToggleStyleButtonOptions(iconSize: 12),
                          clipboardPaste: quill.QuillToolbarToggleStyleButtonOptions(iconSize: 12)),
                      toolbarSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: QuillEditor.basic(
                configurations: const QuillEditorConfigurations(
                  autoFocus: true,
                  placeholder: "Add notes",
                  sharedConfigurations: QuillSharedConfigurations(),
                ),
                controller: controller,
                focusNode: FocusNode(),
              ),
            ),
          
            /*  quill.QuillEditor(
                  controller: controller, 
                 
                  scrollController: ScrollController(), 
                
                  focusNode: FocusNode(), 
            
            ), */
          ],
        ),
      ),
    );
  }
}
