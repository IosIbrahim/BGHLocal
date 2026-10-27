import '../dashboard/dashboard_filter.dart';
import '../session/user_session.dart';

/// Shared request body for every dashboard API endpoint.
class DashboardRequest {
  final String? hospId;
  final String? branchId;
  final String? userId;
  final String? pDateFlag;
  final String? deptType;
  final String? kpiCode;

  /// Only the `GetKPIValues` endpoint reads this; left null everywhere else so
  /// the other endpoints' bodies stay exactly as they were.
  /// Same encoding as `KpiValuesRequest.compareToPreviousPeriod` (1 = compare
  /// the current period against the previous one).
  final int? pCompareType;

  final String? pFromDate;
  final String? pToDate;

  const DashboardRequest({
    this.hospId,
    this.branchId,
    this.userId,
    this.pDateFlag,
    this.deptType,
    this.kpiCode,
    this.pCompareType,
    this.pFromDate,
    this.pToDate,
  });

  factory DashboardRequest.fromSession(
    UserSession? session,
    DashboardFilter filter, {
    String? deptType,
    String? kpiCode,
    int? pCompareType,
  }) =>
      DashboardRequest(
        hospId: filter.branchId ?? session?.defaultBranch,
        branchId: filter.branchId ?? session?.defaultBranch,
        userId: session?.userId,
        pDateFlag: filter.dateFlag,
        deptType: deptType,
        kpiCode: kpiCode,
        pCompareType: pCompareType,
        pFromDate: filter.isPeriod ? filter.fromDateApi : null,
        pToDate: filter.isPeriod ? filter.toDateApi : null,
      );

  Map<String, dynamic> toJson() => {
        if (hospId != null) 'HOSP_ID': hospId,
        if (branchId != null) 'BRANCH_ID': branchId,
        if (userId != null) 'USER_ID': userId,
        if (pDateFlag != null) 'P_DATE_FLAG': pDateFlag,
        if (deptType != null) 'DEPT_TYPE': deptType,
        if (kpiCode != null) 'KPI_CODE': kpiCode,
        if (pCompareType != null) 'P_COMPARE_TYPE': pCompareType,
        if (pFromDate != null) 'P_FROM_DATE': pFromDate,
        if (pToDate != null) 'P_TO_DATE': pToDate,
      };
}
