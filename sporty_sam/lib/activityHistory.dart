import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import './assets/icons/custom_icons_icons.dart';
import 'dart:math';
import 'package:pie_chart/pie_chart.dart';

class ActivityHistoryPage extends StatefulWidget {
  ActivityHistoryPage({
    Key key,
    this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _ActivityHistoryPageState createState() => _ActivityHistoryPageState();
}

class _ActivityHistoryPageState extends State<ActivityHistoryPage> {
  DateTime historyDate;

  DateTime dateOnly(DateTime oldDate) {
    return DateTime(oldDate.year, oldDate.month, oldDate.day);
  }

  void setDatabaseDate(DateTime requiredDate) {
    Firestore.instance
        .collection('users')
        .document(widget.userId)
        .collection('healthHistory')
        .document(requiredDate.toString())
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
            .document(requiredDate.toString())
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
        print('dataset done');
      }
    });
  }

//
  //pie chart
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.green,
    Colors.blue,
//    Colors.purple,
    Colors.red,
    Colors.brown
  ];
  void setChartData() async {
    double walk = 0, bicycle = 0, run = 0, still = 0, unknown = 0;
    var result = await Firestore.instance
        .collection('users')
        .document(widget.userId)
        .collection('healthHistory')
        .document(dateOnly(historyDate).toString())
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
//        "Unknown": unknown
      };
    });

//    dataMap.putIfAbsent("WALKING", () => walk);
//    dataMap.putIfAbsent("RUNNING", () => run);
//    dataMap.putIfAbsent("ON_BICYCLE", () => bicycle);
//    dataMap.putIfAbsent("STILL", () => still);
//    dataMap.putIfAbsent("UNKNOWN", () => unknown);
  }

  @override
  void initState() {
    super.initState();
    historyDate = dateOnly(DateTime.now());
    //pie chart
    dataMap.putIfAbsent("Walking", () => 15);
    dataMap.putIfAbsent("Running", () => 5);
    dataMap.putIfAbsent("Cycling", () => 5);
    dataMap.putIfAbsent("Free", () => 5);
//    dataMap.putIfAbsent("UNKNOWN", () => 5);
    setChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Daily Activity History'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      //maxTime: DateTime(2022, 12, 31),
                      onConfirm: (date) {
                    setDatabaseDate(dateOnly(date));
                    setState(() {
                      historyDate = dateOnly(date);
                    });
                    setChartData();
                  }, currentTime: historyDate, locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  '${historyDate.year} - ${historyDate.month} - ${historyDate.day}',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Select Date",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                child: PieChart(
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
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('users')
                        .document(widget.userId)
                        .collection('healthHistory')
                        .document(historyDate.toString())
                        .collection('activity')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return new ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              DateTime start =
                                  DateTime.parse(document["start"]);
                              Duration actLength =
                                  DateTime.parse(document["end"]).difference(
                                      DateTime.parse(document["start"]));
                              return new Card(
                                elevation: 3.0,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          15,
//                                      height: 150,
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                              "Time " +
                                                  start.hour
                                                      .toString()
                                                      .padLeft(2, '0') +
                                                  " : " +
                                                  start.minute
                                                      .toString()
                                                      .padLeft(2, '0') +
                                                  " : " +
                                                  start.second
                                                      .toString()
                                                      .padLeft(2, '0'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left),
                                          Text(document['type'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left),
                                          Text(
                                              actLength.inMinutes.toString() +
                                                  "min " +
                                                  (actLength.inSeconds % 60)
                                                      .toString() +
                                                  "s",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left),
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
              ),
            ],
          ),
        ));
  }
}
