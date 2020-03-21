import 'package:flutter/material.dart';

import './const/circular_bar_typed.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  './assets/icons/custom_icons_icons.dart';

class MyHealthPage extends StatefulWidget {
//  HealthTips({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _MyHealthPageState createState() => _MyHealthPageState();
}

class _MyHealthPageState extends State<MyHealthPage> {
  int _dateYear = DateTime.now().year;
  int _dateMonth = DateTime.now().month;
  int _dateDay = DateTime.now().day;

  //active time card
  int _activeTime = 10;
  int _activeTotal = 60;
  int _activeCalories = 1535;
  double _activeDistance = 1.39;
  double _sleepHours=7;
  double _bloodPreasure= 44.3;
  double _bloodGlucoes=150;
  double _weight=45;
  double _height=153;
  double _bmi=19.2;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Health History'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  print('confirm $date');
                  _dateYear = date.year;
                  _dateMonth = date.month;
                  _dateDay = date.day;
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
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
                                '$_dateYear - $_dateMonth - $_dateDay',
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
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularBar(
                size: 150,
                color: const Color(0xFF1CB5E0),
                backgroundColor: const Color(0xFF000046),
                currentSteps: 1000,
                goalSteps: 12500,
              ),
            )),
            SizedBox(height: 20),
            //active time
            const SizedBox(height: 50.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 190,
                        color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "9,850",
                                style:
                                Theme.of(context).textTheme.display1.copyWith(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                              trailing: Icon(
                                CustomIcons.directions_walk,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Steps',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        height: 120,
                        color: Colors.green,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "70 bpm",
                                style:
                                Theme.of(context).textTheme.display1.copyWith(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                              trailing: Icon(
                                CustomIcons.heartbeat,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Avg. Heart Rate',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 120,
                        color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "2,430",
                                style:
                                Theme.of(context).textTheme.display1.copyWith(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                              trailing: Icon(
                                CustomIcons.fire,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Calories Burned',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        height: 190,
                        color: Colors.yellow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "15 kms",
                                style:
                                Theme.of(context).textTheme.display1.copyWith(
                                  fontSize: 24.0,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Icon(
                                CustomIcons.road,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Distance',
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )));
  }
}
