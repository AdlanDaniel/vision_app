// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import 'package:vision_app/features/auth/repository/auth_repository.dart';

part 'forgot_password_controller.g.dart';

class ForgotPasswordController = ForgotPasswordControllerBase with _$ForgotPasswordController;

abstract class ForgotPasswordControllerBase with Store {
final AuthRepository _authRep;
  ForgotPasswordControllerBase(
     this._authRep,
  );
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
  Future<Either<Exception, Unit>> resetPassword(String email) async {
    setIsLoading(true);
    final Either<Exception, Unit> result = await _authRep
        .resetPassword(email);
    return result.fold(
      (error) {
        log("Error resetting password: $error");
        setIsLoading(false);
        return left(Exception(error.toString()));
      },
      (unit) {
        log("Password reset email sent successfully");
        setIsLoading(false);
        return right(unit);
      },
    );
  }

}
