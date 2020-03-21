import 'package:flutter/material.dart';

import '../const/circular_bar_typed.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  '../assets/icons/custom_icons_icons.dart';

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
            Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.directions_run,
                          size: 25,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10,height: 40,),
                        Text('Active Time',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$_activeTime ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                                textAlign: TextAlign.left),
                            Text('/ $_activeTotal mins',
                                style: TextStyle(
                                     fontSize: 20),
                                textAlign: TextAlign.left),

                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('$_activeCalories',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                textAlign: TextAlign.left),
                            Text(' kCal  ',
                                style: TextStyle(
                                     fontSize: 20),
                                textAlign: TextAlign.left),
                            Text('$_activeDistance',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.left),
                            Text(' km  ',
                                style: TextStyle(
                                    fontSize: 20),
                                textAlign: TextAlign.left),

                          ],
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          CustomIcons.bed,
                          size: 25,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10,height: 40,),
                        Text('Sleep Time',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$_sleepHours',
                                style: TextStyle(
                                     fontSize: 25),
                                textAlign: TextAlign.left),
                            Text(' hours',
                                style: TextStyle(
                                    fontSize: 20),
                                textAlign: TextAlign.left),

                          ],
                        ),

                      ],
                    )

                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          CustomIcons.heart,
                          size: 25,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10,height: 40,),
                        Text('Blood Presure',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$_bloodPreasure',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                textAlign: TextAlign.left),
                            Text(' mmHg',
                                style: TextStyle(
                                    fontSize: 20),
                                textAlign: TextAlign.left),
                          ],
                        ),

                      ],
                    )

                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          CustomIcons.droplet,
                          size: 25,
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: 10,height: 40,),
                        Text('Blood glucose',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$_bloodGlucoes',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                textAlign: TextAlign.left),
                            Text(' mg/dl',
                                style: TextStyle(
                                    fontSize: 20),
                                textAlign: TextAlign.left),

                          ],
                        ),

                      ],
                    )

                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          CustomIcons.gauge,
                          size: 25,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 10,height: 40,),
                        Text('Weight',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$_weight',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                textAlign: TextAlign.left),
                            Text(' kg',
                                style: TextStyle(
                                     fontSize: 25),
                                textAlign: TextAlign.left),

                          ],
                        ),

                      ],
                    )

                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          CustomIcons.ruler,
                          size: 25,
                          color: Colors.indigo,
                        ),
                        SizedBox(width: 10,height: 40,),
                        Text('Height',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$_height',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                textAlign: TextAlign.left),
                            Text(' cm',
                                style: TextStyle(
                                    fontSize: 25),
                                textAlign: TextAlign.left),

                          ],
                        ),

                      ],
                    )

                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          CustomIcons.gauge,
                          size: 25,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 10,height: 40,),
                        Text('BMI',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$_bmi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                textAlign: TextAlign.left),
                            Text(' kg/m2',
                                style: TextStyle(
                                    fontSize: 20),
                                textAlign: TextAlign.left),

                          ],
                        ),
                        Text('Normal',
                            style: TextStyle(
                               fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.left),


                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
