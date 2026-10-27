import 'package:flutter/material.dart';

import '../models/card_state.dart';
import 'card_placeholders.dart';

/// Renders a [CardState] as loading / error (with retry) / data — WITHOUT any
/// card chrome. Use for sections not wrapped in a [DashCard], such as the
/// summary tiles row and the KPI metrics row. Visuals mirror `DashCard`.
class CardStateView<T> extends StatelessWidget {
  final CardState<T> state;
  final Widget Function(T data) builder;

  /// Height reserved for the loading / error placeholders so the layout doesn't
  /// collapse. Defaults to the summary/metric tile height.
  final double minHeight;

  const CardStateView({
    super.key,
    required this.state,
    required this.builder,
    this.minHeight = 112,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      CardLoading() =>
        CardLoadingPlaceholder(minHeight: minHeight, spinnerSize: 26),
      CardError(:final message, :final onRetry) => CardErrorPlaceholder(
          message: message,
          onRetry: onRetry,
          minHeight: minHeight,
          iconSize: 28,
        ),
      CardData(:final data) => builder(data),
    };
  }
}
