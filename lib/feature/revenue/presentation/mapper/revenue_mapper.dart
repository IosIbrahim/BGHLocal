import 'package:easy_localization/easy_localization.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../core/widgets/dashboard/metric_cards.dart';
import '../../domain/entity/revenue_data.dart';

/// Pure presentation mapper for the Revenue Dashboard.
class RevenueMapper {
  const RevenueMapper._();

  /// Shown in a counter while its KPI is still loading / has failed.
  static const _loadingText = '...';
  static const _noValue = '—';

  static List<DonutSegment> paymentSegments(
    RevenueKpiValue cash,
    RevenueKpiValue credit,
  ) =>
      [
        DonutSegment(label: 'Cash', value: cash.value, color: AppColors.green),
        DonutSegment(
            label: 'Credit', value: credit.value, color: AppColors.purple),
      ];

  /// Exactly two tiles, both showing a `KPI_TREND_PERC`: total revenue's change
  /// against the previous period, and credit's.
  ///
  /// The first tile's label uses `PREV_PERIOD_DESC`, which the backend derives
  /// from the request's `P_DATE_FLAG` — so it tracks the filter's period on its
  /// own ("vs Previous Month" → "vs Previous Year") without the app building
  /// the wording.
  static List<MetricItem> trendItems(
    CardState<RevenueKpiValue> total,
    CardState<RevenueKpiValue> credit, {
    required bool isArabic,
  }) {
    final creditLabel = AppStrings.creditRatio.tr();
    return [
      // The period wording only arrives with the response, so this tile has no
      // placeholder label to fall back on.
      _trendTile(
        total,
        (d) => AppStrings.vsPeriod.tr(args: [d.prevPeriodDesc(isArabic: isArabic)]),
      ),
      _trendTile(credit, (_) => creditLabel, placeholderLabel: creditLabel),
    ];
  }

  /// A tile showing one KPI's `KPI_TREND_PERC`, with the arrow and colour set by
  /// whether that percentage is positive or negative.
  static MetricItem _trendTile(
    CardState<RevenueKpiValue> state,
    String Function(RevenueKpiValue data) label, {
    String placeholderLabel = '',
  }) =>
      switch (state) {
        CardData(:final data) => MetricItem(
            value: fmtPercent(data.trendPercent),
            label: label(data),
            iconAsset: data.trendUp ? DashIcons.trendUp : DashIcons.trendDown,
            color: data.trendUp ? AppColors.green : AppColors.coral,
            colorEnd: data.trendUp ? AppColors.greenDark : AppColors.coralDark,
          ),
        CardLoading() => _placeholderTile(_loadingText, label: placeholderLabel),
        CardError() => _placeholderTile(_noValue, label: placeholderLabel),
      };

  static MetricItem _placeholderTile(String value, {String label = ''}) =>
      MetricItem(
        value: value,
        label: label,
        iconAsset: DashIcons.barChart,
        color: AppColors.slate,
        colorEnd: AppColors.slate,
      );

  static String kpiName(RevenueKpi kpi) => switch (kpi) {
        RevenueKpi.total => 'Total',
        RevenueKpi.cash => 'Cash',
        RevenueKpi.credit => 'Credit',
      };

  /// Renders a KPI counter, collapsing loading and error into short
  /// placeholders since [SummaryCardData] takes a plain display string.
  static String counter(CardState<RevenueKpiValue> state) => switch (state) {
        CardLoading() => _loadingText,
        CardData(:final data) => fmt(data.value),
        CardError() => _noValue,
      };

  /// Formats a raw amount as a compact currency string (e.g. "$94K", "$2.4M").
  static String fmt(double v) {
    if (v >= 1e6) return '\$${(v / 1e6).toStringAsFixed(1)}M';
    if (v >= 1e3) return '\$${(v / 1e3).toStringAsFixed(0)}K';
    return '\$${v.toStringAsFixed(0)}';
  }

  /// Signed percentage, e.g. "+12.3%" / "-92.6%".
  static String fmtPercent(double v) =>
      '${v >= 0 ? '+' : ''}${v.toStringAsFixed(1)}%';
}
