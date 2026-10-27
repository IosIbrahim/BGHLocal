import 'package:flutter/material.dart';

/// Immutable data model representing a single arc segment in a donut chart.
///
/// Example:
/// ```dart
/// const segment = DonutSegment(
///   label: 'Revenue',
///   value: 420.0,
///   color: Color(0xFF7C5CBF),
/// );
/// ```
@immutable
class DonutSegment {
  /// Display label shown in the legend and center when selected.
  final String label;

  /// Numeric value determining the arc's proportional size.
  /// Must be greater than zero to be rendered.
  final double value;

  /// Fill colour of the arc and legend chip.
  final Color color;

  const DonutSegment({
    required this.label,
    required this.value,
    required this.color,
  }) : assert(value >= 0, 'DonutSegment.value must be non-negative');

  /// Returns a copy of this segment with the given fields replaced.
  DonutSegment copyWith({
    String? label,
    double? value,
    Color? color,
  }) {
    return DonutSegment(
      label: label ?? this.label,
      value: value ?? this.value,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonutSegment &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          value == other.value &&
          color == other.color;

  @override
  int get hashCode => Object.hash(label, value, color);

  @override
  String toString() =>
      'DonutSegment(label: $label, value: $value, color: $color)';
}
