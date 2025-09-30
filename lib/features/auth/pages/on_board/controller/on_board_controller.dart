import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:vision_app/features/auth/repository/auth_repository.dart';
import 'package:vision_app/features/auth/repository/model/on_boarding_model.dart';
part 'on_board_controller.g.dart';

class OnBoardController = OnBoardControllerBase with _$OnBoardController;

abstract class OnBoardControllerBase with Store {
  final AuthRepository _authRepository;

  OnBoardControllerBase(this._authRepository);

  @observable
  OnBoardingUserModel? onBoardUser;

  @action
  void setName(String value) {
    if (onBoardUser == null) {
      onBoardUser = OnBoardingUserModel(name: value);
      return;
    }
    onBoardUser!.name = value;
  }

  @action
  void sePhotoUser(XFile? image) {
    if (onBoardUser == null) {
      onBoardUser = OnBoardingUserModel(name: '', photoUser: image);
      return;
    }
    onBoardUser!.photoUser = image;
  }

  @observable
  bool isLoading = false;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @action
  String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu nome';
    }
    if (value.length < 2) {
      return 'O nome deve ter pelo menos 2 caracteres';
    }

    return null;
  }

  @action
  Future<Either<String, String>> finishOnBoarding() async {
    setIsLoading(true);

    final result = await _authRepository.finishOnBoarding(onBoardUser!);

    return result.fold(
      (l) {
        setIsLoading(false);
        return Left('Erro ao finalizar o onboarding');
      },
      (r) {
        setIsLoading(false);
        return Right('Sucesso ao finalizar o onboarding');
      },
    );
  }

  Future<Either<String, String>> loginWithOnBoard({
    required String email,
    required String password,
  }) async {
    setIsLoading(true);
    final List<Either<Exception, dynamic>> futures = await Future.wait([
      _authRepository.finishOnBoarding(onBoardUser!),
      _authRepository.login(email, password),
    ]);

    Either<Exception, dynamic> login = futures[1];

    return login.fold(
      (l) {
        setIsLoading(false);
        return left('Erro ao fazer login');
      },
      (uid) {
        log("User logged in successfully: $uid");
        setIsLoading(false);
        return right('Sucesso ao fazer login');
      },
    );
  }
}
