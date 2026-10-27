import '../../../../core/constants/app_constants.dart';
import '../../domain/entity/filter_options.dart';

enum FilterStatus { loading, loaded, error }

/// State for the filter sheet: the loaded lookups plus the user's in-progress
/// (draft) selection. The draft is only pushed to the global store on "Apply",
/// so dismissing the sheet discards it.
class FilterState {
  final FilterStatus status;
  final String? errorMessage;

  final List<FilterOption> branches;
  final List<FilterOption> periods;

  /// Draft selection (null branch = "all"/default branch).
  final String? selectedBranchId;
  final String selectedDateFlag;
  final DateTime? fromDate;
  final DateTime? toDate;

  const FilterState({
    this.status = FilterStatus.loading,
    this.errorMessage,
    this.branches = const [],
    this.periods = const [],
    this.selectedBranchId,
    required this.selectedDateFlag,
    this.fromDate,
    this.toDate,
  });

  FilterState copyWith({
    FilterStatus? status,
    String? errorMessage,
    List<FilterOption>? branches,
    List<FilterOption>? periods,
    String? selectedBranchId,
    bool clearBranch = false,
    String? selectedDateFlag,
    DateTime? fromDate,
    DateTime? toDate,
  }) =>
      FilterState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        branches: branches ?? this.branches,
        periods: periods ?? this.periods,
        selectedBranchId:
            clearBranch ? null : (selectedBranchId ?? this.selectedBranchId),
        selectedDateFlag: selectedDateFlag ?? this.selectedDateFlag,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
      );

  /// Whether the "Period" flag is the active draft selection.
  bool get isPeriod => selectedDateFlag == AppConstants.periodDateFlag;

  /// The "Period" flag requires both range bounds. Any other flag is always
  /// applicable.
  bool get canApply => !isPeriod || (fromDate != null && toDate != null);
}
