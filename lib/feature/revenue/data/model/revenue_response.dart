import '../../../../core/utils/converters.dart';
import '../../domain/entity/revenue_data.dart';

/// Combined Revenue dashboard response.
///
/// Expected envelope (TODO: confirm keys and endpoint against the live API):
/// ```json
/// { "Root": {
///     "SummaryTd": { "TOTAL_REVENUE":"2400000", "CASH_AMOUNT":"1500000",
///                    "CREDIT_AMOUNT":"900000" },
///     "TrendTd": [
///       { "TREND_LABEL":"vs Last Month", "TREND_VALUE":"+18%", "DIRECTION":"1" },
///       …
///     ]
/// } }
/// ```
class RevenueResponse {
  final double totalRevenue;
  final double cashAmount;
  final double creditAmount;
  final List<RevenueTrendEntry> trends;

  RevenueResponse({
    required this.totalRevenue,
    required this.cashAmount,
    required this.creditAmount,
    required this.trends,
  });

  factory RevenueResponse.fromJson(Map<String, dynamic> json) {
    final root = json['Root'];
    if (root is! Map<String, dynamic>) {
      return RevenueResponse(
        totalRevenue: 0, cashAmount: 0, creditAmount: 0,
        trends: const [],
      );
    }

    final s = unwrapObject(root['SummaryTd']);
    return RevenueResponse(
      totalRevenue: _asDouble(s['TOTAL_REVENUE']),
      cashAmount: _asDouble(s['CASH_AMOUNT']),
      creditAmount: _asDouble(s['CREDIT_AMOUNT']),
      trends: unwrapList(root['TrendTd'])
          .map((m) => RevenueTrendEntry(
                label: asStr(m['TREND_LABEL']),
                value: asStr(m['TREND_VALUE']),
                trendUp: asStr(m['DIRECTION']).trim() == '1',
              ))
          .toList(),
    );
  }

  RevenueData toDomain() => RevenueData(
        totalRevenue: totalRevenue,
        cashAmount: cashAmount,
        creditAmount: creditAmount,
        trends: trends,
      );

  static double _asDouble(dynamic v) =>
      double.tryParse(v?.toString().trim() ?? '') ?? 0.0;
}
