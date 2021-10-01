import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

import 'package:sporty_sam/pages/activityHistory.dart';
import 'package:sporty_sam/pages/dailyQuest.dart';
import 'package:sporty_sam/pages/healthtips.dart';
import 'package:sporty_sam/pages/leaderboard.dart';
import 'package:sporty_sam/pages/profile.dart';
import 'package:sporty_sam/pages/settings.dart';

class CircularMenu extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  CircularMenu();

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => FabCircularMenu(
              key: fabKey,
              // Cannot be `Alignment.center`
              alignment: Alignment.bottomRight,
              ringColor: Colors.amber.withAlpha(470),
              ringDiameter: 500.0,
              ringWidth: 100.0,
              fabSize: 64.0,
              fabElevation: 8.0,
              fabIconBorder: CircleBorder(),
              // Also can use specific color based on wether
              // the menu is open or not:
              // fabOpenColor: Colors.white
              // fabCloseColor: Colors.white
              // These properties take precedence over fabColor
              fabColor: Colors.amber,
              fabOpenIcon: Icon(Icons.menu, color: Colors.white),
              fabCloseIcon: Icon(Icons.close, color: Colors.white),
              fabMargin: const EdgeInsets.all(16.0),
              animationDuration: const Duration(milliseconds: 800),
              animationCurve: Curves.easeInOutCirc,
              onDisplayChange: (isOpen) {
                _showSnackBar(
                    context, "The menu is ${isOpen ? "open" : "closed"}");
              },
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                    fabKey.currentState!.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.settings),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfilePage()));
                    fabKey.currentState!.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.face),
                ),
                RawMaterialButton(
                  onPressed: () {
                    // _showSnackBar(context, "You pressed 5. This one closes the menu on tap");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivityHistory()));
                    fabKey.currentState!.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.directions_run),
                ),
                RawMaterialButton(
                  onPressed: () {
                    // _showSnackBar(context, "You pressed 5. This one closes the menu on tap");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Leaderboard()));
                    fabKey.currentState!.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.leaderboard),
                ),
                RawMaterialButton(
                  onPressed: () {
                    // _showSnackBar(context, "You pressed 5. This one closes the menu on tap");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HealthTipsPage()));
                    fabKey.currentState!.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.network_check),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DailyQuestPage()));
                    fabKey.currentState!.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.golf_course),
                )
              ],
            ));
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ));
  }
}
