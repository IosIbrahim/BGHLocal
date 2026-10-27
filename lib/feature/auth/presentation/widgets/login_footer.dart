import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

/// Renders the "Don't have an account? Register" row at the bottom
/// of the login screen. Purely presentational — receives callbacks only.
class LoginFooter extends StatelessWidget {
  final VoidCallback onRegisterTap;

  const LoginFooter({super.key, required this.onRegisterTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.no_account.tr(),
            style: getMediumStyle(
              color: ColorManager.grey,
              fontSize: FontSize.size18,
            ),
          ),
          GestureDetector(
            onTap: onRegisterTap,
            child: Text(
              AppStrings.register.tr(),
              style: getBoldStyle(
                color: ColorManager.colorBlue09,
                fontSize: FontSize.size18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
