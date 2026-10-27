import '../../../../core/core.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../domain/entity/hr_data.dart';

/// Pure presentation mapper for the HR dashboard.
class HrMapper {
  const HrMapper._();

  /// Shown in a counter while its KPI is still loading / has failed.
  static const _loadingText = '...';
  static const _noValue = '—';

  // One fixed colour per staff category, matching the summary cards.
  static const categoryColors = {
    HrKpi.doctors: AppColors.green,
    HrKpi.nurses: AppColors.purple,
    HrKpi.admins: AppColors.amber,
    HrKpi.techs: AppColors.pink,
  };

  static String counter(CardState<int> state) => switch (state) {
        CardLoading() => _loadingText,
        CardData(:final data) => '$data',
        CardError() => _noValue,
      };

  static List<DonutSegment> staffSegments(Map<HrKpi, int> counts) => [
        for (final kpi in HrKpi.categories)
          DonutSegment(
            label: kpi.label,
            value: (counts[kpi] ?? 0).toDouble(),
            color: categoryColors[kpi] ?? AppColors.blue,
          ),
      ];
}
