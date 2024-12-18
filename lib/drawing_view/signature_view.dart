
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:flutter_signature_view/flutter_signature_view.dart';
// // import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// // import 'package:notes_app/drawing_view/signature_notifier.dart';


// // class SignatureViewWidget extends ConsumerStatefulWidget {
// //   const SignatureViewWidget({super.key});

// //   @override
// //   ConsumerState<SignatureViewWidget> createState() => _SignatureViewWidgetState();
// // }

// // class _SignatureViewWidgetState extends ConsumerState<SignatureViewWidget> {
// //   final GlobalKey<_SignatureViewWidgetState> signatureGlobalKey = GlobalKey();

// //   // Color categoryColor=Colors.black;

// //   @override
// //   Widget build(BuildContext context) {
// //     final signNotifp=ref.watch(signatureNotifierProvider);
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.amber,
// //         title: const Text("Signature View"),
// //         actions: [
// //           IconButton(
// //             onPressed: (){
          
// //           }, icon: Icon(Icons.save)),
// //           const Icon(
// //             Icons.undo,
// //             color: Colors.black,
// //           ),
//           // IconButton(
//           //     onPressed: () {
//           //       showDialog(
//           //         context: context,
//           //         builder: (BuildContext context) {
//           //           return AlertDialog(
//           //             content: Column(
//           //               mainAxisSize: MainAxisSize.min,
//           //               children: [
//           //                 ColorPicker(
//           //                     pickerColor: signNotifp["selectedColor"],
//           //                     onColorChanged: (value) {
//           //                       // setState(() {
//           //                       ref.read(signatureNotifierProvider.notifier).changeColor(value);
//           //                       // });
//           //                     })
//           //               ],
//           //             ),
//           //             // actions: [
//           //             //   TextButton(
//           //             //       onPressed: () {
//           //             //         setState(() {});
//           //             //         Navigator.pop(context);
//           //             //       },
//           //             //       child: const Text("Ok"))
//           //             // ],
//           //           );
//           //         },
//           //       );
//           //     },
//           //     icon: const Icon(Icons.menu))
// //         ],
// //         automaticallyImplyLeading: true,
// //       ),
// //       body: SignatureView(
// //         // canvas color
// //         backgroundColor: Colors.white,
// //         penStyle: Paint()
// //           // pen color
// //           ..color = signNotifp["selectedColor"]
// //           // type of pen point circular or rounded
// //           ..strokeCap = StrokeCap.round
// //           // pen pointer width
// //           ..strokeWidth = 3
// //           // ..colorFilter = ColorFilter.mode(Colors.pink, BlendMode.difference) // filter on color strokes
// //           // ..imageFilter=ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5) //blurs the strokes
// //           ..invertColors =
// //               false // inverts the colors we choose (try switching with button)
// //           // ..isAntiAlias = false //idk
// //           ..maskFilter = const MaskFilter.blur(
// //               BlurStyle.inner, 3) // kind of like flow in sketchbook
// //         //  ..shader=ShaderMask(shaderCallback: shaderCallback)  //idk
// //         ,

// //         // data of the canvas
// //         onSigned: (data) {
// //           debugdebugPrint("On change $data");
// //         },
// //       ),
// //     );
// //   }

// //     // Save the signature as an image
// //   Future<void> _saveSignature() async {
// //     if (_controller.isNotEmpty) {
// //       final Uint8List? data = await _controller.toPngBytes();
// //       if (data != null) {
// //         // Save the data to a file or upload it
// //         // For example, save it to a file
// //         final directory = await getApplicationDocumentsDirectory();
// //         final path = '${directory.path}/signature.png';
// //         final file = File(path);
// //         await file.writeAsBytes(data);
// //         debugPrint('Signature saved to $path');
// //       }
// //     }
// //   }
// // }
// ///////////////////////////////////////////////////////

// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:notes_app/drawing_view/signature_notifier.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:signature/signature.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// class SignatureExample extends ConsumerStatefulWidget {
//   @override
//   _SignatureExampleState createState() => _SignatureExampleState();
// }

