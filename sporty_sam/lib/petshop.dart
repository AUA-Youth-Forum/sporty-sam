import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';

List<bool> isSelect = [false, false, false, false, false, false];

class PetShop extends StatefulWidget {
  PetShop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PetShopState createState() => _PetShopState();
}

class _PetShopState extends State<PetShop> {
  Widget _petItem(String name, String imgPath, int petID) {
    return InkWell(
        onTap: () {
          setState(() {
            isSelect.setAll(0, [false, false, false, false, false, false]);
            isSelect[petID] = !isSelect[petID];
          });
          //print("selected " + name);
        },
        child: Container(
            decoration: BoxDecoration(
                color: isSelect[petID] ? Colors.orange : Colors.grey,
                borderRadius: BorderRadius.circular(50.0)
            ),
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage(imgPath),
                  width: 100,
                  height: 100,
                ),
                Text(name)
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Pet Shop'),
        ),
        body: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(50.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _petItem("cat1", "lib/assets/img/cat1.jpg", 0),
                        _petItem("dog1", "lib/assets/img/dog1.jfif", 1),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _petItem("parrot1", "lib/assets/img/parrot1.jpg", 2),
                        _petItem("teddy1", "lib/assets/img/teddy1.png", 3),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _petItem("parrot1", "lib/assets/img/parrot1.jpg", 4),
                        _petItem("teddy1", "lib/assets/img/teddy1.png", 5),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
              child: Text('Select and go home'),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffdf8e33), Color(0xfff7892b)])),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]));
  }
}
