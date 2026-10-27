import '../../../../core/core.dart';
import '../entity/hr_data.dart';

/// Each KPI is fetched independently so a single failing counter doesn't blank
/// the others, and each card can retry on its own.
abstract class HrRepository {
  Future<Result<int>> getStaffCount(HrKpi kpi);
}
