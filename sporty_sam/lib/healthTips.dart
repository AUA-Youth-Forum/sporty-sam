import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List tips = [
  [
    'Eat a variety of foods',
    'lib/assets/tips/food.jpg',
    'For good health, we need more than 40 different nutrients, and no single food can supply them all. It is not about a single meal, it is about a balanced food choice over time that will make a difference!'
  ],
  [
    'Get on the move, make it a habit',
    'lib/assets/tips/workout.jpg',
    'Physical activity is important for people of all weight ranges and health conditions. It helps us burn off the extra calories, it is good for the heart and circulatory system, it maintains or increases our muscle mass, it helps us focus, and improves overall health well-being.'
  ],
  [
    'Drink plenty of fluids',
    'lib/assets/tips/water.jpg',
    'Adults need to drink at least 1.5 litres of fluid a day! Or more if it\'s very hot or they are physically active. Water is the best source, of course, and we can use tap or mineral water, sparkling or non-sparkling, plain or flavoured.'
  ],
];

class HealthTips extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  Widget _tipsContent(int index) {
    return Container(
      height: 200,
      child: Card(
        elevation: 3.0,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage(tips[index][1]),
                width: 150,
                height: 150,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 200,
              height: 150,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(tips[index][0],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                      textAlign: TextAlign.left),
                  Flexible(
                    child: Text(
                      tips[index][2],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      textAlign: TextAlign.justify,
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Health tips'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            _tipsContent(0),
            _tipsContent(1),
            _tipsContent(2),
            _tipsContent(0),
          ],
        )));
  }
}
