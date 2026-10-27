/// A single KPI metric (source: `GetKPIValues`).
///
/// [requestedCode] is the code we asked for (221 / 222). The response carries
/// its own (different) `KPI_CODE`, so we keep the requested code to place the
/// value in the correct tile. EN/AR variants are kept so the widget can resolve
/// by the active locale.
class KpiValue {
  final String requestedCode;
  final String valueEn;
  final String valueAr;
  final String suffixEn;
  final String suffixAr;
  final String prevPeriodDescEn;
  final String prevPeriodDescAr;
  final bool trendUp;
  final String trendValue;

  const KpiValue({
    required this.requestedCode,
    required this.valueEn,
    required this.valueAr,
    required this.suffixEn,
    required this.suffixAr,
    required this.prevPeriodDescEn,
    required this.prevPeriodDescAr,
    required this.trendUp,
    required this.trendValue,
  });

  String value(bool isArabic) => isArabic ? valueAr : valueEn;
  String suffix(bool isArabic) => isArabic ? suffixAr : suffixEn;
  String prevPeriodDesc(bool isArabic) =>
      isArabic ? prevPeriodDescAr : prevPeriodDescEn;
}
