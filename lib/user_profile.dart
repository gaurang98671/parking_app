

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
  String current_users_email='';


  Future getUserInfo() async
  {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Users").where('email',isEqualTo: current_users_email).getDocuments();
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
      body: FutureBuilder(
        future:  getUserInfo(),
        builder: (_, snapshot)
        {
          if(!snapshot.hasData)
            {
              return Text("No profile");
            }
          else
            {
              return Container(
                child: Column(
                  children: <Widget>[
                    get_profile(snapshot.data[0]["profile pic"]),
                    GestureDetector(
                      child: Text('Upload Picture',
                      style: TextStyle(
                        color: Colors.blue
                      ),
                      ),
                      onTap: (){},
                    ),
                    Text(snapshot.data[0]["Name"]),
                    get_verify_tag(snapshot.data[0]['Verified']),
                    Text(snapshot.data[0]["Phone Number"])
                  ],
                ),
              );
            }
        },
      )
    );
  }

  /*void get_uid() async{
    print('Get uid function called !!!!!!!!!');
    final pref= await SharedPreferences.getInstance();
    setState(() {
      uid=pref.getString('uid');
    });
  }*/

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

    Future<void> get_email() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    setState(() {
      current_users_email=  prefs.getString('user_email');
    });
  }


}
