/// The revenue KPIs fetched from `GETKPIVALUES`, with their backend codes.
enum RevenueKpi {
  total('229'),
  cash('249'),
  credit('250'),
  outPatient('260'),
  inPatient('260');


  final String code;
  const RevenueKpi(this.code);
}

/// One KPI reading: the current-period amount plus its change vs the previous
/// period.
class RevenueKpiValue {
  final RevenueKpi kpi;

  /// `PERIODVALUE_EN` — drives both the summary counter and the donut segment.
  final double value;

  /// `PREVIOUS_PERIODVALUE_EN`.
  final double previousValue;

  /// `KPI_TREND_PERC` — signed percentage change (e.g. -92.61).
  final double trendPercent;

  /// `PREV_PERIOD_DESC_*` / `CURR_PERIOD_DESC_*` (e.g. "Previous Month").
  final String prevPeriodDescEn;
  final String prevPeriodDescAr;
  final String currPeriodDescEn;
  final String currPeriodDescAr;

  /// `SUFFIX_EN`; empty when the KPI carries no unit.
  final String suffix;

  const RevenueKpiValue({
    required this.kpi,
    required this.value,
    required this.previousValue,
    required this.trendPercent,
    required this.prevPeriodDescEn,
    required this.prevPeriodDescAr,
    required this.currPeriodDescEn,
    required this.currPeriodDescAr,
    required this.suffix,
  });

  /// Falls back to the other language when the requested one is blank, so a
  /// missing translation shows the period rather than an empty title.
  String prevPeriodDesc({required bool isArabic}) =>
      _pick(prevPeriodDescAr, prevPeriodDescEn, isArabic);

  String currPeriodDesc({required bool isArabic}) =>
      _pick(currPeriodDescAr, currPeriodDescEn, isArabic);

  static String _pick(String ar, String en, bool isArabic) {
    final primary = isArabic ? ar : en;
    if (primary.isNotEmpty) return primary;
    return isArabic ? en : ar;
  }

  /// Derived from the sign of [trendPercent] rather than the `KPI_TREND` code,
  /// whose encoding isn't documented (the sample returns "3" for a decrease).
  bool get trendUp => trendPercent >= 0;
}

/// Domain data for the Revenue Dashboard.
///
/// Fetched per section (overview / cash-vs-credit) so each card loads and
/// retries independently. [RevenueData] is the aggregate shape kept for the
/// (future) single-call API + response mapping.
class RevenueData {
  final double totalRevenue;
  final double cashAmount;
  final double creditAmount;
  final List<RevenueTrendEntry> trends;

  const RevenueData({
    required this.totalRevenue,
    required this.cashAmount,
    required this.creditAmount,
    required this.trends,
  });
}

/// Summary totals + monthly-trend tiles (one section / endpoint).
class RevenueOverview {
  final double totalRevenue;
  final double cashAmount;
  final double creditAmount;
  final List<RevenueTrendEntry> trends;

  const RevenueOverview({
    required this.totalRevenue,
    required this.cashAmount,
    required this.creditAmount,
    required this.trends,
  });
}

/// Cash vs credit amounts for the donut (one section / endpoint).
class RevenuePayments {
  final double cashAmount;
  final double creditAmount;

  const RevenuePayments({
    required this.cashAmount,
    required this.creditAmount,
  });
}

/// One monthly-trend tile in the Revenue Dashboard.
///
/// [value] is already a formatted display string (e.g. "+18%", "-5%").
class RevenueTrendEntry {
  final String label;
  final String value;
  final bool trendUp;

  const RevenueTrendEntry({
    required this.label,
    required this.value,
    required this.trendUp,
  });
}
