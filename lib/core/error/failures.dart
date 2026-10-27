import 'package:easy_localization/easy_localization.dart';
import 'package:dr_baksh_dashboard/core/resources/app_strings.dart';

sealed class Failure implements Exception {
  final String rawMessage;
  final bool isLocalizationKey;
  const Failure(this.rawMessage, {this.isLocalizationKey = true});

  String get message => isLocalizationKey ? rawMessage.tr() : rawMessage;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = AppStrings.noInternetConnection, bool isLocalizationKey = true]) : super(isLocalizationKey: isLocalizationKey);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = AppStrings.serverErrorOccurred, bool isLocalizationKey = true]) : super(isLocalizationKey: isLocalizationKey);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = AppStrings.authenticationFailed, bool isLocalizationKey = true]) : super(isLocalizationKey: isLocalizationKey);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = AppStrings.connectionTimedOut, bool isLocalizationKey = true]) : super(isLocalizationKey: isLocalizationKey);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = AppStrings.cacheError, bool isLocalizationKey = true]) : super(isLocalizationKey: isLocalizationKey);
}
