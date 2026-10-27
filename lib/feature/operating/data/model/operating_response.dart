import 'package:json_annotation/json_annotation.dart';

part 'operating_response.g.dart';

@JsonSerializable()
class OperatingResponse {
  @JsonKey(name: "Root")
  final Root? root;

  OperatingResponse({
    this.root,
  });

  factory OperatingResponse.fromJson(Map<String, dynamic> json) =>
      _$OperatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OperatingResponseToJson(this);
}

@JsonSerializable()
class Root {
  @JsonKey(name: "SURGERY")
  final Surgery? surgery;

  @JsonKey(name: "CATHETER")
  final Catheter? catheter;

  @JsonKey(name: "ENDOSOPY")
  final Endosopy? endosopy;

  @JsonKey(name: "TOTAL_COUNTS")
  final TotalCounts? totalCounts;

  Root({
    this.surgery,
    this.catheter,
    this.endosopy,
    this.totalCounts,
  });

  factory Root.fromJson(Map<String, dynamic> json) =>
      _$RootFromJson(json);

  Map<String, dynamic> toJson() => _$RootToJson(this);
}

@JsonSerializable()
class Surgery {
  @JsonKey(name: "SURGERY_ROW")
  final SurgeryRow? surgeryRow;

  Surgery({
    this.surgeryRow,
  });

  factory Surgery.fromJson(Map<String, dynamic> json) =>
      _$SurgeryFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryToJson(this);
}

@JsonSerializable()
class SurgeryRow {
  @JsonKey(name: "PENDING")
  final String? pending;

  @JsonKey(name: "COMPLETE")
  final String? complete;

  @JsonKey(name: "CANCELED")
  final String? canceled;

  @JsonKey(name: "COUNT_CASH")
  final String? countCash;

  @JsonKey(name: "COUNT_CREDIT")
  final String? countCredit;

  @JsonKey(name: "COUNT_ALL")
  final String? countAll;

  SurgeryRow({
    this.pending,
    this.complete,
    this.canceled,
    this.countCash,
    this.countCredit,
    this.countAll,
  });

  factory SurgeryRow.fromJson(Map<String, dynamic> json) =>
      _$SurgeryRowFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryRowToJson(this);
}

@JsonSerializable()
class Catheter {
  @JsonKey(name: "CATHETER_ROW")
  final CatheterRow? catheterRow;

  Catheter({
    this.catheterRow,
  });

  factory Catheter.fromJson(Map<String, dynamic> json) =>
      _$CatheterFromJson(json);

  Map<String, dynamic> toJson() => _$CatheterToJson(this);
}

@JsonSerializable()
class CatheterRow {
  @JsonKey(name: "PENDING")
  final String? pending;

  @JsonKey(name: "COMPLETE")
  final String? complete;

  @JsonKey(name: "CANCELED")
  final String? canceled;

  @JsonKey(name: "COUNT_CASH")
  final String? countCash;

  @JsonKey(name: "COUNT_CREDIT")
  final String? countCredit;

  @JsonKey(name: "COUNT_ALL")
  final String? countAll;

  CatheterRow({
    this.pending,
    this.complete,
    this.canceled,
    this.countCash,
    this.countCredit,
    this.countAll,
  });

  factory CatheterRow.fromJson(Map<String, dynamic> json) =>
      _$CatheterRowFromJson(json);

  Map<String, dynamic> toJson() => _$CatheterRowToJson(this);
}

@JsonSerializable()
class Endosopy {
  @JsonKey(name: "ENDOSOPY_ROW")
  final EndosopyRow? endosopyRow;

  Endosopy({
    this.endosopyRow,
  });

  factory Endosopy.fromJson(Map<String, dynamic> json) =>
      _$EndosopyFromJson(json);

  Map<String, dynamic> toJson() => _$EndosopyToJson(this);
}

@JsonSerializable()
class EndosopyRow {
  @JsonKey(name: "PENDING")
  final String? pending;

  @JsonKey(name: "COMPLETE")
  final String? complete;

  @JsonKey(name: "CANCELED")
  final String? canceled;

  @JsonKey(name: "COUNT_CASH")
  final String? countCash;

  @JsonKey(name: "COUNT_CREDIT")
  final String? countCredit;

  @JsonKey(name: "COUNT_ALL")
  final String? countAll;

  EndosopyRow({
    this.pending,
    this.complete,
    this.canceled,
    this.countCash,
    this.countCredit,
    this.countAll,
  });

  factory EndosopyRow.fromJson(Map<String, dynamic> json) =>
      _$EndosopyRowFromJson(json);

  Map<String, dynamic> toJson() => _$EndosopyRowToJson(this);
}

@JsonSerializable()
class TotalCounts {
  @JsonKey(name: "TOTAL_COUNTS_ROW")
  final TotalCountsRow? totalCountsRow;

  TotalCounts({
    this.totalCountsRow,
  });

  factory TotalCounts.fromJson(Map<String, dynamic> json) =>
      _$TotalCountsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalCountsToJson(this);
}

@JsonSerializable()
class TotalCountsRow {
  @JsonKey(name: "TOTAL_CASH")
  final String? totalCash;

  @JsonKey(name: "TOTAL_CREDIT")
  final String? totalCredit;

  @JsonKey(name: "TOTAL_COUNT")
  final String? totalCount;

  TotalCountsRow({
    this.totalCash,
    this.totalCredit,
    this.totalCount,
  });

  factory TotalCountsRow.fromJson(Map<String, dynamic> json) =>
      _$TotalCountsRowFromJson(json);

  Map<String, dynamic> toJson() => _$TotalCountsRowToJson(this);

  int get cashAndCreditTotal =>
      (int.tryParse(totalCash ?? "") ?? 0) +
          (int.tryParse(totalCredit ?? "") ?? 0);

  double get cashAndCreditPercentage =>
      cashAndCreditTotal == 0 ? 0 : (int.tryParse(totalCash ?? "") ?? 0) / cashAndCreditTotal * 100;

}