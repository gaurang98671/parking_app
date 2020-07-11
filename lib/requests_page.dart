import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class requests_page extends StatefulWidget {
  @override
  _requests_pageState createState() => _requests_pageState();
}

class _requests_pageState extends State<requests_page> {
  String current_users_email='';
  String user_id='';
  @override
  void initState() {
    // TODO: implement initState
    get_email();
    get_user_id();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('Users').document(user_id).collection('Requests').snapshots(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData){
            print(current_users_email+' '+user_id);
            return CircularProgressIndicator();
          }
          else
            {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (contex, index)
                {
                  DocumentSnapshot docSnap=snapshot.data.documents[index];

                  String email= docSnap['UserEmail'].toString();
                  String id=docSnap.documentID.toString();
                  String time= docSnap['Time'].toString();
                  String name= docSnap['Name'].toString();
                  String phone= docSnap['Phone'].toString();
                  String address=docSnap['For'].toString();
                  return  Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 2.0,
                  child: Column(
                    children: <Widget>[
                      Text('For: '+ address+ " parking"),
                      Text('Email: '+ email),
                      Text('Time: '+ time),
                      Text('Name: '+ name),
                      Text('Phone Number: '+ phone),
                      Row(children: <Widget>[
                        SizedBox(width: 55,),
                        RaisedButton.icon(onPressed: ()
                        {
                          Firestore.instance.collection('Parkings').document(user_id).collection('Requests').document(id).delete();
                        },
                          icon: Icon(Icons.check),
                          label: Text('Accept', style: TextStyle(
                          color: Colors.white
                        ),
                        ), color: Colors.green,),
                        SizedBox(width: 20,),
                        RaisedButton.icon(onPressed: ()
                        {
                          //Accept function is rremaning
                          },
                          icon: Icon(Icons.remove),
                          label: Text('Reject',
                            style: TextStyle(
                          color: Colors.white
                        ),
                        ),
                          color:  Colors.red,
                        )
                      ],)
                    ],
                  ),
                  );
                },

              );
            }
        },
      ),
    );

  }

  Future<void> get_email() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    setState(() {
      current_users_email=  prefs.getString('user_email');
    });
  }

  Future<void> get_user_id() async{

    FirebaseUser user= await FirebaseAuth.instance.currentUser();
    setState(() {
      user_id= user.uid;
    });
  }


}
