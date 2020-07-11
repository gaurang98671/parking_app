import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class currently_parked extends StatefulWidget {
  @override
  _currently_parkedState createState() => _currently_parkedState();
}

class _currently_parkedState extends State<currently_parked> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Currently parked"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('Users').document(user_id).collection('Currently parked').snapshots(),
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
                  String id=docSnap.documentID.toString();
                  String name= docSnap['Name'].toString();
                  String phone= docSnap['Phone Number'].toString();
                  String address=docSnap['Address'].toString();
                  String parking_id=docSnap['Doc id'].toString();
                  return  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
                        Text('For: '+ address+ " parking"),
                        Text('Name: '+ name),
                        Text('Phone Number: '+ phone),
                        Row(children: <Widget>[
                          SizedBox(width: 55,),
                          RaisedButton.icon(onPressed: ()
                          {
                            decrement_counter(address,parking_id, name, phone, id);

                          },
                            icon: Icon(Icons.check),
                            label: Text('Remove', style: TextStyle(
                                color: Colors.white
                            ),
                            ), color: Colors.green,),
                          SizedBox(width: 20,),
                        ],)
                      ],
                    ),
                  );
                },

              );
            }
          },

        ),
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


  void decrement_counter(String address, String did, String name, String phn, String idi) async {
    print('d'+address);
    QuerySnapshot documents= await Firestore.instance.collection('Parkings').where("Address", isEqualTo: address).getDocuments();
    Firestore.instance.collection('Parkings').where("Address", isEqualTo: address).getDocuments().then((sn){
      for(int i=0; i<sn.documents.length ; i++ )
      {
        String id=sn.documents[i].documentID;
        print(id);
        Firestore.instance.collection('Parkings').document(id).updateData({'Aquired':  FieldValue.increment(-1)});

        Firestore.instance.collection("Users").document(user_id).collection('Currently parked').document(idi).delete();
      }
    });
  }

}
