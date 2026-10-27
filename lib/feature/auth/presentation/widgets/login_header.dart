import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

/// Renders the logo pair and the "Sign In / Welcome Back" title block.
/// Purely presentational — zero state, zero callbacks.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.logoText,
              height: AppSize.s90,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
            Image.asset(
              ImageAssets.splashLogo,
              width: AppSize.s90,
              height: AppSize.s90,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s30),
        Text(
          AppStrings.sign_in.tr(),
          style: getBoldStyle(
            color: ColorManager.colorBlue09,
            fontSize: FontSize.size33,
          ),
        ),
        Text(
          AppStrings.welcome_back.tr(),
          style: getRegularStyle(
            color: ColorManager.colorBlack18,
            fontSize: FontSize.size25,
          ),
        ),
        const SizedBox(height: AppSize.s30),
      ],
    );
  }
}
