import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<void> init();

  Future<bool> containsKey(String key);

  Future<bool> remove(String key);

  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  Future<bool> setDouble(String key, double value);

  Future<bool> setInt(String key, int value);

  Future<bool> setStringList(String key, List<String> value);

  Future<String?> getString(String key);

  Future<bool?> getBool(String key);

  Future<double?> getDouble(String key);

  Future<int?> getInt(String key);

  Future<List<String>?> getStringList(String key);

  Future<bool> clear();
}

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences _localStorage;

  LocalStorageImpl(this._localStorage);

  @override
  Future<void> init() async {}

  @override
  Future<bool> containsKey(String key) async => _localStorage.containsKey(key);

  @override
  Future<bool> remove(String key) => _localStorage.remove(key);

  @override
  Future<bool> clear() => _localStorage.clear();

  @override
  Future<bool?> getBool(String key) async => _localStorage.getBool(key);

  @override
  Future<double?> getDouble(String key) async => _localStorage.getDouble(key);

  @override
  Future<int?> getInt(String key) async => _localStorage.getInt(key);

  @override
  Future<String?> getString(String key) async => _localStorage.getString(key);

  @override
  Future<List<String>?> getStringList(String key) async =>
      _localStorage.getStringList(key);

  @override
  Future<bool> setBool(String key, bool value) =>
      _localStorage.setBool(key, value);

  @override
  Future<bool> setDouble(String key, double value) =>
      _localStorage.setDouble(key, value);

  @override
  Future<bool> setInt(String key, int value) =>
      _localStorage.setInt(key, value);

  @override
  Future<bool> setString(String key, String value) =>
      _localStorage.setString(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _localStorage.setStringList(key, value);
}
