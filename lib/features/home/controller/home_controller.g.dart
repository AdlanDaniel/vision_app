// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  Computed<bool>? _$isMovieLikedComputed;

  @override
  bool get isMovieLiked => (_$isMovieLikedComputed ??= Computed<bool>(
    () => super.isMovieLiked,
    name: 'HomeControllerBase.isMovieLiked',
  )).value;

  late final _$isLoadingAtom = Atom(
    name: 'HomeControllerBase.isLoading',
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

  late final _$movieAtom = Atom(
    name: 'HomeControllerBase.movie',
    context: context,
  );

  @override
  MovieModel? get movie {
    _$movieAtom.reportRead();
    return super.movie;
  }

  @override
  set movie(MovieModel? value) {
    _$movieAtom.reportWrite(value, super.movie, () {
      super.movie = value;
    });
  }

  late final _$quantityMovieLikesAtom = Atom(
    name: 'HomeControllerBase.quantityMovieLikes',
    context: context,
  );

  @override
  int? get quantityMovieLikes {
    _$quantityMovieLikesAtom.reportRead();
    return super.quantityMovieLikes;
  }

  @override
  set quantityMovieLikes(int? value) {
    _$quantityMovieLikesAtom.reportWrite(value, super.quantityMovieLikes, () {
      super.quantityMovieLikes = value;
    });
  }

  late final _$fetchMovieAsyncAction = AsyncAction(
    'HomeControllerBase.fetchMovie',
    context: context,
  );

  @override
  Future<Either<String, String>> fetchMovie() {
    return _$fetchMovieAsyncAction.run(() => super.fetchMovie());
  }

  late final _$likeMovieAsyncAction = AsyncAction(
    'HomeControllerBase.likeMovie',
    context: context,
  );

  @override
  Future<Either<String, String>> likeMovie() {
    return _$likeMovieAsyncAction.run(() => super.likeMovie());
  }

  late final _$unlikeMovieAsyncAction = AsyncAction(
    'HomeControllerBase.unlikeMovie',
    context: context,
  );

  @override
  Future<Either<String, String>> unlikeMovie() {
    return _$unlikeMovieAsyncAction.run(() => super.unlikeMovie());
  }

  late final _$fetchQuantityLikesAsyncAction = AsyncAction(
    'HomeControllerBase.fetchQuantityLikes',
    context: context,
  );

  @override
  Future<Either<String, String>> fetchQuantityLikes() {
    return _$fetchQuantityLikesAsyncAction.run(
      () => super.fetchQuantityLikes(),
    );
  }

  late final _$HomeControllerBaseActionController = ActionController(
    name: 'HomeControllerBase',
    context: context,
  );

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.setIsLoading',
    );
    try {
      return super.setIsLoading(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMovie(MovieModel? value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.setMovie',
    );
    try {
      return super.setMovie(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuantityMovieLikes(int? value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.setQuantityMovieLikes',
    );
    try {
      return super.setQuantityMovieLikes(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
movie: ${movie},
quantityMovieLikes: ${quantityMovieLikes},
isMovieLiked: ${isMovieLiked}
    ''';
  }
}
