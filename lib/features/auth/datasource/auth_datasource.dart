import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';

abstract class AuthDatasource {
     Future<String> login(String email, String password);
  Future<String> loginWithGoogle();
  Future<void> logout();
  Future<String> signUp(String email, String password);

  Future<void> resetPassword(String email);
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
  Future<String> loginWithGoogle() async {
    final googleSignIn = GoogleSignIn.standard();

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Login com Google cancelado pelo usuário');
      }

      final googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Falha ao obter tokens do Google');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null || user.uid.isEmpty) {
        throw Exception('Usuário não encontrado no Firebase');
      }

      return user.uid;
    } catch (e) {
      throw Exception('Erro ao fazer login com Google');
    }
  }

   @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
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
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
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
