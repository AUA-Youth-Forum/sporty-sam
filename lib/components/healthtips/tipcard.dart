import 'package:flutter/material.dart';
import 'package:sporty_sam/components/styles.dart';
import 'package:sporty_sam/components/healthtips/healthtipImage.dart';

class HealthTipCard extends StatelessWidget {
  final String content;
  final String title;
  final String img;

  const HealthTipCard(
      {Key? key, required this.content, required this.title, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: HealthTipImage(
                    filename: img,
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: k_healthtipcard_title_style,
                              textAlign: TextAlign.left),
                          Flexible(
                            child: Text(
                              content,
                              style: k_healthtipcard_content_style,
                              textAlign: TextAlign.justify,
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
