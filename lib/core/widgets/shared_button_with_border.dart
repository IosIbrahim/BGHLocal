import 'package:flutter/material.dart';

import '../theme/color_manager.dart';
  
import '../theme/style_manager.dart';
import '../theme/theme.dart';

class MyButtonBorder extends StatelessWidget {

  const MyButtonBorder({
    super.key,
    required this.color,
    required this.buttonText,
    required this.fun,
    this.buttonTextColor = Colors.white,
    this.borderColor = ColorManager.colorRedB5,
    this.paddingHorizontal = AppPadding.p20,
    this.paddingVertical = AppPadding.p20,
  });

  final Color color;
  final String buttonText;
  final Color buttonTextColor;
  final Color borderColor;
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
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.s40),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: MaterialButton(
          height: AppSize.s50,
          splashColor: color.withValues(alpha: 0.2),
          onPressed: fun,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s40),
          ),
          child: Text(
            buttonText,
            style: getBoldStyle(
              color: buttonTextColor,
              fontSize: AppSize.s16
            ),
          ),
        ),
      ),
    );
  }

}

