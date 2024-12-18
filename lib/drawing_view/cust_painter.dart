import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DrawCircle extends StatefulWidget {
  const DrawCircle({super.key});

  @override
  State<DrawCircle> createState() => _DrawCircleState();
}

class _DrawCircleState extends State<DrawCircle> {
  Color drawingColor = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(" prop : hitTest(), strokeWidth() ,style "),
              Container(
                color: const Color.fromARGB(255, 251, 205, 220),
                child: GestureDetector(
                  onTap: () {
                    if (drawingColor == Colors.black) {
                      drawingColor = Colors.amber;
                      setState(() { });
                    } else if (drawingColor == Colors.amber){
                      drawingColor = Colors.black;
                        setState(() { });
                    }
                  },
                  child: CustomPaint(
                    willChange: true,
                    painter: DemoPainterCircle1(drawingColor), // paints behind the child widget
                          child: const SizedBox.square(
                      dimension: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
               const Text(" prop : stroke cap ,size "),
              Container(
                color: const Color.fromARGB(255, 243, 181, 253),
                 child:  CustomPaint(
                  size: const Size.fromRadius(70),
                  painter:DemoPainterLine() ,
                 ),
              ),
          
                 const SizedBox(height: 20,),
                 const Text(" prop : foreground painter,painter ,stroke join,strokeMiterLimit  "),
             CustomPaint(
                  painter:DemoPainterLine() ,
                   foregroundPainter:DemoPainterTriangle() ,
                  child: Container(height: 100,width: 100,
                  color: Colors.amber.withOpacity(0.7),),
                 ),
          
                     const SizedBox(height: 20,),
                 const Text(" prop : MaskFilter.blur  ,colorFilter"),
             CustomPaint(
                   foregroundPainter:DemoPainterCircle2() ,
                  child: Container(height: 100,width: 100,
                  color: Colors.blue,),
                 ),
          
                   const SizedBox(height: 20,),
                 const Text(" prop : Rect.fromCenter ,RRect.fromRectAndRadius"),
             CustomPaint(
                   foregroundPainter:DemoPainterRect() ,
                  child: Container(height: 200,width: 200,
                  color: Colors.black),
                 ),
                 
                      const SizedBox(height: 20,),
                 const Text(" prop : oval "),
             CustomPaint(
                   foregroundPainter:DemoPainterOval() ,
                  child: Container(height: 150,
                  color: Colors.amber),
                 ),
                 
                      const SizedBox(height: 20,),
                 const Text(" prop : Arc"),
             CustomPaint(
                   foregroundPainter:DemoPainterArc() ,
                  child: Container(height: 150,
                  color: Colors.deepOrange),
                 ),

                  const SizedBox(height: 20,),
                 const Text(" prop : quadraticBezierTo "),
             CustomPaint(
                   foregroundPainter:DemoPainterBezier(),
                  child: Container(height: 150,
                  color: Colors.grey),
                 ),

                  const SizedBox(height: 20,),
                 const Text(" prop : cubic to"),
             CustomPaint(
                   foregroundPainter:DemoPainterCubicCurve(),
                  child: Container(height: 150,
                  color: Colors.grey),
                 ),

                 const SizedBox(height: 20,),
                 const Text(" prop : Polygon"),
             CustomPaint(
                   foregroundPainter:DemoPainterPolygon(),
                  child: Container(height: 150,
                  color: Colors.yellow),
                 ),

                 
            ],
          ),
        ),
      ),
    );
  }
}

/// painter class
class DemoPainterCircle1 extends CustomPainter {
  Color drawColor;
  DemoPainterCircle1(this.drawColor);

  var circle1 = Rect.fromCircle(center: const Offset(50, 50), radius: 30);

  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    Paint paint = Paint()
      ..color= drawColor
      ..strokeWidth = 10
      ..style=PaintingStyle.stroke;  // by default it is [PaintingStyle.fill]
  
    // canvas.drawCircle(Offset(center.width, center.height), 30, paint);
    canvas.drawCircle(Offset(center.width, center.height), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //  return drawColor != oldDelegate.drawColor;
    return true;
  }

  @override
  bool? hitTest(Offset position) {      // detects the taps ONLY inside the circle
    return circle1.contains(position);
  }
}

