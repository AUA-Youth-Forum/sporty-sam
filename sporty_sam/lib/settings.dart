import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './assets/icons/custom_icons_icons.dart';
import 'package:sporty_sam/services/authentication.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import './const/beauty_textfield.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);


  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //default settings
  String gender = 'Male';

  Country _selectedCountry = Country.AD;
  DateTime _birthday = DateTime.now();

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _birthday = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Container(
            child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(widget.userId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    DocumentSnapshot userdetails = snapshot.data;
                    _birthday = DateTime.parse(userdetails['birthday']);
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.deepOrangeAccent,
                            child: BeautyTextfield(
                              width: double.maxFinite,
                              height: 60,
                              duration: Duration(milliseconds: 300),
                              inputType: TextInputType.text,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'lib/assets/tips/food.jpg'),
                                      )),
                                ),
                              ),
                              suffixIcon: Icon(Icons.edit),
                              placeholder: userdetails['name'],
                              onTap: () {
                                print('Click');
                              },
                              onChanged: (text) {},
                              onSubmitted: (data) {
                                Firestore.instance
                                    .collection('users')
                                    .document(widget.userId)
                                    .updateData({"name": data});
                              },
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.fromLTRB(
                                20.0, 8.0, 20.0, 16.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.mail,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  title: Text(userdetails['email']),
                                  onTap: () {
                                    //open change password
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.lock_outline,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  title: Text("Change Password"),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change password
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  title: Row(
                                    children: <Widget>[
                                      CountryPicker(
                                        dense: false,
                                        showFlag:
                                            true, //displays flag, true by default
                                        showDialingCode:
                                            false, //displays dialing code, false by default
                                        showName:
                                            true, //displays country name, true by default
                                        showCurrency:
                                            false, //eg. 'British pound'
                                        showCurrencyISO: false, //eg. 'GBP'
                                        onChanged: (Country country) {
                                          try {
                                            Firestore.instance
                                                .collection('users')
                                                .document(widget.userId)
                                                .updateData({
                                              'country': country.isoCode
                                            });
                                          } catch (e) {
                                            print(e.toString());
                                          }
                                        },
                                        selectedCountry: Country.findByIsoCode(
                                            userdetails['country']),
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change location
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                  leading: Icon(
                                    CustomIcons.male,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  title: Row(
                                    children: <Widget>[
                                      Text("Gender : "),
                                      DropdownButton<String>(
                                        value: userdetails['gender'],
                                        icon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Icon(Icons.edit),
                                          ],
                                        ),
                                        elevation: 16,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        onChanged: (String newValue) {
                                          try {
                                            Firestore.instance
                                                .collection('users')
                                                .document(widget.userId)
                                                .updateData(
                                                    {'gender': newValue});
                                          } catch (e) {
                                            print(e.toString());
                                          }
                                        },
                                        items: <String>[
                                          'Male',
                                          'Female',
                                          'Other'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change language
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.calendar_today,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  title: Text(
                                      'Birthday : ${_birthday.day}/${_birthday.month}/${_birthday.year} '),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        theme: DatePickerTheme(
                                          containerHeight: 210.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime(1950, 1, 1),
                                        maxTime: DateTime.now(),
                                        onConfirm: (date) {
                                      try {
                                        Firestore.instance
                                            .collection('users')
                                            .document(widget.userId)
                                            .updateData(
                                                {'birthday': date.toString()});
                                      } catch (e) {
                                        print('abcd');
                                        print(e.toString());
                                      }
                                    },
                                        currentTime: DateTime.parse(
                                            userdetails['birthday']),
                                        locale: LocaleType.en);
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                    leading: Icon(
                                      Icons.power_settings_new,
                                      color: Colors.deepOrangeAccent,
                                    ),
                                    title: Text("Logout"),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                    onTap: signOut),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SwitchListTile(
                            activeColor: Colors.deepOrangeAccent,
                            contentPadding: const EdgeInsets.all(0),
                            value: true,
                            title: Text("Pubilc Visibility"),
                            onChanged: (val) {},
                          ),
                          _buildDivider(),
                          const SizedBox(height: 20.0),
                          Text(
                            "Notification Settings",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          SwitchListTile(
                            activeColor: Colors.deepOrangeAccent,
                            contentPadding: const EdgeInsets.all(0),
                            value: true,
                            title: Text("Receive notifications"),
                            onChanged: (val) {},
                          ),
                          _buildDivider(),
                          const SizedBox(height: 20.0),
                          ListTile(
                              leading: Icon(
                                Icons.info,
                                color: Colors.deepOrangeAccent,
                              ),
                              title: Text("About Us"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {}),
                          const SizedBox(height: 40.0),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            width: double.infinity,
                            height: 3.0,
                            color: Colors.red,
                          ),
                          ListTile(
                              leading: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                              title: Text(
                                "Delete my account",
                                style: TextStyle(color: Colors.red),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                try {
                                  Firestore.instance
                                      .collection('users')
                                      .document(widget.userId)
                                      .delete();
                                  signOut();
                                } catch (e) {
                                  print(e.toString());
                                }
                              }),
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
