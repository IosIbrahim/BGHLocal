import '../../../../core/core.dart';
import '../entity/emergency_data.dart';
import '../repository/emergency_repository.dart';

class GetEmergencyOverviewUseCase {
  final EmergencyRepository _repository;
  GetEmergencyOverviewUseCase(this._repository);

  Future<Result<EmergencyOverview>> call() =>
      _repository.getOverview();
}
