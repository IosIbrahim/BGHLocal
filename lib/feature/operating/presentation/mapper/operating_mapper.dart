import 'package:flutter/material.dart' show Color;

import '../../../../core/core.dart';
import '../../../../core/widgets/dashboard/dash_icons.dart';
import '../../../../core/widgets/dashboard/department_card.dart';
import '../../domain/entity/operating_data.dart';

/// Visual config for a department: icon + gradient colours.
typedef _DeptVisual = ({String icon, Color colorStart, Color colorEnd});

/// Pure presentation mapper for the Operating Room dashboard, including the
/// backend-code → icon/colour map.
class OperatingMapper {
  const OperatingMapper._();

  static const _fallback = (
    icon: DashIcons.scissors,
    colorStart: AppColors.teal,
    colorEnd: AppColors.tealLight,
  );

  static const Map<String, _DeptVisual> _deptVisuals = {
    'SURG': (
      icon: DashIcons.scissors,
      colorStart: AppColors.teal,
      colorEnd: AppColors.tealLight,
    ),
    'CATH': (
      icon: DashIcons.heart,
      colorStart: Color(0xFFFF5B5B),
      colorEnd: Color(0xFFE5342A),
    ),
    'ENDO': (
      icon: DashIcons.microscope,
      colorStart: Color(0xFF1FBFA8),
      colorEnd: Color(0xFF14A890),
    ),
  };


  static List<DepartmentData> departments(List<OperatingDeptEntry> entries) =>
      entries.map(_toDeptData).toList();

  static DepartmentData _toDeptData(OperatingDeptEntry dept) {
    final visual = _deptVisuals[dept.deptCode.toUpperCase()] ?? _fallback;
    return DepartmentData(
      name: dept.name,
      iconAsset: visual.icon,
      iconColor: visual.colorStart,
      iconColorEnd: visual.colorEnd,
      total: dept.total,
      totalLabel: dept.totalLabel,
      cash: dept.cash,
      credit: dept.credit,
      completed: dept.completed,
      pending: dept.pending,
      cancelled: dept.cancelled,
    );
  }
}
