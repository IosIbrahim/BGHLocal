import 'package:flutter/material.dart';
  import 'package:flutter_svg/svg.dart';
  import '../resources/resources.dart';
  import '../theme/color_manager.dart';
  import '../theme/font_manager.dart';
  import '../resources/resources.dart';
  import '../theme/style_manager.dart';
  import '../theme/theme.dart';
import '../utils/utils.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
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
                    color: colorDarkOrLightMode(widget.isDarkMode , ColorManager.white , ColorManager.black),
                    fontSize: FontSize.size16,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s10),
            ],
          )
              : const SizedBox(height: AppSize.s1),
          TextFormField(
            obscureText: widget.obscureText ? _isObscured : false,
            keyboardType: widget.inputType,
            textAlign: TextAlign.start,
            controller: widget.controller,
            readOnly: widget.readOnly,
            style: getMediumStyle(
              color: colorDarkOrLightMode(widget.isDarkMode , ColorManager.colorGrayF3 , ColorManager.colorBlack_0D),
              fontSize: AppSize.s14,
            ),
            onChanged: (value) {
              widget.takeValue(value);
            },
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: getRegularStyle(
                color: colorDarkOrLightMode(widget.isDarkMode , ColorManager.colorGrayF3 , ColorManager.colorGray4D),
                fontSize: AppSize.s14,
              ),
              filled: true,
              fillColor: colorDarkOrLightMode(widget.isDarkMode , ColorManager.colorGray37 , ColorManager.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.white,
                  width: AppSize.s1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSize.s12),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.white, width: AppSize.s2_0),
                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s12)),
              ),
              focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: colorDarkOrLightMode(widget.isDarkMode , ColorManager.colorGreen02 , ColorManager.colorBlue09), width: AppSize.s2_0),
                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s12)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.colorRedB5, width: AppSize.s2_0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s12)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.colorRedB5, width: AppSize.s2_0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s12)),
              ),
              prefixIcon: widget.prefixIcon.isNotEmpty
                  ? Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: SvgPicture.asset(
                  widget.prefixIcon,
                  height: AppSize.s15,
                  width: AppSize.s15,
                  colorFilter: ColorFilter.mode(
                    colorDarkOrLightMode(widget.isDarkMode, ColorManager.colorGrayF3, ColorManager.colorBlue09),
                    BlendMode.srcIn,
                  ),
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
                    _isObscured
                        ? ImageAssets.eyeClosedIcon
                        : ImageAssets.eyeOpenIcon,
                    height: AppSize.s20,
                    width: AppSize.s20,
                    colorFilter: ColorFilter.mode(ColorManager.colorGray9D, BlendMode.srcIn),
                  ),
                ),
              )
                  : getSuffixIcon(),
            ),
            onTap: widget.readOnly ? (){
              widget.action!();
            }:null,
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
          height: AppSize.s20,
          width: AppSize.s20,
        ),
      );
    }
    return null;
  }
}
