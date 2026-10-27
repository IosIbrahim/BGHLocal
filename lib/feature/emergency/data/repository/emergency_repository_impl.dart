import '../../../../core/core.dart';
import '../../domain/entity/emergency_data.dart';
import '../../domain/repository/emergency_repository.dart';
import '../emergency_api.dart';

class EmergencyRepositoryImpl
    with DashboardRequestBuilder
    implements EmergencyRepository {
  /// `DB_SER` dataset selector for the ER nationality census.
  static const _erCensusDbSer = 8;
  static const _deptType = '0';

  final EmergencyApi _api;
  final AppPreferences _appPreferences;

  EmergencyRepositoryImpl(this._api, this._appPreferences);

  @override
  Future<Result<EmergencyOverview>> getOverview() => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getEmergencyOverview(
            buildDashboardRequest(session, deptType: _deptType));
        return res.toOverview();
      });

  @override
  Future<Result<EmergencyPayments>> getPaymentTypes() => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getEmergencyOverview(
            buildDashboardRequest(session, deptType: _deptType));
        return res.toPayments();
      });

  @override
  Future<Result<List<EmergencyNationalityEntry>>> getNationalityDistribution() =>
      safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getPatientCensusEr(buildPatientCensusRequest(
          session,
          dbSer: _erCensusDbSer,
          deptType: _deptType,
        ));
        return res.map((e) => e.toDomain()).toList();
      });
}
