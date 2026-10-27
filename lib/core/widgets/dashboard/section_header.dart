import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';

/// Section title with a leading accent bar and icon, e.g.
/// "Consultation Types", "Status Breakdown". Shared across dashboard screens.
class SectionHeader extends StatelessWidget {
  /// Material fallback icon (used when [iconAsset] is null).
  final IconData? icon;

  /// Optional SVG asset path; rendered with its own (baked) colours.
  final String? iconAsset;

  final String title;
  final Color accent;
  final Color? iconColor;

  const SectionHeader({
    super.key,
    this.icon,
    this.iconAsset,
    required this.title,
    this.accent = AppColors.accent,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        if (iconAsset != null)
          SvgPicture.asset(iconAsset!, width: 20, height: 20)
        else
          Icon(icon, size: 20, color: iconColor ?? AppColors.navy),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
