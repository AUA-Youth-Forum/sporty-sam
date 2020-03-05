import 'package:flutter/material.dart';

import 'main.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box),
              tooltip: 'Show snackbar',
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.close),
              tooltip: 'Close the app',
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                    'This is Home',
                  style: TextStyle(fontSize: 24,),
                ),

              ),


            ],
          )
        ),
      ),
    );
  }
}