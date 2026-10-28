import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ContactItemCard extends StatelessWidget {
  final String iconPath;
  final String? title;
  final String value;
  final VoidCallback? onTap;
  final bool isSingleTitle;

  const ContactItemCard({
    super.key,
    required this.iconPath,
    this.title,
    required this.value,
    this.onTap,
    this.isSingleTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(
          color: const Color(0xffE2EDF8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.r16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16,
              vertical: AppPadding.p12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon (already circular in asset)
                Image.asset(
                  iconPath,
                  width: AppSize.s44,
                  height: AppSize.s44,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    width: AppSize.s44,
                    height: AppSize.s44,
                  ),
                ),
                const SizedBox(width: AppSize.s14),
                // Text details
                Expanded(
                  child: isSingleTitle
                      ? Text(
                          value,
                          style: getBoldStyle(
                            color: ColorManager.colorBlue09,
                            fontSize: FontSize.size16,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (title != null) ...[
                              Text(
                                title!,
                                style: getRegularStyle(
                                  color: ColorManager.lightGrey96,
                                  fontSize: FontSize.size14,
                                ),
                              ),
                              const SizedBox(height: AppSize.s4),
                            ],
                            Text(
                              value,
                              style: getBoldStyle(
                                color: ColorManager.colorBlue09,
                                fontSize: FontSize.size16,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
