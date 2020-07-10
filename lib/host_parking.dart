

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class host_parking extends StatefulWidget {
  @override
  _host_parkingState createState() => _host_parkingState();
}

class _host_parkingState extends State<host_parking> {
  String _address, _hourly_cost, _description, _quantity;
  String _lat,_long;
  String current_users_email='';
  bool is_gated=false, has_cctv=false, has_light=false, has_cover=false, is_overnight=false, is_guarded=false;

  @override
  void initState() {
    // TODO: implement initState
    get_email();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Host parking'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (address)=>{_address=address},
              decoration: InputDecoration(
                labelText: 'Address',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff020061)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (cost)=>{_hourly_cost=cost},
              decoration: InputDecoration(
                labelText: 'Hourly cost',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff020061)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(height: 10,),
            TextField(

              onChanged: (descrip)=>{_description=descrip},
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                labelText: 'Description',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff020061)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(height: 10,),
            TextField(

              keyboardType: TextInputType.number,
              onChanged: (quantity)=>{
                _quantity=quantity
              },
              decoration: InputDecoration(
                labelText: 'Quantity',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff020061)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(height: 10,),

            Text('Coordinates'),
            Row(
              children: <Widget>[
                SizedBox(width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (lat)=>{
                      _lat=lat
                    },
                    decoration: InputDecoration(
                      labelText: 'Latitude',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                SizedBox(width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (long)=>{
                      _long=long
                    },
                    decoration: InputDecoration(
                      labelText: 'Longitude',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                SizedBox(width: 10,),
                Text('Amenities'),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                SizedBox(width: 10,),
                Text('Gated'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      is_gated = !is_gated;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: is_gated,
                    ),
                  ),
                ),

                SizedBox(width: 10,),
                Text('CCTV'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      has_cctv = !has_cctv;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: has_cctv,
                    ),
                  ),
                ),

                SizedBox(width: 10,),
                Text('Light'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      has_light = !has_light;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: has_light,
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 30,),
            Row(
              children: <Widget>[
                SizedBox(width: 10,),
                Text('Covered'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      has_cover = !has_cover;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: has_cover,
                    ),
                  ),
                ),

                SizedBox(width: 10,),
                Text('Guarded'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      is_guarded = !is_guarded;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: is_guarded,
                    ),
                  ),
                ),

                SizedBox(width: 10,),
                Text('Overnight'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      is_overnight = !is_overnight;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: is_overnight,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30,),
            RaisedButton.icon(onPressed: (){
              add_parking();
              print("$_address  $_hourly_cost $_description  $_quantity  $_lat  $_long $is_overnight $is_guarded $current_users_email");
            },
              icon: Icon(Icons.local_parking, color: Colors.white,),
              label: Text('Host Parking',
              style: TextStyle(
                color: Colors.white
              ),
              ),
              color: Colors.blue,)
          ],
        ),
      ),
    );
  }

  void add_parking() {
    Firestore.instance.collection("Parkings").add(
      {
        'Address': _address,
        'Aquired': 0,
        'Quantity': int.parse(_quantity),
        'Hourly cost': int.parse(_hourly_cost),
        'Type': 'User hosted',
        'Hosted by': current_users_email,
        'Description': _description,
        'location': GeoPoint(double.parse(_lat), double.parse(_long)),
        'isGated': is_gated,
        'hasCCTV': has_cctv,
        'hasLight': has_light,
        'hasCover': has_cover,
        'isGuarded': is_guarded,
        'isOvernight': is_overnight
      }
    );
  }

  Future<void> get_email() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    setState(() {
      current_users_email=  prefs.getString('user_email');
    });
  }
}
