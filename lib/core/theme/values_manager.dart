class AppPadding {
  static const double p2 = 2.0;
  static const double p4 = 4.0;
  static const double p5 = 5.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p28 = 28.0;
  static const double p35 = 35.0;
  static const double p40 = 40.0;
  static const double p50 = 50.0;
  static const double p60 = 60.0;
  static const double p70 = 70.0;
  static const double p90 = 90.0;
  static const double p100 = 100.0;
}

class AppMargin {
  static const double m4 = 4.0;
  static const double m8 = 8.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
  static const double m40 = 40.0;
  static const double m60 = 60.0;
  static const double m90 = 90.0;
}

// Semantic token classes — separate raw numeric scales by intent.
// Each class follows the values_manager prefix convention (p=padding,
// m=margin, g=gap, r=radius, i=icon, f=font, d=dimension). The class carries
// the meaning, so a value may appear in more than one class.

class AppGap {
  // SizedBox gaps between widgets and grid main/cross-axis spacing
  static const double g1 = 1.0;
  static const double g4 = 4.0;
  static const double g6 = 6.0;
  static const double g8 = 8.0;
  static const double g10 = 10.0;
  static const double g12 = 12.0;
  static const double g14 = 14.0;
  static const double g15 = 15.0;
  static const double g16 = 16.0;
  static const double g20 = 20.0;
  static const double g24 = 24.0;
  static const double g30 = 30.0;
  static const double g40 = 40.0;
  static const double g50 = 50.0;
}

class AppRadius {
  // border radii and shadow blur/spread radii
  static const double r2 = 2.0;
  static const double r4 = 4.0;
  static const double r8 = 8.0;
  static const double r12 = 12.0;
  static const double r16 = 16.0;
  static const double r20 = 20.0;
  static const double r24 = 24.0;
  static const double r25 = 25.0;
}

class AppIconSize {
  // Icon(size:), SvgPicture and image-as-icon dimensions
  static const double i15 = 15.0;
  static const double i18 = 18.0;
  static const double i20 = 20.0;
  static const double i22 = 22.0;
  static const double i28 = 28.0;
  static const double i40 = 40.0;
  static const double i60 = 60.0;
}

class AppFontSize {
  // text style font sizes
  static const double f12 = 12.0;
  static const double f14 = 14.0;
  static const double f13 = 13.0;
  static const double f16 = 16.0;
  static const double f18 = 18.0;
  static const double f20 = 20.0;
}

class AppDimension {
  // fixed widths/heights, component & image sizes, border widths
  static const double d1 = 1.0;
  static const double d1_5 = 1.5;
  static const double d2 = 2.0;
  static const double d14 = 14.0;
  static const double d40 = 40.0;
  static const double d44 = 44.0;
  static const double d48 = 48.0;
  static const double d50 = 50.0;
  static const double d90 = 90.0;
  static const double d115 = 115.0;
  static const double d280 = 280.0;
}
