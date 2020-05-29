import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import './assets/icons/custom_icons_icons.dart';
import 'dart:math';

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

  @override
  void initState() {
    super.initState();
    historyDate = dateOnly(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Activity History'),
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
                              return new Card(
                                elevation: 3.0,
                                child: Row(
                                  children: <Widget>[
                                    Container(
//                                      width: MediaQuery.of(context).size.width,
//                                      height: 150,
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(document['start'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left),
                                          Text(document['type'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left),
                                          Text(document['end'],
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
