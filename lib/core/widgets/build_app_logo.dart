import 'package:flutter/material.dart';

import '../core.dart';

class BuildAppLogo extends StatelessWidget {
  const BuildAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.splashLogo,
            width: AppDimension.d40,
            height: AppDimension.d40,
          ),
          const SizedBox(width: AppGap.g8),
          Image.asset(
            ImageAssets.logoText,
            color: AppColors.white,
            height: AppDimension.d44,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
