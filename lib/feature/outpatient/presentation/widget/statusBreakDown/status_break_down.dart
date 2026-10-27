import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_strings.dart';
import '../../../../../core/widgets/charts/models/card_state.dart';
import '../../../../../core/widgets/dashboard/status_breakdown.dart';
import '../../../data/model/outpatient_response.dart';
import '../../../domain/entity/outpatient_data.dart';
import '../../bloc/outpatient_bloc.dart';
import '../../bloc/outpatient_state.dart';
import '../../mapper/outpatient_mapper.dart';

class StatusBreakDown extends StatelessWidget {
  const StatusBreakDown({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OutpatientBloc, OutpatientState>(
      buildWhen: (prev, curr) => prev.outPatientResponse != curr.outPatientResponse,
      builder: (context, state) {
        return StatusBreakdown(items: OutpatientMapper.statusItems(_statusBreakDown(state.outPatientResponse)));
      },
    );
  }

  List<OutpatientStatusEntry> _statusBreakDown(CardState<OutpatientResponse> bs) {
    if (bs is! CardData<OutpatientResponse>) return [];
    return [
      OutpatientStatusEntry(label: AppStrings.New.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.cONSULTATIONS ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Waiting.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.pENDING ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Cancelled.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.cANCELED ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Follow_up.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.fOLLOWUP ?? "") ?? 0),
      OutpatientStatusEntry(label: AppStrings.Apology_No_Show.tr(), count: int.tryParse(bs.data.root?.oUTPARMS?.oUTPARMSROW?.nOSHOW ?? "") ?? 0),
    ];
  }

}
