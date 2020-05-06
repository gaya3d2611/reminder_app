import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_reminders/Services/auth.dart';
import 'firstscreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simpletime_picker/constant.dart';
import 'package:simpletime_picker/scrollable_time_picker.dart';
import 'package:simpletime_picker/time_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:your_reminders/Services/auth.dart';
import 'package:your_reminders/screens/editreminder.dart';
import 'reminder.dart';

class remider extends StatefulWidget {
  @override
  _remiderState createState() => _remiderState();
}

class _remiderState extends State<remider> {
  var userr;
  final AuthService _authService = AuthService();
  var name;
  some() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String UID = user.uid.toString();
    setState(() {
      userr = UID;
    });
  }

  somefunc() async {
    name = await Firestore.instance
        .collection('reminders')
        .document(userr)
        .collection('details')
        .document('userDetails')
        .get();
  }

  final title = new TextEditingController();
  final body = new TextEditingController();
  final time = new TextEditingController();
  final reminderTime = TextEditingController();

  /*TimeOfDay _time = TimeOfDay.now();
  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  } */
  final FirebaseMessaging messaging = FirebaseMessaging();
  @override
  void initState() {
    somefunc();
    /* some();
    print(userr);
    print('**********************');
    super.initState();
    messaging.getToken().then((token) {
      print("token:" + token);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    /* FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification,);
    Future<void> showWeeklyAtDayAndTime(Time time, Day day, int id, String title, String description) async {
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description',
      );
      final iOSPlatformChannelSpecifics = IOSNotificationDetails();
      final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics,
      );
      await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id,
        title,
        description,
        day,
        time,
        platformChannelSpecifics,
      );
    }
    Future<void> showDailyAtTime(Time time, int id, String title, String description) async {
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description',
      );
      final iOSPlatformChannelSpecifics = IOSNotificationDetails();
      final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics,
      );
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        title,
        description,
        time,
        platformChannelSpecifics,
      );
    }
    Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
      final pendingNotifications = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
      return pendingNotifications;
    } */

    /*Future<void> cancelNotification(int id) async {
      await flutterLocalNotificationsPlugin.cancel(id);
    }

    Future<void> cancelAllNotifications() async {
      await flutterLocalNotificationsPlugin.cancelAll();
    } */

    //FirebaseMessaging firebaseMessaging= FirebaseMessaging();
    /*@override initState(){
     super.initState();
     firebaseMessaging.configure(
           onMessage: (Map<String, dynamic> message) async {
             print("onMessage: $message");
             final notification = message['notifications'];
             //_showItemDialog(message);
           },
           onLaunch: (Map<String, dynamic> message) async {
             print("onLaunch: $message");
            // _navigateToItemDetail(message);
           },
           onResume: (Map<String, dynamic> message) async {
             print("onResume: $message");
            // _navigateToItemDetail(message);
           },
     );
   }*/
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm:ss').format(now);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            time.text = formattedDate.toString();
            /* await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(id, title, body, day, notificationTime, notificationDetails)Time(
            Time(1,30,0),
            Day.Sunday,
            0,
            'first notification',
            'description',
          );
          setState(() {
            flutterLocalNotificationsPlugin.getScheduledNotifications();
          }); */
            submit();
          },
          child: Icon(Icons.check),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: AssetImage('asset/images/reminderBackground.png'),
                    fit: BoxFit.fitHeight)),
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
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
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
                      reminderTime.text = result.toString();
                      //String reminderTimee = DateFormat('hh:mm:ss').format(result),
                    },
                    child: Text("Click to enter time"),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  submit() async {
    print(title.text +
        " " +
        body.text +
        " " +
        time.text +
        " " +
        reminderTime.text);
    await Firestore.instance
        .collection('reminders')
        .document(userr)
        .collection('reminder')
        .document()
        .setData({
      'title': title.text,
      'body': body.text,
      'time': time.text,
      'reminderTime': reminderTime.text
    });
    Navigator.pop(context);
  }
  /* Future onSelectNotification(String payload) async {
    if (payload != null)
      {
        print('notification payload: ' + payload);
      }
  } */

}
