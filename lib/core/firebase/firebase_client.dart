
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseClient {
  static FirebaseAuth firebaseAuth(){
    return FirebaseAuth.instance;
  }
 
}