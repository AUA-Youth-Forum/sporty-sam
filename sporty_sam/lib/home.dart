import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:sporty_sam/healthTips.dart';
import 'package:sporty_sam/petshop.dart';
import './const/fab_circular_menu.dart';
import './settings.dart';
import 'dietTracker.dart';
import 'myHealth.dart';
import 'challenge.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = FabCircularMenuController();
    return Scaffold(
//      appBar: AppBar(
//
//        title: Text(widget.title),
//      ),
        body: Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sam',
                style: Theme.of(context).textTheme.display1,
              ),
              InkWell(
                child: Container(
                  height: 300,
                  width: 300,
                  child: FlareActor(
                    "lib/assets/animations/teddy.flr",
                    animation: "success",
                    //color: Colors.red
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetShop(),
                      ));
                },
              ),
            ],
          ),
          FabCircularMenu(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //color: Colors.indigo[900].withOpacity(.5),
//              child:  Padding(
//                padding: const EdgeInsets.only(bottom: 50),
//                child: Text('FAB Circle Menu Example',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(color: Colors.black, fontSize: 36.0)),
////                          ),
//              ),
            ),
            ringColor: Colors.white30,
            controller: controller,
            options: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    controller.isOpen = false;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.fastfood),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DietTrackerPage()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.face),
                  onPressed: () {},
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.directions_run),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHealthPage()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.videogame_asset),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChallengePage()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HealthTips()));
                  },
                  iconSize: 48.0,
                  color: Colors.black),
            ],
            //),
          ),
        ],
      ),
    ));
  }
}
