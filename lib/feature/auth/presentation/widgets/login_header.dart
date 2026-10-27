import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class LoginHeader extends StatelessWidget {

  final bool isDarkMode;

  const LoginHeader({this.isDarkMode = false,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppGap.g40),
        Align(
          alignment: Alignment.center,
          child: Image.asset(ImageAssets.splashLogo,
              width: AppDimension.d90, height: AppDimension.d115),
        ),
        const SizedBox(height: AppGap.g15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppStrings.sign_in.tr(),
                style: getBoldStyle(
                    color: colorDarkOrLightMode(isDarkMode , AppColors.white , AppColors.primaryBlue),
                    fontSize: FontSize.size33)),
            Text(AppStrings.welcome_back.tr(),
                style: getRegularStyle(
                    color: colorDarkOrLightMode(isDarkMode , AppColors.white , AppColors.colorBlack18),
                    fontSize: FontSize.size25))
          ],
        ),
        const SizedBox(height: AppGap.g30),
      ],
    );
  }
}
