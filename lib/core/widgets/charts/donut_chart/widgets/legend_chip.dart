import 'package:flutter/material.dart';

import '../models/donut_segment.dart';
import '../utils/donut_chart_math.dart';

class LegendChip extends StatelessWidget {
  static const _dimmedOpacity = 0.4;
  static const _normalBorderColor = Color(0xFFE2E8F0);
  static const _labelColor = Color(0xFF4A5568);
  static const _valueDimColor = Color(0xFF8A9BB0);
  static const _animDuration = Duration(milliseconds: 200);

  final DonutSegment segment;
  final bool isSelected;
  final bool dimmed;
  final VoidCallback? onTap;
  final String valuePrefix;

  const LegendChip({
    super.key,
    required this.segment,
    required this.isSelected,
    required this.dimmed,
    this.onTap,
    this.valuePrefix = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: dimmed ? _dimmedOpacity : 1.0,
        duration: _animDuration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ColorDot(color: segment.color, isSelected: isSelected),
              const SizedBox(width: 6),
              _Label(
                text: segment.label,
                color: isSelected ? segment.color : _labelColor,
                isSelected: isSelected,
              ),
              const SizedBox(width: 4),
              _ValueBadge(
                value: segment.value,
                prefix: valuePrefix,
                color: isSelected ? segment.color : _valueDimColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const _ColorDot({required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: LegendChip._animDuration,
      width: isSelected ? 15 : 12,
      height: isSelected ? 15 : 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  final Color color;
  final bool isSelected;

  const _Label({
    required this.text,
    required this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        color: color,
      ),
    );
  }
}

class _ValueBadge extends StatelessWidget {
  final double value;
  final Color color;
  final String prefix;

  const _ValueBadge({
    required this.value,
    required this.color,
    this.prefix = '',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '($prefix${DonutFormatting.formatValue(value)})',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}
