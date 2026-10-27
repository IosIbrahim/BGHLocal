import '../../../../core/core.dart';
import '../entity/inpatient_models.dart';
import '../repository/inpatient_repository.dart';

/// Fetches the ward + ICU occupancy breakdown in a single call.
class GetUnitsOccupancyUseCase {
  final InpatientRepository _repository;
  GetUnitsOccupancyUseCase(this._repository);

  Future<Result<UnitsOccupancy>> call() =>
      _repository.getUnitsOccupancy();
}
