import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../../core/widgets/dashboard/summary_card.dart';
import '../../../domain/entity/inpatient_models.dart';
import '../../bloc/inpatient_bloc.dart';
import '../../bloc/inpatient_state.dart';

// ─── Summary Cards ──────────────────────────────────────────────────────────

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocSelector<InpatientBloc, InpatientState, CardState<BedCount>>(
        selector: (state) => state.bedCount,
        builder: (context, bedCountState) => CardStateView<BedCount>(
          state: bedCountState,
          builder: (data) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SummaryCard(
                  data: SummaryCardData(
                    icon: Icons.bed_rounded,
                    color: AppColors.blue,
                    value: '${data.total}',
                    label: AppStrings.totalBeds.tr(),
                    valueFontSize: 22,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  data: SummaryCardData(
                    icon: Icons.local_hospital_rounded,
                    color: AppColors.green,
                    value: '${data.ward}',
                    label: AppStrings.wards.tr(),
                    valueColor: AppColors.green,
                    valueFontSize: 22,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  data: SummaryCardData(
                    icon: Icons.monitor_heart_rounded,
                    color: AppColors.dangerRed,
                    value: '${data.icu}',
                    label: AppStrings.icu.tr(),
                    valueColor: AppColors.dangerRed,
                    valueFontSize: 22,
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
