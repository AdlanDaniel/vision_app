import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vision_app/core/errors/vision_exception.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';

abstract class AuthDatasource {
  Future<String> login(String email, String password);
  Future<String> loginWithGoogle();
  Future<void> logout();
  Future<String> signUp(String email, String password);

  Future<void> resetPassword(String email);
  Future<bool> isLoggedIn();
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
      throw FirebaseAuthErrorMapper.map(e);
    } catch (e) {
      throw VisionException('Um erro desconhecido ocorreu ao logar');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user != null;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e, messageError: 'Usuário não está logado');
    } catch (e) {
      throw VisionException('Um erro desconhecido ocorreu ao deslogar');
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
      throw FirebaseAuthErrorMapper.map(e);
    } catch (e) {
      throw VisionException('Um erro desconhecido ocorreu ao deslogar');
    }
  }

  @override
  Future<String> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e);
    } catch (e) {
      throw VisionException('Um erro desconhecido ocorreu ao cadastrar');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e);
    } catch (e) {
      throw VisionException(
        'Um erro desconhecido ocorreu ao redefinir a senha',
      );
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

class UserNotFoundException extends VisionException {
  UserNotFoundException()
    : super('Nenhum usuário encontrado para este e-mail.');
}

class InvalidEmailException extends VisionException {
  InvalidEmailException() : super('O e-mail fornecido é inválido.');
}

class EmailAlreadyInUseException extends VisionException {
  EmailAlreadyInUseException()
    : super('O e-mail fornecido já está em uso por outra conta.');
}

class WrongPasswordException extends VisionException {
  WrongPasswordException() : super('A senha fornecida está incorreta.');
}

class GenericAuthException extends VisionException {
  GenericAuthException([String? message])
    : super(message ?? 'Erro de autenticação.');
}

class FirebaseAuthErrorMapper {
  static VisionException map(FirebaseAuthException e, {String? messageError}) {
    switch (e.code) {
      case 'user-not-found':
      case 'user-disabled':
        return UserNotFoundException();
      case 'invalid-email':
        return InvalidEmailException();
      case 'wrong-password':
        return WrongPasswordException();
      case 'email-already-in-use':
        return EmailAlreadyInUseException();

      default:
        return GenericAuthException('Erro: ${messageError ??e.code}');
    }
  }
}
