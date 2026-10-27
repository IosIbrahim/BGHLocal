import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../domain/entity/revenue_data.dart';

/// Immutable snapshot of the Revenue Dashboard.
class RevenueState {
  /// The three KPI counters, keyed by KPI. Each carries its own
  /// loading / data / error state so one failure doesn't blank the others.
  final Map<RevenueKpi, CardState<RevenueKpiValue>> kpis;

  /// "Cash vs Credit" donut (raw values; formatted as currency by the chart).
  final CardState<List<DonutSegment>> cashVsCredit;

  const RevenueState({
    this.kpis = const {},
    this.cashVsCredit = const CardLoading(),
  });

  CardState<RevenueKpiValue> kpi(RevenueKpi k) =>
      kpis[k] ?? const CardLoading();

  RevenueState copyWith({
    Map<RevenueKpi, CardState<RevenueKpiValue>>? kpis,
    CardState<List<DonutSegment>>? cashVsCredit,
  }) {
    return RevenueState(
      kpis: kpis ?? this.kpis,
      cashVsCredit: cashVsCredit ?? this.cashVsCredit,
    );
  }

  /// Returns a state with a single [k] slice replaced, preserving the other
  /// KPIs' state identities.
  RevenueState withKpi(RevenueKpi k, CardState<RevenueKpiValue> value) =>
      copyWith(kpis: {...kpis, k: value});
}
