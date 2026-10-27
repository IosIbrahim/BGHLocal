import '../../../../core/core.dart';
import '../entity/inpatient_models.dart';
import '../repository/inpatient_repository.dart';

class GetCurrentBedStatusUseCase {
  final InpatientRepository _repository;
  GetCurrentBedStatusUseCase(this._repository);

  Future<Result<BedStatus>> call() =>
      _repository.getCurrentBedStatus();
}
