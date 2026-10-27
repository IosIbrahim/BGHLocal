// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedCountResponse _$BedCountResponseFromJson(Map<String, dynamic> json) =>
    BedCountResponse(
      total: asInt(json['TOTAL']),
      ward: asInt(json['WARD']),
      icu: asInt(json['ICU']),
    );
