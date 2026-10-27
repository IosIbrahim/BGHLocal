import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    var filter = '';
    return FutureBuilder<UserSession?>(
      future: instance<AppPreferences>().getUserSession(),
      builder: (context, snapshot) {
        final session = snapshot.data;
        final name =
            (isArabic ? session?.empNameAr : session?.empNameEn).orEmpty();
        final hospital =
            (isArabic ? session?.hospNameAr : session?.hospNameEn).orEmpty();
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(ImageAssets.userSaudiIcon,
                width: AppDimension.d40, height: AppDimension.d40),
            const SizedBox(width: AppGap.g6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? '-' : 'DR. $name',
                  style: getBoldStyle(
                      color: AppColors.white, fontSize: AppFontSize.f18),
                ),
                Text(
                  hospital,
                  style: getRegularStyle(
                      color: AppColors.white, fontSize: AppFontSize.f12),
                ),
                Text(
                  filter,
                  style: getRegularStyle(
                      color: AppColors.white, fontSize: AppFontSize.f12),
                ),
              ],
              ],
            )
          ],
        );
      },
    );
  }
}
