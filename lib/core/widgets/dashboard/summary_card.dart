import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';

/// Data for one summary card in [PrimeCareHeader] (e.g. "200 / Total Today").
class SummaryCardData {
  /// Material fallback icon (used when [iconAsset] is null).
  final IconData? icon;

  /// Optional SVG asset path; takes precedence over [icon].
  final String? iconAsset;

  /// Display text for the big number (e.g. "200" or "$2.4M").
  final String value;
  final String label;
  final Color color;

  /// Colour of the big number. Defaults to the app's dark navy.
  final Color valueColor;

  /// Font size of the big number (Figma: 26 on most screens, 24 on HR).
  final double valueFontSize;

  const SummaryCardData({
    this.icon,
    this.iconAsset,
    required this.value,
    required this.label,
    required this.color,
    this.valueColor = AppColors.navy,
    this.valueFontSize = 26,
  });
}

/// A single white summary card. Used by [PrimeCareHeader] for the three
/// counters that overlap the gradient.
class SummaryCard extends StatelessWidget {
  final SummaryCardData data;

  const SummaryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: data.iconAsset != null
                  ? SvgPicture.asset(
                      data.iconAsset!,
                      width: 30,
                      height: 30,
                      colorFilter:
                          ColorFilter.mode(data.color, BlendMode.srcIn),
                    )
                  : Icon(data.icon, color: data.color, size: 30),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.value,
            style: TextStyle(
              fontSize: data.valueFontSize,
              fontWeight: FontWeight.w800,
              color: data.valueColor,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
