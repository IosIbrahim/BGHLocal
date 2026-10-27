import 'package:flutter/material.dart';

import '../models/donut_segment.dart';
import 'legend_chip.dart';

class DonutLegend extends StatelessWidget {
  static const _horizontalPadding = EdgeInsets.symmetric(horizontal: 16);
  static const _chipSpacing = 8.0;

  final List<DonutSegment> segments;

  final int selectedIndex;

  final ValueChanged<int>? onTap;

  final bool scrollable;

  /// Prefix prepended to each chip's value (e.g. "$").
  final String valuePrefix;

  const DonutLegend({
    super.key,
    required this.segments,
    this.selectedIndex = -1,
    this.onTap,
    this.scrollable = true,
    this.valuePrefix = '',
  });

  @override
  Widget build(BuildContext context) {
    final chips = _buildChips();
    return scrollable ? _ScrollRow(chips: chips) : _WrapRow(chips: chips);
  }

  List<Widget> _buildChips() {
    return segments.indexed.map((record) {
      final (index, segment) = record;
      return LegendChip(
        segment: segment,
        isSelected: selectedIndex == index,
        dimmed: selectedIndex != -1 && selectedIndex != index,
        valuePrefix: valuePrefix,
        onTap: () => onTap?.call(selectedIndex == index ? -1 : index),
      );
    }).toList();
  }
}

// ── Layout variants ───────────────────────────────────────────────────────────

class _ScrollRow extends StatelessWidget {
  final List<Widget> chips;

  const _ScrollRow({required this.chips});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: DonutLegend._horizontalPadding,
      child: Row(
        children: chips
            .expand((c) => [c, const SizedBox(width: DonutLegend._chipSpacing)])
            .toList()
          ..removeLast(),
      ),
    );
  }
}

class _WrapRow extends StatelessWidget {
  final List<Widget> chips;

  const _WrapRow({required this.chips});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DonutLegend._horizontalPadding,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: DonutLegend._chipSpacing,
        runSpacing: DonutLegend._chipSpacing,
        children: chips,
      ),
    );
  }
}
