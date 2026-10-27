import '../../domain/entity/revenue_data.dart';

sealed class RevenueEvent {
  const RevenueEvent();
}

/// Initial load / reload (e.g. after a filter change): fans out to every
/// section concurrently.
class RevenueStarted extends RevenueEvent {
  const RevenueStarted();
}

/// Pull-to-refresh: reloads every section.
class RevenueRefreshed extends RevenueEvent {
  const RevenueRefreshed();
}

// ─── Per-section load / retry events (each card retries on its own) ──────────

class RevenueOverviewRequested extends RevenueEvent {
  const RevenueOverviewRequested();
}

class RevenueCashVsCreditRequested extends RevenueEvent {
  const RevenueCashVsCreditRequested();
}

/// Loads / retries a single KPI counter.
class RevenueKpiRequested extends RevenueEvent {
  final RevenueKpi kpi;
  const RevenueKpiRequested(this.kpi);
}
