import '../../../../core/core.dart';
import '../../domain/repository/home_repository.dart';
import '../home_api.dart';

class HomeRepositoryImpl
    with DashboardRequestBuilder
    implements HomeRepository {
  final HomeApi _api;
  final AppPreferences _appPreferences;

  HomeRepositoryImpl(this._api, this._appPreferences);

  @override
  Future<Result<int>> getErPatientsCount() => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getErPatientsCount(buildDashboardRequest(session));
        return res.value;
      });

  @override
  Future<Result<int>> getInPatientsCount() => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getInPatientsCount(buildDashboardRequest(session));
        return res.value;
      });
}
