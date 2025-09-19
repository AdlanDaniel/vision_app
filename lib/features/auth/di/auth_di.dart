
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/features/auth/datasource/auth_datasource.dart';
import 'package:vision_app/features/auth/pages/register/controller/register_controller.dart';
import 'package:vision_app/features/auth/repository/auth_repository.dart';

class AuthDi {
  AuthDi._();


  static void init(){
    InjectionManager.i.registerFactory<AuthDatasource>(() => AuthDatasourceImpl());

    InjectionManager.i.registerFactory<AuthRepository>(() => AuthRepositoryImpl(InjectionManager.i.get<AuthDatasource>()));

    InjectionManager.i.registerFactory<RegisterController>(() => RegisterController(InjectionManager.i.get<AuthRepository>()));
  }



}