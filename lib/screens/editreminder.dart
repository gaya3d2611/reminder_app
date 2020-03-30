import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class editReminder extends StatefulWidget {
  // We're taking in 21alues from the previous class.
  var title, body, id;
  editReminder(tit, bod, ID){
    // here, you can take it in in 2 ways. i'll show both of them in each of the classes.
    // First Method.


    this.title = tit;
    this.body= bod;
    this.id=ID;

  }
  @override
  _editReminderState createState() => _editReminderState(title, body, id);

}

class _editReminderState extends State<editReminder> {
  var titlee, bodyy, idd;
  _editReminderState(this.titlee, this.bodyy, this.idd);

  @override
  Widget build(BuildContext context) {
    TextEditingController title= new TextEditingController(text:titlee.toString());
    TextEditingController body= new TextEditingController(text:bodyy.toString());

    update() async{
      print(idd);
      print(title.text + body.text);
      await Firestore.instance.collection('reminders').document(idd).updateData({'title': title.text, 'body': body.text}); //setData({ 'title': titlee.text, 'body': bodyy.text });
      Navigator.pop(context);
    }
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed:() async{
      update();
    },
    child: Icon(Icons.check),),
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
        ],
      ),
    );
  }
}
