import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import './assets/icons/custom_icons_icons.dart';
import 'dart:math';

class MyHealthPage extends StatefulWidget {
  MyHealthPage({
    Key key,
    this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _MyHealthPageState createState() => _MyHealthPageState();
}

class _MyHealthPageState extends State<MyHealthPage> {
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

  void dataInput(int dataFactor, String dataField) {
    int numberInput = dataFactor;
    var alert = AlertDialog(
      title: Text("Enter Number"),
      content: TextField(
        controller: TextEditingController(text: dataFactor.toString()),
        keyboardType: TextInputType.number,
        style: TextStyle(decoration: TextDecoration.none, fontSize: 20),
        maxLines: 1,
        autofocus: true,
        onChanged: (String a) {
          numberInput = int.parse(a);
        },
        decoration: new InputDecoration(
          prefixIcon: new Icon(
            Icons.dialpad,
            size: 20.0,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          textColor: Colors.black,
          onPressed: () {
            Firestore.instance
                .collection('users')
                .document(widget.userId)
                .collection('healthHistory')
                .document(historyDate.toString())
                .updateData({dataField: numberInput});
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          textColor: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
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
          title: Text('My Health History'),
        ),
        body: Center(
          child: Container(
            child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(widget.userId)
                  .collection('healthHistory')
                  .document(historyDate.toString())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                DocumentSnapshot healthDetails = snapshot.data;

                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return SingleChildScrollView(
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
                                  setDatabaseDate(dateOnly(date));
                                  setState(() {
                                    historyDate = dateOnly(date);
                                  });
                                },
                                    currentTime: historyDate,
                                    locale: LocaleType.en);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          height: 160,
                                          color: Colors.blue,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['steps']
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
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
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Steps',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(
                                              healthDetails['steps'], 'steps');
                                        },
                                      ),
                                      const SizedBox(height: 10.0),
                                      InkWell(
                                        child: Container(
                                          height: 120,
                                          color: Colors.red,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['heartRate']
                                                          .toString() +
                                                      ' ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
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
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Avg. Heart Rate',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(healthDetails['heartRate'],
                                              'heartRate');
                                        },
                                      ),
                                      const SizedBox(height: 10.0),
                                      InkWell(
                                        child: Container(
                                          height: 120,
                                          color: Colors.purple,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['sleep']
                                                          .toString() +
                                                      ' hours',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 24.0,
                                                      ),
                                                ),
                                                trailing: Icon(
                                                  CustomIcons.bed,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Sleep',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(
                                              healthDetails['sleep'], 'sleep');
                                        },
                                      ),
                                      const SizedBox(height: 10.0),
                                      InkWell(
                                        child: Container(
                                          height: 150,
                                          color: Colors.green,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['glucose']
                                                          .toString() +
                                                      " mg/dl",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 24.0,
                                                      ),
                                                ),
                                                trailing: Icon(
                                                  CustomIcons.droplet,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Blood glucose',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(healthDetails['glucose'],
                                              'glucose');
                                        },
                                      ),
                                      const SizedBox(height: 10.0),
                                      InkWell(
                                        child: Container(
                                          height: 120,
                                          color: Colors.green,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['weight']
                                                          .toString() +
                                                      " kg",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 24.0,
                                                      ),
                                                ),
                                                trailing: Icon(
                                                  CustomIcons.gauge,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Weight',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(healthDetails['weight'],
                                              'weight');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          height: 120,
                                          color: Colors.green,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['calIntake']
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 24.0,
                                                      ),
                                                ),
                                                trailing: Icon(
                                                  Icons.fastfood,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Calories Intake',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(healthDetails['calIntake'],
                                              'calIntake');
                                        },
                                      ),
                                      const SizedBox(height: 10.0),
                                      InkWell(
                                        child: Container(
                                          height: 120,
                                          color: Colors.deepOrange,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['calBurn']
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
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
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Calories Burned',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(healthDetails['calBurn'],
                                              'calBurn');
                                        },
                                      ),
                                      const SizedBox(height: 10.0),
                                      Container(
                                        height: 190,
                                        color: Colors.yellow,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ListTile(
                                              title: Text(
                                                healthDetails['distance']
                                                        .toString() +
                                                    ' km',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                      fontSize: 24.0,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              trailing: Icon(
                                                CustomIcons.road,
                                                color: Colors.black,
                                              ),
                                              onTap: () {
                                                dataInput(
                                                    healthDetails['distance'],
                                                    'distance');
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(
                                                'Distance',
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                healthDetails['activeMin']
                                                        .toString() +
                                                    " mins",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                      fontSize: 24.0,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              trailing: Icon(
                                                Icons.timer,
                                                color: Colors.black,
                                              ),
                                              onTap: () {
                                                dataInput(
                                                    healthDetails['activeMin'],
                                                    'activeMin');
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(
                                                'Active time',
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ListTile(
                                              title: Text(
                                                ((healthDetails['weight'] /
                                                            pow(
                                                                healthDetails[
                                                                        'height'] /
                                                                    100,
                                                                2))
                                                        .toStringAsFixed(1)) +
                                                    " kg/m2",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                    ),
                                              ),
                                              trailing: Icon(
                                                CustomIcons.gauge,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(
                                                'BMI',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      InkWell(
                                        child: Container(
                                          height: 120,
                                          color: Colors.green,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  healthDetails['height']
                                                          .toString() +
                                                      " cm",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 24.0,
                                                      ),
                                                ),
                                                trailing: Icon(
                                                  CustomIcons.ruler,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Height',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          dataInput(healthDetails['height'],
                                              'height');
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ));
                }
              },
            ),
          ),
        )
    );
  }
}
