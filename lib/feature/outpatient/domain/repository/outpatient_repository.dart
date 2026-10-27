import '../../../../core/core.dart';
import '../../data/model/outpatient_response.dart';

abstract class OutpatientRepository {
  Future<Result<OutpatientResponse>> getOutPatientDashboard();
}
