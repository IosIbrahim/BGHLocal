import 'ward_occupancy.dart';

/// Occupancy breakdown from `GetCurrentBedStatusData`, split into the two unit
/// groups the backend returns under `Root`: regular [wards] (`WardsTd`) and
/// ICU/nursery units ([icus], `IcusTd`). Both groups share the [WardOccupancy]
/// row schema.
class UnitsOccupancy {
  final List<WardOccupancy> wards;
  final List<WardOccupancy> icus;

  const UnitsOccupancy({required this.wards, required this.icus});
}
