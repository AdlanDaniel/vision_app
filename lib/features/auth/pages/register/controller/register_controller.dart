import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:vision_app/features/auth/repository/auth_repository.dart';
part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final AuthRepository _authRepository;

  RegisterControllerBase(this._authRepository);

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
    if (value == null|| value.isEmpty  ) {
      return 'Digite sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

 

  @action
  Future<Either<Exception, Unit>> register(String email, String password) async {
    setIsLoading(true);
    final Either<Exception, String> result = await _authRepository
        .signUp(email, password);
   return result.fold(
      (error) {
        log("Error registering user: $error");
        setIsLoading(false);
        return left(Exception(error.toString()));
      },
      (uid) {
        log("User registered successfully: $uid");
        setIsLoading(false);
        return right(unit);
      },
    );
  }

}