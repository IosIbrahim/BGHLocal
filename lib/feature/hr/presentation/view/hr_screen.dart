import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../../core/widgets/dashboard/dashboard.dart';
import '../../../filter/presentation/widgets/filter_sheet.dart';
import '../../domain/entity/hr_data.dart';
import '../bloc/hr_bloc.dart';
import '../bloc/hr_event.dart';
import '../bloc/hr_state.dart';
import '../mapper/hr_mapper.dart';

/// HR Dashboard.
///
/// Built on the shared [DashboardScaffold] — same structure and scroll
/// behavior as the other dashboards. Charts come from `core/widgets/charts`.
class HrScreen extends StatelessWidget {
  const HrScreen({super.key});

  /// Only the headline counters get a summary card; admin/tech surface in the
  /// donut below.
  static const _summaryKpis = [HrKpi.totalStaff, HrKpi.doctors, HrKpi.nurses];

  static const _cardIcons = {
    HrKpi.totalStaff: DashIcons.totalStaff,
    HrKpi.doctors: DashIcons.doctors,
    HrKpi.nurses: DashIcons.nursing,
  };

  static const _cardColors = {
    HrKpi.totalStaff: AppColors.blue,
    HrKpi.doctors: AppColors.green,
    HrKpi.nurses: AppColors.purple,
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HrBloc>(
      create: (_) => instance<HrBloc>()..add(const HrStarted()),
      child: BlocBuilder<HrBloc, HrState>(
        builder: (context, state) {
          return DashboardScaffold(
            title: 'HR Dashboard',
            subtitle: 'Staff Management & Overview',
            onFilter: () => openDashboardFilter(
              context,
              () => context.read<HrBloc>().add(const HrStarted()),
            ),
            cards: [
              for (final kpi in _summaryKpis)
                SummaryCardData(
                  iconAsset: _cardIcons[kpi]!,
                  value: HrMapper.counter(state.kpi(kpi)),
                  label: kpi.label,
                  color: _cardColors[kpi]!,
                  valueColor: _cardColors[kpi]!,
                  valueFontSize: 24,
                ),
            ],
            children: [
              // ── Staff Distribution ──────────────────────────────────────
              const SectionHeader(
                iconAsset: DashIcons.pie,
                title: 'Staff Distribution',
              ),
              const SizedBox(height: 12),
              DonutChartCard(
                title: 'Staff by Category',
                state: state.staffByCategory,
                leadingAsset: DashIcons.staffCategory,
                trailing: const PillBadge(
                  text: 'live',
                  iconAsset: DashIcons.barsLive,
                  color: AppColors.accent,
                ),
                config: const DonutChartConfig(
                  size: 200,
                  strokeWidth: 24,
                  gapDegrees: 2,
                  centerLabel: 'TOTAL STAFF',
                  centerValueColor: AppColors.blue,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
