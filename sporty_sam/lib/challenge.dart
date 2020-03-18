import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengePage extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  Widget _tableDataCell(String rank, String name, String score) {
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
                  rank,
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
                score,
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
        body: Column(
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
            SingleChildScrollView(
                child: Column(
              children: <Widget>[

                //data rows
                _tableDataCell('1', 'Peter', '109472'),
                SizedBox(
                  height: 3,
                ),
                _tableDataCell('2', 'John', '98546'),
                SizedBox(
                  height: 3,
                ),
                _tableDataCell('3', 'Michael', '98142'),
                SizedBox(
                  height: 3,
                ),
                _tableDataCell('4', 'Jane', '88976'),
                SizedBox(
                  height: 3,
                ),
                _tableDataCell('5', 'Becky', '88124'),
                SizedBox(
                  height: 3,
                ),
                _tableDataCell('6', 'Ayjan', '78912'),
                SizedBox(
                  height: 3,
                ),
                _tableDataCell('7', 'Roy', '77654'),
                SizedBox(
                  height: 3,
                ),
                _tableDataCell('8', 'Brian', '66432'),
              ],
            ))
          ],
        ));
  }
}
