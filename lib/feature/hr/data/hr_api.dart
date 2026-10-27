import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/dashboard_request.dart';
import 'model/hr_response.dart';

part 'hr_api.g.dart';

@RestApi()
abstract class HrApi {
  factory HrApi(Dio dio, {String baseUrl}) = _HrApi;

  @GET('NewDashBoard/cover_employee_no_graph')
  Future<HrKpiCountResponse> getEmployeeCount(
      @Queries() DashboardRequest request);

  @GET('NewDashBoard/kpi_cover_doctor_no_graph')
  Future<HrKpiCountResponse> getDoctorCount(@Queries() DashboardRequest request);

  @GET('NewDashBoard/kpi_cover_nurse_no_graph')
  Future<HrKpiCountResponse> getNurseCount(@Queries() DashboardRequest request);

  @GET('NewDashBoard/kpi_cover_admin_no_graph')
  Future<HrKpiCountResponse> getAdminCount(@Queries() DashboardRequest request);

  @GET('NewDashBoard/kpi_cover_tech_no_graph')
  Future<HrKpiCountResponse> getTechCount(@Queries() DashboardRequest request);
}
