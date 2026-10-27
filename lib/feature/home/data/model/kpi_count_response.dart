import '../../../../core/utils/converters.dart';

/// Shared response model for `GetERPatientsCount` and `GetInPatientsCount`.
///
/// Both endpoints return:
/// { "Root": { "OUT_PARMS": { "OUT_PARMS_ROW": { "KPI_VALUE": "2" } } } }
class KpiCountResponse {
  final int value;

  const KpiCountResponse({required this.value});

  factory KpiCountResponse.fromJson(Map<String, dynamic> json) {
    final row = unwrapObject(json['Root']);
    return KpiCountResponse(value: asInt(row['KPI_VALUE']));
  }
}
