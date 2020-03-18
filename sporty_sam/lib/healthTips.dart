
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'const/loadimg.dart';

//old system
//List tips = [
//  [
//    'Eat a variety of foods',
//    'lib/assets/tips/food.jpg',
//    'For good health, we need more than 40 different nutrients, and no single food can supply them all. It is not about a single meal, it is about a balanced food choice over time that will make a difference!'
//  ],
//  [
//    'Get on the move, make it a habit',
//    'lib/assets/tips/workout.jpg',
//    'Physical activity is important for people of all weight ranges and health conditions. It helps us burn off the extra calories, it is good for the heart and circulatory system, it maintains or increases our muscle mass, it helps us focus, and improves overall health well-being.'
//  ],
//  [
//    'Drink plenty of fluids',
//    'lib/assets/tips/water.jpg',
//    'Adults need to drink at least 1.5 litres of fluid a day! Or more if it\'s very hot or they are physically active. Water is the best source, of course, and we can use tap or mineral water, sparkling or non-sparkling, plain or flavoured.'
//  ],
//];

class HealthTips extends StatefulWidget {
  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  //final databaseReference = Firestore.instance;
//  void getData() {
//    databaseReference
//        .collection("health tips")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });
//  }
  //
  /////////////////////////////////////////////////
// old local system cards
//  Widget _tipsContent(int index) {
//    return Container(
//      height: 200,
//      child: Card(
//        elevation: 3.0,
//        child: Row(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.all(10.0),
//              child: Image(
//                image: AssetImage(tips[index][1]),
//                width: 150,
//                height: 150,
//              ),
//            ),
//            Container(
//              width: MediaQuery.of(context).size.width - 200,
//              height: 150,
//              padding: EdgeInsets.all(10.0),
//              child: Column(
//                children: <Widget>[
//                  Text(tips[index][0],
//                      style:
//                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
//                      textAlign: TextAlign.left),
//                  Flexible(
//                    child: Text(
//                      tips[index][2],
//                      style:
//                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                      textAlign: TextAlign.justify,
//                      //overflow: TextOverflow.ellipsis,
//                    ),
//                  ),
//                ],
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
////////////////////////////////////////////////

  Widget _tipsFirebase() {
    return Center(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('health tips').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return new Card(
                      elevation: 3.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10.0),
                              child: LoadImg(
                                fileName: document['ImgName'],
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width - 200,
                            height: 150,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Text(document['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                    textAlign: TextAlign.left),
                                Flexible(
                                  child: Text(
                                    document['content'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.justify,
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
            }
          },
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
        body: _tipsFirebase()

////old local system
//        SingleChildScrollView(
//            child: Column(
//          children: <Widget>[
//            RaisedButton(
//              child: Text('View Record'),
//              onPressed: () {
//                getData();
//              },
//            ),
//
//            _tipsContent(0),
////            _tipsContent(1),
////            _tipsContent(2),
////            _tipsContent(0),
//          ],
//        ))
        );
  }
}
