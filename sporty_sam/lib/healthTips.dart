import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListViewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Health tips'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Card(
                elevation: 3.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                    ),

                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
