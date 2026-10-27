import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'model/main_data_response.dart';

part 'filter_api.g.dart';

@RestApi()
abstract class FilterApi {
  factory FilterApi(Dio dio, {String baseUrl}) = _FilterApi;

  @POST('Load-Branches')
  Future<MainDataResponse> loadBranches(@Body() Map<String, dynamic> body);
}
