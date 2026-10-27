import 'package:flutter/material.dart';

/// A single tile inside the shared "Status Breakdown" grid.
class StatusItem {
  final String label;
  final int value;

  /// Material fallback icon (used when [iconAsset] is null).
  final IconData? icon;

  /// Optional SVG asset path; takes precedence over [icon]. Rendered white.
  final String? iconAsset;

  /// Icon-tile gradient start colour.
  final Color color;

  /// Icon-tile gradient end colour. When null, a darkened [color] is used.
  final Color? colorEnd;

  /// Optional trailing pill text (e.g. "3.5%"). When null, no badge is shown.
  final String? badgeText;

  /// Colour of the trailing badge. Defaults to [color] when a badge is shown.
  final Color? badgeColor;

  const StatusItem({
    required this.label,
    required this.value,
    this.icon,
    this.iconAsset,
    required this.color,
    this.colorEnd,
    this.badgeText,
    this.badgeColor,
  });
}
