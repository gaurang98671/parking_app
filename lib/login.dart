import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user_name, password;
  void login_user() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user_name, password: password);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

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
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text('Sign In',
                      style: TextStyle(
                          fontSize: 60,
                          fontFamily: 'Righteous',
                          color: Colors.black87)),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: TextField(
                      onChanged: (userName) {
                        user_name = userName;
                      },
                      style: TextStyle(
                        color: Color(0xff020061),
                      ),
                      decoration: InputDecoration(
                          // filled: true,
                          // fillColor: Colors.blueAccent,
                          labelText: 'username',
                          labelStyle: TextStyle(
                            color: Colors.white,
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
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextField(
                    onChanged: (pass) {
                      password = pass;
                    },
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
                        color: Colors.white,
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
                      login_user();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: Text(
                        'Login',
                        style:
                            TextStyle(color: Color(0xff020061), fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return null;
                      }));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return RegisterScreen();
                      }));
                    },
                    child: Text(
                      'Create new account',
                      style: TextStyle(
                        color: Colors.white,
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
