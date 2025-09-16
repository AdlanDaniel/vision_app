import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {
  String get baseUrl;

  String get baseUrlDev;

  int get connectTimeOut;

  int get receiveTimeOut;

  String get(String key, {String? defaultValue});
}

class DefaultEnvironment implements Environment {
  final DotEnv _env;

  DefaultEnvironment(this._env);

  @override
  String get baseUrl => get("BASE_URL");

  @override
  String get baseUrlDev => get("BASE_URL_DEV");

  @override
  int get connectTimeOut => int.parse(get("CONNECT_TIMEOUT"));

  @override
  int get receiveTimeOut => int.parse(get("RECEIVE_TIMEOUT"));

  Future<void> init({required String fileName}) async {
    await dotenv.load(fileName: fileName);
  }

  @override
  String get(String key, {String? defaultValue}) {
    String value = _env.env[key] ?? defaultValue ?? '';
    return value;
  }

  
}
