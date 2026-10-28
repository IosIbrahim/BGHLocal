import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ContactHeaderCard extends StatelessWidget {
  const ContactHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r20),
        border: Border.all(
          color: const Color(0xffE2EDF8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text section (Start-aligned, so Right in AR and Left in EN)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.stay_in_touch_title.tr(),
                  style: getBoldStyle(
                    color: ColorManager.colorBlue09,
                    fontSize: FontSize.size18,
                  ),
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  AppStrings.stay_in_touch_desc.tr(),
                  style: getRegularStyle(
                    color: ColorManager.colorGray71,
                    fontSize: FontSize.size14,
                  ).copyWith(height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSize.s12),
          // Illustration on End side (Left in AR and Right in EN)
          Image.asset(
            ImageAssets.ic_contact_header,
            width: 130,
            height: 110,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const SizedBox(width: 130, height: 110),
          ),
        ],
      ),
    );
  }
}
