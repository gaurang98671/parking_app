

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class user_profile extends StatefulWidget {
  @override
  _user_profileState createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  String uid='';
  DocumentSnapshot ss;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection("Users").document(uid).snapshots(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData)
            {
              return CircularProgressIndicator();
            }
          else
            {
              return Container(
                child: Column(
                  children: <Widget>[
                    get_profile(snapshot.data["profile pic"]),
                    GestureDetector(
                      child: Text('Upload Picture',
                      style: TextStyle(
                        color: Colors.blue
                      ),
                      ),
                      onTap: (){},
                    ),
                    Text(snapshot.data["Name"]),
                    get_verify_tag(snapshot.data['Verified']),
                    Text(snapshot.data["Phone Number"])
                  ],
                ),
              );
            }
        },
      )
    );
  }

  void get_uid() async{
    final pref= await SharedPreferences.getInstance();
    uid= pref.get('uid');
    DocumentReference ref= Firestore.instance.collection("Users").document(uid);
    ss=await ref.get();
  }

  Widget get_profile(String profile_url)
  {
    if(profile_url=='none')
      {
        return Icon(Icons.account_circle, size: 50);
      }
    //else it will return circular avatar with user profile pic

  }

  Widget get_verify_tag(data) {

    if(data==true)
      {
        return Icon(Icons.verified_user);
      }
    else
      {
        return Text(
          'Not verified'
        );
      }
  }

}
