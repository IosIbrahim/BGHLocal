/// Domain data for the Emergency Room dashboard.
///
/// The dashboard is fetched per section (overview / payments / nationality) so
/// each card loads and retries independently.
library;

/// Top summary counters + the status grid (source: `GetEROverviewData`).
class EmergencyOverview {
  final int totalEr;
  final int saudiCount;
  final int nonSaudiCount;
  final List<EmergencyStatusEntry> statusBreakdown;

  const EmergencyOverview({
    required this.totalEr,
    required this.saudiCount,
    required this.nonSaudiCount,
    required this.statusBreakdown,
  });
}

/// Cash vs credit payment totals (source: `GetEROverviewData`).
class EmergencyPayments {
  final int cashPayments;
  final int creditPayments;

  const EmergencyPayments({
    required this.cashPayments,
    required this.creditPayments,
  });
}

class EmergencyStatusEntry {
  final String label;
  final int count;
  const EmergencyStatusEntry({required this.label, required this.count});
}

/// One nationality row from `GetPatientCensusEr`.
class EmergencyNationalityEntry {
  final String nameAr;
  final String nameEn;
  final int count;

  const EmergencyNationalityEntry({
    required this.nameAr,
    required this.nameEn,
    required this.count,
  });

  String name(bool isArabic) => isArabic ? nameAr : nameEn;
}
