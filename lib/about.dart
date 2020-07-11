import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class About_Page extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<About_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Opacity(
        //     opacity: 1,
        //     child: Image.asset(
        //       'assets/images/background_2.jpg',
        //       width: double.infinity,
        //       height: double.infinity,
        //       fit: BoxFit.cover,
        //     )),
        Shimmer.fromColors(
            baseColor: Color(0xff020061),
            highlightColor: Color(0xffec8b5e),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Parkmate',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'Righteous',
                    ),
                  ),
                ),
                Text('Team'),
              ],
            ))
      ],
    )));
  }
}
