import '../../domain/entity/hr_data.dart';

sealed class HrEvent {
  const HrEvent();
}

/// Initial load / reload (e.g. after a filter change): fans out to every
/// KPI concurrently.
class HrStarted extends HrEvent {
  const HrStarted();
}

/// Pull-to-refresh: reloads every KPI.
class HrRefreshed extends HrEvent {
  const HrRefreshed();
}

/// Per-KPI load / retry (each counter retries on its own).
class HrKpiRequested extends HrEvent {
  final HrKpi kpi;
  const HrKpiRequested(this.kpi);
}
