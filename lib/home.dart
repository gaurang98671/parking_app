import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Marker> _markers=[];
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
      ),
      body: Stack(
        children: <Widget>[

          _loadMap()
          ],
      )
    );
  }


 Widget _loadMap()
  {
    return StreamBuilder(
      stream: Firestore.instance.collection('Parkings').snapshots(),
      builder: (context, snapshot)
      {
        if(!snapshot.hasData)
        {
          return Text('Loading map');
        }
        else
        {
          for(int i=0; i< snapshot.data.documents.length; i++)
          {
            _markers.add(
              new Marker(
                visible: true,
                markerId: MarkerId(i.toString()),
                position: new LatLng(
                  snapshot.data.documents[i]['location'].latitude,
                  snapshot.data.documents[i]['location'].longitude),
                onTap: (){print(snapshot.data.documents[i]['Address']);}
              )
            );
            String a=snapshot.data.documents[i]['Address'];
            print('$a');
          }
        }
        return  GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(19.204761,73.006379),
              zoom: 13
          ),
          markers: _markers.toSet(),

        );
      },
    );
  }
}
