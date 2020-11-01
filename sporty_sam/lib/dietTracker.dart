import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty_sam/const/fab_circle.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'const/fab_circle.dart';


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
        body: Center(
          child: Stack(
            children: [

              Container(
                margin: EdgeInsets.all(60.0),
                child: Column(
                  children: [
                    Text("Safe Range Meter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                              customWidths: CustomSliderWidths(progressBarWidth: 10)),
                          min: 0,
                          max: 100,
                          initialValue: 90,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                            child: Text("High", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FabCircle(
                alignment: Alignment.center,
                children: [
                  RawMaterialButton(
                      onPressed: () {  },
                      child: Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.flag), onPressed: () {  },
                          ),
                          Text("Local Data")
                        ],
                      )
                  ),
                  RawMaterialButton(
                      onPressed: () {  },
                      child: Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.public), onPressed: () {  },
                          ),
                          Text("Global Data")
                        ],
                      )
                  ),
                  RawMaterialButton(
                      onPressed: () {  },
                      child: Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.masks), onPressed: () {  },
                          ),
                          Text("Mask On")
                        ],
                      )
                  ),
                  RawMaterialButton(
                      onPressed: () {  },
                      child: Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.article), onPressed: () {  },
                          ),
                          Text("Tips & News")
                        ],
                      )
                  ),
                  RawMaterialButton(
                      onPressed: () {  },
                      child: Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings), onPressed: () {  },
                          ),
                          Text("Social Distance")
                        ],
                      )
                  ),
                ],
              ),
            ],
          )
        )
    );
  }
}
