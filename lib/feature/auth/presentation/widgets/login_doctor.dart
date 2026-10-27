import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';


class LoginDoctor extends StatelessWidget {
  final VoidCallback onSearchTap;

  const LoginDoctor({super.key, required this.onSearchTap});
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
              ImageAssets.doctorSearch,
              width: AppSize.s40,
              height: AppSize.s40,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        GestureDetector(
          onTap: onSearchTap,
          child: Text(
            AppStrings.search_doctor.tr(),
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