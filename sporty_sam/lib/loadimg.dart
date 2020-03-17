import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoadImg extends StatefulWidget {
  LoadImg({this.fileName});

  final String fileName;

  @override
  _LoadImg createState() => new _LoadImg();
}

class _LoadImg extends State<LoadImg> {
  Uint8List imageFile;
  StorageReference cardImgReference =
      FirebaseStorage.instance.ref().child("healthtips");

  @override
  Widget build(BuildContext context) {
    print('zzzz');

    const int MAXSIZE = 4 * 1024 * 1024;
    cardImgReference
        .child('${widget.fileName}.jpg')
        .getData(MAXSIZE)
        .then((data) {
//      imageFile = data;
      print(widget.fileName);
      this.setState(() {
        imageFile = data;
      });
    }
    ).catchError((error) {
      print(error);
    });
    
    if (imageFile == null) {
      return new Text('no data \n${widget.fileName}.jpg');
    } else {
      return new Image.memory(
        imageFile,
        width: 150,
        height: 150,
      );
    }
  }
}
