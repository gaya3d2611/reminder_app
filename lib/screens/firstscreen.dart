import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:your_reminders/screens/editreminder.dart';
import 'reminder.dart';
class FirstScreen extends StatefulWidget {
  @override
  State createState() => FirstScreenState();
}
class FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => print("timeout"));
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var id;
    return Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
                stream: Firestore.instance.collection('reminders')
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
                                  child: Card(
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
                                  ),
                                /*SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: new ListTile(
                                        title: new Text(document['title']),
                                        subtitle: new Text(document['body']),
                                      )
                                    ),
                                  ),
                                ), */

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
