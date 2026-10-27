import 'package:json_annotation/json_annotation.dart';

part 'outpatient_response.g.dart';

@JsonSerializable()
class OutpatientResponse {
  @JsonKey(name: "Root")
  final Root? root;

  OutpatientResponse ({
    this.root,
  });

  factory OutpatientResponse.fromJson(Map<String, dynamic> json) {
    return _$OutpatientResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OutpatientResponseToJson(this);
  }
}

@JsonSerializable()
class Root {
  @JsonKey(name: "OUT_PARMS")
  final OUTPARMS? oUTPARMS;

  Root ({
    this.oUTPARMS,
  });

  factory Root.fromJson(Map<String, dynamic> json) {
    return _$RootFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RootToJson(this);
  }
}

@JsonSerializable()
class OUTPARMS {
  @JsonKey(name: "OUT_PARMS_ROW")
  final OUTPARMSROW? oUTPARMSROW;

  OUTPARMS ({
    this.oUTPARMSROW,
  });

  factory OUTPARMS.fromJson(Map<String, dynamic> json) {
    return _$OUTPARMSFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OUTPARMSToJson(this);
  }
}

@JsonSerializable()
class OUTPARMSROW {
  @JsonKey(name: "PENDING")
  final String? pENDING;
  @JsonKey(name: "NOSHOW")
  final String? nOSHOW;
  @JsonKey(name: "CANCELED")
  final String? cANCELED;
  @JsonKey(name: "CONSULTATIONS")
  final String? cONSULTATIONS;
  @JsonKey(name: "FOLLOWUP")
  final String? fOLLOWUP;
  @JsonKey(name: "COUNT_CASH")
  final String? cOUNTCASH;
  @JsonKey(name: "COUNT_CREDIT")
  final String? cOUNTCREDIT;
  @JsonKey(name: "COUNT_ALL")
  final String? cOUNTALL;

  OUTPARMSROW ({
    this.pENDING,
    this.nOSHOW,
    this.cANCELED,
    this.cONSULTATIONS,
    this.fOLLOWUP,
    this.cOUNTCASH,
    this.cOUNTCREDIT,
    this.cOUNTALL,
  });

  factory OUTPARMSROW.fromJson(Map<String, dynamic> json) {
    return _$OUTPARMSROWFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OUTPARMSROWToJson(this);
  }

  int get cashAndCreditTotal =>
      (int.tryParse(cOUNTCASH ?? "") ?? 0) +
          (int.tryParse(cOUNTCREDIT ?? "") ?? 0);

  double get cashAndCreditPercentage =>
      cashAndCreditTotal == 0 ? 0 : (int.tryParse(cOUNTCASH ?? "") ?? 0) / cashAndCreditTotal * 100;

}