import '../../../../core/utils/converters.dart';
import '../../domain/entity/revenue_data.dart';

/// Response for `GETKPIVALUES`.
///
/// Unlike most dashboard endpoints this one has no `Root` wrapper — the body is
/// the envelope itself:
/// ```json
/// { "KPI_VALUES": { "KPI_VALUES_ROW": { "KPI_CODE": "229", ... } } }
/// ```
/// [unwrapObject] walks both single-key levels down to the row.
class KpiValuesResponse {
  final double periodValue;
  final double previousPeriodValue;
  final double trendPercent;

  /// Period descriptions come in both languages; the numeric fields don't need
  /// to (`PERIODVALUE_AR` carries the same Latin-digit string as `_EN`).
  final String prevPeriodDescEn;
  final String prevPeriodDescAr;
  final String currPeriodDescEn;
  final String currPeriodDescAr;
  final String suffix;

  const KpiValuesResponse({
    required this.periodValue,
    required this.previousPeriodValue,
    required this.trendPercent,
    required this.prevPeriodDescEn,
    required this.prevPeriodDescAr,
    required this.currPeriodDescEn,
    required this.currPeriodDescAr,
    required this.suffix,
  });

  factory KpiValuesResponse.fromJson(Map<String, dynamic> json) {
    final row = unwrapObject(json);
    return KpiValuesResponse(
      periodValue: asDouble(row['PERIODVALUE_EN']),
      previousPeriodValue: asDouble(row['PREVIOUS_PERIODVALUE_EN']),
      trendPercent: asDouble(row['KPI_TREND_PERC']),
      prevPeriodDescEn: asStr(row['PREV_PERIOD_DESC_EN']),
      prevPeriodDescAr: asStr(row['PREV_PERIOD_DESC_AR']),
      currPeriodDescEn: asStr(row['CURR_PERIOD_DESC_EN']),
      currPeriodDescAr: asStr(row['CURR_PERIOD_DESC_AR']),
      // SUFFIX_* arrives as null when the KPI has no unit.
      suffix: asStr(row['SUFFIX_EN']),
    );
  }

  /// [kpi] is the requested code — the row carries its own `KPI_CODE`, but
  /// tagging with the request keeps the value bound to the tile that asked.
  RevenueKpiValue toDomain(RevenueKpi kpi) => RevenueKpiValue(
        kpi: kpi,
        value: periodValue,
        previousValue: previousPeriodValue,
        trendPercent: trendPercent,
        prevPeriodDescEn: prevPeriodDescEn,
        prevPeriodDescAr: prevPeriodDescAr,
        currPeriodDescEn: currPeriodDescEn,
        currPeriodDescAr: currPeriodDescAr,
        suffix: suffix,
      );
}
