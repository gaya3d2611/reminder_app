import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:your_reminders/Services/auth.dart';
import 'package:your_reminders/screens/editreminder.dart';
import 'reminder.dart';
class FirstScreen extends StatefulWidget {
  @override
  State createState() => FirstScreenState();
}
class FirstScreenState extends State<FirstScreen> {
  var userr;
  @override
  void initState(){
    some();
    print(userr);
    print('**********************');
    super.initState();
  }
  final AuthService _authService= AuthService();
  some()async{
    final FirebaseUser user= await FirebaseAuth.instance.currentUser();
    final String UID = user.uid.toString();
    setState(() {
      userr=UID;
    });
  }
  @override
  Widget build(BuildContext context) {
    var id;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            transport(remider());
          }, child: Icon(Icons.add),
        ),
        /* bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white12,
          height: 50,
        ),
      ),*/
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: (){
               // FirebaseAuth.instance.signOut();
              },
              child: Icon(Icons.exit_to_app, color: Colors.white,),
            )
          ],
          title: Text("Your Reminders", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Color(0xff121212),),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(image: new DecorationImage(
                  image: AssetImage('asset/images/background.jpg'),
                  fit: BoxFit.fill)
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('reminders').document(userr).collection('reminder')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return ListView(
                            children: snapshot.data.documents.map((
                                DocumentSnapshot document) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                  child: /*Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      elevation: 0,
                                      color: Color(0xB3ffffff),
                                      child: FlatButton(onPressed: (){
                                        id=document.documentID;
                                        print(id);
                                        transport(editReminder( document['title'],
                                          document['body'], id));
                                      }, child: new ListTile(
                                        title: new Text(document['title']),
                                        subtitle: new Text(document['body']),
                                      ),)
                                  ), */
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          //color: Colors.deepPurpleAccent,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                                        ),
                                        width: MediaQuery.of(context).size.width-90,
                                        child: FlatButton(
                                          onPressed: (){
                                            id=document.documentID;
                                            print(id);
                                            transport(editReminder( document['title'],
                                                document['body'], id));
                                          },
                                          child: new ListTile(
                                            title: new Text(document['title']),
                                            subtitle: new Text(document['body']),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 70,
                                          child: /*InkWell(
                                            child: new IconButton(
                                                icon: Icon(Icons.delete), onPressed: (){
                                                  Firestore.instance.collection("reminders").document(id).delete();
                                                }
                                                ),
                                            onTap: (){
                                              Firestore.instance.collection("reminders").document(id).delete();
                                            },
                                          ) */
                                          FlatButton(onPressed:(){
                                            id=document.documentID;
                                            print(id);
                                            Firestore.instance.collection('reminders').document(userr).collection('reminder').document(id).delete();
                                          }, child: Icon(Icons.delete))
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20.0),)
                                  ),
                                ),
                              );
                            }
                            ).toList(),
                      );
                  }
                }

            )
          ],
        )
    );
  }

  transport(Widget n) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => n));
  }
}
