import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ActivityIMG extends StatefulWidget {
  final String filename;
  const ActivityIMG({Key? key, required this.filename}) : super(key: key);

  @override
  _ActivityIMGState createState() => _ActivityIMGState();
}

class _ActivityIMGState extends State<ActivityIMG> {
  String imageurl = '';
  var imgReference = FirebaseStorage.instance.ref().child('healthtips');

  String setIcon(type) {
    String link = "";
    if (type == "ON_BICYCLE") {
      link = "icons8-cycling-mountain-bike-100.png";
    } else if (type == "RUNNING") {
      link = "icons8-running-64.png";
    } else if ((type == "WALKING") || (type == "ON_FOOT")) {
      link = "icons8-foot-100.png";
    }
    return link;
  }

  @override
  Widget build(BuildContext context) {
    if (imageurl == '') {
      imgReference
          .child("lib/assets/tips/workout.jpg")
          .getDownloadURL()
          .then((value) => {
                this.setState(() {
                  imageurl = value;
                })
              })
          .catchError((err) {
        print(err);
      });
    }

    return (imageurl == '')
        ? CircularProgressIndicator()
        : CachedNetworkImage(
            imageUrl: '$imageurl',
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
  }
}
