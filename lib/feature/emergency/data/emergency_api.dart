import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/network/dashboard_request.dart';
import '../../../core/network/patient_census_request.dart';
import 'model/emergency_response.dart';

part 'emergency_api.g.dart';

@RestApi()
abstract class EmergencyApi {
  factory EmergencyApi(Dio dio, {String baseUrl}) = _EmergencyApi;

  @POST('NewDashBoard/GetEROverviewData')
  Future<EmergencyOverviewResponse> getEmergencyOverview(
      @Body() DashboardRequest request);

  @POST('NewDashBoard/GetPatientCensusEr')
  Future<List<PatientCensusErResponse>> getPatientCensusEr(
      @Body() PatientCensusRequest request);
}
