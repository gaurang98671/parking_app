import 'package:flutter/material.dart';
import 'signup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: get_started(),
    );
  }
}

class get_started extends StatefulWidget {
  @override
  _get_startedState createState() => _get_startedState();
}

class _get_startedState extends State<get_started> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("images/get_started.gif"), fit: BoxFit.cover,),
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
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),

                  SizedBox(height: 75,),

                  RaisedButton(
                    onPressed: ()=>{},
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: Text("Login"),
                  ),

                  SizedBox(height: 15,),

                  Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  RaisedButton(
                    onPressed: ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>signup_page()))
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(
                            30.0
                        )
                    ),
                    color: Colors.white,
                    child: Text(
                      'Signup'
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
