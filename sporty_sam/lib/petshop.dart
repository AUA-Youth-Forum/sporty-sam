import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PetShop extends StatefulWidget {
  PetShop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PetShopState createState() => _PetShopState();
}

class _PetShopState extends State<PetShop> {
  Widget _petItem(String name, String imgPath, {bool isSelect = false}) {
    return InkWell(
        onTap: () => print("selected " + name),
        customBorder: CircleBorder(),
        child: Container(
//          decoration: BoxDecoration(
////            color: Colors.orange,
//            borderRadius: BorderRadius.only(
//              bottomLeft: Radius.circular(100.0)
//            )
//          ),
            width: 150,
            height: 150,
            //color: isSelect ? Colors.orange : Colors.grey,
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
      body: Column(
        children:<Widget>[ SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _petItem("cat1", "lib/assets/img/cat1.jpg"),
                  _petItem("dog1", "lib/assets/img/dog1.jfif", isSelect: true),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _petItem("parrot1", "lib/assets/img/parrot1.jpg"),
                  _petItem("teddy1", "lib/assets/img/teddy1.png"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _petItem("parrot1", "lib/assets/img/parrot1.jpg"),
                  _petItem("teddy1", "lib/assets/img/teddy1.png"),
                ],
              ),

            ],
          ),
        ),
      ),
          RaisedButton(
            child: Container(
              child: Text('Select and go home'),
            ),
            onPressed: () {Navigator.pop(context);},
          )
      ])
    );
  }
}
