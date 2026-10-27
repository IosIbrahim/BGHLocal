import 'dart:ui' show Color;

/// Generic data model for a single bar inside a [BarChartCard].
class BarItem {
  final String label;
  final double value;
  final Color color;

  const BarItem(this.label, this.value, this.color);
}
