import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporty_sam/components/activities/activitycard.dart';

class ActivityHistory extends StatefulWidget {
  @override
  _ActivityHistoryState createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {
  late DateTime historyDate;
  String timeOnly(DateTime oldDate) {
    String term;
    String hour;
    String minits;
    if (oldDate.hour > 12) {
      term = " AM";
    } else {
      term = " PM";
    }
    if (oldDate.hour % 12 < 10) {
      hour = "0" + (oldDate.hour % 12).toString();
    } else {
      hour = (oldDate.hour % 12).toString();
    }
    if (oldDate.minute < 10) {
      minits = "0" + oldDate.minute.toString();
    } else {
      minits = oldDate.minute.toString();
    }
    return hour + ":" + minits + term;
  }

  Map<String, double> dataMap = Map();
  void setChartData() async {
    double walk = 0, bicycle = 0, run = 0, still = 0;
    var result = await FirebaseFirestore.instance
        .collection("users")
        .doc("exzSZEsn8cUusmd21y5Bblei6V02")
        .collection("healthHistory")
        .doc("2021-05-10 00:00:00.000")
        .collection("activity")
        .get();
    result.docs.forEach((res) {
      Duration actLength =
          DateTime.parse(res["end"]).difference(DateTime.parse(res["start"]));
      if ((res["type"] == "WALKING") || (res["type"] == "ON_FOOT"))
        walk += actLength.inSeconds;
      else if (res["type"] == "RUNNING")
        run += actLength.inSeconds;
      else if (res["type"] == "ON_BICYCLE")
        bicycle += actLength.inSeconds;
      else
        still += actLength.inSeconds;
    });
    setState(() {
      dataMap = {
        "Walking": walk,
        "Running": run,
        "Cycling": bicycle,
        "Free": still,
      };
    });
  }

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Walking", () => 15);
    dataMap.putIfAbsent("Running", () => 5);
    dataMap.putIfAbsent("Cycling", () => 5);
    dataMap.putIfAbsent("Free", () => 5);
    setChartData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity History'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                height: 200,
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32.0,
                  chartRadius: MediaQuery.of(context).size.width / 2.7,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc("exzSZEsn8cUusmd21y5Bblei6V02")
                    .collection("healthHistory")
                    .doc("2021-05-10 00:00:00.000")
                    .collection("activity")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Text('Please Wait')
                      : ListView(
                          children: snapshot.data!.docs.map((document) {
                            return ActivityCard(
                                content: document["end"],
                                title: DateTime.parse(document["end"])
                                        .difference(
                                            DateTime.parse(document["start"]))
                                        .inMinutes
                                        .toString() +
                                    " Mins  " +
                                    ((DateTime.parse(document["end"])
                                                .difference(DateTime.parse(
                                                    document["start"]))
                                                .inSeconds) %
                                            60)
                                        .toString() +
                                    " Seconds",
                                img: document['type'],
                                startTime:
                                    timeOnly(DateTime.parse(document["start"]))
                                        .toString(),
                                endTime:
                                    timeOnly(DateTime.parse(document['end']))
                                        .toString());
                          }).toList(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
