import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/dashboard_request.dart';
import '../../../core/network/kpi_values_request.dart';
import 'model/kpi_values_response.dart';
import 'model/revenue_response.dart';

part 'revenue_api.g.dart';

@RestApi()
abstract class RevenueApi {
  factory RevenueApi(Dio dio, {String baseUrl}) = _RevenueApi;

  @POST('NewDashBoard/GetRevenueDashboard')
  Future<RevenueResponse> getRevenueDashboard(@Body() DashboardRequest request);

  /// One KPI per call — the code is carried in the request body's `KPI_CODE`.
  @POST('NewDashBoard/GETKPIVALUES')
  Future<KpiValuesResponse> getKpiValues(@Body() KpiValuesRequest request);
}
