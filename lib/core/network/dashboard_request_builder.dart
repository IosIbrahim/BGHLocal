import '../dashboard/dashboard_filter_store.dart';
import '../di/di.dart';
import '../session/user_session.dart';
import 'dashboard_request.dart';
import 'patient_census_request.dart';

/// Builds the shared dashboard request body from a [UserSession] overlaid with
/// the active [DashboardFilterStore] filter (branch / date-flag / range).
///
/// Mix into any repository that talks to the `NewDashBoard/*` endpoints so the
/// session + filter wiring lives in one place rather than being copy-pasted per
/// repository.
mixin DashboardRequestBuilder {
  DashboardRequest buildDashboardRequest(
    UserSession? session, {
    String? deptType,
    String? kpiCode,
    int? pCompareType,
  }) =>
      DashboardRequest.fromSession(
        session,
        instance<DashboardFilterStore>().filter,
        deptType: deptType,
        kpiCode: kpiCode,
        pCompareType: pCompareType,
      );

  /// Same body as [buildDashboardRequest] plus the `DB_SER` dataset selector
  /// the `GetPatientCensus*` endpoints require.
  PatientCensusRequest buildPatientCensusRequest(
    UserSession? session, {
    required int dbSer,
    String? deptType,
  }) =>
      PatientCensusRequest.fromSession(
        session,
        instance<DashboardFilterStore>().filter,
        dbSer: dbSer,
        deptType: deptType,
      );
}
