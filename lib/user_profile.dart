import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class user_profile extends StatefulWidget {
  @override
  _user_profileState createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  String current_users_email = '';

  Future getUserInfo() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("Users")
        .where('email', isEqualTo: current_users_email)
        .getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    get_email();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xff020061),
        body: FutureBuilder(
      future: getUserInfo(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            // valueColor: null,
            backgroundColor: Color(0xffec8b5e),
          ));
        } else {
          return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  GestureDetector(
                      child: get_profile(snapshot.data[0]["profile pic"]),
                      onTap: () {}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          snapshot.data[0]["Name"],
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      get_verify_tag(snapshot.data[0]['Verified']),
                    ],
                  ),
                  ListTile(
                      title: Center(child: Text('Phone')),
                      subtitle: Center(
                          child: Text(snapshot.data[0]["Phone Number"]))),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'Vehicle registration plate',
                        style: TextStyle(color: Colors.black87),
                      ),
                      subtitle: TextField(
                        // onChanged: () => {},
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                        decoration: null,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    ));
  }

  /*void get_uid() async{
    print('Get uid function called !!!!!!!!!');
    final pref= await SharedPreferences.getInstance();
    setState(() {
      uid=pref.getString('uid');
    });
  }*/

  Widget get_profile(String profile_url) {
    if (profile_url == 'none') {
      return Icon(Icons.account_circle, size: 120);
    }
    //else it will return circular avatar with user profile pic
  }

  Widget get_verify_tag(data) {
    if (data == true) {
      return Icon(
        Icons.verified_user,
        size: 13,
        color: Colors.green,
      );
    } else {
      return Text(
        'Not verified',
        style: TextStyle(
          color: Colors.black45,
          fontSize: 13,
        ),
      );
    }
  }

  Future<void> get_email() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      current_users_email = prefs.getString('user_email');
    });
  }
}
