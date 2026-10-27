import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../domain/entity/revenue_data.dart';
import '../../domain/usecase/get_revenue_kpi_usecase.dart';
import '../mapper/revenue_mapper.dart';
import 'revenue_event.dart';
import 'revenue_state.dart';

/// Every section of this screen is derived from the three `GETKPIVALUES`
/// readings: the counters use `PERIODVALUE_EN`, the donut uses the cash/credit
/// values, and the trend tiles use `KPI_TREND_PERC`.
class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  final GetRevenueKpiUseCase _getKpi;

  RevenueBloc(this._getKpi) : super(const RevenueState()) {
    on<RevenueStarted>(_onLoadAll, transformer: droppable());
    on<RevenueRefreshed>(_onLoadAll, transformer: droppable());
    // concurrent() so retrying one counter never blocks the others.
    on<RevenueKpiRequested>((e, emit) => _loadKpi(e.kpi, emit),
        transformer: concurrent());
  }

  Future<void> _onLoadAll(
      RevenueEvent event, Emitter<RevenueState> emit) async {
    await Future.wait(RevenueKpi.values.map((k) => _loadKpi(k, emit)));
  }

  Future<void> _loadKpi(RevenueKpi kpi, Emitter<RevenueState> emit) async {
    // Keep an already-loaded value on refresh; only spin when empty.
    if (state.kpi(kpi) is! CardData) {
      emit(_derive(state.withKpi(kpi, const CardLoading())));
    }
    final result = await _getKpi(kpi);
    final next =
        state.withKpi(kpi, result.toCard(() => add(RevenueKpiRequested(kpi))));
    emit(_derive(next));
  }

  /// Recomputes the sections that are projections of the KPI readings, so they
  /// stay consistent with whichever KPIs have resolved so far.
  RevenueState _derive(RevenueState s) => s.copyWith(cashVsCredit: _donut(s));

  /// The donut needs both cash and credit, so it surfaces whichever of the two
  /// failed and retries only that KPI.
  CardState<List<DonutSegment>> _donut(RevenueState s) {
    final cash = s.kpi(RevenueKpi.cash);
    final credit = s.kpi(RevenueKpi.credit);

    return switch ((cash, credit)) {
      (CardError(:final message), _) => CardError(
          message: message,
          onRetry: () => add(const RevenueKpiRequested(RevenueKpi.cash)),
        ),
      (_, CardError(:final message)) => CardError(
          message: message,
          onRetry: () => add(const RevenueKpiRequested(RevenueKpi.credit)),
        ),
      (CardData(data: final c), CardData(data: final cr)) =>
        CardData(RevenueMapper.paymentSegments(c, cr)),
      _ => const CardLoading(),
    };
  }
}
