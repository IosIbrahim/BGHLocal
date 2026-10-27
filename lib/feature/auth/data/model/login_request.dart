import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'USER_ID')
  final String username;
  @JsonKey(name: 'USERPASSWORD')
  final String password;
  @JsonKey(name: 'COMPUTER_NAME')
  final String computerName;
  @JsonKey(name: 'MOBILEAPP_TYPE')
  final String type;
  @JsonKey(name: 'MOBILEAPP_KEY')
  final String appKey;
  @JsonKey(name: 'LANGID')
  final String langId;
  @JsonKey(name: 'user_mobile_unique_key')
  final String deviceId;

  LoginRequest({
    required this.username,
    required this.password,
    required this.computerName,
    required this.type,
    required this.appKey,
    required this.langId,
    required this.deviceId,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
