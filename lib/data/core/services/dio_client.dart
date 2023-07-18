import 'dart:io';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:smartup/core/values/urls.dart';

abstract class DioClient {
  Future<Response<T>> get<T>(String url, {Map<String, dynamic>? queryParameters});

  Future<Response<T>> post<T>(String url, {required body});
}

class DioClientImpl implements DioClient {
  late Dio _dio;
  final Alice alice;
  DioClientImpl({required this.alice}) {
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
      ..interceptors.add(alice.getDioInterceptor());
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
    } catch (e) {
      if(e is DioException){
        if (e.response?.data != null) throw Exception(e.response?.data);
      }
      throw Exception(e);
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
    } catch (e) {
      if(e is DioException){
        if (e.response?.data != null) throw Exception(e.response?.statusMessage);
      }
      throw Exception(e);
    }
  }
}
