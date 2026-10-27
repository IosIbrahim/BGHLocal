import 'package:flutter/material.dart';

/// Immutable configuration object for [AnimatedDonutChart].
///
/// Separating config from the widget keeps the constructor concise and
/// makes it trivial to share the same config across multiple chart instances.
@immutable
class DonutChartConfig {
  /// Outer diameter of the chart canvas in logical pixels.
  final double size;

  /// Thickness of each arc stroke in logical pixels.
  final double strokeWidth;

  /// Gap between adjacent arcs in degrees.
  final double gapDegrees;

  /// Duration of the draw-in animation when the widget first mounts
  /// or when [AnimatedDonutChart.segments] changes.
  final Duration animationDuration;

  /// Easing curve for the draw-in animation.
  final Curve animationCurve;

  /// Whether to paint a blurred glow behind the selected arc.
  final bool showShadow;

  /// Text displayed inside the ring when no segment is selected.
  final String centerLabel;

  /// Colour of the centre total value. When null, the chart's default teal
  /// is used. (A selected segment always shows that segment's colour.)
  final Color? centerValueColor;

  /// Prefix prepended to every formatted value (centre + legend), e.g. "$".
  final String valuePrefix;

  /// Font size of the centre total value.
  final double centerValueFontSize;

  const DonutChartConfig({
    this.size = 220,
    this.strokeWidth = 22,
    this.gapDegrees = 4.0,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.animationCurve = Curves.easeInOutCubic,
    this.showShadow = true,
    this.centerLabel = 'TOTAL',
    this.centerValueColor,
    this.valuePrefix = '',
    this.centerValueFontSize = 44,
  })  : assert(size > 0, 'size must be positive'),
        assert(strokeWidth > 0, 'strokeWidth must be positive'),
        assert(gapDegrees >= 0, 'gapDegrees must be non-negative');

  DonutChartConfig copyWith({
    double? size,
    double? strokeWidth,
    double? gapDegrees,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? showShadow,
    String? centerLabel,
    Color? centerValueColor,
    String? valuePrefix,
    double? centerValueFontSize,
  }) {
    return DonutChartConfig(
      size: size ?? this.size,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      gapDegrees: gapDegrees ?? this.gapDegrees,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      showShadow: showShadow ?? this.showShadow,
      centerLabel: centerLabel ?? this.centerLabel,
      centerValueColor: centerValueColor ?? this.centerValueColor,
      valuePrefix: valuePrefix ?? this.valuePrefix,
      centerValueFontSize: centerValueFontSize ?? this.centerValueFontSize,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonutChartConfig &&
          runtimeType == other.runtimeType &&
          size == other.size &&
          strokeWidth == other.strokeWidth &&
          gapDegrees == other.gapDegrees &&
          animationDuration == other.animationDuration &&
          animationCurve == other.animationCurve &&
          showShadow == other.showShadow &&
          centerLabel == other.centerLabel &&
          centerValueColor == other.centerValueColor &&
          valuePrefix == other.valuePrefix &&
          centerValueFontSize == other.centerValueFontSize;

  @override
  int get hashCode => Object.hash(
        size,
        strokeWidth,
        gapDegrees,
        animationDuration,
        animationCurve,
        showShadow,
        centerLabel,
        centerValueColor,
        valuePrefix,
        centerValueFontSize,
      );
}
