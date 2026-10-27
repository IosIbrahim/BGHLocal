import '../../../../core/widgets/charts/models/card_state.dart';
import '../../domain/entity/inpatient_models.dart';

/// Composite state holding an independent [CardState] per dashboard section, so
/// each can load / error / retry on its own.
class InpatientState {
  final CardState<BedCount> bedCount;
  final CardState<BedStatus> bedStatus;
  final CardState<List<WardOccupancy>> wards;
  final CardState<List<WardOccupancy>> icus;

  /// One [CardState] per KPI, keyed by [InpatientKpi], so each metric tile
  /// loads / errors / retries on its own instead of as a single row.
  final Map<InpatientKpi, CardState<KpiValue>> kpis;

  /// True while a full reload (initial load or pull-to-refresh) is in flight.
  /// The screen awaits this returning to false to dismiss the refresh spinner.
  final bool isRefreshing;

  const InpatientState({
    required this.bedCount,
    required this.bedStatus,
    required this.wards,
    required this.icus,
    required this.kpis,
    this.isRefreshing = false,
  });

  factory InpatientState.initial() => InpatientState(
        bedCount: const CardLoading(),
        bedStatus: const CardLoading(),
        wards: const CardLoading(),
        icus: const CardLoading(),
        kpis: {
          for (final kpi in InpatientKpi.values) kpi: const CardLoading(),
        },
      );

  /// Unchanged slices keep their identity, so per-section `BlocSelector`s only
  /// rebuild when their own slice changes.
  InpatientState copyWith({
    CardState<BedCount>? bedCount,
    CardState<BedStatus>? bedStatus,
    CardState<List<WardOccupancy>>? wards,
    CardState<List<WardOccupancy>>? icus,
    Map<InpatientKpi, CardState<KpiValue>>? kpis,
    bool? isRefreshing,
  }) =>
      InpatientState(
        bedCount: bedCount ?? this.bedCount,
        bedStatus: bedStatus ?? this.bedStatus,
        wards: wards ?? this.wards,
        icus: icus ?? this.icus,
        kpis: kpis ?? this.kpis,
        isRefreshing: isRefreshing ?? this.isRefreshing,
      );
}
