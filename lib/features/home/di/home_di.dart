import 'package:vision_app/core/firebase/firebase_client.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/features/home/controller/home_controller.dart';
import 'package:vision_app/features/home/datasource/home_datasource.dart';
import 'package:vision_app/features/home/repository/home_repository.dart';

class HomeDI {
  HomeDI._();

  static void init() {
    _configDatasource();
    _configRepository();
    _configController();
  }
}

void _configDatasource() {
  InjectionManager.i.registerFactory<HomeDataSource>(
    () => HomeDataSourceFirebaseImpl(FirebaseClient.firebaseStorage()),
  );
}

void _configRepository() {
  InjectionManager.i.registerFactory<HomeRepository>(
    () => HomeRepositoryFirebaseImpl(
      dataSource: InjectionManager.i.get<HomeDataSource>(),
    ),
  );
}

void _configController() {
  InjectionManager.i.registerFactory(
    () => HomeController(InjectionManager.i.get<HomeRepository>()),
  );
}
