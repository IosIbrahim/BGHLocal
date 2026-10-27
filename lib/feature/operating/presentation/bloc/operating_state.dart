import 'package:dr_baksh_dashboard/feature/operating/data/model/operating_response.dart';

import '../../../../core/widgets/charts/dashboard_charts.dart';


class OperatingState {
  final CardState<OperatingResponse> operationResponse;

  final bool isRefreshing;

  const OperatingState({
    required this.operationResponse,
    this.isRefreshing = false,
  });

  factory OperatingState.initial() => const OperatingState(
      operationResponse: CardLoading()
  );

  OperatingState copyWith({
    CardState<OperatingResponse>? operationResponse,
    bool? isRefreshing
  }) =>
      OperatingState(
        operationResponse: operationResponse ?? this.operationResponse,
        isRefreshing: isRefreshing ?? this.isRefreshing,
      );
}
