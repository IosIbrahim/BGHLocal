import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/converters.dart';
import '../../domain/entity/inpatient_models.dart';

part 'bed_status_response.g.dart';

/// Response for `GetCurrentBedStatus`, e.g.
/// `{ "FLOOR_BED_NOT_AVAILABLE":"82", "FLOOR_BED_AVAILABLE":"4",
///    "CARE_BED_NOT_AVAILABLE":"29", "CARE_BED_AVAILABLE":"3" }`.
/// "NOT_AVAILABLE" = occupied, "AVAILABLE" = vacant.
@JsonSerializable(createToJson: false)
class BedStatusResponse {
  // TODO(confirm): JSON keys against the live API.
  @JsonKey(name: 'FLOOR_BED_NOT_AVAILABLE', fromJson: asInt)
  final int floorOccupied;
  @JsonKey(name: 'FLOOR_BED_AVAILABLE', fromJson: asInt)
  final int floorAvailable;
  @JsonKey(name: 'CARE_BED_NOT_AVAILABLE', fromJson: asInt)
  final int careOccupied;
  @JsonKey(name: 'CARE_BED_AVAILABLE', fromJson: asInt)
  final int careAvailable;

  BedStatusResponse({
    required this.floorOccupied,
    required this.floorAvailable,
    required this.careOccupied,
    required this.careAvailable,
  });

  factory BedStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$BedStatusResponseFromJson(unwrapObject(json));

  BedStatus toDomain() => BedStatus(
        floorOccupied: floorOccupied,
        floorAvailable: floorAvailable,
        careOccupied: careOccupied,
        careAvailable: careAvailable,
      );
}
