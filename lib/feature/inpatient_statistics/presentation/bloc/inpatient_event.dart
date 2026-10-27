import '../../domain/entity/inpatient_models.dart';

sealed class InpatientEvent {
  const InpatientEvent();
}

/// Initial load — fans out to every section request.
class InpatientStarted extends InpatientEvent {
  const InpatientStarted();
}

/// Pull-to-refresh — reloads every section.
class InpatientRefreshed extends InpatientEvent {
  const InpatientRefreshed();
}

/// Per-section load / retry events.
class BedCountRequested extends InpatientEvent {
  const BedCountRequested();
}

class BedStatusRequested extends InpatientEvent {
  const BedStatusRequested();
}

/// Reloads the ward + ICU occupancy section (both fill from one API call).
class UnitsRequested extends InpatientEvent {
  const UnitsRequested();
}

/// Reloads a single KPI tile, independently of the others.
class KpiRequested extends InpatientEvent {
  final InpatientKpi kpi;
  const KpiRequested(this.kpi);
}
