
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// final signatureNotifierProvider =
//     NotifierProvider<SignatureNotifier, Map<String, dynamic>>(() {
//   return SignatureNotifier();
// });


// class SignatureNotifier extends Notifier<Map<String,dynamic>>{

//  Color selectedColor=Colors.black;
//  late SignatureController  _controller;
//  double strokeWidth=1;

//   @override
//   Map<String, dynamic> build() { 
//     return {
//       "selectedColor":selectedColor,
//       "strokeWidth":strokeWidth,
//       "_controller": SignatureController(
//     penStrokeWidth: 5,
//     penColor:selectedColor,
//     exportBackgroundColor: Colors.white,
//    )
//     };
//   }

//   void updatevar(){
//     state={
//       ...state,
//       "selectedColor":selectedColor,
//       "strokeWidth":strokeWidth,
//       "_controller" :SignatureController(
//     penStrokeWidth: 5,
//     penColor:selectedColor,
//     exportBackgroundColor: Colors.white,
//    )
//     };
//   }

//   void changeColor(Color color){
//     selectedColor=color;
//     updatevar();
//   }


// }


class Stroke {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  Stroke({required this.points, required this.color, required this.strokeWidth});
}


// class SignatureNotifier extends ChangeNotifier {
//   List<Stroke> strokes = [];
//   List<Offset?> currentStroke = [];
//   Color selectedColor = Colors.black;
//   double strokeWidth = 5;
//
//   void changeColor(Color color) {
//     if (currentStroke.isNotEmpty) {
//       saveCurrentStroke();
//     }
//     selectedColor = color;
//     notifyListeners();
//   }
//
//   void addPoint(Offset point) {
//     currentStroke.add(point);
//     notifyListeners();
//   }
//
//   void saveCurrentStroke() {
//     if (currentStroke.isNotEmpty) {
//       strokes.add(Stroke(
//         points: List.from(currentStroke),
//         color: selectedColor,
//         strokeWidth: strokeWidth,
//       ));
//       currentStroke.clear();
//       notifyListeners();
//     }
//   }
//
//   void clearAll() {
//     strokes.clear();
//     currentStroke.clear();
//     notifyListeners();
//   }
//
//   Future<Uint8List?> exportAsImage(Size size) async {
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);
//
//     // Paint the strokes on the canvas
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     for (final stroke in strokes) {
//       paint.color = stroke.color;
//       paint.strokeWidth = stroke.strokeWidth;
//       _drawStroke(canvas, paint, stroke.points);
//     }
//
//     // Add the current stroke as well
//     paint.color = selectedColor;
//     paint.strokeWidth = strokeWidth;
//     _drawStroke(canvas, paint, currentStroke);
//
//     final picture = recorder.endRecording();
//     final image = await picture.toImage(size.width.toInt(), size.height.toInt());
//     final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     return byteData?.buffer.asUint8List();
//   }
//
//   void _drawStroke(Canvas canvas, Paint paint, List<Offset?> points){
//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i]!, points[i + 1]!, paint);
//       }
//     }
//   }
// }


class SignatureNotifier extends ChangeNotifier {
  List<Stroke> strokes = [];
  List<Offset?> currentStroke = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  ui.Image? backgroundImage; // Store the loaded image

  void changeColor(Color color) {
    if (currentStroke.isNotEmpty) {
      saveCurrentStroke();
    }
    selectedColor = color;
    notifyListeners();
  }

  void addPoint(Offset point) {
    currentStroke.add(point);
    notifyListeners();
  }

  void saveCurrentStroke() {
    if (currentStroke.isNotEmpty) {
      strokes.add(Stroke(
        points: List.from(currentStroke),
        color: selectedColor,
        strokeWidth: strokeWidth,
      ));
      currentStroke.clear();
      notifyListeners();
    }
  }

  void clearAll() {
    strokes.clear();
    currentStroke.clear();
    backgroundImage = null; // Clear the background image
    notifyListeners();
  }

  Future<Uint8List?> exportAsImage(Size size) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Draw the background image if it exists
    if (backgroundImage != null) {
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: backgroundImage!,
      );
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final stroke in strokes) {
      paint.color = stroke.color;
      paint.strokeWidth = stroke.strokeWidth;
      _drawStroke(canvas, paint, stroke.points);
    }

    paint.color = selectedColor;
    paint.strokeWidth = strokeWidth;
    _drawStroke(canvas, paint, currentStroke);

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> loadImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    backgroundImage = frame.image;
    notifyListeners();
  }

  void _drawStroke(Canvas canvas, Paint paint, List<Offset?> points) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }
}


class SignaturePainter extends CustomPainter {
  final List<Stroke> strokes;
  final List<Offset?> currentStroke;
  final Color currentColor;
  final double currentStrokeWidth;
  final ui.Image? backgroundImage;

  SignaturePainter({
    required this.strokes,
    required this.currentStroke,
    required this.currentColor,
    required this.currentStrokeWidth,
    this.backgroundImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the background image if available
    if (backgroundImage != null) {
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: backgroundImage!,
        fit: BoxFit.cover,
      );
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw saved strokes
    for (final stroke in strokes) {
      paint.color = stroke.color;
      paint.strokeWidth = stroke.strokeWidth;
      _drawStroke(canvas, paint, stroke.points);
    }

    // Draw the current stroke
    paint.color = currentColor;
    paint.strokeWidth = currentStrokeWidth;
    _drawStroke(canvas, paint, currentStroke);
  }

  void _drawStroke(Canvas canvas, Paint paint, List<Offset?> points) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



// class SignaturePainter extends CustomPainter {
//   final List<Stroke> strokes;
//   final List<Offset?> currentStroke;
//   final Color currentColor;
//   final double currentStrokeWidth;

//   SignaturePainter({
//     required this.strokes,
//     required this.currentStroke,
//     required this.currentColor,
//     required this.currentStrokeWidth,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     // Draw completed strokes
//     for (final stroke in strokes) {
//       paint.color = stroke.color;
//       paint.strokeWidth = stroke.strokeWidth;
//       _drawStroke(canvas, paint, stroke.points);
//     }

//     // Draw current stroke
//     paint.color = currentColor;
//     paint.strokeWidth = currentStrokeWidth;
//     _drawStroke(canvas, paint, currentStroke);
//   }

//   void _drawStroke(Canvas canvas, Paint paint, List<Offset?> points) {
//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i]!, points[i + 1]!, paint);
//         // canvas.drawLine(points[i]!,Offset(200, 200), paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
