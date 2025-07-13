import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiDio {
  static final ApiDio _instance = ApiDio._internal();

  factory ApiDio() {
    return _instance;
  }

  ApiDio._internal();

  static Dio dioApi({String? url}) {
    Dio dio = Dio(BaseOptions(
      baseUrl: url ?? dotenv.env['BASE_URL_RMS']!,
      connectTimeout: Duration(seconds: int.parse(dotenv.env['TIMEOUT_API']!)),
      receiveTimeout: Duration(seconds: int.parse(dotenv.env['TIMEOUT_API']!)),
    ));

    dio.interceptors.add(AuthInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }
    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    options.headers = headers;
    return super.onRequest(options, handler);
  }
}
