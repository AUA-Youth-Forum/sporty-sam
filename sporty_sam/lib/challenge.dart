import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChallengePage extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  Widget _tableDataCell(int rank, String name, int score) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.amberAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  rank.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
                child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            )),
            Expanded(
                child: Center(
              child: Text(
                score.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/back.png"),
                fit: BoxFit.fitHeight,
              )),
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.transparent,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Challenge with your friends',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
              Container(
                child: Image(
                  image: AssetImage('lib/assets/img/challenge2.gif'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //heading
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                    ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          'Rank',
                          style: TextStyle(
                              color: Color(0xfff79c4f),
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                                color: Color(0xfff79c4f),
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    Expanded(
                        child: Center(
                          child: Text(
                            'Pet\'s Score',
                            style: TextStyle(
                                color: Color(0xfff79c4f),
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        int rankG=1;
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return new ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
//                                  print(snapshot.data.documents.indexOf(document));
                                return _tableDataCell(rankG++, document["name"], document["myScore"]);
                              }).toList(),
                            );
                        }
                      },
                    ),
                  ),)
            ],
          ),
        ));
  }
}
