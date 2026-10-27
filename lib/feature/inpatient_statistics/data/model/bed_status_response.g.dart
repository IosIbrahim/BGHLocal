// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedStatusResponse _$BedStatusResponseFromJson(Map<String, dynamic> json) =>
    BedStatusResponse(
      floorOccupied: asInt(json['FLOOR_BED_NOT_AVAILABLE']),
      floorAvailable: asInt(json['FLOOR_BED_AVAILABLE']),
      careOccupied: asInt(json['CARE_BED_NOT_AVAILABLE']),
      careAvailable: asInt(json['CARE_BED_AVAILABLE']),
    );
