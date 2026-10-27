import 'package:dr_baksh_dashboard/feature/outpatient/data/model/outpatient_response.dart';
import 'package:dr_baksh_dashboard/feature/outpatient/presentation/bloc/outpatient_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../../core/widgets/dashboard/pill_badge.dart';
import '../../bloc/outpatient_state.dart';


class CashAndCredit extends StatelessWidget {
  const CashAndCredit({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OutpatientBloc, OutpatientState>(
      buildWhen: (prev, curr) => prev.outPatientResponse != curr.outPatientResponse,
      builder: (context, state) {
        return DonutChartCard(
          title: AppStrings.cash_Credit.tr(),
          leadingAsset: DashIcons.cashHand,
          trailing: _trailing(state.outPatientResponse),
           state: state.outPatientResponse.mapData(_segments),
          config: DonutChartConfig(
            size: 180,
            strokeWidth: 24,
            gapDegrees: 3,
            centerLabel: AppStrings.Total.tr(),
          )
        );
      },
    );
  }

  List<DonutSegment> _segments(OutpatientResponse bs) {
    final cash = double.tryParse(bs.root?.oUTPARMS?.oUTPARMSROW?.cOUNTCASH?.toString() ?? '') ?? 0.0;

    final credit = double.tryParse(bs.root?.oUTPARMS?.oUTPARMSROW?.cOUNTCREDIT?.toString() ?? '') ?? 0.0;
    final locals = double.tryParse(bs.root?.oUTPARMS?.oUTPARMSROW?.cOUNTCREDIT?.toString() ?? '') ?? 0.0;
    final foreign = double.tryParse(bs.root?.oUTPARMS?.oUTPARMSROW?.cOUNTCREDIT?.toString() ?? '') ?? 0.0;

    if (cash == 0 && credit == 0) {
      return [
        DonutSegment(
          label: AppStrings.No_Data.tr(),
          value: 0.00001,
          color: AppColors.lightSlate,
        ),
      ];
    }

    return [
      DonutSegment(
        label: AppStrings.cash.tr(),
        value: cash,
        color: AppColors.green,
      ),
      DonutSegment(
        label: AppStrings.Credit.tr(),
        value: credit,
        color: AppColors.purple,
      ),
      DonutSegment(
        label: AppStrings.local.tr(),
        value: locals,
        color: AppColors.purple,
      ),
      DonutSegment(
        label: AppStrings.foreign.tr(),
        value: foreign,
        color: AppColors.purple,
      ),
    ];
  }

  Widget? _trailing(CardState<OutpatientResponse> state) {
    if (state is! CardData<OutpatientResponse>) return null;
    final percent = state.data.root?.oUTPARMS?.oUTPARMSROW?.cashAndCreditPercentage;
    return PillBadge(
      text: AppStrings.occupancyPercentFull.tr(args: ['$percent']),
      color: AppColors.green,
      icon: Icons.trending_up_rounded,
    );
  }

}
