import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: dotenv.env['BASE_URL_RMS']!, // ⚠️ Đổi nếu cần
            connectTimeout: Duration(seconds: 200),
            receiveTimeout: Duration(seconds: 200),
            headers: {
              'Content-Type': 'application/json',
              'Accept-Encoding': 'gzip, deflate, br',
            },
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('token');
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },
          ),
        )
        ..interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true, error: true),
        );

  static Dio get instance => _dio;
}
