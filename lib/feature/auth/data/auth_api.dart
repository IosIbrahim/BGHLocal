import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'model/login_request.dart';
import 'model/login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("Hr/Authenticate")
  Future<ModelLoginResponseRemote> login(@Body() LoginRequest request);
}
