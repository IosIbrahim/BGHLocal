import '../../../../core/core.dart';
import '../entity/emergency_data.dart';
import '../repository/emergency_repository.dart';

class GetEmergencyNationalityUseCase {
  final EmergencyRepository _repository;
  GetEmergencyNationalityUseCase(this._repository);

  Future<Result<List<EmergencyNationalityEntry>>> call() =>
      _repository.getNationalityDistribution();
}
