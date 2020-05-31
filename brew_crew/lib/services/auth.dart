import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // method to sign in anonymously

  Future<FirebaseUser> signInAnon() async {
     try {
       AuthResult result = await _auth.signInAnonymously();

       FirebaseUser user = result.user;
       return user;
     } catch(e) {
       print('error: $e');
       return null;
     }
  }


  //sign in with email and password

  //register with email and password

  //sign out
}