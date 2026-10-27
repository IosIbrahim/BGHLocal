import 'package:dr_baksh_dashboard/feature/outpatient/data/model/outpatient_response.dart';

import '../../../../core/widgets/charts/dashboard_charts.dart';

class OutpatientState {

  final CardState<OutpatientResponse> outPatientResponse;

  final bool isRefreshing;

  const OutpatientState({
    required this.outPatientResponse,
    this.isRefreshing = false,
  });

  factory OutpatientState.initial() => const OutpatientState(
    outPatientResponse: CardLoading()
  );

  OutpatientState copyWith({
    CardState<OutpatientResponse>? outPatientResponse,
    bool? isRefreshing
  }) =>
      OutpatientState(
        outPatientResponse: outPatientResponse ?? this.outPatientResponse,
        isRefreshing: isRefreshing ?? this.isRefreshing,
      );
}
