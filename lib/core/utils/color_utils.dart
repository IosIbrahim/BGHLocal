import 'dart:ui';

Color colorDarkOrLightMode(bool isDarkMode , Color darkColor , Color lightColor) {
  if(isDarkMode) {
    return darkColor;
  } else {
    return lightColor;
  }
}
