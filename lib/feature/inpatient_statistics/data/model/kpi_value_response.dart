import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/converters.dart';
import '../../domain/entity/inpatient_models.dart';

part 'kpi_value_response.g.dart';

@JsonSerializable(createToJson: false)
class KpiValueResponse {
  @JsonKey(name: 'PERIODVALUE_EN', fromJson: asStr)
  final String periodValueEn;
  @JsonKey(name: 'PERIODVALUE_AR', fromJson: asStr)
  final String periodValueAr;
  @JsonKey(name: 'SUFFIX_EN', fromJson: asStr)
  final String suffixEn;
  @JsonKey(name: 'SUFFIX_AR', fromJson: asStr)
  final String suffixAr;
  @JsonKey(name: 'PREV_PERIOD_DESC_EN', fromJson: asStr)
  final String prevPeriodDescEn;
  @JsonKey(name: 'PREV_PERIOD_DESC_AR', fromJson: asStr)
  final String prevPeriodDescAr;
  @JsonKey(name: 'KPI_TREND', fromJson: asStr)
  final String kpiTrend;
  @JsonKey(name: 'KPI_TREND_VALUE', fromJson: asStr)
  final String kpiTrendValue;

  KpiValueResponse({
    required this.periodValueEn,
    required this.periodValueAr,
    required this.suffixEn,
    required this.suffixAr,
    required this.prevPeriodDescEn,
    required this.prevPeriodDescAr,
    required this.kpiTrend,
    required this.kpiTrendValue,
  });

  factory KpiValueResponse.fromJson(Map<String, dynamic> json) =>
      _$KpiValueResponseFromJson(unwrapObject(json));

  KpiValue toDomain(String requestedCode) => KpiValue(
        requestedCode: requestedCode,
        valueEn: periodValueEn,
        valueAr: periodValueAr,
        suffixEn: suffixEn,
        suffixAr: suffixAr,
        prevPeriodDescEn: prevPeriodDescEn,
        prevPeriodDescAr: prevPeriodDescAr,
        trendUp: kpiTrend.trim() == '1',
        trendValue: kpiTrendValue,
      );
}
