import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/resources.dart';
import '../theme/color_manager.dart';
import '../resources/resources.dart';
import '../theme/style_manager.dart';
import '../theme/theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  MyAppBar({
    super.key,
    required this.title,
    required this.centerTitle,
    this.titleColor = const Color(0xff093C71),
    this.appBarColor = const Color(0xffEEF1FA),
  });

  final Color titleColor;
  final Color appBarColor;
  final String title;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageManager.getCurrentLanguage(context) == ARABIC;

    return AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: centerTitle,
        title: Text(title,style: getBoldStyle(color: titleColor,fontSize: AppSize.s20)),
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: appBarColor,
        leading: Transform.rotate(
          angle: isArabic ? 3.14 : 0.0,
          child: IconButton(
            icon: SvgPicture.asset(ImageAssets.leftIcon, colorFilter: ColorFilter.mode(ColorManager.colorBlack18, BlendMode.srcIn)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
