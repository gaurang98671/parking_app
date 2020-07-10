import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/host_parking.dart';
import 'package:parkingapp/login.dart';
import 'package:parkingapp/requests_page.dart';
import 'package:parkingapp/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'host_parking.dart';

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
  BitmapDescriptor pinLocationIcon1, pinLocationIcon2, pinLocationIcon3;
  String current_users_email='';
  String current_user_id='';
  @override
  void initState() {
    get_email();
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon1 = BitmapDescriptor.fromAsset('assets/images/marker.png');
    pinLocationIcon2 =
        BitmapDescriptor.fromAsset('assets/images/marker_red.png');
    pinLocationIcon3 =
        BitmapDescriptor.fromAsset('assets/images/marker_green.png');
  }

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
                      FutureBuilder(
                        future: getUserInfo(),
                        builder: (_ , snapshot){
                          if(!snapshot.hasData)
                            {
                              return Text('Couldnt load data');
                            }
                          else
                            {
                              return  ListTile(
                                //get current user name from data base
                                title: Center(
                                    child: Text(
                                      snapshot.data[0]['Name'],
                                      style:
                                      TextStyle(fontSize: 18, color: Color(0xff020061)),
                                    )),
                                //get current user email from data base
                                subtitle: Center(
                                  child: Text(
                                    snapshot.data[0]['email'],
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                              );
                            }
                        },
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
                          Icons.notifications,
                          color: Color(0xff020061),
                        ),
                        title: Text(
                          'Parking requests',
                          style:
                          TextStyle(color: Color(0xff020061), fontSize: 15),
                        ),
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>requests_page()));
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => host_parking()));
                        },
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
                icon: _getMarker(snapshot.data.documents[i]['Aquired'],
                    snapshot.data.documents[i]['Quantity'],
                    snapshot.data.documents[i]['Type']),
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
                            // height: 180.0,
                            // width: 300.0,
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
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 200,
                                          width: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/images/vv.PNG')),
                                          ),

                                          // decoration: BoxDecoration(
                                          //   borderRadius: BorderRadius.all(
                                          //       Radius.circular(20)),

                                          //   image: DecorationImage(
                                          //       image: AssetImage(
                                          //           'assets/images/vv.PNG')),
                                          // ),
                                          // backgroundImage: AssetImage(
                                          //     'assets/images/vv.PNG'),
                                          // radius: 40,
                                        ),
                                        Text(
                                          snap.data.documents[i]['Address']
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                        Text(
                                          "Available spots: " +
                                              (snap.data
                                                  .documents[i]["Aquired"])
                                                  .toString() + "/" +
                                              (snapshot.data
                                                  .documents[i]["Quantity"])
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black45),
                                        ),
                                        get_host_name(snapshot.data.documents[i]['Type'], snapshot.data.documents[i]['Hosted by']),

                                        SizedBox(
                                          height: 20,
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                7, 0, 0, 0),
                                            child: Text(
                                              'Description',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xff020061),
                                              ),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                7, 0, 0, 0),
                                            child: Text(
                                              snapshot.data
                                                  .documents[i]['Description'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Card(
                                            child: ExpansionTile(
                                              title: Text(
                                                'Hourly Rate',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff020061),
                                                ),
                                              ),
                                              // subtitle: Text('22 Rs/hr'),
                                              children: <Widget>[
                                                ListTile(
                                                  title: Text('Two-wheeler'),
                                                  subtitle: Text(snapshot.data
                                                      .documents[i]['2 wheeler cost']
                                                      .toString()),
                                                ),
                                                ListTile(
                                                  title: Text('Four-wheeler'),
                                                  subtitle: Text(snapshot.data
                                                      .documents[i]['4 wheeler cost']
                                                      .toString()),
                                                )
                                              ],
                                            )),
                                        Card(
                                          child: ExpansionTile(
                                            //lit, cctv ,gated,gaurded
                                            title: Text(
                                              'Amenities',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff020061),
                                              ),
                                            ),
                                            children: <Widget>[
                                              //Covered
                                              ListTile(
                                                leading: Icon(
                                                  Icons.lightbulb_outline,
                                                  color: get_color(snapshot.data
                                                      .documents[i]['hasLight']),
                                                ),
                                                title: Text('Lit'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.camera_alt,
                                                  color: get_color(snapshot.data
                                                      .documents[i]['hasCCTV']),
                                                ),
                                                // Icon(Icons.lightbulb_outline),
                                                title: Text('CCTV'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.lock_outline,
                                                  color: get_color(snapshot.data
                                                      .documents[i]['isGuarded']),
                                                ),
                                                title: Text('Guarded'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.lightbulb_outline,
                                                  color: get_color(snapshot.data
                                                      .documents[i]['isGated']),
                                                ),
                                                title: Text('Gated'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.lightbulb_outline,
                                                  color: get_color(snapshot.data
                                                      .documents[i]['isOvernight']),
                                                ),
                                                title: Text('Overnight'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.lightbulb_outline,
                                                  color: get_color(snapshot.data
                                                      .documents[i]['hasCover']),
                                                ),
                                                title: Text('Covered'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RaisedButton(
                                          child: Text(
                                            'Book Now',
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                          color: Color(0xffec8b5e),
                                          onPressed: () => {
                                            make_requests(current_users_email, snapshot.data.documents[i]['Host id'])
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      });
                }));
          }

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

  get_color(document) {
    if (document) {
      return Colors.blue;
    }
  }

  BitmapDescriptor _getMarker(aquired, quantity, type) {
    if (type == 'User hosted') {
      return pinLocationIcon1;
    } else {
      if (aquired != quantity) {
        //return green marker
        return pinLocationIcon3;
      } else {
        //return red marker
        return pinLocationIcon2;
      }
    }
  }

  get_host_name(document, host_name) {
    if(document=='Public')
      {
        return Text('Public parking');
      }
    else
      {
        return Text('Hosted by: '+ host_name.toString());
      }
  }

  Future<void> get_email() async{
    FirebaseUser user= await FirebaseAuth.instance.currentUser();
    SharedPreferences prefs= await SharedPreferences.getInstance();
    setState(() {
      current_users_email=  prefs.getString('user_email');
      current_user_id= user.uid;
    });
  }

  Future getUserInfo() async
  {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Users").where('email',isEqualTo: current_users_email).getDocuments();
    return qn.documents;
  }

  make_requests(String current_users_email, host_id) {
   Firestore.instance.collection('Users').document(host_id).collection('requests').document().setData({
     'Useremail': current_users_email,
     'Time': DateTime.now().toIso8601String().toString(),
   });
  }


}