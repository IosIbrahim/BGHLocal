import 'package:dio/dio.dart';
import '../../error/failures.dart';

/// Maps raw HTTP errors and Dio exceptions to typed Failure classes.
/// Ensures every feature gets consistent, typed error information.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _mapError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: failure,
        message: failure.message,
      ),
    );
  }

  Failure _mapError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const TimeoutFailure();
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        final status = err.response?.statusCode;
        if (status == 401) return const AuthFailure('Session expired. Please login again.');
        if (status == 403) return const AuthFailure('Access denied.');
        if (status != null && status >= 500) return const ServerFailure();
        return ServerFailure('Request failed with status: $status');
      default:
        return ServerFailure(err.message ?? 'Unexpected error occurred');
    }
  }
}
