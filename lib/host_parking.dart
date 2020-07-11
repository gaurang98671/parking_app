import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class host_parking extends StatefulWidget {
  @override
  _host_parkingState createState() => _host_parkingState();
}

class _host_parkingState extends State<host_parking> {
  String _address, _2_wheeler_cost, _4_wheeler_cost, _description, _quantity;
  String user_id = '';
  String _lat, _long;
  String current_users_email = '';
  bool is_gated = false,
      has_cctv = false,
      has_light = false,
      has_cover = false,
      is_overnight = false,
      is_guarded = false;

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
        backgroundColor: Color(0xff020061),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Address'),
                subtitle: TextField(
                  onChanged: (address) => {_address = address},
                  decoration: null,
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                  maxLines: null,
                  // decoration: InputDecoration(
                  //   // labelText: 'Address',
                  //   enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Color(0xff020061)),
                  //       borderRadius: BorderRadius.all(Radius.circular(10))),
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Description',
                  style: TextStyle(color: Color(0xff020061)),
                ),
                subtitle: TextField(
                  onChanged: (descrip) => {_description = descrip},
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                  decoration: null,
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Spaces',
                  style: TextStyle(color: Color(0xff020061)),
                ),
                subtitle: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (quantity) => {_quantity = quantity},
                  decoration: null,
                  maxLines: 1,
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
                title: Text(
              'Coordinates',
              style: TextStyle(color: Color(0xff020061)),
            )),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Latitude',
                        style: TextStyle(fontSize: 13),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (lat) => {_lat = lat},
                        decoration: null,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 01,
                // ),
                SizedBox(
                  width: 100,
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Longitude',
                        style: TextStyle(fontSize: 13),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (long) => {_long = long},
                        decoration: null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
                title: Text(
              'Hourly Rate',
              style: TextStyle(color: Color(0xff020061)),
            )),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_bike,
                        color: Color(0xffec8b5e),
                      ),
                      title: Text(
                        'Two-wheeler',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (cost) => {_2_wheeler_cost = cost},
                        decoration: null,
                      ),
                    ),
                  ),
                ),
                // Icon(Icons.directions_car),
                SizedBox(
                  width: 150,
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_car,
                        color: Color(0xffec8b5e),
                      ),
                      title: Text(
                        'Four-wheeler',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (cost) => {_4_wheeler_cost = cost},
                        decoration: null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // SizedBox(
            //   width: 10,
            // ),
            ListTile(
                title: Text(
              'Amenities',
              style: TextStyle(color: Color(0xff020061)),
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text('Gated'),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      is_gated = !is_gated;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.black12,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: is_gated,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('CCTV'),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      has_cctv = !has_cctv;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.black12,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: has_cctv,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Light'),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      has_light = !has_light;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.black12,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: has_light,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text('Covered'),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      has_cover = !has_cover;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.black12,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: has_cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Guarded'),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      is_guarded = !is_guarded;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.black12,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: is_guarded,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Overnight'),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      is_overnight = !is_overnight;
                    });
                  },
                  child: Center(
                    child: CustomSwitchButton(
                      backgroundColor: Colors.black12,
                      unCheckedColor: Colors.white,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.lightGreen,
                      checked: is_overnight,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton.icon(
              onPressed: () {
                add_parking();
                print(
                    "$_address  $_description  $_quantity  $_lat  $_long $is_overnight $is_guarded $current_users_email");
              },
              icon: Icon(
                Icons.local_parking,
                color: Colors.white,
              ),
              label: Text(
                'Host Parking',
                style: TextStyle(color: Colors.white),
              ),
              color: Color(0xffec8b5e),
            )
          ],
        ),
      ),
    );
  }

  void add_parking() {
    Firestore.instance.collection("Parkings").add({
      'Address': _address,
      'Host id': user_id,
      '2 wheeler cost': _2_wheeler_cost,
      '4 wheeler cost': _4_wheeler_cost,
      'Aquired': 0,
      'Quantity': int.parse(_quantity),
      'Type': 'User hosted',
      'Hosted by': current_users_email,
      'Host id': user_id,
      'Description': _description,
      'location': GeoPoint(double.parse(_lat), double.parse(_long)),
      'isGated': is_gated,
      'hasCCTV': has_cctv,
      'hasLight': has_light,
      'hasCover': has_cover,
      'isGuarded': is_guarded,
      'isOvernight': is_overnight
    });
  }

  Future<void> get_email() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      current_users_email = prefs.getString('user_email');
      user_id = user.uid;
    });
  }
}
