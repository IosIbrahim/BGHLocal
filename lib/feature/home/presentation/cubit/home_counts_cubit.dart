import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../../../core/widgets/charts/models/card_state.dart';
import '../../../hr/domain/entity/hr_data.dart';
import '../../../hr/domain/usecase/get_hr_kpi_usecase.dart';
import '../../../revenue/domain/entity/revenue_data.dart';
import '../../../revenue/domain/usecase/get_revenue_kpi_usecase.dart';
import '../../../revenue/presentation/mapper/revenue_mapper.dart';
import '../../domain/usecase/get_er_patients_count_usecase.dart';
import '../../domain/usecase/get_inpatients_count_usecase.dart';
import '../models/dashboard_feature.dart';
import 'home_counts_state.dart';

class HomeCountsCubit extends Cubit<HomeCountsState> {
  final GetErPatientsCountUseCase _getErCount;
  final GetInPatientsCountUseCase _getInCount;
  final GetHrKpiUseCase _getHrKpi;
  final GetRevenueKpiUseCase _getRevenueKpi;

  HomeCountsCubit(
    this._getErCount,
    this._getInCount,
    this._getHrKpi,
    this._getRevenueKpi,
  ) : super(const HomeCountsState());

  /// The features this cubit can fetch a live count for. Adding a new live card
  /// means adding its feature here and a branch in [_fetch] — the UI stays
  /// generic.
  static const _features = [
    DashboardFeature.emergency,
    DashboardFeature.inpatient,
    DashboardFeature.hr,
    DashboardFeature.revenue,
  ];

  Future<void> loadCounts() => Future.wait(_features.map(loadCount));

  /// Loads a single feature's count. Keeps any already-loaded value on refresh
  /// (only shows a spinner when empty) so retrying one card never blanks others.
  Future<void> loadCount(DashboardFeature feature) async {
    if (state.countFor(feature) is! CardData) {
      emit(state.withCount(feature, const CardLoading()));
    }
    // The result must be awaited before `state` is read: Dart evaluates a
    // method's receiver before its arguments, so inlining the await into the
    // emit would fold this feature's result into a snapshot of the state taken
    // *before* the request, clobbering whatever the other concurrent loads
    // wrote in the meantime.
    final count = await _fetch(feature);
    emit(state.withCount(feature, count));
  }

  /// Fetches one feature's headline figure from the same use case its own
  /// dashboard uses, so the card always matches the number on that screen —
  /// HR's "Total Staff" counter and Revenue's "Total Revenue" counter.
  Future<CardState<String>> _fetch(DashboardFeature feature) async {
    void retry() => loadCount(feature);
    return switch (feature) {
      DashboardFeature.emergency =>
        (await _getErCount()).toCard(retry).mapData((v) => '$v'),
      DashboardFeature.inpatient =>
        (await _getInCount()).toCard(retry).mapData((v) => '$v'),
      DashboardFeature.hr => (await _getHrKpi(HrKpi.totalStaff))
          .toCard(retry)
          .mapData((v) => '$v'),
      DashboardFeature.revenue => (await _getRevenueKpi(RevenueKpi.total))
          .toCard(retry)
          .mapData((v) => RevenueMapper.fmt(v.value)),
      _ => throw ArgumentError('No count loader for $feature'),
    };
  }
}
