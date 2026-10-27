import '../../../../core/core.dart';
import '../entity/inpatient_models.dart';

/// Contract for fetching the inpatient_statistics dashboard data. Each method returns a
/// [Result] so callers can handle success / failure uniformly.
abstract class InpatientRepository {
  Future<Result<BedCount>> getBedCount();

  Future<Result<BedStatus>> getCurrentBedStatus();

  Future<Result<UnitsOccupancy>> getUnitsOccupancy();

  /// Fetches a single KPI by its backend [code] (e.g. '221'), so each metric
  /// tile can load, fail, and retry independently.
  Future<Result<KpiValue>> getKpiValue(String code);
}
