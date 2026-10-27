import 'package:flutter/material.dart';

import '../models/donut_chart_config.dart';
import '../models/donut_segment.dart';
import '../painters/donut_painter.dart';
import '../utils/donut_chart_math.dart';
import 'donut_center_label.dart';

class AnimatedDonutChart extends StatefulWidget {
  final List<DonutSegment> segments;

  final int selectedIndex;

  final ValueChanged<int>? onSegmentTap;

  final DonutChartConfig config;

  const AnimatedDonutChart({
    super.key,
    required this.segments,
    this.selectedIndex = -1,
    this.onSegmentTap,
    this.config = const DonutChartConfig(),
  });

  @override
  State<AnimatedDonutChart> createState() => _AnimatedDonutChartState();
}

class _AnimatedDonutChartState extends State<AnimatedDonutChart>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _drawAnimation;
  late Animation<double> _fadeScaleAnimation;

  // Keep the chart's state (and its completed animation) alive when it scrolls
  // out of the ListView's cache extent. Otherwise the State is disposed and
  // re-created on scroll-back, replaying the draw animation from zero.
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedDonutChart old) {
    super.didUpdateWidget(old);
    if (old.segments != widget.segments) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.config.animationDuration,
    );

    _drawAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.config.animationCurve,
    );

    // Center label fades and scales in slightly after the arcs start drawing.
    _fadeScaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );
  }

  double get _total =>
      widget.segments.fold<double>(0.0, (sum, s) => sum + s.value);

  DonutSegment? get _selectedSegment {
    final idx = widget.selectedIndex;
    if (idx < 0 || idx >= widget.segments.length) return null;
    return widget.segments[idx];
  }

  void _handleTap(TapUpDetails details) {
    if (widget.onSegmentTap == null) return;

    final tapped = DonutChartMath.hitTest(
      localPosition: details.localPosition,
      size: Size(widget.config.size, widget.config.size),
      segments: widget.segments,
      strokeWidth: widget.config.strokeWidth,
      gapDegrees: widget.config.gapDegrees,
    );

    final next =
        (tapped == -1 || tapped == widget.selectedIndex) ? -1 : tapped;
    widget.onSegmentTap!(next);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return AnimatedBuilder(
      animation: _drawAnimation,
      builder: (context, _) => GestureDetector(
        onTapUp: _handleTap,
        child: SizedBox.square(
          dimension: widget.config.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildChart(),
              _buildCenterLabel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return CustomPaint(
      size: Size.square(widget.config.size),
      painter: DonutPainter(
        segments: widget.segments,
        animationProgress: _drawAnimation.value,
        strokeWidth: widget.config.strokeWidth,
        gapDegrees: widget.config.gapDegrees,
        selectedIndex:
            widget.selectedIndex == -1 ? null : widget.selectedIndex,
        showShadow: widget.config.showShadow,
      ),
    );
  }

  Widget _buildCenterLabel() {
    return FadeTransition(
      opacity: _fadeScaleAnimation,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
        ),
        child: DonutCenterLabel(
          total: _total,
          label: widget.config.centerLabel,
          selectedSegment: _selectedSegment,
          valueColor: widget.config.centerValueColor,
          valuePrefix: widget.config.valuePrefix,
          valueFontSize: widget.config.centerValueFontSize,
        ),
      ),
    );
  }
}
