import 'dart:io';
import 'package:dio/dio.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import '../../../core/values/urls.dart';

abstract class DioClient {
  Future<Response<T>> get<T>(String url, {Map<String, dynamic>? queryParameters});

  Future<Response<T>> post<T>(String url, {required body});
}

class DioClientImpl implements DioClient {
  late Dio _dio;

  DioClientImpl() {
    _initApiClient();
  }

  void _initApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: Urls.baseUrl,
      headers: {
        "x-api-key": Urls.apiKey,
        HttpHeaders.contentTypeHeader: "application/json",
      },
      responseType: ResponseType.json,
    );
    _dio = Dio(options)
      ..interceptors.add(ChuckerDioInterceptor());
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        url,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null) throw Exception(e.response?.data);

      throw Exception(e.message);
    }
  }

  @override
  Future<Response<T>> post<T>(
    String url, {
    required body,
    bool authorization = false,
  }) async {
    try {
      final response = await _dio.post<T>(url, data: body);

      return response;
    } on DioException catch (e) {
      if (e.response?.data != null) throw Exception(e.response?.data);

      throw Exception(e.message);
    }
  }
}
