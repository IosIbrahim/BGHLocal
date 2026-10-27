import '../../../../core/core.dart';
import '../../data/model/outpatient_response.dart';
import '../repository/outpatient_repository.dart';

class GetOutpatientDashboardUseCase {
  final OutpatientRepository _repository;
  GetOutpatientDashboardUseCase(this._repository);

  Future<Result<OutpatientResponse>> call() =>
      _repository.getOutPatientDashboard();
}
