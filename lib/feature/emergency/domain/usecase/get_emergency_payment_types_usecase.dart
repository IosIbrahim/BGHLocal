import '../../../../core/core.dart';
import '../entity/emergency_data.dart';
import '../repository/emergency_repository.dart';

class GetEmergencyPaymentTypesUseCase {
  final EmergencyRepository _repository;
  GetEmergencyPaymentTypesUseCase(this._repository);

  Future<Result<EmergencyPayments>> call() =>
      _repository.getPaymentTypes();
}
