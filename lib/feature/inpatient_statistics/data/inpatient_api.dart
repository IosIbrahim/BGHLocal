import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/dashboard_request.dart';
import 'model/bed_count_response.dart';
import 'model/bed_status_response.dart';
import 'model/kpi_value_response.dart';
import 'model/ward_occupancy_response.dart';

part 'inpatient_api.g.dart';

@RestApi()
abstract class InpatientApi {
  factory InpatientApi(Dio dio, {String baseUrl}) = _InpatientApi;

  @POST('NewDashBoard/GetBedCount')
  Future<BedCountResponse> getBedCount(@Body() DashboardRequest request);

  @POST('NewDashBoard/GetCurrentBedStatus')
  Future<BedStatusResponse> getCurrentBedStatus(@Body() DashboardRequest request);

  @POST('NewDashBoard/GetCurrentBedStatusData')
  Future<UnitsOccupancyResponse> getCurrentBedStatusData(
      @Body() DashboardRequest request);

  @POST('NewDashBoard/GetKPIValues')
  Future<KpiValueResponse> getKpiValues(@Body() DashboardRequest request);
}
