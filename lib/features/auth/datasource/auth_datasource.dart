import 'package:firebase_auth/firebase_auth.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';

abstract class AuthDatasource {
    Future<String> login(String email, String password);
  Future<String> signUp(String email, String password);
   Future<void> finishOnBoarding();
}

class AuthDatasourceImpl implements AuthDatasource {
   final FirebaseAuth _firebaseAuth;
  RestClient restClient;
  AuthDatasourceImpl(this._firebaseAuth, this.restClient);

   @override
  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null || userCredential.user?.uid == null) {
        throw Exception('User not found');
      }

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unknown error occurred');
    }
  }


    @override
  Future<String> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null || userCredential.user?.uid == null) {
        throw Exception('User not found');
      }

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unknown error occurred');
    }
  }

  

  @override
  Future<void> finishOnBoarding() async {
    //  try {
    //     final RestClientResponse response = await restClient.patch(
    //       '/api/users/updateMe',data: {'finished_onboarding':true}
    //     );
    //     if (response.statusCode != 200) {
    //       log(
    //         'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //       );
    //       throw Exception(response.statusMessage);
    //     }

    //   } catch (e) {
    //     log(e.toString());
    //     throw Exception('Erro datasource');
    //   }
    await Future.delayed(Duration(seconds: 1));
  }
}
