import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/style_manager.dart';
import '../theme/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.color,
    required this.icon,
    required this.buttonText,
    required this.fun,
    this.buttonTextColor = Colors.white,
    this.paddingHorizontal = AppPadding.p20,
    this.paddingVertical = AppPadding.p20,
  });

  final Color color;
  final String icon;
  final String buttonText;
  final Color buttonTextColor;
  final VoidCallback fun;
  final double paddingHorizontal;
  final double paddingVertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: MaterialButton(
        color: color,
        height: AppSize.s50,
        splashColor: color.withValues(alpha: 0.2),
        onPressed: fun,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon.isNotEmpty)
              SvgPicture.asset(icon, width: AppSize.s20, height: AppSize.s20),
            if (icon.isNotEmpty) const SizedBox(width: AppSize.s4),
            Text(
              buttonText,
              style:
                  getBoldStyle(color: buttonTextColor, fontSize: AppSize.s16),
            )
          ],
        ),
      ),
    );
  }
}
