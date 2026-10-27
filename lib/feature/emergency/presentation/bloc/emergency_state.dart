import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../../core/widgets/dashboard/status_item.dart';
import '../../domain/entity/emergency_data.dart';

/// Immutable snapshot of the Emergency Room dashboard.
///
/// Chart sections are exposed as [CardState] so the reusable chart cards in
/// `core/widgets/charts` can render loading / error / data states directly.
class EmergencyState {
  /// Top summary counters.
  final int totalEr;
  final int saudiCount;
  final int nonSaudiCount;

  /// "Payment Types" donut (Cash vs Credit).
  final CardState<List<DonutSegment>> paymentTypes;

  /// "Status Breakdown" grid tiles.
  final List<StatusItem> statusBreakdown;

  /// "Nationality Distribution" bar chart. Kept as domain entries (not
  /// [BarItem]s) so the screen can pick the AR/EN name per locale at render.
  final CardState<List<EmergencyNationalityEntry>> nationalityDistribution;

  const EmergencyState({
    this.totalEr = 0,
    this.saudiCount = 0,
    this.nonSaudiCount = 0,
    this.paymentTypes = const CardLoading(),
    this.statusBreakdown = const [],
    this.nationalityDistribution = const CardLoading(),
  });

  EmergencyState copyWith({
    int? totalEr,
    int? saudiCount,
    int? nonSaudiCount,
    CardState<List<DonutSegment>>? paymentTypes,
    List<StatusItem>? statusBreakdown,
    CardState<List<EmergencyNationalityEntry>>? nationalityDistribution,
  }) {
    return EmergencyState(
      totalEr: totalEr ?? this.totalEr,
      saudiCount: saudiCount ?? this.saudiCount,
      nonSaudiCount: nonSaudiCount ?? this.nonSaudiCount,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      nationalityDistribution:
          nationalityDistribution ?? this.nationalityDistribution,
    );
  }
}
