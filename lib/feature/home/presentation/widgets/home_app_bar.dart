import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/build_app_logo.dart';

class HomeAppBar extends StatelessWidget {
  final bool isDarkMode;
  final bool showBackButton;
  final bool showFilterButton;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFilterPressed;

  const HomeAppBar({
    super.key,
    this.isDarkMode = false,
    this.showBackButton = true,
    this.showFilterButton = true,
    this.onBackPressed,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageManager.getCurrentLanguage(context) == ARABIC;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p10,
      ),
      child: Row(
        children: [
          _AppBarIconButton(
            isDarkMode: isDarkMode,
            visible: showBackButton,
            onTap: onBackPressed ?? () => Navigator.of(context).maybePop(),
            child: Transform.rotate(
              angle: isArabic ? 3.14 : 0.0,
              child: SvgPicture.asset(
                ImageAssets.arrowLeftIcon,
                width: AppIconSize.i18,
                height: AppIconSize.i18,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(child: BuildAppLogo()),
          ),
          _AppBarIconButton(
            isDarkMode: isDarkMode,
            visible: showFilterButton,
            onTap: onFilterPressed,
            child: SvgPicture.asset(
              ImageAssets.filterIcon,
              width: AppIconSize.i18,
              height: AppIconSize.i18,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _AppBarIconButton extends StatelessWidget {
  final bool isDarkMode;
  final bool visible;
  final VoidCallback? onTap;
  final Widget child;

  const _AppBarIconButton({
    required this.isDarkMode,
    this.visible = true,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: IgnorePointer(
        ignoring: !visible,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: visible ? onTap : null,
            borderRadius: BorderRadius.circular(AppRadius.r12),
            child: Ink(
              width: AppDimension.d40,
              height: AppDimension.d40,
              decoration: BoxDecoration(
                color: colorDarkOrLightMode(
                  isDarkMode,
                  AppColors.colorGray37.withValues(alpha: 0.6),
                  Colors.white.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(AppRadius.r12),
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
