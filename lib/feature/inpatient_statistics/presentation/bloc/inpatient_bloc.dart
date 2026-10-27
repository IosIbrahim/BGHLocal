import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/charts/models/card_state.dart';
import '../../domain/entity/inpatient_models.dart';
import '../../domain/usecase/get_bed_count_usecase.dart';
import '../../domain/usecase/get_current_bed_status_usecase.dart';
import '../../domain/usecase/get_kpi_value_usecase.dart';
import '../../domain/usecase/get_units_occupancy_usecase.dart';
import 'inpatient_event.dart';
import 'inpatient_state.dart';

class InpatientBloc extends Bloc<InpatientEvent, InpatientState> {
  final GetBedCountUseCase _getBedCount;
  final GetCurrentBedStatusUseCase _getBedStatus;
  final GetUnitsOccupancyUseCase _getUnitsOccupancy;
  final GetKpiValueUseCase _getKpi;

  InpatientBloc(
    this._getBedCount,
    this._getBedStatus,
    this._getUnitsOccupancy,
    this._getKpi,
  ) : super(InpatientState.initial()) {
    // Full reloads run all sections concurrently and are awaitable via
    // [InpatientState.isRefreshing]; droppable() ignores a second reload while
    // one is already running.
    on<InpatientStarted>(_onLoadAll, transformer: droppable());
    on<InpatientRefreshed>(_onLoadAll, transformer: droppable());
    // Per-section retry events; droppable() de-dupes Retry spam.
    on<BedCountRequested>((e, emit) => _loadBedCount(emit),
        transformer: droppable());
    on<BedStatusRequested>((e, emit) => _loadBedStatus(emit),
        transformer: droppable());
    on<UnitsRequested>((e, emit) => _loadUnits(emit), transformer: droppable());
    // concurrent() so retrying one KPI tile never blocks loading/retrying the
    // other — each runs independently.
    on<KpiRequested>((e, emit) => _loadKpi(e.kpi, emit),
        transformer: concurrent());
  }

  Future<void> _onLoadAll(
      InpatientEvent event, Emitter<InpatientState> emit) async {
    emit(state.copyWith(isRefreshing: true));
    await Future.wait([
      _loadBedCount(emit),
      _loadBedStatus(emit),
      _loadUnits(emit),
      _loadKpis(emit),
    ]);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _loadBedCount(Emitter<InpatientState> emit) async {
    // Keep showing existing data on refresh; only show a spinner when empty.
    if (state.bedCount is! CardData) {
      emit(state.copyWith(bedCount: const CardLoading()));
    }
    final result = await _getBedCount();
    emit(state.copyWith(
      bedCount: result.toCard(() => add(const BedCountRequested())),
    ));
  }

  Future<void> _loadBedStatus(Emitter<InpatientState> emit) async {
    if (state.bedStatus is! CardData) {
      emit(state.copyWith(bedStatus: const CardLoading()));
    }
    final result = await _getBedStatus();
    emit(state.copyWith(
      bedStatus: result.toCard(() => add(const BedStatusRequested())),
    ));
  }

  /// One `GetCurrentBedStatusData` call fills both the wards and ICU slices, so
  /// they share a load/error lifecycle and a single retry event.
  Future<void> _loadUnits(Emitter<InpatientState> emit) async {
    if (state.wards is! CardData || state.icus is! CardData) {
      emit(state.copyWith(
        wards: state.wards is! CardData ? const CardLoading() : state.wards,
        icus: state.icus is! CardData ? const CardLoading() : state.icus,
      ));
    }
    final result = await _getUnitsOccupancy();
    void retry() => add(const UnitsRequested());
    emit(state.copyWith(
      wards: result.map((u) => u.wards).toCard(retry),
      icus: result.map((u) => u.icus).toCard(retry),
    ));
  }

  /// Fans out to every KPI; each [_loadKpi] emits on its own as it resolves so
  /// the tiles draw independently rather than waiting for the slowest one.
  Future<void> _loadKpis(Emitter<InpatientState> emit) async {
    await Future.wait(
      InpatientKpi.values.map((kpi) => _loadKpi(kpi, emit)),
    );
  }

  Future<void> _loadKpi(InpatientKpi kpi, Emitter<InpatientState> emit) async {
    // Keep showing existing data on refresh; only show a spinner when empty.
    if (state.kpis[kpi] is! CardData) {
      emit(_withKpi(kpi, const CardLoading()));
    }
    final result = await _getKpi(kpi.code);
    emit(_withKpi(kpi, result.toCard(() => add(KpiRequested(kpi)))));
  }

  /// Returns a state with a single [kpi] slice replaced, preserving the other
  /// tiles' [CardState] identities so their `BlocSelector`s don't rebuild.
  InpatientState _withKpi(InpatientKpi kpi, CardState<KpiValue> value) =>
      state.copyWith(kpis: {...state.kpis, kpi: value});
}
