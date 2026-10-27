import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/dashboard_request.dart';
import 'model/kpi_count_response.dart';

part 'home_api.g.dart';

@RestApi()
abstract class HomeApi {
  factory HomeApi(Dio dio, {String baseUrl}) = _HomeApi;

  @POST('NewDashBoard/GetERPatientsCount')
  Future<KpiCountResponse> getErPatientsCount(@Body() DashboardRequest request);

  @POST('NewDashBoard/GetInPatientsCount')
  Future<KpiCountResponse> getInPatientsCount(@Body() DashboardRequest request);
}
