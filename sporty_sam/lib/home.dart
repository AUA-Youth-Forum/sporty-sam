import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:sporty_sam/healthTips.dart';
import 'package:sporty_sam/petshop.dart';
import 'package:sporty_sam/activityHistory.dart';
import './const/fab_circular_menu.dart';
import './settings.dart';
import 'dietTracker.dart';
import 'myHealth.dart';
import 'challenge.dart';
import 'myProfile.dart';
import 'dailyQuest.dart';

import 'package:sporty_sam/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pie_chart/pie_chart.dart';

import 'dart:async';

import 'myProfile.dart';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ////activity timeline

  Activity preAct = new Activity("UNKNOWN", 100);
  DateTime startAct = DateTime.now();
  DateTime endAct = DateTime.now();

  //pie chart
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.green,
    Colors.blue,
//    Colors.purple,
    Colors.red,
    Colors.brown
  ];
//
  String petMovement = "fail";
//
  String userActCato;
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  DateTime dateOnly(DateTime oldDate) {
    return DateTime(oldDate.year, oldDate.month, oldDate.day);
  }

  void setDatabaseDate() {
    Firestore.instance
        .collection('users')
        .document(widget.userId)
        .collection('healthHistory')
        .document(dateOnly(DateTime.now()).toString())
        .get()
        .then((onValue) {
      if (onValue.exists) {
        print('heello');
      } else {
        print('bye beye');
        Firestore.instance
            .collection('users')
            .document(widget.userId)
            .collection('healthHistory')
            .document(dateOnly(DateTime.now()).toString())
            .setData({
          "steps": 0,
          "calIntake": 0,
          "calBurn": 0,
          "heartRate": 0,
          "activeMin": 0,
          "distance": 0,
          "sleep": 0,
          "glucose": 0,
          "weight": 0,
          "height": 0,
        });
      }
    });
  }

  void setChartData() async {
    double walk = 0, bicycle = 0, run = 0, still = 0, unknown = 0;
    var result = await Firestore.instance
        .collection('users')
        .document(widget.userId)
        .collection('healthHistory')
        .document(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString())
        .collection('activity')
        .getDocuments();
    result.documents.forEach((res) {
//      print(res.data);
      Duration actLength = DateTime.parse(res.data["end"])
          .difference(DateTime.parse(res.data["start"]));
      if ((res.data["type"] == "WALKING") || (res.data["type"] == "ON_FOOT"))
        walk += actLength.inSeconds;
      else if (res.data["type"] == "RUNNING")
        run += actLength.inSeconds;
      else if (res.data["type"] == "ON_BICYCLE")
        bicycle += actLength.inSeconds;
//      else if (res.data["type"] == "UNKNOWN")
//        unknown += actLength.inSeconds;
      else
        still += actLength.inSeconds;
    });
    setState(() {
      dataMap = {
        "Walking": walk,
        "Running": run,
        "Cycling": bicycle,
        "Free": still,
//        "UNKNOWN": unknown
      };
      print("chart update");
    });
  }

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    setDatabaseDate();
    //_checkEmailVerification();

    //pie chart
    dataMap.putIfAbsent("Walking", () => 15);
    dataMap.putIfAbsent("Running", () => 5);
    dataMap.putIfAbsent("Cycling", () => 5);
    dataMap.putIfAbsent("Free", () => 5);
//    dataMap.putIfAbsent("UNKNOWN", () => 5);
    setChartData();
    Firestore.instance.collection("users").document(widget.userId).get().then((value) => userActCato=value["activityCategory"]);
  }

  //  void _checkEmailVerification() async {
//    _isEmailVerified = await widget.auth.isEmailVerified();
//    if (!_isEmailVerified) {
//      _showVerifyEmailDialog();
//    }
//  }

//  void _resentVerifyEmail(){
//    widget.auth.sendEmailVerification();
//    _showVerifyEmailSentDialog();
//  }

//  void _showVerifyEmailDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content: new Text("Please verify account in the link sent to email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Resent link"),
//              onPressed: () {
//                Navigator.of(context).pop();
//                _resentVerifyEmail();
//              },
//            ),
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

