import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/converters.dart';
import '../../domain/entity/inpatient_models.dart';

part 'bed_count_response.g.dart';

/// Numeric fields arrive as strings, so each is coerced through [asInt] during
/// deserialization (handles strings, decimals, null/missing).
@JsonSerializable(createToJson: false)
class BedCountResponse {
  @JsonKey(name: 'TOTAL', fromJson: asInt)
  final int total;
  @JsonKey(name: 'WARD', fromJson: asInt)
  final int ward;
  @JsonKey(name: 'ICU', fromJson: asInt)
  final int icu;

  BedCountResponse({
    required this.total,
    required this.ward,
    required this.icu,
  });

  factory BedCountResponse.fromJson(Map<String, dynamic> json) =>
      _$BedCountResponseFromJson(unwrapObject(json));

  BedCount toDomain() => BedCount(total: total, ward: ward, icu: icu);
}
