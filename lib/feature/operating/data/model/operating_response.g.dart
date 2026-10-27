// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatingResponse _$OperatingResponseFromJson(Map<String, dynamic> json) =>
    OperatingResponse(
      root: json['Root'] == null
          ? null
          : Root.fromJson(json['Root'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OperatingResponseToJson(OperatingResponse instance) =>
    <String, dynamic>{
      'Root': instance.root,
    };

Root _$RootFromJson(Map<String, dynamic> json) => Root(
      surgery: json['SURGERY'] == null
          ? null
          : Surgery.fromJson(json['SURGERY'] as Map<String, dynamic>),
      catheter: json['CATHETER'] == null
          ? null
          : Catheter.fromJson(json['CATHETER'] as Map<String, dynamic>),
      endosopy: json['ENDOSOPY'] == null
          ? null
          : Endosopy.fromJson(json['ENDOSOPY'] as Map<String, dynamic>),
      totalCounts: json['TOTAL_COUNTS'] == null
          ? null
          : TotalCounts.fromJson(json['TOTAL_COUNTS'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RootToJson(Root instance) => <String, dynamic>{
      'SURGERY': instance.surgery,
      'CATHETER': instance.catheter,
      'ENDOSOPY': instance.endosopy,
      'TOTAL_COUNTS': instance.totalCounts,
    };

Surgery _$SurgeryFromJson(Map<String, dynamic> json) => Surgery(
      surgeryRow: json['SURGERY_ROW'] == null
          ? null
          : SurgeryRow.fromJson(json['SURGERY_ROW'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurgeryToJson(Surgery instance) => <String, dynamic>{
      'SURGERY_ROW': instance.surgeryRow,
    };

SurgeryRow _$SurgeryRowFromJson(Map<String, dynamic> json) => SurgeryRow(
      pending: json['PENDING'] as String?,
      complete: json['COMPLETE'] as String?,
      canceled: json['CANCELED'] as String?,
      countCash: json['COUNT_CASH'] as String?,
      countCredit: json['COUNT_CREDIT'] as String?,
      countAll: json['COUNT_ALL'] as String?,
    );

Map<String, dynamic> _$SurgeryRowToJson(SurgeryRow instance) =>
    <String, dynamic>{
      'PENDING': instance.pending,
      'COMPLETE': instance.complete,
      'CANCELED': instance.canceled,
      'COUNT_CASH': instance.countCash,
      'COUNT_CREDIT': instance.countCredit,
      'COUNT_ALL': instance.countAll,
    };

Catheter _$CatheterFromJson(Map<String, dynamic> json) => Catheter(
      catheterRow: json['CATHETER_ROW'] == null
          ? null
          : CatheterRow.fromJson(json['CATHETER_ROW'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CatheterToJson(Catheter instance) => <String, dynamic>{
      'CATHETER_ROW': instance.catheterRow,
    };

CatheterRow _$CatheterRowFromJson(Map<String, dynamic> json) => CatheterRow(
      pending: json['PENDING'] as String?,
      complete: json['COMPLETE'] as String?,
      canceled: json['CANCELED'] as String?,
      countCash: json['COUNT_CASH'] as String?,
      countCredit: json['COUNT_CREDIT'] as String?,
      countAll: json['COUNT_ALL'] as String?,
    );

Map<String, dynamic> _$CatheterRowToJson(CatheterRow instance) =>
    <String, dynamic>{
      'PENDING': instance.pending,
      'COMPLETE': instance.complete,
      'CANCELED': instance.canceled,
      'COUNT_CASH': instance.countCash,
      'COUNT_CREDIT': instance.countCredit,
      'COUNT_ALL': instance.countAll,
    };

Endosopy _$EndosopyFromJson(Map<String, dynamic> json) => Endosopy(
      endosopyRow: json['ENDOSOPY_ROW'] == null
          ? null
          : EndosopyRow.fromJson(json['ENDOSOPY_ROW'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EndosopyToJson(Endosopy instance) => <String, dynamic>{
      'ENDOSOPY_ROW': instance.endosopyRow,
    };

EndosopyRow _$EndosopyRowFromJson(Map<String, dynamic> json) => EndosopyRow(
      pending: json['PENDING'] as String?,
      complete: json['COMPLETE'] as String?,
      canceled: json['CANCELED'] as String?,
      countCash: json['COUNT_CASH'] as String?,
      countCredit: json['COUNT_CREDIT'] as String?,
      countAll: json['COUNT_ALL'] as String?,
    );

Map<String, dynamic> _$EndosopyRowToJson(EndosopyRow instance) =>
    <String, dynamic>{
      'PENDING': instance.pending,
      'COMPLETE': instance.complete,
      'CANCELED': instance.canceled,
      'COUNT_CASH': instance.countCash,
      'COUNT_CREDIT': instance.countCredit,
      'COUNT_ALL': instance.countAll,
    };

TotalCounts _$TotalCountsFromJson(Map<String, dynamic> json) => TotalCounts(
      totalCountsRow: json['TOTAL_COUNTS_ROW'] == null
          ? null
          : TotalCountsRow.fromJson(
              json['TOTAL_COUNTS_ROW'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TotalCountsToJson(TotalCounts instance) =>
    <String, dynamic>{
      'TOTAL_COUNTS_ROW': instance.totalCountsRow,
    };

TotalCountsRow _$TotalCountsRowFromJson(Map<String, dynamic> json) =>
    TotalCountsRow(
      totalCash: json['TOTAL_CASH'] as String?,
      totalCredit: json['TOTAL_CREDIT'] as String?,
      totalCount: json['TOTAL_COUNT'] as String?,
    );

Map<String, dynamic> _$TotalCountsRowToJson(TotalCountsRow instance) =>
    <String, dynamic>{
      'TOTAL_CASH': instance.totalCash,
      'TOTAL_CREDIT': instance.totalCredit,
      'TOTAL_COUNT': instance.totalCount,
    };
