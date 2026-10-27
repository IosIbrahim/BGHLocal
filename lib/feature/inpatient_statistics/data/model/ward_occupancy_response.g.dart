// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_occupancy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardOccupancyResponse _$WardOccupancyResponseFromJson(
        Map<String, dynamic> json) =>
    WardOccupancyResponse(
      unitId: asIdStr(json['UNIT_ID']),
      nameAr: asStr(json['UNIT_NAME_AR']),
      nameEn: asStr(json['UNIT_NAME_EN']),
      bedFull: asInt(json['BED_FULL']),
      bedEmpty: asInt(json['BED_EMPTY']),
    );
