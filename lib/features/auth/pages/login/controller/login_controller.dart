import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:vision_app/core/errors/vision_exception.dart';
import 'package:vision_app/features/auth/repository/auth_repository.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  
  final AuthRepository _authRepo;

  LoginControllerBase(this._authRepo);

  @observable
  bool isLoading = false;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @action
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um email válido';
    }
    return null;
  }

  @action
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  @action
  Future<Either<String, Unit>> login(String email, String password) async {
    setIsLoading(true);
    final Either<Exception, String> result = await _authRepo
        .login(email, password);
    return result.fold(
      (error) {
        setIsLoading(false);
        log("Error logging in user: $error");
        return left('Erro ao fazer login');
      },
      (uid) {
        log("User logged in successfully: $uid");
        setIsLoading(false);
        return right(unit);
      },
    );
  }

  @action
  Future<Either<String, bool>> isLoggedIn() async {
  
    final Either<VisionException, bool> result = await _authRepo
        .isLoggedIn();
    return result.fold(
      (error) {
    
        log("Error signing up user: $error");
        return left(error.message );
      },
      (isLoggedIn) {
        return right(isLoggedIn);
      },
    );
  }

  @action
  Future<Either<String, Unit>> loginWithGoogle() async {
    final Either<Exception, String> result = await _authRepo
        .loginWithGoogle();
    return result.fold(
      (error) {
        log("Error logging with google: $error");
        return left('Erro ao fazer login com google');
      },
      (uid) {
        log("User logged with googlesuccessfully: $uid");
        return right(unit);
      },
    );
  }

  Future<Either<String, String>> logout() async {
    final Either<Exception, Unit> result = await _authRepo.logout();
    return result.fold(
      (error) {
        log("Error logging out user: $error");
        return left('Erro ao fazer logout');
      },
      (message) {
        log("User logged out successfully");
        return right('Sucesso ao fazer Logout');
      },
    );
  }


}