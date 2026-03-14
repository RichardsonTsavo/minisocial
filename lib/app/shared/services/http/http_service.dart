import 'package:dio/dio.dart';

class HttpService {
  final Dio dio;

  String? _token;

  HttpService()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'http://10.0.2.2:8080',
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }

          handler.next(options);
        },
      ),
    );
  }

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }
}
