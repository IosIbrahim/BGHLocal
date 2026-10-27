import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/bar_item.dart';
import '../models/card_state.dart';
import 'dash_card.dart';

class BarChartCard extends StatefulWidget {
  final String title;
  final CardState<List<BarItem>> state;

  final ValueChanged<BarItem?>? onBarSelected;

  final double chartHeight;

  final double barSpacing;

  final double? maxY;

  final IconData? leadingIcon;
  final String? leadingAsset;
  final Color? leadingIconColor;
  final Widget? trailing;

  const BarChartCard({
    super.key,
    required this.title,
    required this.state,
    this.onBarSelected,
    this.chartHeight = 280,
    this.barSpacing = 75,
    this.maxY,
    this.leadingIcon,
    this.leadingAsset,
    this.leadingIconColor,
    this.trailing,
  });

  @override
  State<BarChartCard> createState() => _BarChartCardState();
}

class _BarChartCardState extends State<BarChartCard>
    with AutomaticKeepAliveClientMixin {
  int? _selectedIndex;

  // Keep the chart alive when it scrolls out of the ListView's cache extent,
  // so fl_chart doesn't re-run its implicit bar animation from zero on
  // scroll-back.
  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant BarChartCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset selection when data changes
    if (oldWidget.state != widget.state) {
      _selectedIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return DashCard<List<BarItem>>(
      title: widget.title,
      state: widget.state,
      leadingIcon: widget.leadingIcon,
      leadingAsset: widget.leadingAsset,
      leadingIconColor: widget.leadingIconColor,
      trailing: widget.trailing,
      builder: (data) => _buildChart(data),
    );
  }

  Widget _buildChart(List<BarItem> data) {
    final effectiveMaxY =
        widget.maxY ?? _autoMaxY(data);

    return SizedBox(
      height: widget.chartHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: data.length * widget.barSpacing,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: _barTouchData(data),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 30,
                getDrawingHorizontalLine: (_) => const FlLine(
                  color: Color(0xFFEAECF4),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              titlesData: _titlesData(data),
              barGroups: _barGroups(data, effectiveMaxY),
            ),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );
  }

  // ── Touch / tooltip ──────────────────────────────────────────────────────

  BarTouchData _barTouchData(List<BarItem> data) {
    return BarTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      touchCallback: (event, response) {
        if (response?.spot == null) return;

        final index = response!.spot!.touchedBarGroupIndex;
        setState(() {
          if (_selectedIndex == index) {
            _selectedIndex = null;
            widget.onBarSelected?.call(null);
          } else {
            _selectedIndex = index;
            widget.onBarSelected?.call(data[index]);
          }
        });
      },
      touchTooltipData: BarTouchTooltipData(
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        getTooltipColor: (_) => const Color(0xFF1A1D3B),
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            '${data[groupIndex].label}\n',
            const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: rod.toY.toInt().toString(),
                style: const TextStyle(
                  color: Color(0xFF1EC6D4),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Axis titles ──────────────────────────────────────────────────────────

  FlTitlesData _titlesData(List<BarItem> data) {
    return FlTitlesData(
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 30,
          reservedSize: 35,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFFAAAFC8),
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= data.length) {
              return const SizedBox();
            }

            final isSelected = _selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: 60,
                child: Text(
                  data[index].label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? Colors.black87
                        : const Color(0xFF8A8FA8),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Bar groups ───────────────────────────────────────────────────────────

  List<BarChartGroupData> _barGroups(List<BarItem> data, double maxY) {
    return List.generate(data.length, (index) {
      final item = data[index];
      final isSelected = _selectedIndex == index;

      return BarChartGroupData(
        x: index,
        showingTooltipIndicators: isSelected ? [0] : [],
        barRods: [
          BarChartRodData(
            toY: item.value,
            width: isSelected ? 34 : 28,
            color: item.color,
            borderRadius: BorderRadius.circular(12),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: const Color(0xFFF0F2F8),
            ),
          ),
        ],
      );
    });
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// Computes a rounded-up max Y for background bars.
  double _autoMaxY(List<BarItem> data) {
    if (data.isEmpty) return 100;
    final peak = data.map((e) => e.value).reduce(
        (a, b) => a > b ? a : b);
    // Round up to the nearest 30 (matches grid interval)
    return ((peak / 30).ceil() * 30).toDouble() + 10;
  }
}
