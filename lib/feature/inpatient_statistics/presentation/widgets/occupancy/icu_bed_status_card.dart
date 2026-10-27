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

// ─── ICU Bed Status Card ─────────────────────────────────────────────────────

class IcuBedStatusCard extends StatelessWidget {
  const IcuBedStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return BlocBuilder<InpatientBloc, InpatientState>(
      buildWhen: (prev, curr) =>
          prev.bedStatus != curr.bedStatus || prev.icus != curr.icus,
      builder: (context, state) {
        return DonutChartCard(
          title: AppStrings.icuBedStatus.tr(),
          leadingIcon: Icons.monitor_heart_rounded,
          trailing: _trailing(state.bedStatus),
          state: state.bedStatus.mapData(_segments),
          config: DonutChartConfig(
            size: 180,
            strokeWidth: 24,
            gapDegrees: 3,
            centerLabel: AppStrings.busyBed.tr(),
          ),
          footer: UnitListFooter(state: state.icus, isArabic: isArabic),
        );
      },
    );
  }

  List<DonutSegment> _segments(BedStatus bs) {
    // No ICU beds at all — render a single neutral ring instead of a
    // zero-total donut (which would produce NaN sweep angles).
    if (bs.careTotal == 0) {
      return [
        DonutSegment(
          label: AppStrings.vacant.tr(),
          value: 1,
          color: AppColors.blue,
        ),
      ];
    }
    return [
      DonutSegment(
        label: AppStrings.occupied.tr(),
        value: bs.careOccupied.toDouble(),
        color: AppColors.redAlt,
      ),
      DonutSegment(
        label: AppStrings.vacant.tr(),
        value: bs.careAvailable.toDouble(),
        color: AppColors.blue,
      ),
    ];
  }

  Widget? _trailing(CardState<BedStatus> state) {
    if (state is! CardData<BedStatus>) return null;
    final percent = state.data.icuBusyPercent.round();
    return PillBadge(
      text: AppStrings.icuPercentBusy.tr(args: ['$percent']),
      color: AppColors.dangerRed,
      icon: Icons.warning_amber_rounded,
    );
  }

}
