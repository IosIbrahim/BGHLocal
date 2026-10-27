import 'package:dr_baksh_dashboard/feature/operating/data/model/operating_response.dart';

import '../../../../core/core.dart';


abstract class OperatingRepository {
  Future<Result<OperatingResponse>> getOperationDashBoard();
}
