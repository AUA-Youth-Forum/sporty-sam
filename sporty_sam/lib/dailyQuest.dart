import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyQuestPage extends StatefulWidget {
  DailyQuestPage({
    Key key,
    this.userId,
    this.userActCato,
  }) : super(key: key);
  final String userId;
  final String userActCato;
  @override
  _DailyQuestPageState createState() => _DailyQuestPageState();
}

class _DailyQuestPageState extends State<DailyQuestPage> {
  String questDay="2";
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection("users").document(widget.userId).collection("DailyQuest").document("setting").get().then((value){
      setState(() {
        questDay=value["day"].toString();
//        print(value["day"]);
      });

    });
  }
  Widget tasks(String task){
    return new Card(
      margin: EdgeInsets.only(top: 0,left: 30,right: 30,bottom: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width *3/ 4,
        height: 90.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, 0),
              child: Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.elliptical(32.0, 32.0)),
                  color: const Color(0xffffffff),
                  border: Border.all(
                      width: 1.0, color: const Color(0xff707070)),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width *2/ 4,
                child: Text(
                  task,
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 20,
                    color: const Color(0xff000000),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Quest'),
        ),
        body:
        Stack(
          children: <Widget>[
            Container(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      'Complete daily tasks to improve your score and be healthy',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 25,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection("dailyQuest").document(widget.userActCato).collection(questDay).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        print(questDay);
                        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState){
                          case ConnectionState.waiting:
                            return new Text('Loading');
                          default:
                            return new ListView(
                              children:
                                snapshot.data.documents.map((DocumentSnapshot document){
                                  return tasks(document["task"]);
                                }).toList(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),

                            ) ;

                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
