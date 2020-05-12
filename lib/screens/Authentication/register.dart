import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_reminders/Services/auth.dart';
import 'package:your_reminders/screens/Authentication/loginPage.dart';
import '../firstscreen.dart';
class registerPage extends StatefulWidget {
  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  //final AuthService _authService= AuthService();
  final _formKey = GlobalKey<FormState>();
  String usern='';
  String passw='';
  String name='';
  String Rpassw='';
  String error= '';
  final namee= new TextEditingController();
  final lnamee= new TextEditingController();
  final emaill= new TextEditingController();
  final passww= new TextEditingController();
  final Rpassww= new TextEditingController();
  final title= new TextEditingController();
  final body= new TextEditingController();
  final time= new TextEditingController();
  final reminderTime= TextEditingController();
  var userr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('asset/images/registerBackground.png'), fit: BoxFit.fill)
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 250),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFFFFFFF)
                    ),
                    child: TextFormField(
                      // keyboardType: TextInputType.phone,
                      //validator: validateMobile,
                      controller: namee,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide()
                          ),
                          prefixIcon: Icon(Icons.person),
                          hintText: " First Name",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontSize: 14.0)),
                      validator: (val) => val.isEmpty? 'Enter your name' : null,
                      onChanged: (val)=>
                          setState(()=> name=val),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFFFFFFF)
                    ),
                    child: TextFormField(
                      // keyboardType: TextInputType.phone,
                      //validator: validateMobile,
                      controller: lnamee,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide()
                          ),
                          prefixIcon: Icon(Icons.person),
                          hintText: "Last Name",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontSize: 14.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xFFFFFFFF),
                    ),
                    child: TextFormField(
                      // keyboardType: TextInputType.phone,
                      //validator: validateMobile,
                      //obscureText: true,
                        controller: emaill,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide()
                            ),
                            prefixIcon: Icon(Icons.mail),
                            hintText: "E-Mail",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 14.0)),
                        validator: (val) => val.isEmpty? 'Enter Email' : null,
                        onChanged: (val) {
                          setState(() => usern = val);
                        }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFFFFFFF)
                    ),
                    child: TextFormField(
                        controller: passww,
                        // keyboardType: TextInputType.phone,
                        //validator: validateMobile,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide()
                            ),
                            prefixIcon: Icon(Icons.vpn_key),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 14.0)),
                        validator: (val) => val.length<6? 'Enter password of more than 6 characters long' : null,
                        onChanged: (val) {
                          setState(() => passw = val);
                        }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Color(0xFFFFFFFF)
                    ),
                    child: TextFormField(
                      // keyboardType: TextInputType.phone,
                      //validator: validateMobile,
                        controller: Rpassww,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide()
                            ),
                            prefixIcon: Icon(Icons.vpn_key),
                            hintText: "Re-enter the password",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 14.0)),
                        validator: (val) => passw != Rpassw? 'Passwords  mis-match' : null,
                        onChanged: (val) {
                          setState(() => Rpassw = val);
                        }
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Container(
                        width: MediaQuery.of(context).size.width-260,
                        height: 50,
                        child: RaisedButton(onPressed: ()async{
                          if(_formKey.currentState.validate()){
                            final FirebaseUser user= (await _auth.createUserWithEmailAndPassword(email: emaill.text, password: passww.text)).user;
                            userr= user.uid;
                            if(userr==null){
                              setState(()=> error= 'Entered E-Mail or password is incorrect'
                              );
                            }else{
                              submit();
                              print('**********************************************');
                              print(userr);
                              print('**********************************************');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FirstScreen()));
                            }
                          }


                        },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                          color: Colors.black,
                          elevation: 0,
                          child: Text('Register', textAlign: TextAlign.center, style: TextStyle(color:Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                          /*child: Ink(
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           colors: <Color>[
                             Color(),
                           ]
                         )
                       ),
                     ), */
                        ),
                      )
                  ),
                ),
                SizedBox(height: 20,),
                Text('or', style: TextStyle(color: Colors.black26, fontSize: 14.0)),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width-260,
                    height: 50,
                    child: RaisedButton(onPressed: ()async{

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginPage()));
                    },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                      color: Color(0xFF604F8E),
                      elevation: 0,
                      child: Text('go to login', textAlign: TextAlign.center, style: TextStyle(color:Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                      /*child: Ink(
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       colors: <Color>[
                         Color(),
                       ]
                     )
                   ),
                     ), */
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0))
              ],
            ),
          ),

        ),
      ),
    );
  }
  submit() async{
    //print(title.text + " " + body.text + " " + time.text + " " + reminderTime.text);
    await Firestore.instance.collection('reminders').document(userr).collection('details').document('udetails').setData({'name': namee.text, 'email': emaill.text});
    Navigator.pop(context);
  }
}