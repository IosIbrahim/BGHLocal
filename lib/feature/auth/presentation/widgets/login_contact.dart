import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';


class LoginContact extends StatelessWidget {
  final VoidCallback onContactTap;

  const LoginContact({super.key, required this.onContactTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.contactUs,
              width: AppSize.s40,
              height: AppSize.s40,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        GestureDetector(
          onTap: onContactTap,
          child: Text(
            AppStrings.contact_us.tr(),
            style: getBoldStyle(
              color: ColorManager.colorBlack18,
              fontSize: FontSize.size18,
            ),
          ),
        ),
      ],
    );
  }
}
