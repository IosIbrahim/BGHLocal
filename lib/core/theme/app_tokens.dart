import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Shared box shadows.
class AppShadows {
  const AppShadows._();

  static const card = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );

  static const strong = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 16,
    offset: Offset(0, 6),
  );
}

/// Shared text styles using the Inter font family.
class AppTextStyles {
  const AppTextStyles._();

  static const display = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.navy,
    letterSpacing: 0.5,
  );

  static const headline = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
    letterSpacing: 0,
  );

  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );

  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.muted,
  );

  static const label = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.muted,
    letterSpacing: 0.5,
  );
}
