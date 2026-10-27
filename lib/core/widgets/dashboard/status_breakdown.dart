import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import 'status_item.dart';

/// Shared "Status Breakdown" grid. Items are laid out two-per-row; a final odd
/// item spans the full width. A tile may carry an optional trailing badge.
class StatusBreakdown extends StatelessWidget {
  final List<StatusItem> items;

  const StatusBreakdown({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var i = 0; i < items.length; i += 2) {
      final isLastSingle = i == items.length - 1;

      if (isLastSingle) {
        rows.add(_StatusTile(item: items[i]));
      } else {
        rows.add(Row(
          children: [
            Expanded(child: _StatusTile(item: items[i])),
            const SizedBox(width: 12),
            Expanded(child: _StatusTile(item: items[i + 1])),
          ],
        ));
      }

      if (i + 2 < items.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    return Column(children: rows);
  }
}

class _StatusTile extends StatelessWidget {
  final StatusItem item;

  const _StatusTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  item.color,
                  item.colorEnd ?? Color.lerp(item.color, Colors.black, 0.18)!,
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: item.iconAsset != null
                ? SvgPicture.asset(
                    item.iconAsset!,
                    width: 24,
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  )
                : Icon(item.icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item.value}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navy,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          if (item.badgeText != null) _badge(item),
        ],
      ),
    );
  }

  Widget _badge(StatusItem item) {
    final color = item.badgeColor ?? item.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        item.badgeText!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
