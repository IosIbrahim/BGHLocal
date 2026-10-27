import 'package:flutter/material.dart';

/// Single source of truth for every colour used in the app.
///
/// Replaces the two-class system that existed before:
///   • `AppPalette` — compile-time `const` brand / data colours
///   • `ColorManager` — mutable statics for legacy UI colours
///
/// All entries here are `const` so they work inside `const` constructors,
/// chart data lists, and `const` widget declarations.
class AppColors {
  const AppColors._();

  // ── Brand identity ─────────────────────────────────────────────────────────
  static const accent     = Color(0xFF0076A8);
  static const headerBlue = Color(0xFF0085B9);
  static const headerTeal = Color(0xFF7BDEC2);
  static const live       = Color(0xFF7CF2A8); // "real-time" pulse dot

  // ── Data / category palette (Figma exact) ──────────────────────────────────
  static const blue       = Color(0xFF0076A8); // same value as accent
  static const cyan       = Color(0xFF00B4DB);
  static const green      = Color(0xFF37C88C);
  static const purple     = Color(0xFF8B5CF6);
  static const amber      = Color(0xFFF59E0B); // was "orange" in ColorManager
  static const red        = Color(0xFFF03B29); // Emergency "Admitted" chart colour
  static const coral      = Color(0xFFFF7675); // Outpatient "Cancelled"
  static const pink       = Color(0xFFEC4899); // Outpatient "Apology"

  // ── Gradient end stops ─────────────────────────────────────────────────────
  static const greenDark  = Color(0xFF2BB179);
  static const amberDark  = Color(0xFFD97706);
  static const tealLight  = Color(0xFF00A8D1); // "In Treatment" gradient end
  static const teal       = Color(0xFF0087B6); // "In Treatment" gradient start
  static const purpleDark = Color(0xFF7C3AED);
  static const redDark    = Color(0xFFE42E27);
  static const coralDark  = Color(0xFFD63031);
  static const pinkDark   = Color(0xFFDB2777);

  // ── Neutrals ───────────────────────────────────────────────────────────────
  static const navy       = Color(0xFF1E293B); // primary text (was AppPalette.navy / ColorManager.colorBlue1E)
  static const slate      = Color(0xFF64748B); // chart axis / muted icon
  static const muted      = Color(0xFF8A8FA8); // secondary label text
  static const lightSlate = Color(0xFFE2E8F0); // progress bar track / chart axis bg

  // ── Semantic dashboard colours ─────────────────────────────────────────────
  // Note: dangerRed (E94E40) ≠ red (F03B29); use dangerRed for occupancy warnings.
  static const dangerRed    = Color(0xFFE94E40); // high-occupancy warning (was ColorManager.red)
  static const redAlt       = Color(0xFFFF4B2B); // ICU card accent (was ColorManager.redAlt)
  static const textDark     = Color(0xFF1C2B3A);
  static const textMid      = Color(0xFF6B7C93);
  static const cardBg       = Colors.white;
  static const scaffoldBg   = Color(0xFFEDF2F6); // dashboard canvas
  static const navInactiveBg = Color(0xFFF1F5F9);

  // ── Legacy UI palette (auth / home / core widgets) ─────────────────────────
  static const white        = Colors.white;
  static const black        = Color(0xFF000000);
  static const grayBg       = Color(0xFFF3F6FB); // was colorGrayF3 — auth/splash bg
  static const primaryBlue  = Color(0xFF093C71); // was colorBlue09 — home app bar
  static const errorRed     = Color(0xFFB50202); // was colorRedB5 — form validation
  static const darkMode     = Color(0xFF181A20); // dark scaffold bg
  static const colorBlue1F  = Color(0xFF1F2A37);
  static const colorGray4D  = Color(0xFF4D5761);
  static const colorGray9D  = Color(0xFF9DA4AE);
  static const colorBlack0D = Color(0xFF0D121C); // was colorBlack_0D
  static const colorBlack18 = Color(0xFF181818);
  static const colorBlack12 = Color(0xFF121212);
  static const legacyCyan   = Color(0xFF02AFB6); // was colorBlue02 — bottom nav selected
  static const legacyTeal   = Color(0xFF02CECA); // was colorGreen02 — text field focus
  static const colorGray37  = Color(0xFF373A42);
  static const colorGray71  = Color(0xFF717784);
  static const colorGray99  = Color(0xFF999A9C);
  static const colorGrayA7  = Color(0xFFA7ABB0);

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const headerGradient = LinearGradient(
    begin: Alignment(1.30, 1.0),
    end: Alignment(-0.54, 0.16),
    colors: [headerTeal, headerBlue],
  );
  static const scaffoldGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [grayBg, scaffoldBg],
  );
  static const metricBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, cyan],
  );
  static const metricGreenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [green, greenDark],
  );
  static const navActiveGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, green],
  );
  static const accentGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [blue, green],
  );
}
