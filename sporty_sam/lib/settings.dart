import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingsPage extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[

              ],
            )));
  }
}
