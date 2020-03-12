import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyHealthPage extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _MyHealthPageState createState() => _MyHealthPageState();
}

class _MyHealthPageState extends State<MyHealthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Health'),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[

              ],
            )));
  }
}
