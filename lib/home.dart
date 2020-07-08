import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
          _markers.clear();
          for(int i=0; i< snapshot.data.documents.length; i++)
          {
            _markers.add(
              new Marker(
                infoWindow: InfoWindow(title: snapshot.data.documents[i]['Aquired'].toString(), snippet: 'Spaces Aquired' ),
                visible: true,
                markerId: MarkerId(i.toString()),
                position: new LatLng(
                  snapshot.data.documents[i]['location'].latitude,
                  snapshot.data.documents[i]['location'].longitude),
                onTap: (){

                  print(snapshot.data.documents[i]['Aquired'].toString());
                }
              )
            );

          }
          print(_markers.length);
        }
        return Stack(
          children: <Widget>[
        new GoogleMap(
        mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
              target: LatLng(19.204761,73.006379),
              zoom: 13
          ),
          markers: _markers.toSet(),

        ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Pa,
              ),
            )
          ],
        );
      },
    );
  }


}
