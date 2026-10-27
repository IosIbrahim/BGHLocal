sealed class OperatingEvent {
  const OperatingEvent();
}

/// Initial load / reload (e.g. after a filter change): fans out to every
/// section concurrently.
class OperatingStarted extends OperatingEvent {
  const OperatingStarted();
}

/// Pull-to-refresh: reloads every section.
class OperatingRefreshed extends OperatingEvent {
  const OperatingRefreshed();
}

// ─── Per-section load / retry events (each card retries on its own) ──────────

class OperationDashboardRequested extends OperatingEvent {
  const OperationDashboardRequested();
}
