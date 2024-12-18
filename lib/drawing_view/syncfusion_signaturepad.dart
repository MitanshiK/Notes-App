// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';


// class SyncfusionSignView extends StatefulWidget {
//   const SyncfusionSignView({super.key});

//   @override
//   State<SyncfusionSignView> createState() => _SyncfusionSignViewState();
// }

// class _SyncfusionSignViewState extends State<SyncfusionSignView> {
// @override
//   Widget build(BuildContext context) {

//     return  Scaffold(
//       appBar: AppBar(actions:  [
//           const Icon(
//             Icons.undo,
//             color: Colors.black,
//           ),
//           IconButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ColorPicker(
//                               pickerColor: categoryColor,
//                               onColorChanged: (value) {
//                                 // setState(() {
//                                 ref.read(signatureNotifierProvider.notifier).changeColor(value);
//                                 // });
//                               })
//                         ],
//                       ),
//                       // actions: [
//                       //   TextButton(
//                       //       onPressed: () {
//                       //         setState(() {});
//                       //         Navigator.pop(context);
//                       //       },
//                       //       child: const Text("Ok"))
//                       // ],
//                     );
//                   },
//                 );
//               },
//               icon: const Icon(Icons.menu))
//         ],),
//       body: Center(
//         child: SizedBox(
//           height: 200,
//           width: 300,
//           child: SfSignaturePad(
//             minimumStrokeWidth: 1,
//             maximumStrokeWidth: 3,
//             strokeColor: Colors.blue,
//             backgroundColor: Colors.grey,
//           ),
//         ),
//       ),
//     );
//   }
// }