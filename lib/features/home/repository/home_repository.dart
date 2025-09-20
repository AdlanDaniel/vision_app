
import 'package:dartz/dartz.dart';
import 'package:vision_app/features/home/datasource/home_datasource.dart';
import 'package:vision_app/features/home/repository/model/movie_model.dart';

abstract class HomeRepository {
Future <Either<Exception, MovieModel>> fetchMovie();
  Future<Either<Exception, int>> fetchQuantityLikes();
  Future<Either<Exception, Unit>> likeMovie({required int userId, required int movieId});
  Future<Either<Exception, Unit>> unlikeMovie({required int idLike});

  
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Exception, MovieModel>> fetchMovie() async {
    try {
      final result = await dataSource.fetchMovie();
      final model = MovieModel.fromMap(result);
      return Right(model);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, int>> fetchQuantityLikes() async {
    try {
      final result = await dataSource.fetchQuantityLikes();
      return Right(result['quantity']);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> likeMovie({required int userId, required int movieId}) async {
    try {
      await dataSource.likeMovie(userId: userId, movieId: movieId);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> unlikeMovie({required int idLike}) async {
    try {
      await dataSource.unlikeMovie(idLike: idLike);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Erro ao descurtir filme'));
    }
  }
}


class HomeRepositoryFirebaseImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryFirebaseImpl({required this.dataSource});

  @override
  Future<Either<Exception, MovieModel>> fetchMovie() async {
    try {
      final result = await dataSource.fetchMovie();
      final model = MovieModel.fromMap(result);
      return Right(model);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, int>> fetchQuantityLikes() async {
    try {
      final result = await dataSource.fetchQuantityLikes();
      return Right(result['quantity']);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> likeMovie({required int userId, required int movieId}) async {
    try {
      await dataSource.likeMovie(userId: userId, movieId: movieId);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> unlikeMovie({required int idLike}) async {
    try {
      await dataSource.unlikeMovie(idLike: idLike);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Erro ao descurtir filme'));
    }
  }
  
}