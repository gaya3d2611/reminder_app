
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_reminders/screens/Authentication/loginPage.dart';
import 'package:your_reminders/screens/firstscreen.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}
class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting) {
          return Center(child: Text('loading'),);
        }
        else{
          if(snapshot.hasData){
            return FirstScreen();
          }
          else{
            return loginPage();
          }
        }

      },
    );
  }
}