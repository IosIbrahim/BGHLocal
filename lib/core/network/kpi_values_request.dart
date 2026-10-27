import '../dashboard/dashboard_filter.dart';
import '../session/user_session.dart';

/// Request body for `GETKPIVALUES`.
///
/// Kept separate from `DashboardRequest` because this endpoint's contract
/// genuinely differs: it takes `P_BRANCHES` where the others take `BRANCH_ID`.
/// (`P_COMPARE_TYPE` is shared — `DashboardRequest` carries it too, for the
/// inpatient `GetKPIValues` call — but the branch key is not.)
class KpiValuesRequest {
  final String? hospId;
  final String? pBranches;
  final String? userId;
  final String? pDateFlag;
  final String kpiCode;
  final int pCompareType;
  final String? pFromDate;
  final String? pToDate;

  /// 1 = compare the current period against the previous one.
  static const compareToPreviousPeriod = 1;

  const KpiValuesRequest({
    required this.kpiCode,
    this.hospId,
    this.pBranches,
    this.userId,
    this.pDateFlag,
    this.pCompareType = compareToPreviousPeriod,
    this.pFromDate,
    this.pToDate,
  });

  /// Builds the body from an already-loaded [session] with the active dashboard
  /// filter overlaid. `HOSP_ID` and `P_BRANCHES` both carry the selected branch.
  factory KpiValuesRequest.fromSession(
    UserSession? session,
    DashboardFilter filter, {
    required String kpiCode,
    int pCompareType = compareToPreviousPeriod,
  }) {
    final branch = filter.branchId ?? session?.defaultBranch;
    return KpiValuesRequest(
      kpiCode: kpiCode,
      hospId: branch,
      pBranches: branch,
      userId: session?.userId,
      pDateFlag: filter.dateFlag,
      pCompareType: pCompareType,
      pFromDate: filter.isPeriod ? filter.fromDateApi : null,
      pToDate: filter.isPeriod ? filter.toDateApi : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (hospId != null) 'HOSP_ID': hospId,
        if (pBranches != null) 'P_BRANCHES': pBranches,
        if (userId != null) 'USER_ID': userId,
        if (pDateFlag != null) 'P_DATE_FLAG': pDateFlag,
        'KPI_CODE': kpiCode,
        'P_COMPARE_TYPE': pCompareType,
        if (pFromDate != null) 'P_FROM_DATE': pFromDate,
        if (pToDate != null) 'P_TO_DATE': pToDate,
      };
}
