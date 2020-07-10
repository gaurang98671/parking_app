import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockcheckForSession().then((status) async {
      if (await FirebaseAuth.instance.currentUser() != null) {


        FirebaseUser u=await FirebaseAuth.instance.currentUser();
        print(u.email);
        SharedPreferences pref= await SharedPreferences.getInstance();
        await pref.setString('user_email', u.email);


       _navigateToHome();
            } else {
        _navigateToLogin();
      }
    });
  }

//mock checking if user is already logged in
//later to be replaced by authentication api
  Future<bool> _mockcheckForSession() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
   return false;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));

  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    //to load image at startup
    precacheImage(AssetImage('assets/images/background.jpg'), context);

    return Scaffold(
        body: Container(
            child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/images/background_2.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
        Shimmer.fromColors(
            baseColor: Color(0xff020061),
            highlightColor: Color(0xffec8b5e),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
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
              ],
            ))
      ],
    )));
  }
}
