import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firstscreen.dart';


class remider extends StatefulWidget {
  @override
  _remiderState createState() => _remiderState();
}

class _remiderState extends State<remider> {
  final title= new TextEditingController();
  final body= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed: (){
          submit();
        },
          child: Icon(Icons.check),),
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
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
                    image: AssetImage('asset/images/reminders.jpg'),
                    fit: BoxFit.fitHeight)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x52000000),
                        ),
                        child: TextField(
                          controller: title,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "give your reminder a title",

                          ),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          color: Color(0x52000000),
                        ),

                        child: TextField(
                            maxLines: 6,
                            controller: body,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "enter your reminder",
                            )
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]

        )
    );
  }
  submit() async{
    print(title.text + body.text);
    await Firestore.instance.collection('reminders').document()
        .setData({ 'title': title.text, 'body': body.text });
    Navigator.pop(context);
  }
}