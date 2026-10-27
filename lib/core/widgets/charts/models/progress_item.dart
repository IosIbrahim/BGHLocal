import 'package:flutter/material.dart';

class ProgressItem {
  final String label;
  final IconData icon;
  final int current;
  final int total;
  final Color color;

  const ProgressItem({
    required this.label,
    required this.icon,
    required this.current,
    required this.total,
    required this.color,
  });

  double get percent => total > 0 ? (current / total).clamp(0.0, 1.0) : 0;
}
