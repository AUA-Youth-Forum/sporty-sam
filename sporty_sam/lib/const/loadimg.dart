import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cached_network_image/cached_network_image.dart';

class LoadImg extends StatefulWidget {
  LoadImg({this.fileName});

  final String fileName;

  @override
  _LoadImg createState() => new _LoadImg();
}

class _LoadImg extends State<LoadImg> {
  String imgUrl;
  String data;
  Uint8List imageFile;
  StorageReference cardImgReference =
      FirebaseStorage.instance.ref().child("healthtips");

//  @override
//  Widget build(BuildContext context) {
//    print('zzzz');
//
//    const int MAXSIZE = 4 * 1024 * 1024;
//    cardImgReference
//        .child('${widget.fileName}.jpg')
//        .getData(MAXSIZE)
//        .then((data) {
////      imageFile = data;
//      print(widget.fileName);
//      this.setState(() {
//        imageFile = data;
//      });
//    }
//    ).catchError((error) {
//      print(error);
//    });
//
//    if (imageFile == null) {
//      return new Text('no data \n${widget.fileName}.jpg');
//    } else {
//      return new Image.memory(
//        imageFile,
//        width: 150,
//        height: 150,
//      );
//    }

  @override
  Widget build(BuildContext context) {
    print('zzzz');

    //const int MAXSIZE = 4 * 1024 * 1024;
    if (imgUrl == null) {
      cardImgReference
          .child('${widget.fileName}.jpg')
          .getDownloadURL()
          .then((data) {
//
////      print(widget.fileName);
        this.setState(() {
          print('nnnn');
          imgUrl = data;
        });
      }).catchError((error) {
        print(error);
      });
    }
    print(imgUrl);
//    print(data);
//    imgUrl=data;
    if (imgUrl == null) {
      return new Text('no data \n${widget.fileName}.jpg');
    } else {
      print('ddd');
      return Container(
        child: CachedNetworkImage(
          imageUrl: '${imgUrl}',
          fit: BoxFit.fitWidth,
        ),
        width: 150,
        height: 150,
      );
    }
  }
}
