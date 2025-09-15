import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {
  String get baseUrl;

  String get baseUrlDev;

  String get(String key, {String? defaultValue});
}

class DefaultEnvironment implements Environment {
  final DotEnv _env;

  DefaultEnvironment(this._env);

  @override
  String get(String key, {String? defaultValue}) {
    String value = _env.env[key] ?? defaultValue ?? '';
    return value;
  }

  @override
  String get baseUrl => get("BASE_URL");

  @override
  String get baseUrlDev => get("BASE_URL_DEV");
}
