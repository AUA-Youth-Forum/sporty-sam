
import 'package:flutter/material.dart';

import 'package:sporty_sam/services/authentication.dart';
import 'package:sporty_sam/root_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sporty Sam',
      theme: ThemeData(

        primarySwatch: Colors.orange,
      ),
      home: new RootPage(auth: new Auth()),

    );
  }
}

