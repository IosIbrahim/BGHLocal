import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/usecase/get_main_data_usecase.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final GetMainDataUseCase _getMainData;
  final DashboardFilterStore _store;

  FilterCubit(this._getMainData, this._store)
      : super(_seed(_store.filter));

  /// Seeds the draft from the currently-applied filter so the sheet opens on
  /// the user's previous choices.
  static FilterState _seed(DashboardFilter f) => FilterState(
        selectedBranchId: f.branchId,
        selectedDateFlag: f.dateFlag,
        fromDate: f.fromDate,
        toDate: f.toDate,
      );

  Future<void> load() async {
    emit(state.copyWith(status: FilterStatus.loading));
    final result = await _getMainData();
    emit(result.when(
      success: (data) => state.copyWith(
        status: FilterStatus.loaded,
        branches: data.branches,
        periods: data.periods,
      ),
      error: (f) => state.copyWith(
        status: FilterStatus.error,
        errorMessage: f.message,
      ),
    ));
  }

  void selectBranch(String? id) => emit(
        id == null
            ? state.copyWith(clearBranch: true)
            : state.copyWith(selectedBranchId: id),
      );

  void selectPeriod(String dateFlag) =>
      emit(state.copyWith(selectedDateFlag: dateFlag));

  void setFromDate(DateTime date) => emit(state.copyWith(fromDate: date));

  void setToDate(DateTime date) => emit(state.copyWith(toDate: date));

  /// Commits the draft to the shared store. Returns the applied filter so the
  /// caller can decide whether a reload is needed.
  DashboardFilter apply() {
    final filter = DashboardFilter(
      branchId: state.selectedBranchId,
      dateFlag: state.selectedDateFlag,
      fromDate: state.fromDate,
      toDate: state.toDate,
    );
    _store.apply(filter);
    return filter;
  }
}
