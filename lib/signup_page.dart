import 'package:flutter/material.dart';



class signup_page extends StatefulWidget {
  @override
  _signup_pageState createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("images/signup.jpg"), fit: BoxFit.cover,),
            ),
          ),
          Center(
            child: Container(
              width: 330,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 150,),

                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none
                            )
                        ),
                        hintText: 'User Name',
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),

                  SizedBox(height: 20,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none
                            )
                        ),
                        hintText: 'License Plate No.',
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none
                            )
                        ),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),


                  SizedBox(height: 20,),

                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none
                          )
                      ),
                      hintText: 'Retype Password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),

                  SizedBox(height: 75,),

                  RaisedButton(
                    onPressed: ()=>{},

                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(
                            30.0
                        )
                    ),
                    child: Text("SignUp",
                    style: TextStyle(
                      fontSize: 15
                    ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
