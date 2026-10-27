import '../../../../core/core.dart';
import '../../domain/entity/revenue_data.dart';
import '../../domain/repository/revenue_repository.dart';
import '../revenue_api.dart';

class RevenueRepositoryImpl implements RevenueRepository {
  final RevenueApi _api;
  final AppPreferences _appPreferences;

  RevenueRepositoryImpl(this._api, this._appPreferences);

  @override
  Future<Result<RevenueKpiValue>> getKpi(RevenueKpi kpi) =>
      safeApiCall(() async {
        final session = await _appPreferences.getUserSession();
        final res = await _api.getKpiValues(
          KpiValuesRequest.fromSession(
            session,
            instance<DashboardFilterStore>().filter,
            kpiCode: kpi.code,
          ),
        );
        return res.toDomain(kpi);
      });
}
