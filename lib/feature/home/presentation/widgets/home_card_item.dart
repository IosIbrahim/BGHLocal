import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/charts/models/card_state.dart';
import '../models/home_card_item_model.dart';

class HomeCardItem extends StatelessWidget {
  final HomeCardItemModel item;

  /// Live, already-formatted count for this card. `null` means the feature has
  /// no count endpoint yet — the card then renders a placeholder rather than a
  /// value.
  final CardState<String>? countState;
  final bool isDarkMode;
  final VoidCallback? onTap;

  const HomeCardItem({
    super.key,
    required this.item,
    this.countState,
    this.isDarkMode = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = colorDarkOrLightMode(
      isDarkMode,
      AppColors.white,
      AppColors.navy,
    );
    final subtitleColor = colorDarkOrLightMode(
      isDarkMode,
      AppColors.colorGray9D,
      AppColors.colorGrayA7,
    );
    final countColor = colorDarkOrLightMode(
      isDarkMode,
      AppColors.white,
      AppColors.navy,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.r20),
        child: Ink(
          padding: const EdgeInsets.all(AppPadding.p12),
          decoration: BoxDecoration(
            color: colorDarkOrLightMode(isDarkMode, AppColors.colorGray37, AppColors.white),
            borderRadius: BorderRadius.circular(AppRadius.r20),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.06),
                blurRadius: AppRadius.r16, offset: const Offset(0, AppRadius.r4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: _buildIconContainer()),
                  const SizedBox(height: AppGap.g8),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getBoldStyle(
                      color: titleColor,
                      fontSize: AppFontSize.f16,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(
                      color: subtitleColor,
                      fontSize: AppFontSize.f12,
                    ),
                  ),
                ],
              ),
              _buildFooter(countColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: AppDimension.d48,
      height: AppDimension.d48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [item.iconColor, item.iconColorEnd],
        ),
      ),
      child: Center(child: _buildIcon()),
    );
  }

  Widget _buildIcon() {
    if (item.iconUrl != null && item.iconUrl!.isNotEmpty) {
      return Image.network(
        item.iconUrl!,
        width: AppIconSize.i28,
        height: AppIconSize.i28,
        color: AppColors.white,
        errorBuilder: (_, __, ___) => _buildFallbackIcon(),
      );
    }

    if (item.iconAsset != null && item.iconAsset!.isNotEmpty) {
      final asset = item.iconAsset!;
      if (asset.endsWith('.svg')) {
        return SvgPicture.asset(
          asset,
          width: AppIconSize.i28,
          height: AppIconSize.i28,
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
        );
      }

      return Image.asset(
        asset,
        width: AppIconSize.i28,
        height: AppIconSize.i28,
        color: AppColors.white,
      );
    }

    return _buildFallbackIcon();
  }

  Widget _buildFallbackIcon() {
    return const Icon(
      Icons.medical_services_outlined,
      color: AppColors.white,
      size: AppIconSize.i28,
    );
  }

  /// Shown in place of a number when the value isn't available — either the
  /// feature has no count endpoint yet, or the request failed.
  static const _noValue = '—';

  Widget _buildFooter(Color countColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p8,
        horizontal: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: item.footerBackgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      // A *minimum* height keeps the card from jumping between loading, data
      // and error, while still letting the count column take its natural size
      // (a fixed height clips it, and would clip harder under text scaling).
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: AppDimension.d44),
        child: Center(
          child: switch (countState) {
            // No endpoint for this feature yet — placeholder, nothing to retry.
            null => _buildCount(_noValue, countColor),
            CardLoading() => _buildLoading(countColor),
            CardData(:final data) => _buildCount(data, countColor),
            CardError(:final onRetry) => _buildRetry(onRetry, countColor),
          },
        ),
      ),
    );
  }

  Widget _buildLoading(Color countColor) {
    return SizedBox(
      width: AppIconSize.i20,
      height: AppIconSize.i20,
      child: CircularProgressIndicator(
        strokeWidth: AppDimension.d2,
        valueColor: AlwaysStoppedAnimation(countColor.withValues(alpha: 0.5)),
      ),
    );
  }

  Widget _buildCount(String count, Color countColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getBoldStyle(color: countColor, fontSize: AppFontSize.f20),
        ),
        Text(
          item.countLabel,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(color: countColor, fontSize: AppFontSize.f12),
        ),
      ],
    );
  }

  /// Tapping retry must not fall through to the card's navigation tap, so it
  /// gets its own InkWell (the inner gesture wins the hit test).
  Widget _buildRetry(VoidCallback? onRetry, Color countColor) {
    return InkWell(
      onTap: onRetry,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.refresh,
              size: AppIconSize.i18,
              color: AppColors.errorRed,
            ),
            const SizedBox(width: AppGap.g8),
            Flexible(
              child: Text(
                AppStrings.retry.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(
                  color: AppColors.errorRed,
                  fontSize: AppFontSize.f12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
