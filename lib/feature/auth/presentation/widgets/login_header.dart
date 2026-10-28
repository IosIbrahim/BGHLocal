import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

/// Renders the language switcher icon, the logo pair, and the "Sign In / Welcome Back" title block.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Language Switcher Icon (top start) ────────────────────
        Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p8,
            left: AppPadding.p20,
            right: AppPadding.p20,
          ),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.r20),
              onTap: () => showLanguageDialog(context),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Image.asset(
                  ImageAssets.ic_contact_web,
                  width: AppSize.s28,
                  height: AppSize.s28,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.language,
                    color: Color(0xff00ABC8),
                    size: AppSize.s28,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSize.s20),

        // ── Logos ──────────────────────────────────────────────────
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

        // ── Welcome Text ───────────────────────────────────────────
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
