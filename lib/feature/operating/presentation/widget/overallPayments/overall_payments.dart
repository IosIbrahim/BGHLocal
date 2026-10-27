
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/donut_chart/models/donut_chart_config.dart';
import '../../../../../core/widgets/charts/donut_chart/models/donut_segment.dart';
import '../../../../../core/widgets/charts/models/card_state.dart';
import '../../../../../core/widgets/charts/widgets/donut_chart_card.dart';
import '../../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../../core/widgets/dashboard/pill_badge.dart';
import '../../../data/model/operating_response.dart';
import '../../bloc/operating_bloc.dart';
import '../../bloc/operating_state.dart';


class OverallPayments extends StatelessWidget {
  const OverallPayments({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OperatingBloc, OperatingState>(
      buildWhen: (prev, curr) => prev.operationResponse != curr.operationResponse,
      builder: (context, state) {
        return DonutChartCard(
          title: AppStrings.cash_Credit.tr(),
          leadingAsset: DashIcons.cashHand,
          trailing: _trailing(state.operationResponse),
           state: state.operationResponse.mapData(_segments),
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

  List<DonutSegment> _segments(OperatingResponse bs) {
    final cash = double.tryParse(bs.root?.totalCounts?.totalCountsRow?.totalCash?.toString() ?? '') ?? 0.0;

    final credit = double.tryParse(bs.root?.totalCounts?.totalCountsRow?.totalCredit?.toString() ?? '') ?? 0.0;

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
    ];
  }

  Widget? _trailing(CardState<OperatingResponse> state) {
    if (state is! CardData<OperatingResponse>) return null;
    final percent = state.data.root?.totalCounts?.totalCountsRow?.cashAndCreditPercentage;
    return PillBadge(
      text: AppStrings.occupancyPercentFull.tr(args: ['$percent']),
      color: AppColors.green,
      icon: Icons.trending_up_rounded,
    );
  }

}
