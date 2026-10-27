import '../../../../core/core.dart';
import '../entity/filter_options.dart';
import '../repository/filter_repository.dart';

class GetMainDataUseCase {
  final FilterRepository _repository;
  GetMainDataUseCase(this._repository);

  Future<Result<MainData>> call() => _repository.getMainData();
}
