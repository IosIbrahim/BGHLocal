import '../../../../core/error/result.dart';
import '../repository/home_repository.dart';

class GetErPatientsCountUseCase {
  final HomeRepository _repository;
  GetErPatientsCountUseCase(this._repository);

  Future<Result<int>> call() => _repository.getErPatientsCount();
}