// line
class DemoPainterLine extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
   var center=size/2;
   Paint paint=Paint()
             ..color=Colors.blue
             ..strokeWidth=10
             ..strokeCap=StrokeCap.round; // round {adds semicircles to both ends} , square{ adds squares to the ends}, butt{adds nothing to the ends}
  canvas.drawLine(const Offset(10, 50),const Offset(50,90),paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// triangle
class DemoPainterTriangle extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
   var center=size/2;
   Paint paint=Paint()
             ..color=Colors.blue
             ..strokeWidth=10
             ..strokeMiterLimit = 0.6 //When sharp corners are drawn, there is a limit as to how sharp they can be
            ..strokeJoin = StrokeJoin.bevel;  //The strokeJoinparameter defines how the connections between individual strokes look 

  canvas.drawLine(const Offset(40, 80),const Offset(90,110),paint);
  canvas.drawLine(const Offset(40, 80),const Offset(10,100),paint);
  canvas.drawLine(const Offset(10, 100),const Offset(90,110),paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// circle 2
class DemoPainterCircle2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    Paint paint = Paint()
    ..maskFilter=const MaskFilter.blur(BlurStyle.normal, 10)
    ..colorFilter=const ColorFilter.mode(Colors.amber, BlendMode.colorBurn)
      ..color= Colors.blue;
  
    // canvas.drawCircle(Offset(center.width, center.height), 30, paint);
    canvas.drawCircle(Offset(center.width, center.height), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

//rectangles
class DemoPainterRect extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
   var center=size/2;
   Paint paint=Paint()
              ..color=Colors.orange
              ..style=PaintingStyle.fill;
   var rect1=Rect.fromCenter(center: Offset(center.width, center.height), width: 150, height: 80);
  var rect2= RRect.fromRectAndRadius(
    Rect.fromCenter(center:  Offset(center.width, center.height), width: 120, height: 60),
    const Radius.circular(50.0),
  );
   canvas.drawRect(rect1, paint);
    canvas.drawRRect(rect2, Paint()
              ..color=const Color.fromARGB(255, 135, 96, 109)
              ..style=PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return false;
  }
}

//oval
class DemoPainterOval extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
   var center=Offset((size/2).width, (size/2).height);
   var rect=Rect.fromCenter(center: center, width: 150, height: 75);
   Paint paint=Paint()
            ..color=Colors.green
            ..style=PaintingStyle.stroke
            ..strokeWidth=10;
   canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}

//arc
class DemoPainterArc extends CustomPainter{

  @override
void paint(Canvas canvas, Size size) {
  var center =  Offset((size/2).width, (size/2).height);
  var rectangle = Rect.fromCenter(center: center, width: 150, height: 75);
  Paint paint=Paint()
            ..color=Colors.white
            ..style=PaintingStyle.fill
            ..strokeWidth=10;
  canvas.drawArc(rectangle, 0.0, pi/2, true, paint);
}
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}

//BezierCurve
class DemoPainterBezier extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

//quadraticBezierTo
    Path bezierPath = Path()
             ..moveTo(20, size.height-10)  // starting point of curve
            ..quadraticBezierTo(40,80 ,100, 140);

    canvas.drawPath(bezierPath, paint);

    // points black
    canvas.drawCircle(const Offset(40,80), 5, Paint()..color=Colors.black);
    canvas.drawCircle(const Offset( 100, 140), 5, Paint()..color=Colors.black);


  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}

//Cubic curve
class DemoPainterCubicCurve extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

   /// cubic to
    Path path = Path();
    path.cubicTo(100,60, 60,100, size.width-10, size.height-10);
    canvas.drawPath(path, paint);

    // points white
    canvas.drawCircle(Offset(size.width / 4,3 * size.height / 4), 5, Paint()..color=Colors.white);
    canvas.drawCircle(Offset( 3 * size.width / 4, size.height / 4), 5, Paint()..color=Colors.white);
     canvas.drawCircle(Offset( size.width-10, size.height-10), 5, Paint()..color=Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}

// polygon
class DemoPainterPolygon extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
  Paint paint=Paint()
             ..color=Colors.purple
             ..style=PaintingStyle.stroke
             ..strokeWidth=5;
  var points=[
    const Offset(20, 20),
    const Offset(90, 100),
    const Offset(70, 20),
    const Offset(50, 40),
  ];

  Path path=Path()
         ..addPolygon(points, true);
         canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}

//It is a curve which is defined by a set of points, where the first and last
//points are the end points of the curve, whereas the intermediate points do 
//not typically lie on the curve — however they determine the shape of the curve.