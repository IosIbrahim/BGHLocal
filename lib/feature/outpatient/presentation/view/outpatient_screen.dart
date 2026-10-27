import 'package:dr_baksh_dashboard/core/core.dart';
import 'package:dr_baksh_dashboard/feature/outpatient/presentation/widget/cashAndCredit/cash_and_credit.dart';
import 'package:dr_baksh_dashboard/feature/outpatient/presentation/widget/summary/outpatient_summary_cards.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/dashboard/dashboard.dart';
import '../../../filter/presentation/widgets/filter_sheet.dart';
import '../../data/model/outpatient_response.dart';
import '../../domain/entity/outpatient_data.dart';
import '../bloc/outpatient_bloc.dart';
import '../bloc/outpatient_event.dart';
import '../bloc/outpatient_state.dart';
import '../mapper/outpatient_mapper.dart';
import '../widget/statusBreakDown/status_break_down.dart';


class OutpatientScreen extends StatelessWidget {
  const OutpatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OutpatientBloc>(
      create: (_) => instance<OutpatientBloc>()..add(const OutpatientStarted()),
      child: BlocBuilder<OutpatientBloc, OutpatientState>(
        builder: (context, state) {
          return DashboardScaffold(
            title: AppStrings.outpatient_analytics.tr(),
            subtitle: AppStrings.real_time_clinic_monitoring.tr(),
            onFilter: () => openDashboardFilter(
              context,
              () => context.read<OutpatientBloc>().add(const OutpatientStarted()),
            ),
            onRefresh: () => _refresh(context),
            summaryWidget: const OutpatientSummaryCards(),
            children: [
              SectionHeader(
                icon: Icons.pie_chart_rounded,
                title: AppStrings.consultation_types.tr(),
                iconColor: AppColors.blue,
              ),
              const SizedBox(height: 12),
              const CashAndCredit(),
              const SizedBox(height: 24),
              SectionHeader(
                iconAsset: DashIcons.clipboard,
                title: AppStrings.status_breakdown.tr(),
                iconColor: AppColors.blue,
              ),
              const SizedBox(height: 12),
              const StatusBreakDown(),
              const SizedBox(height: 24),

              BarChartCard(
                title: AppStrings.status_distribution.tr(),
                state: CardData(OutpatientMapper.statusBars(_statusBreakDown(state.outPatientResponse))),
                leadingAsset: DashIcons.barChart,
                trailing: PillBadge(
                  text: AppStrings.Live.tr(),
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

  List<OutpatientStatusEntry> _statusBreakDown(CardState<OutpatientResponse> bs) {
    if (bs is! CardData<OutpatientResponse>) return [];
    return [
      OutpatientStatusEntry(label: AppStrings.New.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.cONSULTATIONS ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Follow_up.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.fOLLOWUP ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Waiting.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.pENDING ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Cancelled.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.cANCELED ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Apology_No_Show.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.nOSHOW ?? "") ?? 0),
    ];
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<OutpatientBloc>();
    bloc.add(const OutpatientRefreshed());
    await bloc.stream.firstWhere(
          (s) => !s.isRefreshing,
      orElse: () => bloc.state,
    );
  }
}
