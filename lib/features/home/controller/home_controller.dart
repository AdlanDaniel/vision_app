import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:vision_app/features/home/repository/home_repository.dart';
import 'package:vision_app/features/home/repository/model/movie_model.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
    final HomeRepository _homeRepository;

  HomeControllerBase(this._homeRepository);

  @observable
  bool isLoading = false;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @observable
  MovieModel? movie;

  @action
  void setMovie(MovieModel? value) => movie = value;

  @computed
  bool get isMovieLiked => movie?.idLike != null;

  @observable
  int? quantityMovieLikes;

  @action
  void setQuantityMovieLikes(int? value) => quantityMovieLikes = value;

  @action
  Future<Either<String, String>> fetchMovie() async {
    final result = await _homeRepository.fetchMovie();
    return result.fold(
      (error) {
        return left('Erro ao buscar Filme');
      },
      (movie) {
        setMovie(movie);
        return right('Sucesso ao buscar Filme');
      },
    );
  }

  @action
  Future<Either<String, String>> likeMovie() async {
    final result = await _homeRepository.likeMovie(userId: 1, movieId: 2);
    return result.fold(
      (error) {
        return left('Erro ao curtir Filme');
      },
      (success) {
        fetchMovie();
        setQuantityMovieLikes(quantityMovieLikes! + 1);
        return right('Sucesso ao curtir Filme');
      },
    );
  }

  @action
  Future<Either<String, String>> unlikeMovie() async {
    final result = await _homeRepository.unlikeMovie(idLike: movie!.idLike!);
    return result.fold(
      (error) {
        return left('Erro ao descurtir Filme');
      },
      (success) {
        fetchMovie();
        setQuantityMovieLikes(quantityMovieLikes! - 1);
        return right('Sucesso ao descurtir Filme');
      },
    );
  }

  @action
  Future<Either<String, String>> fetchQuantityLikes() async {
    final result = await _homeRepository.fetchQuantityLikes();
    return result.fold(
      (error) {
        return left('Erro ao buscar quantidade de likes');
      },
      (quantity) {
        setQuantityMovieLikes(quantity);
        return right('Sucesso ao buscar quantidade de likes');
      },
    );
  }

  Future<void> fetchUtilsHome() async {
    setIsLoading(true);
    final List<Either<Exception, dynamic>> futures = await Future.wait([
      _homeRepository.fetchMovie(),
      _homeRepository.fetchQuantityLikes(),
    ]);

    Either<Exception, dynamic> movieResult = futures[0];
    Either<Exception, dynamic> quantityResult = futures[1];

    movieResult.fold((l) {}, (movie) {
      setMovie(movie);
    });

    quantityResult.fold(
      (l) {
        setIsLoading(false);
      },
      (quantity) {
        setQuantityMovieLikes(quantity);
      },
    );
    setIsLoading(false);
  }

}