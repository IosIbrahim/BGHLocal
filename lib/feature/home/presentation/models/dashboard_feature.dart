import '../../../../core/routes/route_manager.dart';

enum DashboardFeature {
  inpatient,
  outpatient,
  emergency,
  hr,
  revenue,
  operating;

  static DashboardFeature? fromKey(String key) {
    return DashboardFeature.values.where((f) => f.name == key).firstOrNull;
  }

  String get route => switch (this) {
        DashboardFeature.inpatient => Routes.inpatientRoute,
        DashboardFeature.outpatient => Routes.outpatientRoute,
        DashboardFeature.emergency => Routes.emergencyRoute,
        DashboardFeature.hr => Routes.hrRoute,
        DashboardFeature.revenue => Routes.revenueRoute,
        DashboardFeature.operating => Routes.operatingRoute,
      };
}
