import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../domain/entity/hr_data.dart';

/// Immutable snapshot of the HR Dashboard.
class HrState {
  /// The staff counters, keyed by KPI. Each carries its own
  /// loading / data / error state so one failure doesn't blank the others.
  final Map<HrKpi, CardState<int>> kpis;

  /// "Staff by Category" donut, derived from the category KPIs.
  final CardState<List<DonutSegment>> staffByCategory;

  const HrState({
    this.kpis = const {},
    this.staffByCategory = const CardLoading(),
  });

  CardState<int> kpi(HrKpi k) => kpis[k] ?? const CardLoading();

  HrState copyWith({
    Map<HrKpi, CardState<int>>? kpis,
    CardState<List<DonutSegment>>? staffByCategory,
  }) {
    return HrState(
      kpis: kpis ?? this.kpis,
      staffByCategory: staffByCategory ?? this.staffByCategory,
    );
  }

  /// Returns a state with a single [k] slice replaced, preserving the other
  /// KPIs' state identities.
  HrState withKpi(HrKpi k, CardState<int> value) =>
      copyWith(kpis: {...kpis, k: value});
}
