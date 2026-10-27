import '../../../../core/error/result.dart';
import '../entity/filter_options.dart';

abstract class FilterRepository {
  /// Loads the branch and period lookups for the filter sheet.
  Future<Result<MainData>> getMainData();
}
