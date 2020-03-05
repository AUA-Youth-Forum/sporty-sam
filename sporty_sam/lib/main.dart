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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Sporty Sam'),
            Image.asset("assets/img/pic2.png"),
            ],
        ),

      ),
    );
  }
}
