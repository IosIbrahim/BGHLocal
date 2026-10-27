import '../../../../core/core.dart';
import '../../domain/entity/inpatient_models.dart';
import '../../domain/repository/inpatient_repository.dart';
import '../inpatient_api.dart';

class InpatientRepositoryImpl
    with DashboardRequestBuilder
    implements InpatientRepository {
  final InpatientApi _api;
  final AppPreferences _appPreferences;

  InpatientRepositoryImpl(this._api, this._appPreferences);

  @override
  Future<Result<BedCount>> getBedCount() => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getBedCount(buildDashboardRequest(session));
        return res.toDomain();
      });

  @override
  Future<Result<BedStatus>> getCurrentBedStatus() => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getCurrentBedStatus(buildDashboardRequest(session));
        return res.toDomain();
      });

  @override
  Future<Result<UnitsOccupancy>> getUnitsOccupancy() => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res =
            await _api.getCurrentBedStatusData(buildDashboardRequest(session));
        return UnitsOccupancy(
          wards: res.wards.map((e) => e.toDomain()).toList(),
          icus: res.icus.map((e) => e.toDomain()).toList(),
        );
      });

  @override
  Future<Result<KpiValue>> getKpiValue(String code) => safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        // Tag the value with the requested code so the row can place it in the
        // correct tile (the response carries its own, different KPI_CODE).
        final res = await _api.getKpiValues(buildDashboardRequest(
          session,
          kpiCode: code,
          pCompareType: KpiValuesRequest.compareToPreviousPeriod,
        ));
        return res.toDomain(code);
      });
}
