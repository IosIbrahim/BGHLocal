import 'package:dr_baksh_dashboard/feature/outpatient/data/model/outpatient_response.dart';
import 'package:dr_baksh_dashboard/feature/outpatient/presentation/bloc/outpatient_bloc.dart';
import 'package:dr_baksh_dashboard/feature/outpatient/presentation/bloc/outpatient_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../../core/widgets/dashboard/summary_card.dart';


class OutpatientSummaryCards extends StatelessWidget {
  const OutpatientSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocSelector<OutpatientBloc, OutpatientState, CardState<OutpatientResponse>>(
        selector: (state) => state.outPatientResponse,
        builder: (context, bedCountState) => CardStateView<OutpatientResponse>(
          state: bedCountState,
          builder: (data) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SummaryCard(
                  data: SummaryCardData(
                    iconAsset: DashIcons.users,
                    value: '${data.root?.oUTPARMS?.oUTPARMSROW?.cOUNTALL}',
                    label: AppStrings.total_today.tr(),
                    color: AppColors.blue,
                    valueColor: AppColors.blue,
                  )
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  data: SummaryCardData(
                    iconAsset: DashIcons.cash,
                    value: '${data.root?.oUTPARMS?.oUTPARMSROW?.cOUNTCASH}',
                    label: AppStrings.cash.tr(),
                    color: AppColors.green,
                    valueColor: AppColors.green,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  data: SummaryCardData(
                    iconAsset: DashIcons.creditCard,
                    value: '${data.root?.oUTPARMS?.oUTPARMSROW?.cOUNTCREDIT}',
                    label: AppStrings.Credit.tr(),
                    color: AppColors.purple,
                    valueColor: AppColors.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
