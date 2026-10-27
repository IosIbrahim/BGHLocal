sealed class OutpatientEvent {
  const OutpatientEvent();
}

/// Initial load / reload (e.g. after a filter change): fans out to every
/// section concurrently.
class OutpatientStarted extends OutpatientEvent {
  const OutpatientStarted();
}

/// Pull-to-refresh: reloads every section.
class OutpatientRefreshed extends OutpatientEvent {
  const OutpatientRefreshed();
}

// ─── Per-section load / retry events (each card retries on its own) ──────────
class OutpatientDashboardRequested extends OutpatientEvent {
  const OutpatientDashboardRequested();
}
