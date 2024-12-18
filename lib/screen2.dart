import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';


// ignore: must_be_immutable
class Screen2 extends StatefulWidget {
   String doc;
   Screen2({super.key ,required this.doc});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
 late quill.QuillController controller =quill.QuillController.basic();
  dynamic doc;
//  late Delta delta;

@override
  void initState() {
 /* delta = Delta.fromJson(jsonDecode(widget.doc));

            final document = quill.Document.fromDelta(delta);
            controller= quill.QuillController(
                    document: document,
                    selection: const TextSelection.collapsed(offset: 0)); */
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 204, 159, 212),
          child: const Text("save"),
          onPressed: () async {
            // saving and converting into json
           /* doc = jsonEncode(controller.document.toDelta().toJson());
            print("doc data is $doc");

            final delta = Delta.fromJson(jsonDecode(doc));

            final document = quill.Document.fromDelta(delta);
            var dta = quill.QuillController(
                    document: document,
                    selection: const TextSelection.collapsed(offset: 0))
                    .pastePlainText;
            print("getdata is $dta"); */
          }),
      appBar: AppBar(
        title: const Text("Text Editor"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 204, 159, 212)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: quill.QuillToolbar.simple(
                  controller: controller,
                  configurations: const QuillSimpleToolbarConfigurations(
                      showInlineCode: false,
                      showCodeBlock: false,
                      showFontFamily: false,
                      showListBullets: false,
                      showUndo: false,
                      showRedo: false,
                      showClipboardCut: false,
                      toolbarSectionSpacing: 0,
                      showDividers: false,
                      toolbarIconAlignment: WrapAlignment.start,
                      toolbarIconCrossAlignment: WrapCrossAlignment.end,
                      buttonOptions: QuillSimpleToolbarButtonOptions(
                          fontSize:
                              QuillToolbarFontSizeButtonOptions(iconSize: 12),
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
                          listNumbers:quill.QuillToolbarToggleStyleButtonOptions(
                                  iconSize: 12),
                          toggleCheckList:quill.QuillToolbarToggleCheckListButtonOptions(
                                  iconSize: 12),
                          selectHeaderStyleDropdownButton:quill.QuillToolbarSelectHeaderStyleDropdownButtonOptions(
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
          
          ],
        ),
      ),
    );
  }
}
