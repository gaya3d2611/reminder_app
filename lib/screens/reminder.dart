import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firstscreen.dart';
import 'package:intl/intl.dart';

import 'package:simpletime_picker/constant.dart';
import 'package:simpletime_picker/scrollable_time_picker.dart';
import 'package:simpletime_picker/time_picker.dart';



class remider extends StatefulWidget {
  @override
  _remiderState createState() => _remiderState();
}

class _remiderState extends State<remider> {
  final title= new TextEditingController();
  final body= new TextEditingController();
  final time= new TextEditingController();
  final reminderTime= TextEditingController();
  TimeOfDay _time = TimeOfDay.now();

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final format = DateFormat("HH:mm");
    String formattedDate = DateFormat('kk:mm:ss').format(now);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed: (){
          time.text= formattedDate.toString();
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
                    ),
                    Padding(padding: const EdgeInsets.all(20.0),
                      child:
                      RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                          color: Colors.black,
                          onPressed: () async {
                            var result = await TimePicker.pickTime(context,
                                selectedColor: Colors.amber,
                                nonSelectedColor: Colors.black,
                                displayType: DisplayType.bottomSheet,
                                timePickType: TimePickType.hourMinute,
                                buttonBackgroundColor: Colors.red,
                                title: "this is bottomsheet",
                                fontSize: 24.0,
                                isTwelveHourFormat: true);
                            print("ini apa ? $result");
                            reminderTime.text= result.toString();
                          },
                          child: Text("Click to enter time"), textColor: Colors.white,),
                    ),
                  ],
                ),
              ),
            ]
        )
    );
  }
  submit() async{
    print(title.text + " " + body.text + " " + time.text + " " + reminderTime.text);
    await Firestore.instance.collection('reminders').document()
        .setData({ 'title': title.text, 'body': body.text, 'time': time.text, 'reminderTime': reminderTime.text });
    Navigator.pop(context);
  }

}