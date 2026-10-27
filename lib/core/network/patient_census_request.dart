import '../dashboard/dashboard_filter.dart';
import '../session/user_session.dart';
import 'dashboard_request.dart';

/// Request body for the `NewDashBoard/GetPatientCensus*` endpoints.
///
/// Same params as the shared [DashboardRequest] plus `DB_SER`, the dataset
/// selector that picks which census breakdown the endpoint returns (e.g. 8 =
/// ER census by nationality). Wraps [DashboardRequest] rather than extending
/// it so the shared body stays free of endpoint-specific fields.
class PatientCensusRequest {
  final DashboardRequest base;
  final int dbSer;

  const PatientCensusRequest({required this.base, required this.dbSer});

  factory PatientCensusRequest.fromSession(
    UserSession? session,
    DashboardFilter filter, {
    required int dbSer,
    String? deptType,
  }) =>
      PatientCensusRequest(
        base: DashboardRequest.fromSession(session, filter, deptType: deptType),
        dbSer: dbSer,
      );

  Map<String, dynamic> toJson() => {
        ...base.toJson(),
        'DB_SER': dbSer,
      };
}
