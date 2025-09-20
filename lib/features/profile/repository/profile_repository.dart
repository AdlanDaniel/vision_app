import 'package:dartz/dartz.dart';
import 'package:vision_app/features/auth/repository/model/user_model.dart';
import 'package:vision_app/features/profile/datasource/profile_datasource.dart';

abstract class ProfileRepository {
  Future<Either<Exception, UserModel>> fetchUserProfileData();

  Future<Either<Exception, Unit>> updateUserProfileData(UserModel user);

  Future<Either<Exception, Unit>> deleteUserProfileData(int userId);

  Future<Either<Exception, Unit>> registerUserPhoto(
    String uid,
    String photoUrl,
  );
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);
  final ProfileDatasource _dataSource;

  @override
  Future<Either<Exception, UserModel>> fetchUserProfileData() async {
    try {
      final result = await _dataSource.fetchUserProfileData();
      final model = UserModel.fromMap(result);
      return Right(model);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> updateUserProfileData(UserModel user) async {
    try {
      await _dataSource.updateUserProfileData(user);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteUserProfileData(int userId) async {
    try {
      await _dataSource.deleteUserProfileData(userId);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> registerUserPhoto(
    String uid,
    String photoUrl,
  ) async {
    try {
      await _dataSource.registerUserPhoto(uid, photoUrl);
      return Right(unit);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}


class ProfileFirebaseRepositoryImpl implements ProfileRepository {
  ProfileFirebaseRepositoryImpl(this._dataSource);
  final ProfileDatasource _dataSource;

  @override
  Future<Either<Exception, UserModel>> fetchUserProfileData() async {
    try {
      final result = await _dataSource.fetchUserProfileData();
      final model = UserModel.fromMap(result);
      return Right(model);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> updateUserProfileData(UserModel user) async {
    try {
      await _dataSource.updateUserProfileData(user);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteUserProfileData(int userId) async {
    try {
      await _dataSource.deleteUserProfileData(userId);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> registerUserPhoto(
    String uid,
    String photoUrl,
  ) async {
    try {
      await _dataSource.registerUserPhoto(uid, photoUrl);
      return Right(unit);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
  
}
