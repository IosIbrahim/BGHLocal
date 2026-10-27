import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../di/di.dart';
import '../error/failures.dart';
import '../error/result.dart';
import '../resources/app_strings.dart';
import 'network_info.dart';

Future<Result<T>> safeApiCall<T>(Future<T> Function() call) async {
  try {
    final networkInfo = instance<NetworkInfo>();
    if (!await networkInfo.isConnected) {
      return const Error(NetworkFailure());
    }

    return Success(await call());
  } on DioException catch (e) {
    return Error(_mapDioException(e));
  } on Failure catch (f) {
    return Error(f);
  } catch (e) {
    return Error(ServerFailure(e.toString(), false));
  }
}

Failure _mapDioException(DioException err) {
  switch (err.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return const TimeoutFailure();
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      return _mapBadResponse(err);
    default:
      return ServerFailure(
        err.message ?? AppStrings.unexpectedError,
        err.message == null,
      );
  }
}

Failure _mapBadResponse(DioException err) {
  final status = err.response?.statusCode;
  final data = err.response?.data;

  String? serverMessage;
  if (data is Map<String, dynamic>) {
    serverMessage = data['NAME_EN']?.toString() ??
        data['NAME_AR']?.toString() ??
        data['message']?.toString() ??
        data['code']?.toString();
  }

  if (status == 401) {
    return AuthFailure(
      serverMessage ?? AppStrings.sessionExpired,
      serverMessage == null,
    );
  }
  if (status == 403) {
    return AuthFailure(
      serverMessage ?? AppStrings.accessDenied,
      serverMessage == null,
    );
  }
  if (status != null && status >= 500) {
    return ServerFailure(
      serverMessage ?? AppStrings.serverErrorOccurred,
      serverMessage == null,
    );
  }

  return ServerFailure(
    serverMessage ??
        AppStrings.requestFailedWithStatus.tr(args: [status.toString()]),
    serverMessage == null,
  );
}
