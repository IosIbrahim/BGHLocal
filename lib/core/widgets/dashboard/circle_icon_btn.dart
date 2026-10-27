import 'package:flutter/material.dart';

/// Rounded translucent icon button used on colored headers.
///
/// When [onTap] is null the widget is purely decorative (no ripple and not
/// exposed as a button to assistive tech).
class CircleIconBtn extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback? onTap;

  const CircleIconBtn({
    super.key,
    required this.icon,
    this.iconSize = 18,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 12.0;
    // `Ink` (not `Container`) paints the background *below* the ripple layer so
    // the ink splash stays visible on tap.
    final box = Ink(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(icon, color: Colors.white, size: iconSize),
    );

    if (onTap == null) {
      // No interaction → render the plain decorated box without Material/InkWell.
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      );
    }

    return Semantics(
      button: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: box,
        ),
      ),
    );
  }
}
