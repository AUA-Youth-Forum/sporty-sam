import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sporty_sam/assets/custom_icons_icons.dart';
import 'package:sporty_sam/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporty_sam/components/settings/functions.dart';
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //default settings
  String gender = 'Male';
  String? userID = getUser()?.uid;
  DateTime _birthday = DateTime.now();

  void _signOut() async {
    print("Logging out");
    await signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userID)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    DocumentSnapshot<Object?>? userdetails = snapshot.data;
                    _birthday = DateTime.parse(userdetails!['birthday']);
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Card(
//                            elevation: 8.0,
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(10.0)),
//                            color: Colors.deepOrangeAccent,
//                            child: TextFormField(
//                              width: double.maxFinite,
//                              height: 60,
//                              duration: Duration(milliseconds: 300),
//                              inputType: TextInputType.text,
//                              prefixIcon: Padding(
//                                padding: const EdgeInsets.all(10.0),
//                                child: Container(
//                                  width: 50,
//                                  height: 50,
//                                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
//                                      image: DecorationImage(
//                                        fit: BoxFit.fill,
//                                        image: AssetImage(
//                                            'lib/assets/tips/food.jpg'),
//                                      )),
//                                ),
//                              ),
//                              suffixIcon: Icon(Icons.edit),
//                              placeholder: userdetails['name'],
//                              onTap: () {
//                                print('Click');
//                              },
//                              onChanged: (text) {},
//                              onSaved: (String? value) {
//                                FirebaseFirestore.instance
//                                    .collection('users')
//                                    .doc(userID)
//                                    .update({"name": value});
//                              },
//                            ),
//                          ),
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
                                  title: Text(userdetails['country']),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    showCountries(context,userID);
                                    //open change location
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                  leading: Icon(
                                    CustomIcons.female_1,
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
                                        onChanged: (String? newValue) {
                                          updateGender(newValue, userID);
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
                                  title:
                                  Text('Birthday : ${_birthday.day}/${_birthday.month}/${_birthday.year} '),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    updateBirthday(context, userID, userdetails['birthday']);
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
                                    onTap: _signOut),
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
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userID)
                                      .delete();
                                  _signOut();
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
