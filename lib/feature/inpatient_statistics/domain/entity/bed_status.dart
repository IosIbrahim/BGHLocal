/// Current bed status feeding BOTH donut charts (source: `GetCurrentBedStatus`).
///
/// "Floor" = general wards, "Care" = ICU.
class BedStatus {
  final int floorOccupied;
  final int floorAvailable;
  final int careOccupied;
  final int careAvailable;

  const BedStatus({
    required this.floorOccupied,
    required this.floorAvailable,
    required this.careOccupied,
    required this.careAvailable,
  });

  int get floorTotal => floorOccupied + floorAvailable;
  int get careTotal => careOccupied + careAvailable;

  /// Ward occupancy as a 0–100 percentage.
  double get floorBusyPercent =>
      floorTotal == 0 ? 0 : floorOccupied / floorTotal * 100;

  /// ICU occupancy as a 0–100 percentage.
  double get icuBusyPercent =>
      careTotal == 0 ? 0 : careOccupied / careTotal * 100;
}
