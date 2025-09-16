  import 'package:dio/dio.dart';


class DioFactory {
  static Dio create({
    required String baseUrl,
    int connectTimeout = 5000,
    int receiveTimeout = 3000,
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    );
    return Dio(options);
  }
}