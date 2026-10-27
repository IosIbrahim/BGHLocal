import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../domain/usecase/get_emergency_nationality_usecase.dart';
import '../../domain/usecase/get_emergency_overview_usecase.dart';
import '../../domain/usecase/get_emergency_payment_types_usecase.dart';
import '../mapper/emergency_mapper.dart';
import 'emergency_event.dart';
import 'emergency_state.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  final GetEmergencyOverviewUseCase _getOverview;
  final GetEmergencyPaymentTypesUseCase _getPaymentTypes;
  final GetEmergencyNationalityUseCase _getNationality;

  EmergencyBloc(
    this._getOverview,
    this._getPaymentTypes,
    this._getNationality,
  ) : super(const EmergencyState()) {
    // Full reloads fan out to every section concurrently; per-section events
    // reload just one card. droppable() de-dupes repeated taps / retries.
    on<EmergencyStarted>(_onLoadAll, transformer: droppable());
    on<EmergencyRefreshed>(_onLoadAll, transformer: droppable());
    on<EmergencyOverviewRequested>((e, emit) => _loadOverview(emit),
        transformer: droppable());
    on<EmergencyPaymentTypesRequested>((e, emit) => _loadPaymentTypes(emit),
        transformer: droppable());
    on<EmergencyNationalityRequested>((e, emit) => _loadNationality(emit),
        transformer: droppable());
  }

  Future<void> _onLoadAll(
      EmergencyEvent event, Emitter<EmergencyState> emit) async {
    emit(state.copyWith(
      paymentTypes: const CardLoading(),
      nationalityDistribution: const CardLoading(),
    ));
    await Future.wait([
      _loadOverview(emit),
      _loadPaymentTypes(emit),
      _loadNationality(emit),
    ]);
  }

  Future<void> _loadOverview(Emitter<EmergencyState> emit) async {
    final result = await _getOverview();
    result.when(
      success: (o) => emit(state.copyWith(
        totalEr: o.totalEr,
        saudiCount: o.saudiCount,
        nonSaudiCount: o.nonSaudiCount,
        statusBreakdown: EmergencyMapper.statusItems(o.statusBreakdown),
      )),
      // Summary has no retry affordance; a failure simply leaves the prior
      // values in place.
      error: (_) {},
    );
  }

  Future<void> _loadPaymentTypes(Emitter<EmergencyState> emit) async {
    final result = await _getPaymentTypes();
    emit(state.copyWith(
      paymentTypes: result.when(
        success: (p) => CardData(EmergencyMapper.paymentSegments(p)),
        error: (f) => CardError(
            message: f.message,
            onRetry: () => add(const EmergencyPaymentTypesRequested())),
      ),
    ));
  }

  Future<void> _loadNationality(Emitter<EmergencyState> emit) async {
    final result = await _getNationality();
    emit(state.copyWith(
      nationalityDistribution: result.when(
        success: (n) => CardData(n),
        error: (f) => CardError(
            message: f.message,
            onRetry: () => add(const EmergencyNationalityRequested())),
      ),
    ));
  }
}
