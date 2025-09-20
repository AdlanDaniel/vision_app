
import 'package:vision_app/core/firebase/firebase_client.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/features/profile/datasource/profile_datasource.dart';
import 'package:vision_app/features/profile/pages/detail_plan/controller/detail_plan_controller.dart';
import 'package:vision_app/features/profile/pages/profile_details/controller/profile_detail_controller.dart';
import 'package:vision_app/features/profile/repository/profile_repository.dart';

class ProfileDI {
  static void config() {
    _configDataSources();
    _configRepositories();
    _initController();
  }
}

void _configDataSources() {
  InjectionManager.i.registerFactory<ProfileDatasource>(
    () => ProfileFirebaseDatasourceImpl(FirebaseClient.firebaseStorage()),
  );
}

void _configRepositories() {
  InjectionManager.i.registerFactory<ProfileRepository>(
    () => ProfileFirebaseRepositoryImpl(InjectionManager.i.get<ProfileDatasource>()),
  );
}

void _initController() {
  InjectionManager.i.registerFactory<ProfileDetailController>(
    () => ProfileDetailController(InjectionManager.i.get<ProfileRepository>()),
  );

  InjectionManager.i.registerFactory<DetailPlanController>(
    () => DetailPlanController(InjectionManager.i.get<ProfileRepository>()),
  );
}
