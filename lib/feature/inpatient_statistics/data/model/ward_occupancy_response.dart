import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/converters.dart';
import '../../domain/entity/inpatient_models.dart';

part 'ward_occupancy_response.g.dart';

/// One element of the `GetCurrentBedStatusData` array, e.g.
/// `{ "UNIT_ID":"3", "UNIT_NAME_AR":"…", "UNIT_NAME_EN":"Third Floor",
///    "BED_FULL":"29", "BED_EMPTY":"0" }`.
@JsonSerializable(createToJson: false)
class WardOccupancyResponse {
  // TODO(confirm): JSON keys against the live API.
  @JsonKey(name: 'UNIT_ID', fromJson: asIdStr)
  final String unitId;
  @JsonKey(name: 'UNIT_NAME_AR', fromJson: asStr)
  final String nameAr;
  @JsonKey(name: 'UNIT_NAME_EN', fromJson: asStr)
  final String nameEn;
  @JsonKey(name: 'BED_FULL', fromJson: asInt)
  final int bedFull;
  @JsonKey(name: 'BED_EMPTY', fromJson: asInt)
  final int bedEmpty;

  WardOccupancyResponse({
    required this.unitId,
    required this.nameAr,
    required this.nameEn,
    required this.bedFull,
    required this.bedEmpty,
  });

  factory WardOccupancyResponse.fromJson(Map<String, dynamic> json) =>
      _$WardOccupancyResponseFromJson(json);

  WardOccupancy toDomain() => WardOccupancy(
        unitId: unitId,
        nameEn: nameEn,
        nameAr: nameAr,
        bedFull: bedFull,
        bedEmpty: bedEmpty,
      );
}

/// Envelope wrapper for `GetCurrentBedStatusData`, whose body groups units under
/// a `Root` object with two arrays sharing the same row schema:
/// `{ "Root": { "WardsTd": [ ...wards ], "IcusTd": [ ...icus ] } }`.
///
/// Retrofit can only return a type that exposes `fromJson(Map)`, so the two
/// groups live behind this type rather than a bare `List`. [unwrapList]
/// tolerates a missing group, an empty array, or a single row that the backend
/// collapses into a bare object.
class UnitsOccupancyResponse {
  final List<WardOccupancyResponse> wards;
  final List<WardOccupancyResponse> icus;

  UnitsOccupancyResponse({required this.wards, required this.icus});

  factory UnitsOccupancyResponse.fromJson(Map<String, dynamic> json) {
    final root = json['Root'];
    if (root is! Map<String, dynamic>) {
      throw FormatException(
          'UnitsOccupancyResponse: expected "Root" map, got: $json');
    }
    return UnitsOccupancyResponse(
      wards:
          unwrapList(root['WardsTd']).map(WardOccupancyResponse.fromJson).toList(),
      icus:
          unwrapList(root['IcusTd']).map(WardOccupancyResponse.fromJson).toList(),
    );
  }
}
