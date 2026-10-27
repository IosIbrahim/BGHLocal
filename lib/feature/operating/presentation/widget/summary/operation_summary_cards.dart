import 'package:dr_baksh_dashboard/feature/operating/data/model/operating_response.dart';
import 'package:dr_baksh_dashboard/feature/operating/presentation/bloc/operating_bloc.dart';
import 'package:dr_baksh_dashboard/feature/operating/presentation/bloc/operating_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../../core/widgets/dashboard/summary_card.dart';


class OperationSummaryCards extends StatelessWidget {
  const OperationSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocSelector<OperatingBloc, OperatingState, CardState<OperatingResponse>>(
        selector: (state) => state.operationResponse,
        builder: (context, bedCountState) => CardStateView<OperatingResponse>(
          state: bedCountState,
          builder: (data) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SummaryCard(
                  data: SummaryCardData(
                    iconAsset: DashIcons.scissors,
                    value: '${data.root?.totalCounts?.totalCountsRow?.totalCount}',
                    label: AppStrings.total_procedures.tr(),
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
                    value: '${data.root?.totalCounts?.totalCountsRow?.totalCash}',
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
                    value: '${data.root?.totalCounts?.totalCountsRow?.totalCredit}',
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
