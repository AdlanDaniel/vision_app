import 'package:dartz/dartz.dart';
import 'package:vision_app/features/auth/datasource/auth_datasource.dart';

abstract class AuthRepository {
   Future<Either<Exception, String>> login(String email, String password);
    Future<Either<Exception, String>> loginWithGoogle();
      Future<Either<Exception, Unit>> logout();
 Future<Either<Exception, String>> signUp(String email, String password);
  Future<Either<Exception, Unit>> resetPassword(String email);
   Future<Either<Exception, Unit>> finishOnBoarding();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;
  AuthRepositoryImpl(this._authDatasource);

   @override
  Future<Either<Exception, String>> login(String email, String password) async {
    try {
      final result = await _authDatasource.login(email, password);
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

   @override
  Future<Either<Exception, String>> loginWithGoogle() async {
    try {
      final result = await _authDatasource.loginWithGoogle();
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

   @override
  Future<Either<Exception, Unit>> logout() async {
    try {
      await _authDatasource.logout();
      return Right(unit);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, String>> signUp(
    String email,
    String password,
  ) async {
    try {
      final result = await _authDatasource.signUp(email, password);
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
   @override
  Future<Either<Exception, Unit>> resetPassword(String email) async {
    try {
      await _authDatasource.resetPassword(email);
      return Right(unit);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }


    @override
  Future<Either<Exception, Unit>> finishOnBoarding() async {
    try {
      await _authDatasource.finishOnBoarding();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
