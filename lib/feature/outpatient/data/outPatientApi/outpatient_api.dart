import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/outpatient_response.dart';

part 'outpatient_api.g.dart';

@RestApi()
abstract class OutpatientApi {
  factory OutpatientApi(Dio dio, {String baseUrl}) = _OutpatientApi;

  @GET('NewDashBoard/kpi_get_outpatient_statistics')
  Future<OutpatientResponse> getOutpatientDashboard(
      @Queries() Map<String, dynamic> query);
}
