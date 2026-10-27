import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/donut_segment.dart';

/// Shared math helpers used by both the painter and the gesture recogniser.
///
/// All functions are pure (no side effects, no state) so they are trivially
/// testable without a widget tree.
abstract final class DonutChartMath {
  /// Computes the gap in radians that accounts for the stroke caps' visual
  /// inset so that adjacent arcs don't visually overlap.
  static double capInsetRadians({
    required double strokeWidth,
    required double radius,
  }) =>
      (strokeWidth / 2) / radius;

  /// Converts [gapDegrees] to radians.
  static double gapToRadians(double gapDegrees) =>
      gapDegrees * math.pi / 180.0;

  /// Total radians consumed by all gaps for [segmentCount] segments.
  static double totalGapRadians({
    required int segmentCount,
    required double gapDegrees,
  }) =>
      gapToRadians(gapDegrees) * segmentCount;

  /// Radians available for arcs after accounting for gaps, scaled by
  /// [animationProgress] (0 → 1).
  static double availableRadians({
    required int segmentCount,
    required double gapDegrees,
    double animationProgress = 1.0,
  }) =>
      (2 * math.pi -
          totalGapRadians(
            segmentCount: segmentCount,
            gapDegrees: gapDegrees,
          )) *
      animationProgress;

  /// Returns the chart radius given the canvas [size], [strokeWidth], and an
  /// optional extra [padding] to prevent clipping of the selection glow.
  static double chartRadius({
    required Size size,
    required double strokeWidth,
    double padding = 6.0,
  }) =>
      (math.min(size.width, size.height) / 2) - strokeWidth / 2 - padding;

  /// Returns the index of the arc that contains [localPosition], or `-1` when
  /// the tap falls outside every arc.
  ///
  /// Geometry:
  ///  • Tests whether the tap is inside the stroke band [inner, outer].
  ///  • Converts the tap angle to a clock-wise angle from 12 o'clock.
  ///  • Walks the segment list comparing against arc start/end angles.
  static int hitTest({
    required Offset localPosition,
    required Size size,
    required List<DonutSegment> segments,
    required double strokeWidth,
    required double gapDegrees,
  }) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = chartRadius(size: size, strokeWidth: strokeWidth);

    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    final inner = radius - strokeWidth / 2;
    final outer = radius + strokeWidth / 2;
    if (distance < inner || distance > outer) return -1;

    // atan2 gives angle from +x axis; rotate -90° so 0 = 12 o'clock.
    double tapAngle = (math.atan2(dy, dx) + math.pi / 2) % (2 * math.pi);
    if (tapAngle < 0) tapAngle += 2 * math.pi;

    final total = segments.fold<double>(0.0, (s, e) => s + e.value);
    if (total == 0) return -1;

    final inset = capInsetRadians(strokeWidth: strokeWidth, radius: radius);
    final gapRad = gapToRadians(gapDegrees);
    final available = availableRadians(
      segmentCount: segments.length,
      gapDegrees: gapDegrees,
    );

    double cursor = 0.0;
    for (int i = 0; i < segments.length; i++) {
      final rawSweep = (segments[i].value / total) * available;
      final arcStart = cursor + inset;
      final arcEnd = cursor + rawSweep - inset;

      if (tapAngle >= arcStart && tapAngle <= arcEnd) return i;

      cursor += rawSweep + gapRad;
    }
    return -1;
  }
}

/// Formatting helpers used by labels and chips.
abstract final class DonutFormatting {
  /// Formats [value] compactly, adding a K/M suffix for large numbers.
  ///
  /// Examples: `420.0` → `'420'`, `3.5` → `'3.5'`, `890000` → `'890K'`,
  /// `1500000` → `'1.5M'`, `2390000` → `'2.4M'`.
  static String formatValue(double value) {
    if (value >= 1000000) return '${_trim(value / 1000000)}M';
    if (value >= 1000) return '${_trim(value / 1000)}K';
    return _trim(value);
  }

  static String _trim(double v) =>
      v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 1);
}
