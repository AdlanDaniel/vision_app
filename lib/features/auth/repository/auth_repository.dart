import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/vision_exception.dart';
import 'package:vision_app/features/auth/datasource/auth_datasource.dart';

abstract class AuthRepository {
  Future<Either<VisionException, String>> login(String email, String password);
  Future<Either<VisionException, bool>> isLoggedIn();
  Future<Either<VisionException, String>> loginWithGoogle();
  Future<Either<VisionException, Unit>> logout();
  Future<Either<VisionException, String>> signUp(String email, String password);
  Future<Either<VisionException, Unit>> resetPassword(String email);
  Future<Either<VisionException, Unit>> finishOnBoarding();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;
  AuthRepositoryImpl(this._authDatasource);

  @override
  Future<Either<VisionException, String>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await _authDatasource.login(email, password);
      return Right(result);
    } on VisionException catch (e) {
      return Left(FirebaseRepoExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<VisionException, bool>> isLoggedIn() async {
    try {
      final result = await _authDatasource.isLoggedIn();
      return Right(result);
    } on VisionException catch (e) {
      return Left(FirebaseRepoExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<VisionException, String>> loginWithGoogle() async {
    try {
      final result = await _authDatasource.loginWithGoogle();
      return Right(result);
    } on VisionException catch (e) {
      return Left(FirebaseRepoExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<VisionException, Unit>> logout() async {
    try {
      await _authDatasource.logout();
      return Right(unit);
    } on VisionException catch (e) {
      return Left(FirebaseRepoExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<VisionException, String>> signUp(
    String email,
    String password,
  ) async {
    try {
      final result = await _authDatasource.signUp(email, password);
      return Right(result);
    } on VisionException catch (e) {
      return Left(FirebaseRepoExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<VisionException, Unit>> resetPassword(String email) async {
    try {
      await _authDatasource.resetPassword(email);
      return Right(unit);
    } on VisionException catch (e) {
      return Left(FirebaseRepoExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<VisionException, Unit>> finishOnBoarding() async {
    try {
      await _authDatasource.finishOnBoarding();
      return const Right(unit);
    } on VisionException catch (e) {
      return Left(FirebaseRepoExceptionMapper.map(e));
    }
  }
}

class UserNotFoundRepoException extends VisionException {
  UserNotFoundRepoException(super.message);
}

class InvalidEmailRepoException extends VisionException {
  InvalidEmailRepoException(super.message);
}

class EmailAlreadyInUseRepoException extends VisionException {
  EmailAlreadyInUseRepoException(super.message);
}

class WrongPasswordRepoException extends VisionException {
  WrongPasswordRepoException(super.message);
}

class GenericAuthRepoException extends VisionException {
  GenericAuthRepoException(super.message);
}

class FirebaseRepoExceptionMapper {
  static VisionException map(VisionException exception) {
    if (exception is UserNotFoundException) {
      return UserNotFoundRepoException(exception.message);
    } else if (exception is InvalidEmailException) {
      return InvalidEmailRepoException(exception.message);
    } else if (exception is EmailAlreadyInUseException) {
      return EmailAlreadyInUseRepoException(exception.message);
    } else if (exception is WrongPasswordException) {
      return WrongPasswordRepoException(exception.message);
    } else {
      return GenericAuthRepoException(exception.message);
    }
  }
}
