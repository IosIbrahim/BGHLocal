import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/resources/language_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../../core/widgets/dashboard/metric_tile.dart';
import '../../../domain/entity/inpatient_models.dart';
import '../../bloc/inpatient_bloc.dart';
import '../../bloc/inpatient_state.dart';

// ─── Key Metrics Row ─────────────────────────────────────────────────────────

class KeyMetricsRow extends StatelessWidget {
  const KeyMetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Each tile owns its own BlocSelector, so the two KPIs load, fail, and
    // retry independently — one slow/failed KPI never blocks the other.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _KpiTile(
              kpi: InpatientKpi.alos,
              icon: Icons.access_time_rounded,
              title: AppStrings.alos.tr(),
              // The unit comes from the response's SUFFIX, not a hardcoded
              // "Days" — the backend owns the wording (and localises it).
              subtitle: _unitSubtitle,
              gradient: AppColors.metricBlueGradient,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _KpiTile(
              kpi: InpatientKpi.bedTurnover,
              icon: Icons.sync_rounded,
              title: AppStrings.bedTurnoverShort.tr(),
              subtitle: (_, __) => AppStrings.bedTurnover.tr(),
              gradient: AppColors.metricGreenGradient,
            ),
          ),
        ],
      ),
    );
  }

  /// "Avg Stay (Days)" — the parenthetical is the KPI's own `SUFFIX_*`. Falls
  /// back to the bare label when the response carries no suffix, so the tile
  /// never renders an empty "Avg Stay ()".
  static String _unitSubtitle(KpiValue value, bool isArabic) {
    final suffix = value.suffix(isArabic).trim();
    return suffix.isEmpty
        ? AppStrings.avgStay.tr()
        : AppStrings.avgStayDays.tr(args: [suffix]);
  }
}

/// A single KPI metric tile, bound to its own slice of [InpatientState.kpis].
class _KpiTile extends StatelessWidget {
  final InpatientKpi kpi;
  final IconData icon;
  final String title;

  /// Built from the loaded [KpiValue] rather than passed in ready-made, because
  /// a subtitle may need fields that only arrive with the response (the unit
  /// suffix).
  final String Function(KpiValue value, bool isArabic) subtitle;

  final Gradient gradient;

  const _KpiTile({
    required this.kpi,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return BlocSelector<InpatientBloc, InpatientState, CardState<KpiValue>>(
      selector: (state) => state.kpis[kpi] ?? const CardLoading(),
      builder: (context, kpiState) => CardStateView<KpiValue>(
        state: kpiState,
        minHeight: 140,
        builder: (value) => MetricTile(
          icon: icon,
          title: title,
          value: value.value(isArabic),
          subtitle: subtitle(value, isArabic),
          trend: AppStrings.kpiVsPeriod.tr(args: [
            (value.trendValue),
            value.prevPeriodDesc(isArabic),
          ]),
          trendUp: value.trendUp,
          gradient: gradient,
        ),
      ),
    );
  }
}
