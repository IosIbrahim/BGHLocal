import '../../../../core/core.dart';
import '../entity/hr_data.dart';
import '../repository/hr_repository.dart';

class GetHrKpiUseCase {
  final HrRepository _repository;
  GetHrKpiUseCase(this._repository);

  /// [params] is the KPI to fetch, so each counter loads independently.
  Future<Result<int>> call(HrKpi params) => _repository.getStaffCount(params);
}
