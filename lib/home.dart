import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          Container(
            child: Text(
              'HomeScreen',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
          )
        ],
      ),
    );
  }
}
