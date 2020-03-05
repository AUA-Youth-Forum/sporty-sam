import 'package:flutter/material.dart';

import './home.dart';
import './login.dart';
import './signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sporty Sam',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Sam\'s Home'),
    );
  }
}


