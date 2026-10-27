import 'package:dr_baksh_dashboard/feature/operating/data/model/operating_response.dart';
import 'package:dr_baksh_dashboard/feature/operating/data/operationApi/operating_api.dart';
import '../../../../core/core.dart';
import '../../../../core/network/dashboard_request.dart';
import '../../domain/repository/operating_repository.dart';

class OperatingRepositoryImpl implements OperatingRepository {

  final OperatingApi _api;
  final AppPreferences _appPreferences;

  OperatingRepositoryImpl(this._api, this._appPreferences);

  DashboardRequest _build(UserSession? session, {String? kpiCode}) =>
      DashboardRequest.fromSession(
        session,
        instance<DashboardFilterStore>().filter,
        kpiCode: kpiCode,
      );

  @override
  Future<Result<OperatingResponse>> getOperationDashBoard() => safeApiCall(() async {
    final session = await _appPreferences.getUserSession();
    final res = await _api.getOperatingDashboard(_build(session).toJson());
    return res;
  });

}
