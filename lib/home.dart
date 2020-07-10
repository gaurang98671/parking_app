import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/login.dart';
import 'package:parkingapp/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;
  const HomeScreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Marker> _markers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Container(
          width: 270,
          child: new Drawer(
            child: new ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  // color: Colors.purpleAccent,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            //get image from storage
                            'assets/images/vv.PNG'),
                        radius: 40,
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      ListTile(
                        //get current user name from data base
                        title: Center(
                            child: Text(
                          'Gaurang Pawar',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xff020061)),
                        )),
                        //get current user email from data base
                        subtitle: Center(
                          child: Text(
                            'gaurangpawar@gmail.com',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      Container(
                        height: 1,
                        width: 250,
                        color: Color(0xff020061),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.home,
                          color: Color(0xff020061),
                        ),
                        title: Text(
                          'Home',
                          style:
                              TextStyle(color: Color(0xff020061), fontSize: 15),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          color: Color(0xff020061),
                        ),
                        title: Text(
                          'Profile',
                          style:
                              TextStyle(color: Color(0xff020061), fontSize: 15),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => user_profile()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.history,
                          color: Color(0xff020061),
                        ),
                        title: Text(
                          'My bookings',
                          style:
                              TextStyle(color: Color(0xff020061), fontSize: 15),
                        ),
                        onTap: () {
                          print('Current user');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.add,
                          color: Color(0xff020061),
                        ),
                        title: Text(
                          'Host parking',
                          style:
                              TextStyle(color: Color(0xff020061), fontSize: 15),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.info,
                          color: Color(0xff020061),
                        ),
                        title: Text(
                          'About',
                          style:
                              TextStyle(color: Color(0xff020061), fontSize: 15),
                        ),
                      ),
                      // SizedBox(
                      //   height: 60,
                      // ),
                      // Container(
                      //   height: 1,
                      //   width: 250,
                      //   color: Colors.black45,
                      // ),
                      Card(
                        color: Color(0xffec8b5e),
                        child: ListTile(
                          leading: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            clear_pref();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            _loadMap(),
            Positioned(
                left: 0,
                top: 20,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => scaffoldKey.currentState.openDrawer(),
                  color: Colors.white,
                  iconSize: 35,
                ))
          ],
        ));
  }

  Widget _loadMap() {
    return StreamBuilder(
      stream: Firestore.instance.collection('Parkings').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading map');
        } else {
          _markers.clear();
          for (int i = 0; i < snapshot.data.documents.length; i++) {
            _markers.add(new Marker(
                visible: true,
                markerId: MarkerId(i.toString()),
                position: new LatLng(
                    snapshot.data.documents[i]['location'].latitude,
                    snapshot.data.documents[i]['location'].longitude),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext contex) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            height: 180.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('Parkings')
                                  .snapshots(),
                              builder: (context, snap) {
                                if (!snap.hasData) {
                                  return CircularProgressIndicator();
                                } else {
                                  return Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/vv.PNG'),
                                        radius: 40,
                                      ),
                                      Text(snap.data.documents[i]['Address']
                                          .toString()),
                                      Text(
                                        "Aquired spots: " +
                                            snap.data.documents[i]['Aquired']
                                                .toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      RaisedButton(
                                        child: Text(
                                          'Book spot',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.purple,
                                        onPressed: () => {},
                                      )
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      });
                }));
          }
          print(_markers.length);
        }
        return Stack(
          children: <Widget>[
            new GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                  target: LatLng(19.204761, 73.006379), zoom: 13),
              markers: _markers.toSet(),
            ),
          ],
        );
      },
    );
  }

  void clear_pref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
