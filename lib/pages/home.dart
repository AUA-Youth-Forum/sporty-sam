import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:sporty_sam/services/activity_recognition_flutter.dart';
import 'package:sporty_sam/services/auth.dart';
import '../components/home/circularMenu.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sporty_sam/components/functions/firebaseFunctions.dart';
import 'package:country_picker/country_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stream<ActivityEvent> activityStream;
  ActivityEvent latestActivity = ActivityEvent.empty();
  List<ActivityEvent> _events = [];
  ActivityRecognition activityRecognition = ActivityRecognition.instance;
  String? userID = "";
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    /////////////////////////////////////////////// from documentation
    /// Android requires explicitly asking permission
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        _startTracking();
        print(getUser()?.uid);
      }
    }

    /// iOS does not
    else {
      _startTracking();
    }
    ///////////////////////////////////////////////////
    userID = getUser()?.uid;
    print(userID);
    setDatabaseDate(userID);
  }

  void _startTracking() {
    activityStream =
        activityRecognition.startStream(runForegroundService: true);
    activityStream.listen(onData);
  }

  void _signOut() async {
    print("Logging out");
    await signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  void showCountries() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) =>
          print('Select country: ${country.countryCode}'),
    );
  }

  void onData(ActivityEvent activityEvent) {
    print(activityEvent.toString());
    setState(() {
      _events.add(activityEvent);
      latestActivity = activityEvent;
    });
    ActivityEvent previousActivity =
        _events[_events.length == 1 ? _events.length - 1 : _events.length - 2];
    updateUserActivity(latestActivity, previousActivity, userID);
    print("updateUserActivity:");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
//        alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("lib/assets/back1.jpg"),
                fit: BoxFit.fitHeight,
              )),
            ),
            Center(
                child: ListView.builder(
                    itemCount: _events.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int idx) {
                      final entry = _events[idx];
                      return ListTile(
                          leading:
                              Text(entry.timeStamp.toString().substring(0, 19)),
                          trailing:
                              Text(entry.type.toString().split('.').last));
                    })),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("Flags"),
                    onPressed: (showCountries),
                  ),
                  ElevatedButton(
                    child: Text("Logout"),
                    onPressed: (_signOut),
                  )
                ],
              ),
            ),
          ]),
      floatingActionButton: CircularMenu(),
    );
  }
}
