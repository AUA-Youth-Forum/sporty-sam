import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'assets/icons/custom_icons_icons.dart';

class ProfPage extends StatefulWidget {
  ProfPage({
    Key key,
    this.userId,
  }) : super(key: key);

  final String userId;

  @override
  _ProfPageState createState() => _ProfPageState();
}

class _ProfPageState extends State<ProfPage> {


  DateTime dateOnly(DateTime oldDate) {
    return DateTime(oldDate.year, oldDate.month, oldDate.day);
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
                .document(dateOnly(DateTime.now()).toString())
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Center(
          child: Container(
            child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(widget.userId)
                  .collection('healthHistory')
                  .document(dateOnly(DateTime.now()).toString())
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
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                          ),
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('users')
                                        .document(widget.userId)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      DocumentSnapshot personDetails =
                                          snapshot.data;

                                      if (snapshot.hasError)
                                        return new Text(
                                            'Error: ${snapshot.error}');
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return new Text('Loading...');
                                        default:
                                          return Stack(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(16.0),
                                                margin:
                                                    EdgeInsets.only(top: 16.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 96.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            personDetails[
                                                                'name'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .title,
                                                          ),
                                                          ListTile(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            title: Text(
                                                                "Product Designer"),
                                                            subtitle: Text(
                                                                "Colombo,Moratuwa"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text("285"),
                                                              Text("Likes")
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text("3025"),
                                                              Text("Comments")
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text("650"),
                                                              Text("Favourites")
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 80,
                                                width: 80,
                                                margin:
                                                    EdgeInsets.only(left: 16.0),
                                              ),
                                            ],
                                          );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails['steps']
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          CustomIcons
                                                              .directions_walk,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Steps',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails['steps'],
                                                      'steps');
                                                },
                                              ),
                                              const SizedBox(height: 10.0),
                                              InkWell(
                                                child: Container(
                                                  height: 120,
                                                  color: Colors.red,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails[
                                                                      'heartRate']
                                                                  .toString() +
                                                              ' ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          CustomIcons.heartbeat,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Avg. Heart Rate',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails[
                                                          'heartRate'],
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails['sleep']
                                                                  .toString() +
                                                              ' hours',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          CustomIcons.bed,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Sleep',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails['sleep'],
                                                      'sleep');
                                                },
                                              ),
                                              const SizedBox(height: 10.0),
                                              InkWell(
                                                child: Container(
                                                  height: 150,
                                                  color: Colors.green,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails[
                                                                      'glucose']
                                                                  .toString() +
                                                              " mg/dl",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          CustomIcons.droplet,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Blood glucose',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails['glucose'],
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails[
                                                                      'weight']
                                                                  .toString() +
                                                              " kg",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          CustomIcons.gauge,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Weight',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails['weight'],
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails[
                                                                  'calIntake']
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          Icons.fastfood,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Calories Intake',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails[
                                                          'calIntake'],
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails[
                                                                  'calBurn']
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          CustomIcons.fire,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Calories Burned',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails['calBurn'],
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
                                                        healthDetails[
                                                                    'distance']
                                                                .toString() +
                                                            ' km',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1
                                                            .copyWith(
                                                              fontSize: 24.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      trailing: Icon(
                                                        CustomIcons.road,
                                                        color: Colors.black,
                                                      ),
                                                      onTap: () {
                                                        dataInput(
                                                            healthDetails[
                                                                'distance'],
                                                            'distance');
                                                      },
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Text(
                                                        'Distance',
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        healthDetails[
                                                                    'activeMin']
                                                                .toString() +
                                                            " mins",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1
                                                            .copyWith(
                                                              fontSize: 24.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      trailing: Icon(
                                                        Icons.timer,
                                                        color: Colors.black,
                                                      ),
                                                      onTap: () {
                                                        dataInput(
                                                            healthDetails[
                                                                'activeMin'],
                                                            'activeMin');
                                                      },
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                        healthDetails['height'] /
                                                                            100,
                                                                        2))
                                                                .toStringAsFixed(
                                                                    1)) +
                                                            " kg/m2",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20.0,
                                                            ),
                                                      ),
                                                      trailing: Icon(
                                                        CustomIcons.gauge,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Text(
                                                        'BMI',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(
                                                          healthDetails[
                                                                      'height']
                                                                  .toString() +
                                                              " cm",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                        ),
                                                        trailing: Icon(
                                                          CustomIcons.ruler,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0),
                                                        child: Text(
                                                          'Height',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  dataInput(
                                                      healthDetails['height'],
                                                      'height');
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          )
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ));
  }
}
