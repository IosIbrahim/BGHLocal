import 'package:dr_baksh_dashboard/core/core.dart';
import 'package:dr_baksh_dashboard/feature/operating/presentation/mapper/operating_mapper.dart';
import 'package:dr_baksh_dashboard/feature/operating/presentation/widget/overallPayments/overall_payments.dart';
import 'package:dr_baksh_dashboard/feature/operating/presentation/widget/summary/operation_summary_cards.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../core/widgets/dashboard/dashboard.dart';
import '../../../filter/presentation/widgets/filter_sheet.dart';
import '../../data/model/operating_response.dart';
import '../../domain/entity/operating_data.dart';
import '../bloc/operating_bloc.dart';
import '../bloc/operating_event.dart';
import '../bloc/operating_state.dart';


class OperatingScreen extends StatelessWidget {
  const OperatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OperatingBloc>(
      create: (_) => instance<OperatingBloc>()..add(const OperatingStarted()),
      child: BlocBuilder<OperatingBloc, OperatingState>(
        builder: (context, state) {
          return DashboardScaffold(
            title: AppStrings.operating_room.tr(),
            subtitle: AppStrings.surgery_procedure_dashboard.tr(),
            onFilter: () => openDashboardFilter(
              context,
              () => context.read<OperatingBloc>().add(const OperatingStarted()),
            ),
            onRefresh: () => _refresh(context),
            summaryWidget: const OperationSummaryCards(),
            children: [
              SectionHeader(
                iconAsset: DashIcons.pie,
                title: AppStrings.overall_payment.tr(),
                iconColor: AppColors.blue,
              ),
              const SizedBox(height: 12),
              const OverallPayments(),
              const SizedBox(height: 24),
              for (final dept in OperatingMapper.departments(_depratmentCars(state.operationResponse))) ...[
                DepartmentCard(data: dept),
                const SizedBox(height: 16),
              ],
            ],
          );
        },
      ),
    );
  }

  List<OperatingDeptEntry> _depratmentCars(CardState<OperatingResponse> state){
    if (state is! CardData<OperatingResponse>) return [];
    return [
      OperatingDeptEntry(
        name: AppStrings.general_surgery.tr(),
        deptCode: 'SURG',
        totalLabel: 'Procedures',
        total: int.tryParse(state.data.root?.surgery?.surgeryRow?.countAll ?? "") ?? 0,
        cash: int.tryParse(state.data.root?.surgery?.surgeryRow?.countCash ?? "") ?? 0,
        credit: int.tryParse(state.data.root?.surgery?.surgeryRow?.countCredit ?? "") ?? 0,
        completed: int.tryParse(state.data.root?.surgery?.surgeryRow?.complete ?? "") ?? 0,
        pending: int.tryParse(state.data.root?.surgery?.surgeryRow?.pending ?? "") ?? 0,
        cancelled: int.tryParse(state.data.root?.surgery?.surgeryRow?.canceled ?? "") ?? 0,
      ),
      OperatingDeptEntry(
        name: AppStrings.catheterization.tr(),
        deptCode: 'CATH',
        totalLabel: 'Procedures',
        total: int.tryParse(state.data.root?.catheter?.catheterRow?.countAll ?? "") ?? 0,
        cash: int.tryParse(state.data.root?.catheter?.catheterRow?.countCash ?? "") ?? 0,
        credit: int.tryParse(state.data.root?.catheter?.catheterRow?.countCredit ?? "") ?? 0,
        completed: int.tryParse(state.data.root?.catheter?.catheterRow?.complete ?? "") ?? 0,
        pending: int.tryParse(state.data.root?.catheter?.catheterRow?.pending ?? "") ?? 0,
        cancelled: int.tryParse(state.data.root?.catheter?.catheterRow?.canceled ?? "") ?? 0,
      ),
      OperatingDeptEntry(
        name: AppStrings.endoscopy.tr(),
        deptCode: 'ENDO',
        totalLabel: 'Procedures',
        total: int.tryParse(state.data.root?.endosopy?.endosopyRow?.countAll ?? "") ?? 0,
        cash: int.tryParse(state.data.root?.endosopy?.endosopyRow?.countCash ?? "") ?? 0,
        credit: int.tryParse(state.data.root?.endosopy?.endosopyRow?.countCredit ?? "") ?? 0,
        completed: int.tryParse(state.data.root?.endosopy?.endosopyRow?.complete ?? "") ?? 0,
        pending: int.tryParse(state.data.root?.endosopy?.endosopyRow?.pending ?? "") ?? 0,
        cancelled: int.tryParse(state.data.root?.endosopy?.endosopyRow?.canceled ?? "") ?? 0,
      ),
    ];
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<OperatingBloc>();
    bloc.add(const OperatingRefreshed());
    await bloc.stream.firstWhere(
          (s) => !s.isRefreshing,
      orElse: () => bloc.state,
    );
  }

}
