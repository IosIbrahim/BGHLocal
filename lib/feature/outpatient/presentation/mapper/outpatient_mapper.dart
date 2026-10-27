import 'dart:math' show min;

import '../../../../core/core.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../core/widgets/dashboard/status_item.dart';
import '../../domain/entity/outpatient_data.dart';

/// Pure presentation mappers: turn each domain section into its chart-ready
/// view data. Kept out of the bloc so the bloc only orchestrates fetching.
class OutpatientMapper {
  const OutpatientMapper._();

  // Position-based icon/colour config for the outpatient status types.
  static const _statusIcons = [
    DashIcons.newArrival, DashIcons.hourglass, DashIcons.cancel,
    DashIcons.followUp, DashIcons.apology,
  ];
  static const _statusColors = [
    AppColors.green, AppColors.amber, AppColors.coral,
    AppColors.purple, AppColors.pink,
  ];
  static const _statusColorEnds = [
    AppColors.greenDark, AppColors.amberDark, AppColors.coralDark,
    AppColors.purpleDark, AppColors.pinkDark,
  ];

  static List<StatusItem> statusItems(List<OutpatientStatusEntry> entries) {
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

  static List<BarItem> statusBars(List<OutpatientStatusEntry> entries) {
    final count = min(entries.length, _statusColors.length);
    return [
      for (var i = 0; i < count; i++)
        BarItem(
          entries[i].label,
          entries[i].count.toDouble(),
          _statusColors[i],
        ),
    ];
  }
}
