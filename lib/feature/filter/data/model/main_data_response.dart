import '../../../../core/utils/converters.dart';
import '../../domain/entity/filter_options.dart';

class MainDataResponse {
  final MainData data;

  const MainDataResponse(this.data);

  factory MainDataResponse.fromJson(Map<String, dynamic> json) {
    final root = json['Root'];
    final rootMap = root is Map<String, dynamic> ? root : const {};

    List<FilterOption> options(String key) =>
        unwrapList(rootMap[key]).map(_toOption).toList();

    return MainDataResponse(MainData(
      branches: options('USER_BRANCHES'),
      periods: options('DASHBOARD_MEDICAL_DATE_FLAG'),
    ));
  }

  static FilterOption _toOption(Map<String, dynamic> row) => FilterOption(
        id: asIdStr(row['ID']),
        nameAr: asStr(row['NAME_AR']),
        nameEn: asStr(row['NAME_EN']),
      );
}
