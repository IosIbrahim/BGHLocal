import '../../../../core/core.dart';
import '../entity/revenue_data.dart';
import '../repository/revenue_repository.dart';

class GetRevenueKpiUseCase {
  final RevenueRepository _repository;
  GetRevenueKpiUseCase(this._repository);

  /// [params] is the KPI to fetch, so each counter loads independently.
  Future<Result<RevenueKpiValue>> call(RevenueKpi params) =>
      _repository.getKpi(params);
}
