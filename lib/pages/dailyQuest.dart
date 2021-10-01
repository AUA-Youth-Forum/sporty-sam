import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sporty_sam/components/dailyQuest/task.dart';
import 'package:sporty_sam/components/functions/firebaseFunctions.dart';
import 'package:sporty_sam/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporty_sam/components/functions/common.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DailyQuestPage extends StatefulWidget {
  @override
  _DailyQuestPageState createState() => _DailyQuestPageState();
}

class _DailyQuestPageState extends State<DailyQuestPage> {
  String? userID = getUser()?.uid;
  int questDay = 2;
  String newDate = "";
  bool taskComplete = false;
  bool updateScore = false;
  int activityScore = 0;
  String userActivityCategory = "light";
  Map<String, double> activitySummaryData = Map();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    setState(() {
      loading = true;
    });
    activitySummaryData = await getActivitySummary(userID);
    print(activitySummaryData);
    await questData();
    setState(() {
      loading = false;
    });
  }

  Future<bool> questData() async {
    String? userID = getUser()?.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) => userActivityCategory = value["activityCategory"]);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("DailyQuest")
        .doc("setting")
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
    });
    await FirebaseFirestore.instance
        .collection("dailyQuest")
        .doc(userActivityCategory)
        .collection(questDay.toString())
        .doc("1")
        .get()
        .then((value) {
//            print(widget.dataMap);
      if ((value["amount"] * 60) <= activitySummaryData[value["activity"]]) {
        if (taskComplete == false) {
//          print("aaaa");
          setState(() {
            taskComplete = true;
            updateScore = true;
            activityScore = value["score"];
          });
        }
      }
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("DailyQuest")
        .doc("setting")
        .update({"date": newDate, "day": questDay, "complete": taskComplete});
    if (updateScore == true) {
//      print("bbbb");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .update({"myScore": FieldValue.increment(activityScore)});
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Congratulations',
        desc: 'You have earned $activityScore points',
        btnOkOnPress: () {},
      )..show();
    }
    return true;
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
            !loading
                ? SingleChildScrollView(
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
                          stream: FirebaseFirestore.instance
                              .collection("dailyQuest")
                              .doc(userActivityCategory)
                              .collection(questDay.toString())
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return new Text('Loading');
                              default:
                                return new ListView(
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    // print(document);
                                    double cAmount = activitySummaryData[
                                            document["activity"]] ??
                                        0;
                                    return Task(
                                      task: document["task"],
                                      actType: document["activity"],
                                      amount: document["amount"],
                                      currAmount: cAmount / 60,
                                    );
                                  }).toList(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                );
                            }
                          },
                        )),
                        SizedBox(
                          height: 60,
                        ),
                        Center(
                          child: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("dailyQuest")
                                .doc(userActivityCategory)
                                .collection(questDay.toString())
                                .doc("1")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              DocumentSnapshot<Object?>? goalDetails =
                                  snapshot.data;
//                        print(questDay);

                              if (snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return new Text('Loading');
                                default:
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        3 /
                                        4,
                                    child: new Card(
                                        color: Colors.amber[300],
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.brown, width: 8),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        elevation: 20,
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Did you know !",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  goalDetails != null
                                                      ? goalDetails["tip"]
                                                      : "",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.italic),
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
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ));
  }
}
