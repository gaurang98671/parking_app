import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'home.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/background.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text('Register',
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xff020061),
                      ),
                      decoration: InputDecoration(
                          // filled: true,
                          // fillColor: Colors.blueAccent,
                          labelText: 'username',
                          labelStyle: TextStyle(
                            color: Color(0xffB65133),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff020061)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff020061)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      textAlign: TextAlign.left,
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xff020061),
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'password',
                      labelStyle: TextStyle(
                        color: Color(0xffB65133),
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xff020061),
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'confirm password',
                      labelStyle: TextStyle(
                        color: Color(0xffB65133),
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: FlatButton(
                    color: Color(0xffec8b5e),
                    splashColor: Color(0xff020061),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return HomeScreen();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: Text(
                        'Register',
                        style:
                            TextStyle(color: Color(0xff020061), fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return LoginPage();
                      }));
                    },
                    child: Text(
                      'Already have an account? Sign in',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        )));
  }
}
