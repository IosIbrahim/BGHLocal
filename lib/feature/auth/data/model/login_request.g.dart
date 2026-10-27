// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      username: json['USER_ID'] as String,
      password: json['USERPASSWORD'] as String,
      computerName: json['COMPUTER_NAME'] as String,
      type: json['MOBILEAPP_TYPE'] as String,
      appKey: json['MOBILEAPP_KEY'] as String,
      langId: json['LANGID'] as String,
      deviceId: json['user_mobile_unique_key'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'USER_ID': instance.username,
      'USERPASSWORD': instance.password,
      'COMPUTER_NAME': instance.computerName,
      'MOBILEAPP_TYPE': instance.type,
      'MOBILEAPP_KEY': instance.appKey,
      'LANGID': instance.langId,
      'user_mobile_unique_key': instance.deviceId,
    };
