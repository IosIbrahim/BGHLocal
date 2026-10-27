

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

enum LanguageType { ENGLISH, ARABIC }

const String ARABIC = "ar";
const String ENGLISH = "en";
const String ASSET_PATH_LOCALIZATION = "assets/translations";

const Locale ARABIC_LOCALE = Locale("ar","SA");
const Locale ENGLISH_LOCALE = Locale("en","US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}

class LanguageManager {
  static String getCurrentLanguage(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

}

extension LocaleX on BuildContext {
  /// True when the active locale is Arabic. Use this instead of repeating
  /// `context.locale.languageCode == 'ar'` across widgets.
  bool get isArabic => locale.languageCode == ARABIC;
}
