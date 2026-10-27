import 'package:dr_baksh_dashboard/feature/operating/data/model/operating_response.dart';
import 'package:dr_baksh_dashboard/feature/operating/domain/repository/operating_repository.dart';

import '../../../../core/core.dart';

class GetOperationDashboardUseCase {
  final OperatingRepository _repository;
  GetOperationDashboardUseCase(this._repository);

  Future<Result<OperatingResponse>> call() =>
      _repository.getOperationDashBoard();
}
