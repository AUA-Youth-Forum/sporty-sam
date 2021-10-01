import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HealthTipImage extends StatefulWidget {
  final String filename;
  const HealthTipImage({Key? key, required this.filename}) : super(key: key);

  @override
  _HealthTipImageState createState() => _HealthTipImageState();
}

class _HealthTipImageState extends State<HealthTipImage> {
  String imageurl = '';
  var imgReference = FirebaseStorage.instance.ref().child('healthtips');
  @override
  Widget build(BuildContext context) {
    if (imageurl == '') {
      imgReference
          .child('${widget.filename}.jpg')
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
