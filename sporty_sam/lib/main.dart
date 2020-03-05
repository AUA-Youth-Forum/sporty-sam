import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:async';

void main(){
  runApp(
      MaterialApp(
        home: myapp(),
      )
  );
}

class myapp extends StatefulWidget {
  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
          (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>home(),
            )
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 400,
          textColor: Colors.deepPurpleAccent[700],
        ),

      ),
    );
  }
}
