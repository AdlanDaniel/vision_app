import 'package:vision_app/features/auth/datasource/auth_datasource.dart';

abstract class AuthRepository {
  Future<int> registerUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;
  AuthRepositoryImpl(this._authDatasource);
  @override
  Future<int> registerUser() {
    return _authDatasource.registerUSer();
  }
}
