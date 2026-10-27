import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resources/app_strings.dart';

const _spinnerColor = Color(0xFF1B5EF7);
const _errorIconColor = Color(0xFFFF6B81);
const _messageColor = Color(0xFF8A8FA8);

/// Centered loading spinner reserving [minHeight] so layouts don't collapse.
/// Shared by [DashCard] and [CardStateView].
class CardLoadingPlaceholder extends StatelessWidget {
  final double minHeight;
  final double spinnerSize;

  const CardLoadingPlaceholder({
    super.key,
    this.minHeight = 120,
    this.spinnerSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: minHeight,
      child: Center(
        child: SizedBox(
          width: spinnerSize,
          height: spinnerSize,
          child: const CircularProgressIndicator(
            strokeWidth: 2.5,
            color: _spinnerColor,
          ),
        ),
      ),
    );
  }
}

/// Error icon + message with an optional retry button, reserving [minHeight].
/// Shared by [DashCard] and [CardStateView].
class CardErrorPlaceholder extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final double minHeight;
  final double iconSize;

  const CardErrorPlaceholder({
    super.key,
    required this.message,
    this.onRetry,
    this.minHeight = 120,
    this.iconSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: minHeight,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: iconSize, color: _errorIconColor),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _messageColor,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(AppStrings.retry.tr()),
                style: TextButton.styleFrom(
                  foregroundColor: _spinnerColor,
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
