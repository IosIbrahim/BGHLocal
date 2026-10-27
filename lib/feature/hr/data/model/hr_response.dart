import '../../../../core/utils/converters.dart';
import '../../domain/entity/hr_data.dart';

/// Response of the `NewDashBoard/kpi_cover_*_no_graph` endpoints — a single
/// counter keyed per staff type, e.g. `{ "V_DOCTOR_NO": "86" }`.
///
/// The row is kept raw and read by the requested KPI's key, so a response that
/// ever grows extra fields still resolves the right counter.
class HrKpiCountResponse {
  final Map<String, dynamic> row;

  const HrKpiCountResponse(this.row);

  factory HrKpiCountResponse.fromJson(Map<String, dynamic> json) =>
      HrKpiCountResponse(unwrapObject(json));

  int countFor(HrKpi kpi) => asInt(row[kpi.responseKey]);
}
