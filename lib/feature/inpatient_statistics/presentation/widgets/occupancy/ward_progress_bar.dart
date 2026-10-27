import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../domain/entity/inpatient_models.dart';

// ─── Shared occupancy helpers ────────────────────────────────────────────────

/// Colour a progress bar by occupancy ratio: green < 70% ≤ orange < 90% ≤ red.
Color occupancyBarColor(WardOccupancy unit) {
  if (unit.total == 0) return AppColors.lightSlate;
  final ratio = unit.bedFull / unit.total;
  if (ratio >= 0.9) return AppColors.dangerRed;
  if (ratio >= 0.7) return AppColors.amber;
  return AppColors.green;
}

/// Row accent colours, cycled by list position so consecutive units never share
/// a colour. Ordered for contrast between neighbours rather than by hue.
const _unitPalette = <Color>[
  AppColors.blue,
  AppColors.green,
  AppColors.purple,
  AppColors.amber,
  AppColors.cyan,
  AppColors.pink,
  AppColors.coral,
  AppColors.teal,
];

/// Accent colour for the unit at [index] in the list.
Color unitAccentColor(int index) => _unitPalette[index % _unitPalette.length];

/// A [CardStateView] that renders a [WardProgressBar] for every unit in the
/// list. Shared between the wards and ICU occupancy cards; each row picks its
/// own accent colour from [_unitPalette] so the rows stay visually separable.
class UnitListFooter extends StatelessWidget {
  final CardState<List<WardOccupancy>> state;
  final bool isArabic;

  const UnitListFooter({
    super.key,
    required this.state,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return CardStateView<List<WardOccupancy>>(
      state: state,
      minHeight: 80,
      builder: (units) => Column(
        children: [
          for (var i = 0; i < units.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            WardProgressBar(
              accentColor: unitAccentColor(i),
              label: units[i].name(isArabic),
              current: units[i].bedFull,
              total: units[i].total,
              statusColor: occupancyBarColor(units[i]),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Ward Progress Bar ───────────────────────────────────────────────────────

class WardProgressBar extends StatelessWidget {
  /// Drives the bar fill and track; varies per row.
  final Color accentColor;
  final String label;
  final int current;
  final int total;

  /// Occupancy severity (see [occupancyBarColor]). Kept off the bar — which now
  /// carries the row accent — and shown on the count instead.
  final Color statusColor;

  const WardProgressBar({
    super.key,
    required this.accentColor,
    required this.label,
    required this.current,
    required this.total,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    // Guard total == 0: int 0/0 is NaN, which LinearProgressIndicator rejects.
    final ratio = total <= 0 ? 0.0 : (current / total).clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(
          width: 118,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 7,
              backgroundColor: accentColor.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$current/$total',
          style: TextStyle(
            fontSize: 11.5,
            color: statusColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
