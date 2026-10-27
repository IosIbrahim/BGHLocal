import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/resources/language_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/charts/dashboard_charts.dart';
import '../../../../../core/widgets/charts/donut_chart/donut_chart.dart';
import '../../../domain/entity/inpatient_models.dart';
import '../../bloc/inpatient_bloc.dart';
import '../../bloc/inpatient_state.dart';
import '../common/common.dart';
import 'ward_progress_bar.dart';

// ─── Wards Occupancy Card ────────────────────────────────────────────────────

class WardsOccupancyCard extends StatelessWidget {
  const WardsOccupancyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return BlocBuilder<InpatientBloc, InpatientState>(
      buildWhen: (prev, curr) =>
          prev.bedStatus != curr.bedStatus || prev.wards != curr.wards,
      builder: (context, state) {
        return DonutChartCard(
          title: AppStrings.wardsOccupancy.tr(),
          leadingIcon: Icons.domain_rounded,
          trailing: _trailing(state.bedStatus),
          state: state.bedStatus.mapData(_segments),
          config: DonutChartConfig(
            size: 180,
            strokeWidth: 24,
            gapDegrees: 3,
            centerLabel: AppStrings.occupancy.tr(),
          ),
          footer: UnitListFooter(state: state.wards, isArabic: isArabic),
        );
      },
    );
  }

  List<DonutSegment> _segments(BedStatus bs) {
    // No ward beds at all — render a single neutral ring instead of a
    // zero-total donut (which would produce NaN sweep angles).
    if (bs.floorTotal == 0) {
      return [
        DonutSegment(
          label: AppStrings.vacant.tr(),
          value: 1,
          color: AppColors.lightSlate,
        ),
      ];
    }
    return [
      DonutSegment(
        label: AppStrings.occupied.tr(),
        value: bs.floorOccupied.toDouble(),
        color: AppColors.green,
      ),
      DonutSegment(
        label: AppStrings.vacant.tr(),
        value: bs.floorAvailable.toDouble(),
        color: AppColors.lightSlate,
      ),
    ];
  }

  Widget? _trailing(CardState<BedStatus> state) {
    if (state is! CardData<BedStatus>) return null;
    final percent = state.data.floorBusyPercent.round();
    return PillBadge(
      text: AppStrings.occupancyPercentFull.tr(args: ['$percent']),
      color: AppColors.green,
      icon: Icons.trending_up_rounded,
    );
  }

}
