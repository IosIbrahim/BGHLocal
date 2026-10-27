sealed class EmergencyEvent {
  const EmergencyEvent();
}

/// Initial load / reload (e.g. after a filter change): fans out to every
/// section concurrently.
class EmergencyStarted extends EmergencyEvent {
  const EmergencyStarted();
}

/// Pull-to-refresh: reloads every section.
class EmergencyRefreshed extends EmergencyEvent {
  const EmergencyRefreshed();
}

// ─── Per-section load / retry events (each card retries on its own) ──────────

class EmergencyOverviewRequested extends EmergencyEvent {
  const EmergencyOverviewRequested();
}

class EmergencyPaymentTypesRequested extends EmergencyEvent {
  const EmergencyPaymentTypesRequested();
}

class EmergencyNationalityRequested extends EmergencyEvent {
  const EmergencyNationalityRequested();
}
