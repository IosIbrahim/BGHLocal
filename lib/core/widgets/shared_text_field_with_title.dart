import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/resources.dart';
import '../theme/color_manager.dart';
import '../theme/font_manager.dart';
import '../theme/style_manager.dart';
import '../theme/theme.dart';

class MyTextFieldWithTitle extends StatefulWidget {
  const MyTextFieldWithTitle({
    super.key,
    required this.hint,
    this.maxLines = 1,
    required this.title,
    required this.prefixIcon,
    required this.obscureText,
    required this.inputType,
    required this.takeValue,
    required this.controller,
    required this.validator,
    this.paddingHorizontal = AppPadding.p20,
  });

  final String hint;
  final String title;
  final int? maxLines;
  final String prefixIcon;
  final bool obscureText;
  final TextInputType inputType;
  final TextEditingController controller;
  final double paddingHorizontal;
  final String? Function(String?)? validator;
  final Function takeValue;

  @override
  State<MyTextFieldWithTitle> createState() => _MyTextFieldWithTitleState();
}

class _MyTextFieldWithTitleState extends State<MyTextFieldWithTitle> {
  var _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.title.isNotEmpty
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                      child: Text(widget.title,
                          style: getSemiBoldStyle(
                              color: ColorManager.colorBlack12,
                              fontSize: FontSize.size16)),
                    ),
                  )
                : const SizedBox(height: AppSize.s0),
            const SizedBox(height: AppSize.s6),
            TextFormField(
              obscureText: widget.obscureText ? _isObscured : false,
              maxLines: widget.maxLines,
              keyboardType: widget.inputType,
              textAlign: TextAlign.start,
              controller: widget.controller,
              style: getMediumStyle(
                color: ColorManager.colorBlack_0D,
                fontSize: AppSize.s14,
              ),
              onChanged: (value) {
                widget.takeValue(value);
              },
              validator: widget.validator,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: widget.hint,
                hintStyle: getRegularStyle(
                  color: ColorManager.colorGray4D,
                  fontSize: AppSize.s14,
                ),
                filled: true,
                fillColor: ColorManager.white,
                contentPadding: const EdgeInsets.all(AppPadding.p16),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorManager.white, width: AppSize.s1),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppSize.s25)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.white, width: AppSize.s2_0),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppSize.s25)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.colorBlue09, width: AppSize.s2_0),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppSize.s25)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.colorRedB5, width: AppSize.s2_0),
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s25)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.colorRedB5, width: AppSize.s2_0),
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s25)),
                ),
                prefixIcon: (widget.prefixIcon.isNotEmpty ?? false)
                    ? Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        child: SvgPicture.asset(
                          widget.prefixIcon,
                          height: AppSize.s15,
                          width: AppSize.s15,
                        ),
                      )
                    : null,
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
                          ),
                        ),
                      )
                    : null,
              ),
            )
          ],
        ));
  }
}
