import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'book.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = BitmapDescriptor.fromAsset('assets/images/marker.png');
  }

  List<Marker> _markers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[_loadMap()],
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
                icon: pinLocationIcon,
                infoWindow: InfoWindow(
                    title: snapshot.data.documents[i]['Aquired'].toString(),
                    snippet: 'Spots Booked'),
                visible: true,
                markerId: MarkerId(i.toString()),
                position: new LatLng(
                    snapshot.data.documents[i]['location'].latitude,
                    snapshot.data.documents[i]['location'].longitude),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Color(0xff737373),
                          child: Container(
                            height: 150,
                            child: _buildBottomNavigationMenu(snapshot, i),
                            decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20),
                                  topRight: const Radius.circular(20),
                                )),
                          ),
                        );
                      });
                  // print(snapshot.data.documents[i]['Aquired'].toString());
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
}

Column _buildBottomNavigationMenu(AsyncSnapshot snapshot, int i) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 20,
      ),
      StreamBuilder(
        stream: Firestore.instance.collection('Parkings').snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    maxRadius: 30,
                    minRadius: 30,
                    backgroundImage: AssetImage('assets/images/vv.PNG'),
                    // radius: 40,
                  ),
                  title: Text(
                    snap.data.documents[i]['Address'].toString(),
                    style: TextStyle(
                      // fontFamily: 'Open Sans',
                      fontSize: 20,
                    ),
                  ),
                  trailing: Text(
                    "Spots Booked: " +
                        snap.data.documents[i]['Aquired'].toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                    child: Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Color(0xff020061),
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return BookingScreen();
                    }))
                  },
                )
              ],
            );
          }
        },
      ),
    ],
  );
}
