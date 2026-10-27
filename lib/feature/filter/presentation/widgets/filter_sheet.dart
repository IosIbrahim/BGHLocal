import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resources/app_strings.dart';
import '../../../../core/resources/language_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/values_manager.dart';
import '../../domain/entity/filter_options.dart';
import '../cubit/filter_cubit.dart';
import '../cubit/filter_state.dart';

/// Opens the dashboard filter as a modal bottom sheet (1:1 with the Figma).
///
/// Resolves to `true` when the user tapped "Apply Filters" (the selection has
/// been written to the shared [DashboardFilterStore]); `null`/`false` when the
/// sheet was dismissed without applying. Callers should reload their dashboard
/// when this completes truthy.
Future<bool?> showDashboardFilterSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => BlocProvider<FilterCubit>(
      create: (_) => instance<FilterCubit>()..load(),
      child: const _FilterSheet(),
    ),
  );
}

/// Opens the filter sheet and invokes [onApplied] when the user committed a new
/// filter (and the originating [context] is still mounted). Reduces every
/// dashboard's filter button to a one-liner that reloads its own state.
Future<void> openDashboardFilter(
  BuildContext context,
  VoidCallback onApplied,
) async {
  final applied = await showDashboardFilterSheet(context);
  if (applied == true && context.mounted) onApplied();
}

