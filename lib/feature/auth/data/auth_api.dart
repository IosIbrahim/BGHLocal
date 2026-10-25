import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<dynamic> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'authentication/authenticate',
        data: {
          'username': username,
          'password': password,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
