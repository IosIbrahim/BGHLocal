import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import '../storage/storage.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {
  final AppPreferences _appPreferences;
  final SecureTokenStorage _tokenStorage;

  DioFactory(this._appPreferences, this._tokenStorage);

  Future<Dio> getDio() async {
    final dio = Dio();
    final language = await _appPreferences.getAppLanguage();

    dio.options = BaseOptions(
      baseUrl: kDebugMode ? ApiConstants.devBaseUrl : ApiConstants.baseUrl,
      headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        ACCEPT: APPLICATION_JSON,
        DEFAULT_LANGUAGE: language,
        // Authorization is injected dynamically by AuthInterceptor
      },
      connectTimeout: const Duration(seconds: ApiConstants.apiTimeoutSeconds),
      receiveTimeout: const Duration(seconds: ApiConstants.apiTimeoutSeconds),
      sendTimeout: const Duration(seconds: ApiConstants.apiTimeoutSeconds),
    );

    dio.interceptors.addAll([
      AuthInterceptor(_tokenStorage), // Dynamic token injection
      ErrorInterceptor(),              // Typed error mapping
      if (!kReleaseMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
        ),
    ]);

    return dio;
  }
}