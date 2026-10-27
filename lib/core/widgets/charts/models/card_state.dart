import 'package:flutter/foundation.dart' show VoidCallback;

sealed class CardState<T> {
  const CardState();
}

class CardLoading<T> extends CardState<T> {
  const CardLoading();
}

class CardError<T> extends CardState<T> {
  final String message;
  final VoidCallback? onRetry;

  const CardError({required this.message, this.onRetry});
}

class CardData<T> extends CardState<T> {
  final T data;
  const CardData(this.data);
}

extension CardStateMap<T> on CardState<T> {
  /// Projects the value of a [CardData] through [transform] while preserving the
  /// loading and error (including its `onRetry`) variants. Lets one source
  /// [CardState] feed differently-typed widgets (e.g. a `BedStatus` state into a
  /// `List<DonutSegment>` chart).
  CardState<R> mapData<R>(R Function(T data) transform) {
    final state = this;
    return switch (state) {
      CardLoading<T>() => CardLoading<R>(),
      CardError<T>(:final message, :final onRetry) =>
        CardError<R>(message: message, onRetry: onRetry),
      CardData<T>(:final data) => CardData<R>(transform(data)),
    };
  }
}
