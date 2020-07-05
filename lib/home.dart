import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name='gaurang';
  @override
  void initstate()
  {
    getuid().then(update_uid);
  }

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
              _name,
              style: TextStyle(
                fontSize: 50,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getuid() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String uid=prefs.get('uid');
    return uid;
  }



  void update_uid(String uid)
  {
    setState(() {
      this._name=uid;
    });
  }
}
