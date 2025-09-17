import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';
import 'package:vision_app/core/rest_client/rest_client_response.dart';


class DioRestClient implements RestClient {
  final Dio _dio;

  DioRestClient(this._dio);

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.response == null) {
        throw HttpError(
          errorType: e.error is SocketException
              ? ErrorType.networkError
              : ErrorType.serverError,
        );
      } else {
        throw HttpResponseError(_dioErrorConverter(e.response!));
      }
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options( headers: headers),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.response == null) {
        throw HttpError(
          errorType: e.error is SocketException
              ? ErrorType.networkError
              : ErrorType.serverError,
        );
      } else {
        throw HttpResponseError(_dioErrorConverter(e.response!));
      }
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options( headers: headers),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.response == null) {
        throw HttpError(
          errorType: e.error is SocketException
              ? ErrorType.networkError
              : ErrorType.serverError,
        );
      } else {
        throw HttpResponseError(_dioErrorConverter(e.response!));
      }
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Duration? customReceiveTimeout,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          receiveTimeout: customReceiveTimeout,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.response == null) {
        throw HttpError(
          errorType: e.error is SocketException
              ? ErrorType.networkError
              : ErrorType.serverError,
        );
      } else {
        throw HttpResponseError(_dioErrorConverter(e.response!));
      }
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options( headers: headers),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.response == null) {
        throw HttpError(
          errorType: e.error is SocketException
              ? ErrorType.networkError
              : ErrorType.serverError,
        );
      } else {
        throw HttpResponseError(_dioErrorConverter(e.response!));
      }
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    data,
    required String method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(  headers: headers),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.response == null) {
        throw HttpError(
          errorType: e.error is SocketException
              ? ErrorType.networkError
              : ErrorType.serverError,
        );
      } else {
        throw HttpResponseError(_dioErrorConverter(e.response!));
      }
    }
  }

  RestClientResponse<T> _dioErrorConverter<T>(Response response) {
    return RestClientResponse(
      data: response.data,
      statusMessage: response.statusMessage,
      statusCode: response.statusCode!,
    );
  }
}