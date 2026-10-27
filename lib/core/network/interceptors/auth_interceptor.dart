import 'package:dio/dio.dart';
import '../../storage/storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  final SecureTokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