class _FilterSheet extends StatelessWidget {
  const _FilterSheet();

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          final cubit = context.read<FilterCubit>();
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SheetHeader(),
                const SizedBox(height: 20),
                if (state.status == FilterStatus.error)
                  _ErrorRow(
                    message: state.errorMessage,
                    onRetry: cubit.load,
                  )
                else if (state.status == FilterStatus.loading)
                  // Keep the whole form hidden until `Load-Branches` resolves —
                  // the branch/period options aren't known yet.
                  const _LoadingRow()
                else ...[
                  _FieldLabel(AppStrings.filterSelectBranch.tr()),
                  const SizedBox(height: 8),
                  _BranchDropdown(
                    branches: state.branches,
                    value: state.selectedBranchId,
                    isArabic: isArabic,
                    onChanged: cubit.selectBranch,
                  ),
                  const SizedBox(height: 20),
                  _FieldLabel(AppStrings.filterSelectPeriod.tr()),
                  const SizedBox(height: 10),
                  _PeriodChips(
                    periods: state.periods,
                    selected: state.selectedDateFlag,
                    isArabic: isArabic,
                    onSelected: cubit.selectPeriod,
                  ),
                  // The custom range only applies to the "Period" flag, so it
                  // stays hidden for every other selection.
                  if (state.isPeriod) ...[
                    const SizedBox(height: 20),
                    _FieldLabel(AppStrings.filterCustomDateRange.tr()),
                    const SizedBox(height: 8),
                    _DateRangeRow(
                      from: state.fromDate,
                      to: state.toDate,
                      onFrom: cubit.setFromDate,
                      onTo: cubit.setToDate,
                    ),
                    if (!state.canApply) ...[
                      const SizedBox(height: 10),
                      Text(
                        AppStrings.filterPeriodDatesRequired.tr(),
                        style: const TextStyle(
                          color: AppColors.dangerRed,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                  const SizedBox(height: 28),
                  // Apply is only offered once the lookups load: while loading
                  // it stays disabled, and on failure the error/retry row
                  // replaces the whole form so there is nothing to commit.
                  _ApplyButton(
                    enabled: state.status == FilterStatus.loaded &&
                        state.canApply,
                    onTap: () {
                      cubit.apply();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.filter_alt_rounded, color: AppColors.accent, size: 24),
        const SizedBox(width: 10),
        Text(
          AppStrings.filterTitle.tr(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
          ),
        ),
        const Spacer(),
        Material(
          color: AppColors.navInactiveBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Navigator.of(context).maybePop(),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.close_rounded, size: 20, color: AppColors.slate),
            ),
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: AppColors.muted,
      ),
    );
  }
}

class _BranchDropdown extends StatelessWidget {
  final List<FilterOption> branches;
  final String? value;
  final bool isArabic;
  final ValueChanged<String?> onChanged;

  const _BranchDropdown({
    required this.branches,
    required this.value,
    required this.isArabic,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Guard against a stale id that isn't in the loaded list.
    final hasValue = branches.any((b) => b.id == value);
    return DropdownButtonFormField<String?>(
      initialValue: hasValue ? value : null,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: AppColors.accent),
      hint: Text(AppStrings.filterBranchHint.tr(),
          style: const TextStyle(color: AppColors.muted, fontSize: 15)),
      style: const TextStyle(
          color: AppColors.navy, fontSize: 15, fontWeight: FontWeight.w500),
      decoration: _fieldDecoration,
      items: [
        // Lets the user fall back to the session's default branch ("all").
        DropdownMenuItem<String?>(
          value: null,
          child: Text(
            AppStrings.filterAllBranches.tr(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        for (final b in branches)
          DropdownMenuItem<String?>(
            value: b.id,
            child: Text(
              b.name(isArabic: isArabic),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class _PeriodChips extends StatelessWidget {
  final List<FilterOption> periods;
  final String selected;
  final bool isArabic;
  final ValueChanged<String> onSelected;

  const _PeriodChips({
    required this.periods,
    required this.selected,
    required this.isArabic,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Options are loaded before this renders; an empty list means the backend
    // returned none, so there is simply nothing to show.
    if (periods.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: AppGap.g8,
      runSpacing: AppGap.g8,
      children: [
        for (final p in periods)
          _Chip(
            label: p.name(isArabic: isArabic),
            selected: p.id == selected,
            onTap: () => onSelected(p.id),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12, vertical: AppPadding.p8),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [AppColors.headerBlue, AppColors.teal],
                  )
                : null,
            color: selected ? null : Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.r8),
            border: Border.all(
              color: selected ? Colors.transparent : AppColors.lightSlate,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppFontSize.f13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.navy,
            ),
          ),
        ),
      ),
    );
  }
}

class _DateRangeRow extends StatelessWidget {
  final DateTime? from;
  final DateTime? to;
  final ValueChanged<DateTime> onFrom;
  final ValueChanged<DateTime> onTo;

  const _DateRangeRow({
    required this.from,
    required this.to,
    required this.onFrom,
    required this.onTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DateField(
            date: from,
            onPick: onFrom,
            firstDate: DateTime(2000),
            lastDate: to ?? DateTime(2100),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(AppStrings.filterDateTo.tr(),
              style: const TextStyle(color: AppColors.muted, fontSize: 14)),
        ),
        Expanded(
          child: _DateField(
            date: to,
            onPick: onTo,
            firstDate: from ?? DateTime(2000),
            lastDate: DateTime(2100),
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final DateTime? date;
  final ValueChanged<DateTime> onPick;
  final DateTime firstDate;
  final DateTime lastDate;

  const _DateField({
    required this.date,
    required this.onPick,
    required this.firstDate,
    required this.lastDate,
  });

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) onPick(picked);
  }

  @override
  Widget build(BuildContext context) {
    final label = date == null
        ? AppStrings.filterDatePlaceholder.tr()
        : DateFormat('dd/MM/yyyy').format(date!);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _pick(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightSlate),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: date == null ? AppColors.muted : AppColors.navy,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.calendar_month_rounded,
                size: 18, color: AppColors.accent),
          ],
        ),
      ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;
  const _ApplyButton({required this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: enabled ? onTap : null,
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.headerBlue, AppColors.headerTeal],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.filterApply.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-sheet placeholder shown while `Load-Branches` is in flight, before the
/// branch/period options are known.
class _LoadingRow extends StatelessWidget {
  const _LoadingRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}

class _ErrorRow extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const _ErrorRow({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const Icon(Icons.error_outline_rounded,
              color: AppColors.dangerRed, size: 32),
          const SizedBox(height: 10),
          Text(
            message ?? AppStrings.filterLoadFailed.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMid, fontSize: 14),
          ),
          const SizedBox(height: 12),
          TextButton(onPressed: onRetry, child: Text(AppStrings.filterRetry.tr())),
        ],
      ),
    );
  }
}

/// Shared white rounded field outline used by the branch dropdown.
const _fieldDecoration = InputDecoration(
  isDense: true,
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: AppColors.lightSlate),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: AppColors.accent),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: AppColors.lightSlate),
  ),
);
