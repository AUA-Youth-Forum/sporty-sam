import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String content;
  final String title;
  final String img;
  final String endTime;
  final String startTime;

  const ActivityCard(
      {Key? key,
      required this.content,
      required this.title,
      required this.img,
      required this.startTime,
      required this.endTime})
      : super(key: key);
  String setIcon(type) {
    String link = "";
    if (type == "ON_BICYCLE") {
      link = "lib/assets/cyclling.png";
    } else if (type == "RUNNING") {
      link = "lib/assets/running.png";
    } else if (type == "WALKING") {
      link = "lib/assets/walking.png";
    }
    return link;
  }

  String setTitle(type) {
    String title = "";
    if (type == "ON_BICYCLE") {
      title = "On Bycicle";
    } else if (type == "RUNNING") {
      title = "Running";
    } else if (type == "WALKING") {
      title = "Walking";
    }
    return title;
  }

  Color setColor(type) {
    Color main = Colors.amber;
    if (type == "ON_BICYCLE") {
      main = Colors.purple;
    } else if (type == "RUNNING") {
      main = Colors.blue;
    } else if (type == "WALKING") {
      main = Colors.orange.shade700;
    }
    return main;
  }

  Color setTimeColor(type) {
    Color main = Colors.amber;
    if (type == "ON_BICYCLE") {
      main = Colors.purple.shade200;
    } else if (type == "RUNNING") {
      main = Colors.blue.shade200;
    } else if (type == "WALKING") {
      main = Colors.orange.shade200;
    }
    return main;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(setIcon(img)),
                    fit: BoxFit.fitHeight,
                  )),
                ),
                Flexible(
                  child: Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              startTime,
                              style: TextStyle(
                                color: setTimeColor(img),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Text(setTitle(img),
                              style: TextStyle(
                                  color: setColor(img),
                                  fontSize: 20,
                                  height: 1,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                          Flexible(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              endTime,
                              style: TextStyle(
                                color: setTimeColor(img),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
