import 'package:flutter/material.dart';

import '../models/donut_segment.dart';
import '../utils/donut_chart_math.dart';

class DonutCenterLabel extends StatelessWidget {
  static const _valueFontSize = 44.0;
  static const _subtitleFontSize = 11.0;
  static const _subtitleLetterSpacing = 1.4;
  static const _defaultValueColor = Color(0xFF1A9FAF);
  static const _subtitleColor = Color(0xFF8A9BB0);

  final double total;
  final String label;

  final DonutSegment? selectedSegment;

  /// Colour of the total value. Falls back to [_defaultValueColor] when null.
  final Color? valueColor;

  /// Prefix prepended to the formatted value (e.g. "$").
  final String valuePrefix;

  /// Font size of the total value.
  final double valueFontSize;

  const DonutCenterLabel({
    super.key,
    required this.total,
    required this.label,
    this.selectedSegment,
    this.valueColor,
    this.valuePrefix = '',
    this.valueFontSize = _valueFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final seg = selectedSegment;
    final displayValue = seg != null ? seg.value : total;
    final displayLabel = (seg?.label ?? label).toUpperCase();
    final displayColor = seg?.color ?? valueColor ?? _defaultValueColor;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Column(
        key: ValueKey(seg?.label ?? '__total__'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$valuePrefix${DonutFormatting.formatValue(displayValue)}',
            style: TextStyle(
              fontSize: valueFontSize,
              fontWeight: FontWeight.w800,
              color: displayColor,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            displayLabel,
            style: const TextStyle(
              fontSize: _subtitleFontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: _subtitleLetterSpacing,
              color: _subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
