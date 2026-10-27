import '../../../../core/core.dart';
import '../entity/emergency_data.dart';

/// Each dashboard section is fetched independently so a single failing section
/// doesn't blank the others, and each card can retry on its own.
abstract class EmergencyRepository {
  Future<Result<EmergencyOverview>> getOverview();
  Future<Result<EmergencyPayments>> getPaymentTypes();
  Future<Result<List<EmergencyNationalityEntry>>> getNationalityDistribution();
}
