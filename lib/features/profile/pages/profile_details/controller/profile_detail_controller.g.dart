// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileDetailController on ProfileDetailControllerBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'ProfileDetailControllerBase.isLoading',
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

  late final _$userAtom = Atom(
    name: 'ProfileDetailControllerBase.user',
    context: context,
  );

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$historicMoviesAtom = Atom(
    name: 'ProfileDetailControllerBase.historicMovies',
    context: context,
  );

  @override
  List<HistoricMovieModel> get historicMovies {
    _$historicMoviesAtom.reportRead();
    return super.historicMovies;
  }

  @override
  set historicMovies(List<HistoricMovieModel> value) {
    _$historicMoviesAtom.reportWrite(value, super.historicMovies, () {
      super.historicMovies = value;
    });
  }

  late final _$deleteAccountAsyncAction = AsyncAction(
    'ProfileDetailControllerBase.deleteAccount',
    context: context,
  );

  @override
  Future<Either<String, String>> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$ProfileDetailControllerBaseActionController = ActionController(
    name: 'ProfileDetailControllerBase',
    context: context,
  );

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$ProfileDetailControllerBaseActionController
        .startAction(name: 'ProfileDetailControllerBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$ProfileDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUser(UserModel? value) {
    final _$actionInfo = _$ProfileDetailControllerBaseActionController
        .startAction(name: 'ProfileDetailControllerBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$ProfileDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
user: ${user},
historicMovies: ${historicMovies}
    ''';
  }
}
