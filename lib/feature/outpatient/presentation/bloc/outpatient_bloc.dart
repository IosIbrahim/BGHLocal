import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dr_baksh_dashboard/core/core.dart';
import 'package:dr_baksh_dashboard/feature/outpatient/domain/usecase/get_outpatient_dashboard_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/charts/dashboard_charts.dart';
import 'outpatient_event.dart';
import 'outpatient_state.dart';

class OutpatientBloc extends Bloc<OutpatientEvent, OutpatientState> {

  final GetOutpatientDashboardUseCase _getOutpatientDashboardUseCase;

  OutpatientBloc(
    this._getOutpatientDashboardUseCase
  ) : super(OutpatientState.initial()) {
    on<OutpatientStarted>(_onLoadAll, transformer: droppable());
    on<OutpatientRefreshed>(_onLoadAll, transformer: droppable());
  }

  Future<void> _onLoadAll(
      OutpatientEvent event, Emitter<OutpatientState> emit) async {
    emit(state.copyWith(isRefreshing: true));
    await Future.wait([
      _loadOutPatientDashboard(emit),
    ]);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _loadOutPatientDashboard(Emitter<OutpatientState> emit) async {
    if (state is! CardData) {
      emit(state.copyWith(outPatientResponse: const CardLoading()));
    }
    final result = await _getOutpatientDashboardUseCase();
    emit(state.copyWith(
      outPatientResponse: result.toCard(() => add(const OutpatientDashboardRequested())),
    ));
  }

}
