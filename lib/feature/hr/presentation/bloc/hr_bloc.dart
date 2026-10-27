import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../domain/entity/hr_data.dart';
import '../../domain/usecase/get_hr_kpi_usecase.dart';
import '../mapper/hr_mapper.dart';
import 'hr_event.dart';
import 'hr_state.dart';

/// Every section of this screen is derived from the per-type staff counters:
/// the summary cards read them directly and the "Staff by Category" donut is
/// their category slice.
class HrBloc extends Bloc<HrEvent, HrState> {
  final GetHrKpiUseCase _getKpi;

  HrBloc(this._getKpi) : super(const HrState()) {
    on<HrStarted>(_onLoadAll, transformer: droppable());
    on<HrRefreshed>(_onLoadAll, transformer: droppable());
    // concurrent() so retrying one counter never blocks the others.
    on<HrKpiRequested>((e, emit) => _loadKpi(e.kpi, emit),
        transformer: concurrent());
  }

  Future<void> _onLoadAll(HrEvent event, Emitter<HrState> emit) async {
    await Future.wait(HrKpi.values.map((k) => _loadKpi(k, emit)));
  }

  Future<void> _loadKpi(HrKpi kpi, Emitter<HrState> emit) async {
    // Keep an already-loaded value on refresh; only spin when empty.
    if (state.kpi(kpi) is! CardData) {
      emit(_derive(state.withKpi(kpi, const CardLoading())));
    }
    final result = await _getKpi(kpi);
    final next = state.withKpi(kpi, result.toCard(() => add(HrKpiRequested(kpi))));
    emit(_derive(next));
  }

  /// Recomputes the donut, which is a projection of the category KPIs, so it
  /// stays consistent with whichever counters have resolved so far.
  HrState _derive(HrState s) => s.copyWith(staffByCategory: _donut(s));

  /// The donut needs every category count; it surfaces the first failed one
  /// and retries only that KPI.
  CardState<List<DonutSegment>> _donut(HrState s) {
    final slices = {for (final k in HrKpi.categories) k: s.kpi(k)};

    for (final entry in slices.entries) {
      if (entry.value case CardError(:final message)) {
        return CardError(
          message: message,
          onRetry: () => add(HrKpiRequested(entry.key)),
        );
      }
    }
    if (slices.values.every((v) => v is CardData<int>)) {
      return CardData(HrMapper.staffSegments(
          slices.map((k, v) => MapEntry(k, (v as CardData<int>).data))));
    }
    return const CardLoading();
  }
}
