/// A single selectable lookup row (branch, period, …) from `Load-Branches`.
///
/// Carries both localized names so the UI can pick by the active locale without
/// re-fetching.
class FilterOption {
  final String id;
  final String nameAr;
  final String nameEn;

  const FilterOption({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  /// Localized label for the active locale, with a sensible fallback when one
  /// side is blank.
  String name({required bool isArabic}) {
    final primary = isArabic ? nameAr : nameEn;
    if (primary.trim().isNotEmpty) return primary;
    return isArabic ? nameEn : nameAr;
  }
}

/// The lookups the filter sheet needs, parsed from `Load-Branches`.
class MainData {
  /// Branches a user may scope the dashboard to (`USER_BRANCHES`).
  final List<FilterOption> branches;

  /// Period options for the date-flag chips (`DASHBOARD_MEDICAL_DATE_FLAG`).
  final List<FilterOption> periods;

  const MainData({
    required this.branches,
    required this.periods,
  });

  static const empty = MainData(branches: [], periods: []);
}
