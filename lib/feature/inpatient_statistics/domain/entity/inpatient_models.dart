// Barrel for the inpatient_statistics dashboard domain entities.
//
// These are UI-agnostic; the data layer maps API responses into them via
// `toDomain()` and the presentation layer reads them through the bloc.
export 'bed_count.dart';
export 'bed_status.dart';
export 'inpatient_kpi.dart';
export 'kpi_value.dart';
export 'units_occupancy.dart';
export 'ward_occupancy.dart';
