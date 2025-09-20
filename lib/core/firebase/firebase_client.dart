
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseClient {
  static FirebaseAuth firebaseAuth(){
    return FirebaseAuth.instance;
  }
  static FirebaseStorage firebaseStorage(){
    return FirebaseStorage.instance;
  }

  
 
}