import '../../../../core/error/result.dart';
import '../repository/home_repository.dart';

class GetInPatientsCountUseCase {
  final HomeRepository _repository;
  GetInPatientsCountUseCase(this._repository);

  Future<Result<int>> call() => _repository.getInPatientsCount();
}
