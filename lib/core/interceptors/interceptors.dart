import 'package:dio/dio.dart';

class AuthInterceptor implements InterceptorsWrapper {

  const AuthInterceptor();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final authId = await firebaseAuth.currentUser?.getIdToken();
    // if (authId != null) {
    //   options.headers['Authorization'] = "Bearer $authId";
    // }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}