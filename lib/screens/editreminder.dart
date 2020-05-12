import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_reminders/Services/auth.dart';
class editReminder extends StatefulWidget {
  // We're taking in 21alues from the previous class.
  var title, body, id;
  editReminder(tit, bod, ID){
    // here, you can take it in in 2 ways. i'll show both of them in each of the classes.
    // First Method.fl


    this.title = tit;
    this.body= bod;
    this.id=ID;

  }
  @override
  void dispose(){}
  @override
  _editReminderState createState() => _editReminderState(title, body, id);

}

class _editReminderState extends State<editReminder> {
  var userr;
  var userrr;
  final AuthService _authService= AuthService();
  some()async{
    final FirebaseUser user= await FirebaseAuth.instance.currentUser();
    final String userr = user.uid;
    print(userr);
    print('userr value in some function');
    setState(() {
      userrr=userr;
    });
  }

  @override
  void initState(){
    some();
    print(userr);
    print('this is edit reminder');
    print('**********************');
    super.initState();
  }
  var titlee, bodyy, idd;
  _editReminderState(this.titlee, this.bodyy, this.idd);

  @override
  Widget build(BuildContext context) {
    TextEditingController title= new TextEditingController(text:titlee.toString());
    TextEditingController body= new TextEditingController(text:bodyy.toString());
    update() async{
      print(idd);
      print(userrr);
      print(title.text + " " + body.text);
      await Firestore.instance.collection('reminders').document(userrr).collection('reminder').document(idd).updateData({'title': title.text, 'body': body.text}); //setData({ 'title': titlee.text, 'body': bodyy.text });
      Navigator.pop(context);
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed:() async{
        update();
      },
        child: Icon(Icons.check),),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(image: new DecorationImage(
                  image: AssetImage('asset/images/editReminderBackground.png'),
                  fit: BoxFit.fitHeight)
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/2),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffffffff),
                      ),
                      child: TextField(
                        controller: title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          labelText: "give your reminder a title",

                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffffffff),
                      ),
                      child: TextField(
                          maxLines: 6,
                          controller: body,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            labelText: "enter your reminder",
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}