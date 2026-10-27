import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';

/// One metric tile (e.g. "+18% / vs Last Month") with a gradient icon box and
/// a coloured value. Used by the Revenue "Monthly Trends" row.
class MetricItem {
  /// Display value, coloured with [color] (e.g. "+18%").
  final String value;
  final String label;
  final String iconAsset;

  /// Icon-tile gradient start / end.
  final Color color;
  final Color colorEnd;

  const MetricItem({
    required this.value,
    required this.label,
    required this.iconAsset,
    required this.color,
    required this.colorEnd,
  });
}

/// A row of equal-width metric tiles.
class MetricCards extends StatelessWidget {
  final List<MetricItem> items;

  const MetricCards({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight + stretch so both tiles match the taller one when a label
    // wraps to two lines, instead of sitting at different heights.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: SmallMetricTile(item: items[i])),
          ],
        ],
      ),
    );
  }
}

class SmallMetricTile extends StatelessWidget {
  final MetricItem item;

  const SmallMetricTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEF1F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [item.color, item.colorEnd],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              item.iconAsset,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Shrinks rather than clipping if a long value meets a narrow
                // tile; stays at its natural size otherwise.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    item.value,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: item.color,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                // Two lines so a full period label ("vs Previous Month") shows
                // instead of being cut to an ellipsis.
                Text(
                  item.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