// class _SignatureExampleState extends ConsumerState<SignatureExample> {
//   // Create a controller for the signature view

//   Color categoryColor = Colors.black;
//   var _signatureImage;
//   final TextEditingController nameController =TextEditingController();
//     final nameKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//    Future.delayed(const Duration(microseconds: 200),(){
//    showNameDialg();
//    });
//     super.initState();
//   }

    // void showNameDialg(){
    //   showDialog(context: context,
    //   builder: (BuildContext context) { 
    //    return  AlertDialog(
    //     content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //       children: [
    //          const Text("Name"),
    //          Form(
    //           key: nameKey,
    //            child: TextFormField(
    //             controller: nameController,
    //             validator: (value) {
    //               if(value!.trim().isEmpty){
    //                  return "No Name";
    //               }
    //               return null;
    //             },
    //            ),
    //          )
    //       ],
    //     ),
    //     actions: [
    //       TextButton(
    //        onPressed: (){
    //         if(nameKey.currentState!.validate()){
    //           nameKey.currentState!.save();
    //           _saveSignature();
    //           Navigator.pop(context);
    //         }
    //        },
    //        child: const Text("Ok")
    //       )
    //     ],
    //    );
    //   }
    //  );
    // }

//   @override
//   Widget build(BuildContext context) {
//     // showNameDialg();
//     final signNotifp = ref.watch(signatureNotifierProvider);
//     return Scaffold(
//       bottomNavigationBar: Container(
//         color: Colors.black,
//         child: Row(
//           children: [
//             IconButton(onPressed: (){
//               _saveSignature();
//                ref.read(signatureNotifierProvider.notifier).changeColor( Colors.green);
//                _loadSignature();
//             }, icon: const Icon(Icons.circle,color: Colors.green,)),
//                    IconButton(onPressed: (){
//                ref.read(signatureNotifierProvider.notifier).changeColor( Colors.blue);
//             }, icon: const Icon(Icons.circle,color: Colors.blue,)),
//                    IconButton(onPressed: (){
//                ref.read(signatureNotifierProvider.notifier).changeColor( Colors.black);
//             }, icon: const Icon(Icons.circle,color: Colors.black,)),
//                    IconButton(onPressed: (){
//                ref.read(signatureNotifierProvider.notifier).changeColor( Colors.white);
//             }, icon: const Icon(Icons.circle,color: Colors.white,)),
//                    IconButton(onPressed: (){
//                ref.read(signatureNotifierProvider.notifier).changeColor( Colors.red);
//             }, icon: const Icon(Icons.circle,color: Colors.red,)),
//                    IconButton(onPressed: (){
//                ref.read(signatureNotifierProvider.notifier).changeColor( Colors.yellow);
//             }, icon: const Icon(Icons.circle,color: Colors.yellow,))
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text("Signature Example"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _saveSignature,
//             ),
//             IconButton(
//               onPressed: () {
//                 _saveSignature();
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ColorPicker(
//                               pickerColor: signNotifp["selectedColor"],
//                               onColorChanged: (value) {
//                                 ref.read(signatureNotifierProvider.notifier).changeColor(value);
//                               })
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                             onPressed: () {
                        
//                               Navigator.pop(context);
//                               _loadSignature();
//                             },
//                             child: const Text("Ok"))
//                       ],
//                     );
//                   },
//                 );
//               },
//               icon: const Icon(Icons.menu))

//         ],
//       ),
//       body: Column(
//         children: [
//           // Signature Pad
//           Expanded(
//             child: Signature(
//               controller:signNotifp['_controller'],
//               backgroundColor: Colors.grey[200]!,
//             ),
//           ),
//           // Clear Button
//           ElevatedButton(
//             onPressed: () {
//               signNotifp['_controller'].clear();
//             },
//             child: const Text("Clear"),
//           ),
//         ],
//       ),
//     );
//   }

//   // Save the signature as an image
//   Future<void> _saveSignature() async {
//      final signNotifp=ref.watch(signatureNotifierProvider);
//     if (signNotifp['_controller'].isNotEmpty) {
//       final Uint8List? data = await signNotifp['_controller'].toPngBytes();
//       if (data != null) {
//         // Save the data to a file or upload it
//         // For example, save it to a file
//         final directory = await getApplicationDocumentsDirectory();
//         final path = '${directory.path}/${nameController.value}.png';
//         final file = File(path);
//         await file.writeAsBytes(data);
//         debugPrint('Signature saved to $path');
//       }
//     }
//   }

//   Future<void> _loadSignature() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final path = '${directory.path}/${nameController.value}.png';
//   final file = File(path);
//   if (await file.exists()) {
//     setState(() {
//       _signatureImage = Image.file(file); // Display the saved image
//     });
//   }
//  }

// }
/////////////////////////////////////////////


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/database/art_db_helper.dart';
import 'package:notes_app/drawing_view/model/art_model.dart';
import 'package:notes_app/drawing_view/signature_notifier.dart';
import 'package:path_provider/path_provider.dart';

final signatureProvider = ChangeNotifierProvider((_) => SignatureNotifier());

class SignatureExample extends ConsumerWidget {
  final TextEditingController nameController =TextEditingController();
    final nameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signatureProvider);


  Future showNameDialg() async{
      showDialog(context: context,
      builder: (BuildContext context) { 
       return  AlertDialog(
        content: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
             const Text("Name"),
             Form(
              key: nameKey,
               child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if(value!.trim().isEmpty){
                     return "No Name";
                  }
                  return null;
                },
               ),
             )
          ],
        ),
        actions: [
          TextButton(
           onPressed: ()async{
            if(nameKey.currentState!.validate()){
              nameKey.currentState!.save();
                final size = MediaQuery.of(context).size;
              final imageData = await ref.read(signatureProvider).exportAsImage(size);

              if (imageData != null) {
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/${nameController.text}.png');
                await file.writeAsBytes(imageData);
                // saving in database
              await ArtDbHelper.instance.insertArt(ArtModal(artPath: file.path, artName: nameController.text)).then((value){
                print("value added");
              }
              );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Saved to ${file.path}')),
                );
              }
              // Navigator.pop(context);
            }
           },
           child: const Text("Ok")
          )
        ],
       );
      }
     );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Signature Example"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(signatureProvider).saveCurrentStroke();
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              ref.read(signatureProvider).clearAll();
            },
            icon: const Icon(Icons.clear),
          ),
          IconButton(
            onPressed: () async {  
             await showNameDialg();
             
            },
            icon: const Icon(Icons.download),
          ),
          IconButton(
            onPressed: () async {
              final directory = await getApplicationDocumentsDirectory();
              final file = File('${directory.path}/drawing.png');

              if (await file.exists()) {
                await ref.read(signatureProvider).loadImage(file);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Loaded ${file.path}')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: const Text('No saved image found!')),
                );
              }
            },
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanUpdate: (details) {
              final renderBox = context.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(details.globalPosition);
              ref.read(signatureProvider).addPoint(localPosition);
            },
            onPanEnd: (_) {
              ref.read(signatureProvider).saveCurrentStroke();
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: SignaturePainter(
                strokes: notifier.strokes,
                currentStroke: notifier.currentStroke,
                currentColor: notifier.selectedColor,
                currentStrokeWidth: notifier.strokeWidth,
                backgroundImage: notifier.backgroundImage,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.circle, color: Colors.black),
            onPressed: () {
              ref.read(signatureProvider).changeColor(Colors.black);
            },
          ),
          IconButton(
            icon: const Icon(Icons.circle, color: Colors.red),
            onPressed: () {
              ref.read(signatureProvider).changeColor(Colors.red);
            },
          ),
          IconButton(
            icon: const Icon(Icons.circle, color: Colors.blue),
            onPressed: () {
              ref.read(signatureProvider).changeColor(Colors.blue);
            },
          ),
          IconButton(
            icon: const Icon(Icons.circle, color: Colors.green),
            onPressed: () {
              ref.read(signatureProvider).changeColor(Colors.green);
            },
          ),
        ],
      ),
    );
  }
}
