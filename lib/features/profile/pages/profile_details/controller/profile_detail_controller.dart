// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/features/auth/repository/model/user_model.dart';
import 'package:vision_app/features/profile/models/historic_movie_model.dart';

import 'package:vision_app/features/profile/repository/profile_repository.dart';

part 'profile_detail_controller.g.dart';

class ProfileDetailController = ProfileDetailControllerBase with _$ProfileDetailController;

abstract class ProfileDetailControllerBase with Store {

final ProfileRepository _profileRepository;
  ProfileDetailControllerBase(
     this._profileRepository,
  );

   @observable
  bool isLoading = false;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @observable
  UserModel? user;

  @action
  void setUser(UserModel? value) => user = value;

  @observable
  List<HistoricMovieModel> historicMovies = ObservableList.of([
    HistoricMovieModel(
      name: 'Interestelar',
      imageUrl: VisionAssets.interstellar,
      year: '2014',
    ),
  ]);



  Future<void> fetchUserData() async {
    setIsLoading(true);
    final result = await _profileRepository.fetchUserProfileData();
    result.fold(
      (error) {
        setIsLoading(false);
        throw Exception('Erro ao buscar dados do usuário');
      },
      (user) {
        setUser(user);
        setIsLoading(false);
      },
    );
  }
    @action
  Future<Either<String,String>> deleteAccount() async {
    setIsLoading(true);
    final result = await _profileRepository.deleteUserProfileData(user!.id!);
    return result.fold(
      (error) {
          setIsLoading(false);
        return Left('Error ao deletar conta');
      },
      (success) {
         setIsLoading(false);
        return Right('Conta deletada com sucesso');
      },
    );
  
  }


}
