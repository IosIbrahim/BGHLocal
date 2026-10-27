import 'package:flutter/material.dart';

import '../donut_chart/donut_chart.dart';
import '../models/card_state.dart';
import 'dash_card.dart';

class DonutChartCard extends StatefulWidget {
  final String title;
  final CardState<List<DonutSegment>> state;

  final DonutChartConfig config;

  /// Optional icon shown before the [title].
  final IconData? leadingIcon;
  final String? leadingAsset;
  final Color? leadingIconColor;

  /// Optional widget pinned to the trailing edge of the header (e.g. a badge).
  final Widget? trailing;

  /// Optional content rendered below the legend (e.g. progress bars).
  final Widget? footer;

  /// Whether the legend scrolls horizontally. Set false to let it wrap.
  final bool legendScrollable;

  const DonutChartCard({
    super.key,
    required this.title,
    required this.state,
    this.leadingIcon,
    this.leadingAsset,
    this.leadingIconColor,
    this.trailing,
    this.config = const DonutChartConfig(
      size: 200,
      strokeWidth: 24,
      gapDegrees: 2.0,
      centerLabel: 'TOTAL',
    ),
    this.footer,
    this.legendScrollable = false,
  });

  @override
  State<DonutChartCard> createState() => _DonutChartCardState();
}

class _DonutChartCardState extends State<DonutChartCard> {
  int _selectedIndex = -1;

  @override
  void didUpdateWidget(covariant DonutChartCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset selection when data changes
    if (oldWidget.state != widget.state) {
      _selectedIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashCard<List<DonutSegment>>(
      title: widget.title,
      state: widget.state,
      leadingIcon: widget.leadingIcon,
      leadingAsset: widget.leadingAsset,
      leadingIconColor: widget.leadingIconColor,
      trailing: widget.trailing,
      footer: widget.footer,
      builder: (segments) => Column(
        children: [
          Center(
            child: AnimatedDonutChart(
              segments: segments,
              selectedIndex: _selectedIndex,
              onSegmentTap: (index) {
                setState(() => _selectedIndex = index);
              },
              config: widget.config,
            ),
          ),
          const SizedBox(height: 24),
          DonutLegend(
            segments: segments,
            selectedIndex: _selectedIndex,
            scrollable: widget.legendScrollable,
            valuePrefix: widget.config.valuePrefix,
            onTap: (index) {
              setState(() => _selectedIndex = index);
            },
          ),
        ],
      ),
    );
  }
}
