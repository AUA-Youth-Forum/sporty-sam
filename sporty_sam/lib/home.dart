import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:sporty_sam/healthTips.dart';
import 'package:sporty_sam/petshop.dart';
import './const/fab_circular_menu.dart';
import './settings.dart';
import 'dietTracker.dart';
import 'myHealth.dart';
import 'challenge.dart';
import 'myProfile.dart';


import 'package:sporty_sam/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:async';

import 'myProfile.dart';


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
  //bool _isEmailVerified = false;
  @override
  void initState() {
    super.initState();
  setDatabaseDate();
    //_checkEmailVerification();
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
//      appBar: AppBar(
//
//        title: Text(widget.title),
//      ),
        body: Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Sporty Sam',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                widget.userId,
                //style: Theme.of(context).textTheme.display1,

              ),

              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  height: 300,
                  width: 300,
                  child: FlareActor(
                    "lib/assets/animations/teddy.flr",
                    animation: "success",
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
                            builder: (context) => SettingsPage(auth: widget.auth,logoutCallback: widget.logoutCallback,userId: widget.userId,)));
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
                            builder: (context) => ProfPage()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.directions_run),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHealthPage(userId: widget.userId,)));
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
            ],
            //),
          ),
        ],
      ),
    ));
  }
}
