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
  final FirebaseAuth _auth= FirebaseAuth.instance;
  var userr;
  var uname;
  var name;
  var UID;
  var namee;
  var names;
  //var name;
  @override
  void initState(){
          some();
          print(userr);
          //print(uname);
          print('**********************_________________');
          /*nameFetch();
          name=name.toString();
          print('*-********************');
          print(name); */

          //name= Firestore.instance.collection('reminders').document(userr).collection('details').document('udetails').collection('name');
          //name= name.toString();
          //print(name);

          super.initState();
  }
  final AuthService _authService= AuthService();
  some()async{
    final FirebaseUser user= await FirebaseAuth.instance.currentUser();
     uname= user.uid;
    print(uname);
    print('*****************_______*******************');
      print('abcdefghijklmnopqrstuvwxyz');
      name = await Firestore.instance
          .collection('reminders')
          .document(uname)
          .collection('details')
          .getDocuments()
          .then((querySnapshot){
        querySnapshot.documents.forEach((result) {
          //print(result.data);
          namee=result.data['name'];
          return namee;
        });
      });

      print(namee);
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      namee=namee.toString();
      setState(() {
        names=namee;
      });

      /*.get()
        .then(
          (value) {
        print(value.toString());
        print(name + 'this is name');
      },
    ); */



  }
  @override
  Widget build(BuildContext context) {
    var id;
    print(names);
    print('_________________________________________________________');
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
        /*appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                color: Color(0xFF604F8E),
                onPressed: () async{

                    try {
                      return await _auth.signOut();
                    } catch (error) {
                      print(error.toString());

                      return null;
                    }

                },
                child: Text('Sign out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            )
          ],
          //title: Text("Your Reminders", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Color(0xFFF0F0F0),
        elevation: 0,),*/
        body: Container(
          decoration: BoxDecoration(
              color: Color(0xFFF0F0F0)
          ),
          child: Stack(
            // fit: StackFit.expand,
            children: <Widget>[

              /*Container(
                decoration: new BoxDecoration(image: new DecorationImage(
                    image: AssetImage('asset/images/background.jpg'),
                    fit: BoxFit.fill)
                ),
              ),*/
              //SizedBox(height:10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                    color: Color(0xFF604F8E),
                    onPressed: () async{

                      try {
                        return await _auth.signOut();
                      } catch (error) {
                        print(error.toString());
                        return null;
                      }

                    },
                    child: Text('Sign out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                  Center(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('asset/images/welcomeBox.png'),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 150,),
                          Center(
                            child: Text('Welcome, ' + names.toString(), style: TextStyle(color: Colors.white, fontSize: 28.0),),
                          ),
                          SizedBox(height: 10,),
                          Center(
                            child: Text('Here are your reminders', style: TextStyle(color: Colors.white, fontSize: 28.0),),
                          ),
                        ],
                      ),

                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 370),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('reminders').document(uname).collection('reminder')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return (snapshot.data.documents.length ==0)?Column(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height/3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('asset/images/oops.png')
                                    )
                                ),
                              ),
                              SizedBox(height: 30,),
                              Center(child: Text('Oops!! it seems you have no reminders yet', style: TextStyle(fontSize: 20.0),)),
                              //Center(child: Text(uname, style: TextStyle(fontSize: 20.0),)),
                            ],
                          ):ListView(
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
                                            print(uname);
                                            Firestore.instance.collection('reminders').document(uname).collection('reminder').document(id).delete();
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

                ),
              )
            ],
          ),
        )
    );
  }

  transport(Widget n) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => n));
  }
}