import '../../../../core/core.dart';
import '../../domain/entity/filter_options.dart';
import '../../domain/repository/filter_repository.dart';
import '../filter_api.dart';

class FilterRepositoryImpl implements FilterRepository {
  final FilterApi _api;
  final AppPreferences _prefs;

  FilterRepositoryImpl(this._api, this._prefs);

  @override
  Future<Result<MainData>> getMainData() => safeApiCall(() async {
        final session = await _prefs.getUserSession();
        final response = await _api.loadBranches({
          'USER_ID': session?.userId ?? '',
          'BranchID': session?.defaultBranch ?? '',
        });
        return response.data;
      });
}
