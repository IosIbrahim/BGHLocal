import 'package:easy_localization/easy_localization.dart';

import '../constants/app_constants.dart';

class DashboardFilter {
  final String? branchId;
  final String dateFlag;
  final DateTime? fromDate;
  final DateTime? toDate;

  const DashboardFilter({
    this.branchId,
    this.dateFlag = AppConstants.todayDateFlag,
    this.fromDate,
    this.toDate,
  });

  /// The app default: Today, default branch, no custom range.
  static const initial = DashboardFilter();

  bool get isPeriod => dateFlag == AppConstants.periodDateFlag;

  // The backend expects P_FROM_DATE / P_TO_DATE as dd/MM/yyyy.
  String get fromDateApi => _fmt(fromDate);
  String get toDateApi => _fmt(toDate);

  static String _fmt(DateTime? d) =>
      d == null ? '' : DateFormat('dd/MM/yyyy').format(d);

  DashboardFilter copyWith({
    String? branchId,
    String? dateFlag,
    DateTime? fromDate,
    DateTime? toDate,
  }) =>
      DashboardFilter(
        branchId: branchId ?? this.branchId,
        dateFlag: dateFlag ?? this.dateFlag,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
      );

  @override
  bool operator ==(Object other) =>
      other is DashboardFilter &&
      other.branchId == branchId &&
      other.dateFlag == dateFlag &&
      other.fromDate == fromDate &&
      other.toDate == toDate;

  @override
  int get hashCode => Object.hash(branchId, dateFlag, fromDate, toDate);
}
