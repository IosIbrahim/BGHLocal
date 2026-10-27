import '../../../../core/core.dart';
import '../entity/revenue_data.dart';

abstract class RevenueRepository {
  /// Fetches one KPI from `GETKPIVALUES`. Called once per [RevenueKpi] so each
  /// counter loads and retries on its own; the donut and trend tiles are
  /// derived from these same readings.
  Future<Result<RevenueKpiValue>> getKpi(RevenueKpi kpi);
}
