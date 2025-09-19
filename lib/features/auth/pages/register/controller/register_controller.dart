import 'package:mobx/mobx.dart';
import 'package:vision_app/features/auth/repository/auth_repository.dart';
part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final AuthRepository _authRepository;

  RegisterControllerBase(this._authRepository);

  @action
  Future<void> registerUser() async {
    final result = await _authRepository.registerUser();
    print('User registered with id: $result');
  }

}