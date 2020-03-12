import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ChallengePage extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Challenge'),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[

              ],
            )));
  }
}
