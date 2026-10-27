import '../../../../core/core.dart';
import '../../../../core/network/dashboard_request.dart';
import '../../domain/entity/hr_data.dart';
import '../../domain/repository/hr_repository.dart';
import '../hr_api.dart';
import '../model/hr_response.dart';

class HrRepositoryImpl implements HrRepository {
  final HrApi _api;
  final AppPreferences _appPreferences;

  HrRepositoryImpl(this._api, this._appPreferences);

  Future<DashboardRequest> _build() async {
    final session = await _appPreferences.getUserSession();
    return DashboardRequest.fromSession(
      session,
      instance<DashboardFilterStore>().filter,
    );
  }

  Future<HrKpiCountResponse> _fetch(HrKpi kpi, DashboardRequest request) =>
      switch (kpi) {
        HrKpi.totalStaff => _api.getEmployeeCount(request),
        HrKpi.doctors => _api.getDoctorCount(request),
        HrKpi.nurses => _api.getNurseCount(request),
        HrKpi.admins => _api.getAdminCount(request),
        HrKpi.techs => _api.getTechCount(request),
      };

  @override
  Future<Result<int>> getStaffCount(HrKpi kpi) => safeApiCall(() async {
        final res = await _fetch(kpi, await _build());
        return res.countFor(kpi);
      });
}
