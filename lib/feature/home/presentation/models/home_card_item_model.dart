import 'package:flutter/material.dart';

import 'dashboard_feature.dart';

/// Static presentation data for a home dashboard card.
///
/// Deliberately carries no count: the count is live state owned by
/// `HomeCountsCubit` and passed to the card separately. A feature with no count
/// endpoint yet simply has no state entry, and its card renders without a
/// count footer instead of showing a placeholder number.
class HomeCardItemModel {
  final String title;
  final String subtitle;

  /// Label rendered under the live count (e.g. 'Patients'). Only shown when a
  /// count is actually available.
  final String countLabel;
  final String? iconUrl;
  final String? iconAsset;
  final Color iconColor;
  final Color iconColorEnd;
  final DashboardFeature? feature;

  const HomeCardItemModel({
    required this.title,
    required this.subtitle,
    required this.countLabel,
    this.iconUrl,
    this.iconAsset,
    required this.iconColor,
    required this.iconColorEnd,
    this.feature,
  });

  Color get footerBackgroundColor =>
      Color.lerp(iconColor, Colors.white, 0.88) ?? iconColor.withValues(alpha: 0.12);

  factory HomeCardItemModel.fromJson(Map<String, dynamic> json) {
    final iconColor = _colorFromJson(
      json['icon_color'] ?? json['iconColor'],
      const Color(0xFF3DDC84),
    );
    final iconColorEnd = _colorFromJson(
      json['icon_color_end'] ?? json['iconColorEnd'],
      iconColor,
    );

    return HomeCardItemModel(
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      countLabel: json['count_label']?.toString() ??
          json['countLabel']?.toString() ??
          '',
      iconUrl: json['icon_url']?.toString() ?? json['iconUrl']?.toString(),
      iconAsset: json['icon_asset']?.toString() ?? json['iconAsset']?.toString(),
      iconColor: iconColor,
      iconColorEnd: iconColorEnd,
      feature: DashboardFeature.fromKey(
          json['feature']?.toString() ?? json['route_name']?.toString() ?? ''),
    );
  }

  static Color _colorFromJson(dynamic value, Color fallback) {
    if (value == null) return fallback;

    final colorValue = value.toString().replaceFirst('#', '');
    if (colorValue.length == 6 || colorValue.length == 8) {
      final hex = colorValue.length == 6 ? 'FF$colorValue' : colorValue;
      return Color(int.parse(hex, radix: 16));
    }

    return fallback;
  }
}
