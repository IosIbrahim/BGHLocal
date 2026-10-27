import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/donut_segment.dart';
import '../utils/donut_chart_math.dart';

/// Paints the donut arcs onto the canvas.
///
/// This painter is intentionally free of Flutter widget dependencies so it
/// can be unit-tested without a widget tree.
///
/// Selected segment behaviour:
///  • Arc is drawn at full opacity; all others at [_dimmedOpacity].
///  • Arc radius and stroke width are slightly enlarged.
///  • An optional blurred glow is drawn beneath the arc.
class DonutPainter extends CustomPainter {
  static const double _selectedRadiusBoost = 3.0;
  static const double _selectedStrokeBoost = 5.0;
  static const double _shadowExtraStroke = 8.0;
  static const double _shadowBlurSigma = 6.0;
  static const double _shadowOpacity = 0.35;
  static const double _dimmedOpacity = 0.45;

  final List<DonutSegment> segments;
  final double animationProgress;
  final double strokeWidth;
  final double gapDegrees;
  final int? selectedIndex;
  final bool showShadow;

  const DonutPainter({
    required this.segments,
    required this.animationProgress,
    required this.strokeWidth,
    this.gapDegrees = 4.0,
    this.selectedIndex,
    this.showShadow = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = segments.fold<double>(0.0, (sum, s) => sum + s.value);
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = DonutChartMath.chartRadius(
      size: size,
      strokeWidth: strokeWidth,
    );

    final inset = DonutChartMath.capInsetRadians(
      strokeWidth: strokeWidth,
      radius: baseRadius,
    );
    final gapRad = DonutChartMath.gapToRadians(gapDegrees);
    final available = DonutChartMath.availableRadians(
      segmentCount: segments.length,
      gapDegrees: gapDegrees,
      animationProgress: animationProgress,
    );

    double startAngle = -math.pi / 2; // 12 o'clock

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final rawSweep = (segment.value / total) * available;
      final insetSweep = rawSweep - inset * 2;

      if (insetSweep <= 0) {
        startAngle += rawSweep + gapRad;
        continue;
      }

      final isSelected = selectedIndex == i;
      final hasSelection = selectedIndex != null;

      final arcRadius =
          isSelected ? baseRadius + _selectedRadiusBoost : baseRadius;
      final arcStroke =
          isSelected ? strokeWidth + _selectedStrokeBoost : strokeWidth;
      final arcRect = Rect.fromCircle(center: center, radius: arcRadius);
      final arcStart = startAngle + inset;

      if (showShadow && isSelected) {
        _paintShadow(
          canvas: canvas,
          arcRect: arcRect,
          arcStart: arcStart,
          insetSweep: insetSweep,
          color: segment.color,
          arcStroke: arcStroke,
        );
      }

      _paintArc(
        canvas: canvas,
        arcRect: arcRect,
        arcStart: arcStart,
        insetSweep: insetSweep,
        color: segment.color,
        arcStroke: arcStroke,
        isSelected: isSelected,
        hasSelection: hasSelection,
      );

      startAngle += rawSweep + gapRad;
    }
  }

  void _paintShadow({
    required Canvas canvas,
    required Rect arcRect,
    required double arcStart,
    required double insetSweep,
    required Color color,
    required double arcStroke,
  }) {
    final shadowPaint = Paint()
      ..color = color.withOpacity(_shadowOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcStroke + _shadowExtraStroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _shadowBlurSigma);

    canvas.drawArc(arcRect, arcStart, insetSweep, false, shadowPaint);
  }

  void _paintArc({
    required Canvas canvas,
    required Rect arcRect,
    required double arcStart,
    required double insetSweep,
    required Color color,
    required double arcStroke,
    required bool isSelected,
    required bool hasSelection,
  }) {
    final opacity = isSelected || !hasSelection ? 1.0 : _dimmedOpacity;

    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcStroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(arcRect, arcStart, insetSweep, false, paint);
  }

  @override
  bool shouldRepaint(DonutPainter old) =>
      old.animationProgress != animationProgress ||
      old.segments != segments ||
      old.strokeWidth != strokeWidth ||
      old.gapDegrees != gapDegrees ||
      old.selectedIndex != selectedIndex ||
      old.showShadow != showShadow;
}
