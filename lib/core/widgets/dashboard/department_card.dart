import 'package:dr_baksh_dashboard/core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dash_icons.dart';

/// Data for one department block on the Operating Room screen.
class DepartmentData {
  final String name;

  /// White header icon (scissors / heart / microscope).
  final String iconAsset;

  /// Header icon gradient (start → end).
  final Color iconColor;
  final Color iconColorEnd;

  final int total;
  final String totalLabel;

  final int cash;
  final int credit;
  final int completed;
  final int pending;
  final int cancelled;

  const DepartmentData({
    required this.name,
    required this.iconAsset,
    required this.iconColor,
    required this.iconColorEnd,
    required this.total,
    required this.totalLabel,
    required this.cash,
    required this.credit,
    required this.completed,
    required this.pending,
    required this.cancelled,
  });
}

/// A department block: header + total + cash/credit + completed/pending/
/// cancelled tiles. The inner tile colours are fixed (shared by every
/// department); only the header icon/gradient and the values vary.
class DepartmentCard extends StatelessWidget {
  final DepartmentData data;

  const DepartmentCard({super.key, required this.data});

  // Fixed tile palette (same across departments).
  static const _blue = Color(0xFF0076A8);
  static const _green = Color(0xFF37C88C);
  static const _purple = Color(0xFF8B5CF6);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFFF4B2B);

  static const _totalBg = Color(0xFFF4FBF9);
  static const _cashBg = Color(0xFFF4FBF9);
  static const _cashBorder = Color(0xFFB0E6C6);
  static const _creditBg = Color(0xFFF6F2FE);
  static const _creditBorder = Color(0xFFC0C4FB);
  static const _completedBg = Color(0xFFF1FBF7);
  static const _completedBorder = Color(0x6642CA93);
  static const _pendingBg = Color(0xFFFEF6EA);
  static const _pendingBorder = Color(0x66F59E0B);
  static const _cancelledBg = Color(0xFFFFEFEC);
  static const _cancelledBorder = Color(0x66FF504C);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _header(),
          const SizedBox(height: 14),
          _totalTile(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _iconStatTile(
                  value: data.cash,
                  label: AppStrings.cash.tr(),
                  iconAsset: DashIcons.cash,
                  color: _green,
                  bg: _cashBg,
                  border: _cashBorder,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _iconStatTile(
                  value: data.credit,
                  label: AppStrings.Credit.tr(),
                  iconAsset: DashIcons.creditCard,
                  color: _purple,
                  bg: _creditBg,
                  border: _creditBorder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _statusTile(
                  value: data.completed,
                  label: AppStrings.completed.tr(),
                  iconAsset: DashIcons.check,
                  color: _green,
                  bg: _completedBg,
                  border: _completedBorder,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statusTile(
                  value: data.pending,
                  label: AppStrings.pending.tr(),
                  iconAsset: DashIcons.clock,
                  color: _amber,
                  bg: _pendingBg,
                  border: _pendingBorder,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statusTile(
                  value: data.cancelled,
                  label: AppStrings.cancelled.tr(),
                  iconAsset: DashIcons.xmark,
                  color: _red,
                  bg: _cancelledBg,
                  border: _cancelledBorder,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [data.iconColor, data.iconColorEnd],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: SvgPicture.asset(
            data.iconAsset,
            width: 22,
            height: 22,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            data.name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.navy,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalTile() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: _totalBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            '${data.total}',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: _blue,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.totalLabel,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconStatTile({
    required int value,
    required String label,
    required String iconAsset,
    required Color color,
    required Color bg,
    required Color border,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconAsset, width: 22, height: 22),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusTile({
    required int value,
    required String label,
    required String iconAsset,
    required Color color,
    required Color bg,
    required Color border,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          SvgPicture.asset(iconAsset, width: 26, height: 26),
          const SizedBox(height: 6),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
