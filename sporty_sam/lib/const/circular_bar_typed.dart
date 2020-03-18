import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:core';

 int _currentSteps;
int _goalSteps;


class CircularBar extends StatefulWidget{
  final double size;
  final Color backgroundColor;
  final Color color;
  final int currentSteps;
  final int goalSteps;
  CircularBar({@required this.size, this.backgroundColor = Colors.grey, this.color = Colors.blue,this.currentSteps=100,this.goalSteps=8000});

  @override
  _CircularProgress createState() => new _CircularProgress();

}

class _CircularProgress extends State<CircularBar> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation animation;

  @override
  // ignore: must_call_super
  void initState() {
    // TODO: implement initState
    super.initState();
//    controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 10000))..repeat();
    controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 10000));
    animation = Tween(begin: 270.0, end: 270.0).animate(controller)
    ..addListener((){
      setState(() {

      });

    })
    ..addStatusListener((state) {
    if (state == AnimationStatus.completed) {
    print("complete");
    controller.stop();
    }
    });
//    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {

_currentSteps=widget.currentSteps;
_goalSteps=widget.goalSteps;

    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
      
      new CustomPaint(
        painter: new CircularCanvas(progress: animation.value, backgroundColor: widget.backgroundColor, color: widget.color),
        size: new Size(widget.size, widget.size),
      ),
//      new Text('${(animation.value/360*100).round()}',
//      style: new TextStyle(color: widget.color, fontSize: widget.size/5, fontWeight: FontWeight.bold),),

        new Column(
          children: <Widget>[
            new Text('$_currentSteps', textAlign: TextAlign.center,
              style: new TextStyle(color: widget.color, fontSize: widget.size/5, fontWeight: FontWeight.bold),),
            new Text('/ $_goalSteps Steps', textAlign: TextAlign.center,
              style: new TextStyle(color: widget.color, fontSize: widget.size/8, fontWeight: FontWeight.bold),),
          ],
        ),

      ],);
  }
}

class CircularCanvas extends CustomPainter{
  final double progress;
  final Color backgroundColor;
  final Color color;

  CircularCanvas({this.progress, this.backgroundColor = Colors.grey, this.color = Colors.blue});
  @override
  void paint(Canvas canvas, Size size) {

    var strokeWidth = size.width/18;
    var paint = new Paint();
    paint..color = backgroundColor
      ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill;

    canvas.drawCircle(new Offset(size.width/2, size.height/2), size.width/1.9, paint);

    paint..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke;

    canvas.drawArc(new Offset(strokeWidth/2, strokeWidth/2)
    &new Size(size.width - strokeWidth, size.width - strokeWidth), -90.0*0.0174533, progress*0.0174533,
        false, paint..color = color);

  }

  @override
  bool shouldRepaint(CircularCanvas oldDelegate) {
    return oldDelegate.progress !=progress;
  }

}