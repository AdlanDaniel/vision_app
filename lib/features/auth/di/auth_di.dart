
import 'package:vision_app/core/firebase/firebase_client.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';
import 'package:vision_app/features/auth/datasource/auth_datasource.dart';
import 'package:vision_app/features/auth/pages/login/controller/login_controller.dart';
import 'package:vision_app/features/auth/pages/register/controller/register_controller.dart';
import 'package:vision_app/features/auth/repository/auth_repository.dart';

class AuthDi {
  AuthDi._();


   static void init(){
    _configDatasource();
    _configRepository();
    _configController();
  }


  



}
void _configDatasource(){
    InjectionManager.i.registerFactory<AuthDatasource>(() => AuthDatasourceImpl(FirebaseClient.firebaseAuth(), InjectionManager.i.get<RestClient>()));

  }

  void _configRepository(){
    InjectionManager.i.registerFactory<AuthRepository>(() => AuthRepositoryImpl(InjectionManager.i.get<AuthDatasource>()));
  }

   void _configController(){
    InjectionManager.i.registerFactory<RegisterController>(() => RegisterController(InjectionManager.i.get<AuthRepository>()));
    InjectionManager.i.registerFactory<LoginController>(() => LoginController(InjectionManager.i.get<AuthRepository>()));
  }
