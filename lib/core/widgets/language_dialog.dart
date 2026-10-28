import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../di/di.dart';
import '../resources/resources.dart';
import '../storage/storage.dart';
import '../theme/theme.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late Locale _selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocale = context.locale;
  }

  Future<void> _submitLanguageChange() async {
    if (_selectedLocale != context.locale) {
      await context.setLocale(_selectedLocale);
      final prefs = instance<AppPreferences>();
      await prefs.changeAppLanguage(_selectedLocale.languageCode);
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isArSelected = _selectedLocale.languageCode == ARABIC;
    final bool isEnSelected = _selectedLocale.languageCode == ENGLISH;

    return Dialog(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Dialog Title ───────────────────────────────────────
            Text(
              AppStrings.choose_favorite_language.tr(),
              style: getMediumStyle(
                color: ColorManager.colorGray71,
                fontSize: FontSize.size16,
              ),
            ),
            const SizedBox(height: AppSize.s20),

            // ── Arabic Option ──────────────────────────────────────
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              onTap: () {
                setState(() {
                  _selectedLocale = ARABIC_LOCALE;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p8,
                  horizontal: AppPadding.p4,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSize.s44,
                      height: AppSize.s44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xff00ABC8),
                          width: 1.8,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "AR",
                        style: getBoldStyle(
                          color: ColorManager.colorBlue09,
                          fontSize: FontSize.size16,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s24),
                    Expanded(
                      child: Text(
                        "عربى",
                        style: getMediumStyle(
                          color: ColorManager.colorBlack18,
                          fontSize: FontSize.size16,
                        ),
                      ),
                    ),
                    if (isArSelected)
                      const Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 26,
                      )
                    else
                      const SizedBox(width: 26),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSize.s12),

            // ── English Option ─────────────────────────────────────
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              onTap: () {
                setState(() {
                  _selectedLocale = ENGLISH_LOCALE;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p8,
                  horizontal: AppPadding.p4,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSize.s44,
                      height: AppSize.s44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xff00ABC8),
                          width: 1.8,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "EN",
                        style: getBoldStyle(
                          color: ColorManager.colorBlue09,
                          fontSize: FontSize.size16,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s24),
                    Expanded(
                      child: Text(
                        "English",
                        style: getMediumStyle(
                          color: ColorManager.colorBlack18,
                          fontSize: FontSize.size16,
                        ),
                      ),
                    ),
                    if (isEnSelected)
                      const Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 26,
                      )
                    else
                      const SizedBox(width: 26),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSize.s28),

            // ── Submit Button: CHANGE LANGUAGE ─────────────────────
            SizedBox(
              height: AppSize.s48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00ABC8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                ),
                onPressed: _submitLanguageChange,
                child: Text(
                  AppStrings.change_language.tr().toUpperCase(),
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.size15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showLanguageDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const LanguageDialog(),
  );
}
