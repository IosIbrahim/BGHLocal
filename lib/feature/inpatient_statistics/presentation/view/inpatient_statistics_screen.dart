import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resources/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dashboard/dashboard.dart';
import '../../../filter/presentation/widgets/filter_sheet.dart';
import '../bloc/inpatient_bloc.dart';
import '../bloc/inpatient_event.dart';
import '../widgets/metrics/key_metrics.dart';
import '../widgets/occupancy/icu_bed_status_card.dart';
import '../widgets/occupancy/wards_occupancy_card.dart';
import '../widgets/summary/summary_cards.dart';

/// Inpatient statistics dashboard. Provides an [InpatientBloc] for the whole
/// subtree and renders on the shared [DashboardScaffold]. The summary cards
/// and pull-to-refresh are wired to the BLoC.
class InpatientStatisticsScreen extends StatelessWidget {
  const InpatientStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InpatientBloc>(
      create: (_) => instance<InpatientBloc>()..add(const InpatientStarted()),
      // Builder so [onRefresh] can read the BLoC from a context *below* the
      // provider.
      child: Builder(
        builder: (context) => DashboardScaffold(
          title: AppStrings.inpatientTitle.tr(),
          subtitle: AppStrings.inpatientSubtitle.tr(),
          summaryWidget: const SummaryCards(),
          onFilter: () => openDashboardFilter(
            context,
            () => context.read<InpatientBloc>().add(const InpatientRefreshed()),
          ),
          onRefresh: () => _refresh(context),
          children: [
            SectionHeader(
              icon: Icons.pie_chart_rounded,
              title: AppStrings.bedOccupancy.tr(),
              iconColor: AppColors.blue,
            ),
            const SizedBox(height: 12),
            const WardsOccupancyCard(),
            const SizedBox(height: 16),
            const IcuBedStatusCard(),
            const SizedBox(height: 24),
            SectionHeader(
              icon: Icons.speed_rounded,
              title: AppStrings.keyMetrics.tr(),
              iconColor: AppColors.blue,
            ),
            const SizedBox(height: 12),
            const KeyMetricsRow(),
          ],
        ),
      ),
    );
  }

  /// Triggers a full reload and keeps the refresh spinner until it settles.
  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<InpatientBloc>();
    bloc.add(const InpatientRefreshed());
    await bloc.stream.firstWhere(
      (s) => !s.isRefreshing,
      orElse: () => bloc.state,
    );
  }
}
