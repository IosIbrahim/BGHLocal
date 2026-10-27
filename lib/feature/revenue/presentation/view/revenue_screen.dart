import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resources/language_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../../core/widgets/dashboard/dashboard.dart';
import '../../../filter/presentation/widgets/filter_sheet.dart';
import '../../domain/entity/revenue_data.dart';
import '../bloc/revenue_bloc.dart';
import '../bloc/revenue_event.dart';
import '../bloc/revenue_state.dart';
import '../mapper/revenue_mapper.dart';

/// Revenue Dashboard.
///
/// Built on the shared [DashboardScaffold]. The donut formats its values as
/// currency (`$` prefix + K/M suffix); charts come from `core/widgets/charts`.
class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RevenueBloc>(
      create: (_) => instance<RevenueBloc>()..add(const RevenueStarted()),
      child: BlocBuilder<RevenueBloc, RevenueState>(
        builder: (context, state) {
          return DashboardScaffold(
            title: 'Revenue Dashboard',
            subtitle: 'Financial Overview & Analytics',
            onFilter: () => openDashboardFilter(
              context,
              () => context.read<RevenueBloc>().add(const RevenueStarted()),
            ),
            cards: [
              SummaryCardData(
                iconAsset: DashIcons.moneyBag,
                value: RevenueMapper.counter(state.kpi(RevenueKpi.total)),
                label: 'Total Revenue',
                color: AppColors.blue,
                valueColor: AppColors.blue,
                valueFontSize: 22,
              ),
              SummaryCardData(
                iconAsset: DashIcons.cash,
                value: RevenueMapper.counter(state.kpi(RevenueKpi.cash)),
                label: 'CASH',
                color: AppColors.green,
                valueColor: AppColors.green,
                valueFontSize: 22,
              ),
              SummaryCardData(
                iconAsset: DashIcons.creditCard,
                value: RevenueMapper.counter(state.kpi(RevenueKpi.credit)),
                label: 'Credit',
                color: AppColors.purple,
                valueColor: AppColors.purple,
                valueFontSize: 22,
              ),
              SummaryCardData(
                iconAsset: DashIcons.cash,
                value: RevenueMapper.counter(state.kpi(RevenueKpi.inPatient)),
                label: 'InPatient',
                color: AppColors.purple,
                valueColor: AppColors.purple,
                valueFontSize: 22,
              ),
              SummaryCardData(
                iconAsset: DashIcons.creditCard,
                value: RevenueMapper.counter(state.kpi(RevenueKpi.outPatient)),
                label: 'OutPatient',
                color: AppColors.green,
                valueColor: AppColors.green,
                valueFontSize: 22,
              ),
            ],
            children: [
              // ── Revenue Distribution ────────────────────────────────────
              const SectionHeader(
                iconAsset: DashIcons.pie,
                title: 'Revenue Distribution',
              ),
              const SizedBox(height: 12),
              DonutChartCard(
                title: 'Cash vs Credit',
                state: state.cashVsCredit,
                leadingAsset: DashIcons.staffCategory,
                trailing: _trendBadge(
                  state.kpi(RevenueKpi.total),
                  isArabic: context.isArabic,
                ),
                config: const DonutChartConfig(
                  size: 200,
                  strokeWidth: 24,
                  gapDegrees: 2,
                  centerValueColor: AppColors.blue,
                  valuePrefix: '\$',
                  centerValueFontSize: 30,
                ),
              ),
              const SizedBox(height: 24),

              // ── Monthly Trends ──────────────────────────────────────────
              const SectionHeader(
                iconAsset: DashIcons.pie,
                title: 'Monthly Trends',
              ),
              const SizedBox(height: 12),
              MetricCards(
                items: RevenueMapper.trendItems(
                  state.kpi(RevenueKpi.total),
                  state.kpi(RevenueKpi.credit),
                  isArabic: context.isArabic,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Total-revenue trend on the donut header, e.g. "+12.3% Current Month" with
  /// an up/down arrow. Returns null until the KPI resolves, so the badge shows
  /// real data rather than a placeholder.
  static Widget? _trendBadge(
    CardState<RevenueKpiValue> total, {
    required bool isArabic,
  }) {
    if (total is! CardData<RevenueKpiValue>) return null;
    final kpi = total.data;
    return PillBadge(
      text: '${RevenueMapper.fmtPercent(kpi.trendPercent)} '
          '${kpi.currPeriodDesc(isArabic: isArabic)}',
      icon: kpi.trendUp
          ? Icons.trending_up_rounded
          : Icons.trending_down_rounded,
      color: kpi.trendUp ? AppColors.green : AppColors.coral,
      // Percentage + period description runs long ("-92.6% Current Month"),
      // so this badge sits a step below the default size.
      fontSize: 11,
    );
  }
}
