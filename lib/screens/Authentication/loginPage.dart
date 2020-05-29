import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_reminders/Services/auth.dart';
import 'package:your_reminders/screens/Authentication/register.dart';
import 'package:your_reminders/screens/firstscreen.dart';
import 'package:toast/toast.dart';
class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final AuthService _authService= AuthService();
  final _formKey = GlobalKey<FormState>();
  String usern='';
  String passw='';
  String error= '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('asset/images/loginBackground.png'), fit: BoxFit.fill)
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('asset/images/reminderGIF.gif'))
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 50, right: 50,),
                  child: TextFormField(
                   // keyboardType: TextInputType.phone,
                    //validator: validateMobile,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide()
                      ),
                        prefixIcon: Icon(Icons.person),
                        hintText: "E-Mail",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 14.0)),
                      validator: (val) => val.isEmpty? 'Enter your email' : null,
                      onChanged: (val)=>
                          setState(()=> usern=val),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: TextFormField(
                    // keyboardType: TextInputType.phone,
                    //validator: validateMobile,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide()
                        ),
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 14.0)),
                        onChanged: (val) =>
                          setState(() => passw = val),
                      validator: (val) => val.length<6? 'Enter password of more than 6 characters long' : null,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      width: MediaQuery.of(context).size.width-180,
                      height: 50,
                      child: RaisedButton(onPressed: ()async{
                        if(_formKey.currentState.validate()){
                          dynamic result = await _authService.signInWithEmailAndPassword(usern, passw);
                          if(result==null){
                            setState(()=> error= 'Entered E-Mail or password is incorrect'
                            );
                            Toast.show(error,context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, textColor:Colors.black, backgroundColor: Color(0xFFD3D3D3), );
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> FirstScreen()));
                          }
                        }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                      color: Color(0xFF604F8E),
                        elevation: 0,
                      child: Text('Login', textAlign: TextAlign.center, style: TextStyle(color:Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
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
                    width: MediaQuery.of(context).size.width-180,
                    height: 50,
                    child: RaisedButton(onPressed: ()async{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> registerPage()));
                    },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                      color: Colors.black,
                      elevation: 0,
                      child: Text('Sign up', textAlign: TextAlign.center, style: TextStyle(color:Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
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
                Center(child: Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)))
                ],
                ),
          ),

          ),
      ),
    );
  }
}
