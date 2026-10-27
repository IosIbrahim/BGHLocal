import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

class SharedBottomNavItem {
  SharedBottomNavItem._();

  static const _selectedGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0076A8),
      Color(0xFF37C88C),
    ],
  );

  static Widget buildIcon({
    required String iconAsset,
    required bool isSelected,
    double iconSize = AppIconSize.i22,
    double containerSize = AppDimension.d44,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p8,
        bottom: AppPadding.p4,
      ),
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          gradient: isSelected ? _selectedGradient : null,
          color: isSelected ? null : AppColors.grayBg,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconAsset,
            width: iconSize,
            height: iconSize,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.white : AppColors.navy,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  static BottomNavigationBarItem item({
    required String iconAsset,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: buildIcon(iconAsset: iconAsset, isSelected: false),
      activeIcon: buildIcon(iconAsset: iconAsset, isSelected: true),
      label: label,
    );
  }

  static Widget wrapBar({
    required Widget child,
    double topRadius = AppRadius.r24,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(topRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: AppRadius.r16,
            offset: const Offset(0, -AppRadius.r4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(topRadius),
        ),
        child: child,
      ),
    );
  }

  static BottomNavigationBar buildBar({
    required int currentIndex,
    required ValueChanged<int> onTap,
    required List<BottomNavigationBarItem> items,
  }) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.white,
      elevation: 0,
      selectedItemColor: AppColors.legacyCyan,
      unselectedItemColor: AppColors.colorGray71,
      selectedLabelStyle: getMediumStyle(
        fontSize: AppFontSize.f12,
        color: AppColors.legacyCyan,
      ),
      unselectedLabelStyle: getRegularStyle(
        fontSize: AppFontSize.f12,
        color: AppColors.colorGray71,
      ),
      items: items,
    );
  }
}