//  void _showVerifyEmailSentDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content: new Text("Link to verify account has been sent to your email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Widget build(BuildContext context) {
    final controller = FabCircularMenuController();
    return Scaffold(
        body: Center(
      child: Stack(
//        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/back1.jpg"),
                  fit: BoxFit.fitHeight,
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Sporty Sam',
                style: Theme.of(context).textTheme.headline4,
              ),
              InkWell(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Stack(children: <Widget>[
                    Center(
                      child: Text(
                        "Daily Progress",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    PieChart(
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32.0,
                      chartRadius: MediaQuery.of(context).size.width / 2.7,
                      showChartValuesInPercentage: false,
                      showChartValues: true,
                      showChartValuesOutside: true,
                      chartValueBackgroundColor: Colors.grey[200],
                      colorList: colorList,
                      showLegends: false,
                      legendPosition: LegendPosition.right,
                      decimalPlaces: 1,
                      showChartValueLabel: true,
                      initialAngle: 0,
                      chartValueStyle: defaultChartValueStyle.copyWith(
                        color: Colors.blueGrey[900].withOpacity(0.9),
                      ),
                      chartType: ChartType.ring,
                    ),
                  ]),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActivityHistoryPage(
                                userId: widget.userId,
                              )));
                },
              ),
//              Text(
//                widget.userId,
//                //style: Theme.of(context).textTheme.display1,
//              ),
              //activity
              new Center(
                child: StreamBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Activity act = snapshot.data;
//                      print(preAct.type + act.type);
                      if (act.type != preAct.type) {
                        endAct = DateTime.now();
                        print("activity change" + preAct.type + act.type);
                        //calc activity duration
                        Duration actLength = endAct.difference(startAct);
                        if (actLength.inSeconds > 2) {
                          //send to database
                          print("new activity saved");
                          Firestore.instance
                              .collection('users')
                              .document(widget.userId)
                              .collection('healthHistory')
                              .document(dateOnly(DateTime.now()).toString())
                              .collection('activity')
                              .document(startAct.toString())
                              .setData({
                            "start": startAct.toString(),
                            "end": endAct.toString(),
                            "type": preAct.type
                          });
                          setChartData();
                          //
                        }

                        startAct = endAct;
                        preAct = act;
                        print("activity updated" + preAct.type + act.type);
                      }
                      if (act.type == 'STILL')
                        petMovement = "fail";
                      else if (act.type == 'ON_BICYCLE')
                        petMovement = "idle";
                      else
                        petMovement = "success";

                      return new Column(
                        children: <Widget>[
                          Text(
                              "Your phone is to ${act.confidence}% ${act.type}!"),
                          InkWell(
                            child: Container(
                              height: 300,
                              width: 300,
                              child: FlareActor(
                                "lib/assets/animations/teddy.flr",
                                animation: petMovement,
                                //color: Colors.red
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PetShop(),
                                  ));
                            },
                          ),
                        ],
                      );
//                      return Text("Your phone is to ${act.confidence}% ${act.type}!");
                    }

                    return Column(
                      children: <Widget>[
                        Text("No activity detected."),
                        InkWell(
                          child: Container(
                            height: 300,
                            width: 300,
                            child: FlareActor(
                              "lib/assets/animations/teddy.flr",
                              animation: petMovement,
                              //color: Colors.red
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetShop(),
                                ));
                          },
                        )
                      ],
                    );
                  },
                  stream: ActivityRecognition.activityUpdates(),
                ),
              ),
              ////////////////////

              SizedBox(
                height: 20,
              ),
            ],
          ),
          FabCircularMenu(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //color: Colors.indigo[900].withOpacity(.5),
//              child:  Padding(
//                padding: const EdgeInsets.only(bottom: 50),
//                child: Text('FAB Circle Menu Example',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(color: Colors.black, fontSize: 36.0)),
////                          ),
//              ),
            ),
            ringColor: Colors.white30,
            controller: controller,
            options: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    controller.isOpen = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage(
                                  auth: widget.auth,
                                  logoutCallback: widget.logoutCallback,
                                  userId: widget.userId,
                                )));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.fastfood),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DietTrackerPage()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.face),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfPage(
                                  userId: widget.userId,
                                )));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.directions_run),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHealthPage(
                                  userId: widget.userId,
                                )));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.videogame_asset),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChallengePage()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.network_check),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HealthTips()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.golf_course),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DailyQuestPage(userId: widget.userId,userActCato: userActCato,dataMap: dataMap,)));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
            ],
            //),
          ),
        ],
      ),
    ));
  }
}
