import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class Task extends StatefulWidget {
  Task({this.task = "",this.actType="",this.amount=0,this.currAmount=0});
  final String task;
  final String actType;
  final int amount;
  final double? currAmount;

  @override
  _TaskState createState() => _TaskState();
}
class _TaskState extends State<Task>{
//  double currAmount = widget.dataMap[actType] / 60;
  String midText="";
  @override
  void initState() {
    super.initState();
//    double currAmount = 0;
//    String midText = '';
    if (widget.amount <= 60) {
      midText = widget.currAmount!.toStringAsFixed(1) + "\nmins";
    } else {
      midText = (widget.currAmount! / 60).toStringAsFixed(1) + "\nhrs";
    }
  }
//  print(currAmount/amount);
  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 3 / 4,
        height: 90.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, 0),
              child:
              Container(width: 70.0, height: 70.0, child: new CircularPercentIndicator(
                radius: 60,
                lineWidth: 5,
                percent: ((widget.currAmount!>widget.amount) ? 1.0 : widget.currAmount!/ widget.amount),
                progressColor: Colors.purple,
                center: new Text(
                  midText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 4,
                child: Text(
                  widget.task,
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 20,
                    color: const Color(0xff000000),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
