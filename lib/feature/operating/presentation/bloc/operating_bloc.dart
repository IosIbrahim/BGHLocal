import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dr_baksh_dashboard/core/core.dart';
import 'package:dr_baksh_dashboard/feature/operating/domain/usecase/get_operation_dashboard_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/charts/dashboard_charts.dart';
import 'operating_event.dart';
import 'operating_state.dart';


class OperatingBloc extends Bloc<OperatingEvent, OperatingState> {
  final GetOperationDashboardUseCase _getOperationDashboardUseCase;

  OperatingBloc(this._getOperationDashboardUseCase)
      : super(OperatingState.initial()) {
    on<OperatingStarted>(_onLoadAll, transformer: droppable());
    on<OperatingRefreshed>(_onLoadAll, transformer: droppable());
  }

  Future<void> _onLoadAll(
      OperatingEvent event, Emitter<OperatingState> emit) async {
    emit(state.copyWith(isRefreshing: true));
    await Future.wait([
      _loadOperationDashboard(emit),
    ]);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _loadOperationDashboard(Emitter<OperatingState> emit) async {
    if (state is! CardData) {
      emit(state.copyWith(operationResponse: const CardLoading()));
    }
    final result = await _getOperationDashboardUseCase();
    emit(state.copyWith(
      operationResponse: result.toCard(() => add(const OperationDashboardRequested())),
    ));
  }
}
