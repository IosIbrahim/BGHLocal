import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/operating_response.dart';

part 'operating_api.g.dart';

@RestApi()
abstract class OperatingApi {
  factory OperatingApi(Dio dio, {String baseUrl}) = _OperatingApi;

  @GET('NewDashBoard/kpi_get_operations_statistics')
  Future<OperatingResponse> getOperatingDashboard(
      @Queries() Map<String, dynamic> query);
}
