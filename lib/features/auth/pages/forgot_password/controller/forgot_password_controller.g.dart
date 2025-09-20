// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordController on ForgotPasswordControllerBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'ForgotPasswordControllerBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$resetPasswordAsyncAction = AsyncAction(
    'ForgotPasswordControllerBase.resetPassword',
    context: context,
  );

  @override
  Future<Either<Exception, Unit>> resetPassword(String email) {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword(email));
  }

  late final _$ForgotPasswordControllerBaseActionController = ActionController(
    name: 'ForgotPasswordControllerBase',
    context: context,
  );

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$ForgotPasswordControllerBaseActionController
        .startAction(name: 'ForgotPasswordControllerBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$ForgotPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validateEmail(String? value) {
    final _$actionInfo = _$ForgotPasswordControllerBaseActionController
        .startAction(name: 'ForgotPasswordControllerBase.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$ForgotPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
