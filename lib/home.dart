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
                visible: true,
                markerId: MarkerId(i.toString()),
                position: new LatLng(
                  snapshot.data.documents[i]['location'].latitude,
                  snapshot.data.documents[i]['location'].longitude),

                //Pop up window shows up showing info of parking

                onTap: (){
                  print(snapshot.data.documents[i]['Aquired'].toString());
                  showDialog(context: context, builder: (BuildContext contex){
                    return Dialog(
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                      child: Container(
                        height: 180.0,
                        width: 300.0,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                        child: StreamBuilder(
                          stream: Firestore.instance.collection('Parkings').snapshots(),
                          builder: (context, snap)
                          {
                            if(!snap.hasData)
                              {
                                return CircularProgressIndicator();
                              }
                            else
                              {
                                return Column(
                                  children: <Widget>[
                                    SizedBox(height: 10,),
                                    CircleAvatar(backgroundImage: AssetImage(
                                      'assets/images/vv.PNG'
                                    ),
                                    radius: 40,),
                                    Text(snap.data.documents[i]['Address'].toString()),
                                    Text("Aquired spots: "+snap.data.documents[i]['Aquired'].toString(),
                                    style: TextStyle(fontSize: 15),
                                    ),
                                    RaisedButton(
                                      child: Text(
                                        'Book spot',
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                      color: Colors.purple,
                                      onPressed: ()=>{},
                                    )
                                  ],
                                );
                              }
                          },
                        ),
                      ),
                    );
                  });
                }
              )
            );
          }
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
          ],
        );
      },
    );
  }


}
