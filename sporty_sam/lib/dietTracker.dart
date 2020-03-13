import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DietTrackerPage extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _DietTrackerPageState createState() => _DietTrackerPageState();
}

class _DietTrackerPageState extends State<DietTrackerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Diet Tracker'),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[

              ],
            )
        )
    );
  }
}
