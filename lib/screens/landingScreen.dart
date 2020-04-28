import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:your_reminders/screens/firstscreen.dart';

class landingScreen extends StatefulWidget {
  @override
  _landingScreenState createState() => _landingScreenState();
}

class _landingScreenState extends State<landingScreen> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController= AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation= Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve:  Curves.fastOutSlowIn
    ));
    animationController.forward();
    startTimer();
  }
  @override
  void dispose(){
    super.dispose();
    animationController.dispose();
  }
  startTimer() async{
    var duration= Duration(seconds: 3);
    return Timer(duration, route);
  }
  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double width= MediaQuery.of(context).size.width;
    final double height= MediaQuery.of(context).size.height/2;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: Transform(
            transform: Matrix4.translationValues(0.0, -animation.value*height, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      //color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage('asset/images/appstore.png'),
                        )
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 50,
                  height: 250,
                  decoration: BoxDecoration(
                    //color: Colors.cyanAccent,
                      image: DecorationImage(
                        image: AssetImage(
                            'asset/images/titleYourReminderstrans.png'),
                      )
                  ),
                ),
                /*Container(
                height: 50,
                width: 150,
                child: RaisedButton(onPressed: (){
                  transport(FirstScreen());
                },
                child: Text('Get Started'),
                ),
              ) */
              ],
            ),
          ),
        );
      }
    );
  }
  transport(Widget n) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => n));
  }
}
