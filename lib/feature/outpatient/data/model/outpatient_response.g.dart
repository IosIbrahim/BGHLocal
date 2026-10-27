// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outpatient_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutpatientResponse _$OutpatientResponseFromJson(Map<String, dynamic> json) =>
    OutpatientResponse(
      root: json['Root'] == null
          ? null
          : Root.fromJson(json['Root'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OutpatientResponseToJson(OutpatientResponse instance) =>
    <String, dynamic>{
      'Root': instance.root,
    };

Root _$RootFromJson(Map<String, dynamic> json) => Root(
      oUTPARMS: json['OUT_PARMS'] == null
          ? null
          : OUTPARMS.fromJson(json['OUT_PARMS'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RootToJson(Root instance) => <String, dynamic>{
      'OUT_PARMS': instance.oUTPARMS,
    };

OUTPARMS _$OUTPARMSFromJson(Map<String, dynamic> json) => OUTPARMS(
      oUTPARMSROW: json['OUT_PARMS_ROW'] == null
          ? null
          : OUTPARMSROW.fromJson(json['OUT_PARMS_ROW'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OUTPARMSToJson(OUTPARMS instance) => <String, dynamic>{
      'OUT_PARMS_ROW': instance.oUTPARMSROW,
    };

OUTPARMSROW _$OUTPARMSROWFromJson(Map<String, dynamic> json) => OUTPARMSROW(
      pENDING: json['PENDING'] as String?,
      nOSHOW: json['NOSHOW'] as String?,
      cANCELED: json['CANCELED'] as String?,
      cONSULTATIONS: json['CONSULTATIONS'] as String?,
      fOLLOWUP: json['FOLLOWUP'] as String?,
      cOUNTCASH: json['COUNT_CASH'] as String?,
      cOUNTCREDIT: json['COUNT_CREDIT'] as String?,
      cOUNTALL: json['COUNT_ALL'] as String?,
    );

Map<String, dynamic> _$OUTPARMSROWToJson(OUTPARMSROW instance) =>
    <String, dynamic>{
      'PENDING': instance.pENDING,
      'NOSHOW': instance.nOSHOW,
      'CANCELED': instance.cANCELED,
      'CONSULTATIONS': instance.cONSULTATIONS,
      'FOLLOWUP': instance.fOLLOWUP,
      'COUNT_CASH': instance.cOUNTCASH,
      'COUNT_CREDIT': instance.cOUNTCREDIT,
      'COUNT_ALL': instance.cOUNTALL,
    };
