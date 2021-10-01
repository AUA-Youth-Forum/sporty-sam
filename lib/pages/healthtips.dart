import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporty_sam/components/healthtips/tipcard.dart';

class HealthTipsPage extends StatefulWidget {
  @override
  _HealthTipsPageState createState() => _HealthTipsPageState();
}

class _HealthTipsPageState extends State<HealthTipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tips'),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("health tips")
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  : ListWheelScrollView(
                      itemExtent: 180,
                      diameterRatio: 5,
                      children: snapshot.data!.docs.map((document) {
                        return HealthTipCard(
                            content: document["content"],
                            title: document['title'],
                            img: document['ImgName']);
                      }).toList(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
