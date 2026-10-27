import '../../../../core/core.dart';
import '../entity/inpatient_models.dart';
import '../repository/inpatient_repository.dart';

class GetKpiValueUseCase {
  final InpatientRepository _repository;
  GetKpiValueUseCase(this._repository);

  /// [params] is the backend KPI code to fetch (e.g. '221'), so each metric
  /// tile can load independently.
  Future<Result<KpiValue>> call(String params) =>
      _repository.getKpiValue(params);
}
