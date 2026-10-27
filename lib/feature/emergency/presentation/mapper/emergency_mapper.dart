import 'dart:math' show min;

import '../../../../core/core.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../core/widgets/dashboard/status_item.dart';
import '../../domain/entity/emergency_data.dart';

/// Pure presentation mappers: turn each domain section into its chart-ready
/// view data. Kept out of the bloc so the bloc only orchestrates fetching.
class EmergencyMapper {
  const EmergencyMapper._();

  // Position-based icon/colour config for the ER status types:
  // Triaged / In Treatment / Discharged / Admitted.
  static const _statusIcons = [
    DashIcons.hourglass, DashIcons.inTreatment,
    DashIcons.discharged, DashIcons.admitted,
  ];
  static const _statusColors = [
    AppColors.amber, AppColors.teal,
    AppColors.purple, AppColors.red,
  ];
  static const _statusColorEnds = [
    AppColors.amberDark, AppColors.tealLight,
    AppColors.purpleDark, AppColors.redDark,
  ];
  static const _nationalityColors = [
    AppColors.green, AppColors.blue, AppColors.purple,
    AppColors.amber, AppColors.pink,
  ];

  static List<StatusItem> statusItems(List<EmergencyStatusEntry> entries) {
    final count = min(entries.length, _statusIcons.length);
    return List.generate(
      count,
      (i) => StatusItem(
        label: entries[i].label,
        value: entries[i].count,
        iconAsset: _statusIcons[i],
        color: _statusColors[i],
        colorEnd: _statusColorEnds[i],
      ),
    );
  }

  static List<DonutSegment> paymentSegments(EmergencyPayments p) => [
        DonutSegment(label: 'Cash', value: p.cashPayments.toDouble(), color: AppColors.blue),
        DonutSegment(label: 'Credit', value: p.creditPayments.toDouble(), color: AppColors.green),
      ];

  static List<BarItem> nationalityBars(
    List<EmergencyNationalityEntry> entries, {
    required bool isArabic,
  }) {
    final nationals = entries.take(5).toList();
    return [
      for (var i = 0; i < nationals.length; i++)
        BarItem(
          nationals[i].name(isArabic),
          nationals[i].count.toDouble(),
          _nationalityColors[i % _nationalityColors.length],
        ),
    ];
  }
}
