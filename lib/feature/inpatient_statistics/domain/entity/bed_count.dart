/// Bed totals shown in the summary cards (source: `GetBedCount`).
class BedCount {
  final int total;
  final int ward;
  final int icu;

  const BedCount({
    required this.total,
    required this.ward,
    required this.icu,
  });
}
