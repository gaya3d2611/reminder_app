import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_reminders/Models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //sign-in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      return user;
    } catch (error) {
      print(error.toString());

      return null;
    }
  }

//Register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return /*  _userFromFirebaseUser(user) */ user.uid.toString();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

//Logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());

      return null;
    }
  }
}
