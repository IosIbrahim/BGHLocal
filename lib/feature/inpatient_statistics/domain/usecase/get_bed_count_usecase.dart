import '../../../../core/core.dart';
import '../entity/inpatient_models.dart';
import '../repository/inpatient_repository.dart';

class GetBedCountUseCase {
  final InpatientRepository _repository;
  GetBedCountUseCase(this._repository);

  Future<Result<BedCount>> call() => _repository.getBedCount();
}
