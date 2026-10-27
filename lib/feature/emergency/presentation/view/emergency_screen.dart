import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resources/language_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../../core/widgets/dashboard/dashboard.dart';
import '../../../filter/presentation/widgets/filter_sheet.dart';
import '../bloc/emergency_bloc.dart';
import '../mapper/emergency_mapper.dart';
import '../bloc/emergency_event.dart';
import '../bloc/emergency_state.dart';

/// Emergency Room dashboard.
///
/// Built on the shared [DashboardScaffold] — same structure and scroll
/// behavior as the Outpatient screen. Charts come from `core/widgets/charts`.
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmergencyBloc>(
      create: (_) => instance<EmergencyBloc>()..add(const EmergencyStarted()),
      child: BlocBuilder<EmergencyBloc, EmergencyState>(
        builder: (context, state) {
          return DashboardScaffold(
            title: 'Emergency Room',
            subtitle: 'Real-time Triage & Patient Flow',
            onFilter: () => openDashboardFilter(
              context,
              () => context.read<EmergencyBloc>().add(const EmergencyStarted()),
            ),
            cards: [
              SummaryCardData(
                iconAsset: DashIcons.ambulance,
                value: '${state.totalEr}',
                label: 'Total ER',
                color: AppColors.blue,
                valueColor: AppColors.blue,
              ),
              SummaryCardData(
                iconAsset: DashIcons.flag,
                value: '${state.saudiCount}',
                label: 'SAUDI',
                color: AppColors.green,
                valueColor: AppColors.green,
              ),
              SummaryCardData(
                iconAsset: DashIcons.passport,
                value: '${state.nonSaudiCount}',
                label: 'Non-Saudi',
                color: AppColors.amber,
                valueColor: AppColors.amber,
              ),
            ],
            children: [
              // ── Payment Types ───────────────────────────────────────────
              const SectionHeader(
                iconAsset: DashIcons.pie,
                title: 'Payment Types',
              ),
              const SizedBox(height: 12),
              DonutChartCard(
                title: 'Cash vs Credit',
                state: state.paymentTypes,
                leadingAsset: DashIcons.cashHand,
                trailing: const PillBadge(
                  text: '+8% Today',
                  icon: Icons.trending_up_rounded,
                  color: AppColors.green,
                ),
                config: const DonutChartConfig(
                  size: 200,
                  strokeWidth: 24,
                  gapDegrees: 2,
                  centerValueColor: AppColors.blue,
                ),
              ),
              const SizedBox(height: 24),

              // ── Status Breakdown ────────────────────────────────────────
              const SectionHeader(
                iconAsset: DashIcons.clipboard,
                title: 'Status Breakdown',
              ),
              const SizedBox(height: 12),
              StatusBreakdown(items: state.statusBreakdown),
              const SizedBox(height: 24),

              // ── Nationality Distribution ────────────────────────────────
              BarChartCard(
                title: 'Nationality Distribution',
                state: state.nationalityDistribution.mapData(
                  (entries) => EmergencyMapper.nationalityBars(
                    entries,
                    isArabic: context.isArabic,
                  ),
                ),
                leadingAsset: DashIcons.barChart,
                trailing: const PillBadge(
                  text: 'Live',
                  iconAsset: DashIcons.barsLive,
                  color: AppColors.accent,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
