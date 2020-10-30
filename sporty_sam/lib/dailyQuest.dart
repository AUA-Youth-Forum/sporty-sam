import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyQuestPage extends StatefulWidget {
  DailyQuestPage({
    Key key,
    this.userId,
    this.userActCato,
    this.dataMap,
  }) : super(key: key);
  final String userId;
  final String userActCato;
  final Map<String, double> dataMap;

  @override
  _DailyQuestPageState createState() => _DailyQuestPageState();
}

class _DailyQuestPageState extends State<DailyQuestPage> {
  int questDay = 2;
  String newDate;
  bool taskComplete =false;
  bool updateScore = false;

  DateTime dateOnly(DateTime oldDate) {
    return DateTime(oldDate.year, oldDate.month, oldDate.day);
  }

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("users")
        .document(widget.userId)
        .collection("DailyQuest")
        .document("setting")
        .get()
        .then((value) {
      if (value["date"] == "") {
        setState(() {
          questDay = 1;
          newDate = dateOnly(DateTime.now()).toString();
        });
      } else if (value["date"] == dateOnly(DateTime.now()).toString()) {
        if (value["complete"] == true) {
          setState(() {
            questDay = value["day"];
            newDate = dateOnly(DateTime.now()).toString();
            taskComplete = true;
          });
        } else {
          setState(() {
            questDay = value["day"];
            newDate = dateOnly(DateTime.now()).toString();
            taskComplete = false;
          });
        }
      } else {
//        print(value["complete"]);
//        print(value["date"]);
//        print(value["day"]);
        if (value["complete"] == true) {
          setState(() {
            questDay = ((value["day"] + 1) % 30);
            newDate = dateOnly(DateTime.now()).toString();
            taskComplete = false;
          });
        } else {
          setState(() {
            questDay = value["day"];
            newDate = dateOnly(DateTime.now()).toString();
            taskComplete = false;
          });
        }
      }
      Firestore.instance
          .collection("dailyQuest")
          .document(widget.userActCato)
          .collection(questDay.toString())
          .document("1")
          .get()
          .then((value) {
//            print(widget.dataMap);
        if ((value["amount"] * 60) <= widget.dataMap[value["activity"]]) {
          if(taskComplete == false){
            print("aaaa");
            setState(() {
              taskComplete = true;
              updateScore = true;
            });
          }
        }
      });
      Firestore.instance
          .collection("users")
          .document(widget.userId)
          .collection("DailyQuest")
          .document("setting")
          .updateData({
        "date": newDate,
        "day": questDay,
        "complete": taskComplete
      });
      if(updateScore==true){
        print("bbbb");
        Firestore.instance
            .collection("users")
            .document(widget.userId).updateData({"myScore":FieldValue.increment(10)});

      }
    });
  }

  Widget tasks(String task, String actType, int amount) {
    double currAmount = widget.dataMap[actType] / 60;
    String midText;
    if (amount <= 60) {
      midText = currAmount.toStringAsFixed(1) + "\nmins";
    } else {
      midText = (currAmount / 60).toStringAsFixed(1) + "\nhrs";
    }
//  print(currAmount/amount);
    return new Card(
      margin: EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 3 / 4,
        height: 90.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, 0),
              child: Container(
                width: 70.0,
                height: 70.0,
                child: new CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 5,
                  percent: ((currAmount>amount) ? 1.0 : currAmount/ amount),
                  progressColor: Colors.purple,
                  center: new Text(
                    midText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 4,
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
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("lib/assets/back.png"),
                fit: BoxFit.fitHeight,
              )),
            ),
            SingleChildScrollView(
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
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
                      stream: Firestore.instance
                          .collection("dailyQuest")
                          .document(widget.userActCato)
                          .collection(questDay.toString())
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
//                        print(questDay);
//                        Firestore.instance
//                            .collection("users")
//                            .document(widget.userId)
//                            .collection("DailyQuest")
//                            .document("setting")
//                            .updateData({
//                          "date": newDate,
//                          "day": questDay,
//                          "complete": taskComplete
//                        });
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading');
                          default:
                            return new ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
//                                    print(document["task"]);

                                return tasks(document["task"],
                                    document["activity"], document["amount"]);
                              }).toList(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                            );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: Firestore.instance
                          .collection("dailyQuest")
                          .document(widget.userActCato)
                          .collection(questDay.toString())
                          .document("1")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        DocumentSnapshot goalDetails = snapshot.data;
//                        print(questDay);

                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading');
                          default:
                            return Container(
                              width: MediaQuery.of(context).size.width * 3 / 4,
                              child: new Card(
                                  color: Colors.amber[300],
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.brown, width: 8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 20,
                                  child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Did you know !",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            goalDetails["tip"],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontStyle: FontStyle.italic),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ))),
                            );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
