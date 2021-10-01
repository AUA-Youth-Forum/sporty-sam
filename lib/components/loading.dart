import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 3,
                semanticsLabel: 'Linear progress indicator',
              ),
            ],
          ),
        ),
      ),
    );
  }
}