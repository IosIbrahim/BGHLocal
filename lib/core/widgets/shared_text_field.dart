import 'package:flutter/material.dart';
  import 'package:flutter_svg/svg.dart';
  import '../resources/resources.dart';
  import '../theme/font_manager.dart';
  import '../theme/style_manager.dart';
  import '../theme/theme.dart';
import '../utils/utils.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({super.key, 
    required this.hint,
    required this.title,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.obscureText,
    required this.inputType,
    required this.takeValue,
    this.action,
    required this.validator,
    required this.controller,
    this.readOnly = false,
    this.isDarkMode = false,
    this.maxLines = 1,
    this.paddingHorizontal = AppPadding.p16,
  });

  final String hint;
  final String title;
  final String suffixIcon;
  final String prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final bool isDarkMode;
  final int? maxLines;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final double paddingHorizontal;
  final Function takeValue;
  final Function? action;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  var _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageManager.getCurrentLanguage(context) == ARABIC;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: getBoldStyle(
                    color: colorDarkOrLightMode(
                        widget.isDarkMode, AppColors.white,
                        AppColors.black),
                    fontSize: FontSize.size16,
                  ),
                ),
              ),
              const SizedBox(height: AppGap.g10),
            ],
          )
              : const SizedBox(height: AppGap.g1),
          TextFormField(
            obscureText: widget.obscureText ? _isObscured : false,
            keyboardType: widget.inputType,
            textAlign: TextAlign.start,
            controller: widget.controller,
            readOnly: widget.readOnly,
            style: getMediumStyle(
              color: colorDarkOrLightMode(
                  widget.isDarkMode, AppColors.colorGray99,
                  AppColors.colorBlack0D),
              fontSize: AppFontSize.f14,
            ),
            onChanged: (value) {
              // `takeValue` often does `controller.text = value`, which replaces the
              // whole [TextEditingValue] and resets the caret/IME state (breaks
              // backspace and mid-field editing). If the text did not actually
              // change, restore the value from before the callback.
              final TextEditingValue beforeTake = widget.controller.value;
              widget.takeValue(value);
              final TextEditingValue afterTake = widget.controller.value;
              if (beforeTake.text == afterTake.text &&
                  beforeTake != afterTake) {
                widget.controller.value = beforeTake;
              }
            },
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: getRegularStyle(
                color: colorDarkOrLightMode(
                    widget.isDarkMode, AppColors.colorBlue1F,
                    AppColors.colorGray4D),
                fontSize: AppFontSize.f14,
              ),
              filled: true,
              fillColor: colorDarkOrLightMode(
                  widget.isDarkMode, AppColors.colorGray37,
                  AppColors.white),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.white,
                  width: AppDimension.d1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.r12),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.white, width: AppDimension.d2),
                borderRadius: BorderRadius.all(
                    Radius.circular(AppRadius.r12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorDarkOrLightMode(
                    widget.isDarkMode, AppColors.legacyTeal,
                    AppColors.primaryBlue), width: AppDimension.d2),
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadius.r12)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.errorRed, width: AppDimension.d2),
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.errorRed, width: AppDimension.d2),
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12)),
              ),
              prefixIcon: (widget.prefixIcon.isNotEmpty ?? false)
                  ? Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: SvgPicture.asset(
                  widget.prefixIcon,
                  height: AppIconSize.i15,
                  width: AppIconSize.i15,
                  color: colorDarkOrLightMode(
                      widget.isDarkMode, AppColors.colorGray99,
                      AppColors.primaryBlue),
                ),
              ) : null,
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: SvgPicture.asset(
                    color: AppColors.colorGray9D,
                    _isObscured
                        ? ImageAssets.eyeClosedIcon
                        : ImageAssets.eyeOpenIcon,
                    height: AppIconSize.i20,
                    width: AppIconSize.i20,
                  ),
                ),
              )
                  : getSuffixIcon(),
            ),
            onTap: widget.readOnly ? () {
              widget.action!();
            } : null,
          ),
        ],
      ),
    );
  }

  Widget? getSuffixIcon() {
    if (widget.suffixIcon.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: SvgPicture.asset(
          widget.suffixIcon,
          height: AppIconSize.i20,
          width: AppIconSize.i20,
        ),
      );
    }
    return null;
  }
}