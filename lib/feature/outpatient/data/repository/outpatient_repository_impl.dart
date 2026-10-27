import 'package:dr_baksh_dashboard/feature/outpatient/data/outPatientApi/outpatient_api.dart';

import '../../../../core/core.dart';
import '../../../../core/network/dashboard_request.dart';
import '../../domain/repository/outpatient_repository.dart';
import '../model/outpatient_response.dart';

class OutpatientRepositoryImpl implements OutpatientRepository {
  final OutpatientApi _api;
  final AppPreferences _appPreferences;

  OutpatientRepositoryImpl(this._api, this._appPreferences);

  DashboardRequest _build(UserSession? session, {String? kpiCode}) =>
      DashboardRequest.fromSession(
        session,
        instance<DashboardFilterStore>().filter,
        kpiCode: kpiCode,
      );

  @override
  Future<Result<OutpatientResponse>> getOutPatientDashboard() => safeApiCall(() async {
    final session = await _appPreferences.getUserSession();
    final res = await _api.getOutpatientDashboard(_build(session).toJson());
    return res;
  });

}
