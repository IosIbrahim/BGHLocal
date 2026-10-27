import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Small rounded status pill, e.g. "+12% Today" or "Live".
/// Shared across dashboard chart-card headers.
class PillBadge extends StatelessWidget {
  final String text;
  final IconData? icon;

  /// Optional SVG asset; takes precedence over [icon]. Tinted to [color].
  final String? iconAsset;
  final Color color;

  /// Text size. Drop below the default for badges whose label can run long
  /// (e.g. a percentage followed by a period description).
  final double fontSize;

  const PillBadge({
    super.key,
    required this.text,
    this.icon,
    this.iconAsset,
    required this.color,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconAsset != null)
            SvgPicture.asset(
              iconAsset!,
              width: 14,
              height: 14,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            )
          else
            Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          // Flexible so a long label ellipsises if the badge is ever given a
          // bounded width, instead of overflowing the header row.
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
