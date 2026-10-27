import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'dash_icons.dart';

/// Pinned gradient hero band (brand + back/filter + [title] + [subtitle]),
/// shared by every dashboard screen.
///
/// Drawn *on top* of the scrolling body so the summary cards and sections
/// slide up and hide beneath it. Brand identity (logo, gradient, tag line)
/// lives here, so a rebrand is a single edit for all screens.
class PrimeCareHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onFilter;

  const PrimeCareHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
    this.onFilter,
  });

  /// Visible height of the band below the status bar. Includes a colored strip
  /// beneath the subtitle for the summary cards to overlap.
  static const contentHeight = 200.0;

  /// Y (from the band top) that splits the pinned title area from the lower
  /// strip the cards overlap. Cards render in front of everything below this
  /// line and behind everything above it.
  static const splitBelowTitle = 150.0;

  /// Total pinned height including the status-bar inset.
  static double heightOf(BuildContext context) =>
      MediaQuery.of(context).padding.top + contentHeight;

  /// Absolute Y of the title/strip split, including the status-bar inset.
  static double splitOf(BuildContext context) =>
      MediaQuery.of(context).padding.top + splitBelowTitle;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      height: topInset + contentHeight,
      padding: EdgeInsets.fromLTRB(20, topInset + 12, 20, 16),
      decoration: const BoxDecoration(
        // Figma: linear-gradient(279.44deg, #7BDEC2 -12.76%, #0085B9 71.78%)
        gradient: LinearGradient(
          begin: Alignment(1.0, 0.17), // ~bottom-right (teal)
          end: Alignment(-1.0, -0.17), // ~top-left (blue)
          colors: [AppColors.headerTeal, AppColors.headerBlue],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x332E6CA6),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Text sits in the upper portion; the remaining height is the colored
        // strip the summary cards overlap.
        children: [
          _topBar(),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const _LiveDot(),
              const SizedBox(width: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        _headerIconButton(Icons.arrow_back_rounded, onBack),
        Expanded(
          child: Center(
            child: Image.asset(DashIcons.logo, height: 44),
          ),
        ),
        _headerIconButton(Icons.filter_alt_rounded, onFilter),
      ],
    );
  }

  /// Translucent rounded header button. Uses [IconButton] so it gets a centered
  /// Material ripple and proper hit-target sizing for free.
  Widget _headerIconButton(IconData icon, VoidCallback? onTap) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 22),
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.18),
        fixedSize: const Size(42, 42),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: const BoxDecoration(
        color: AppColors.live,
        shape: BoxShape.circle,
      ),
    );
  }
}
