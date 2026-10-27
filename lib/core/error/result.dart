import '../widgets/charts/models/card_state.dart';
import 'failures.dart';

sealed class Result<S> {
  const Result();

  T when<T>({
    required T Function(S value) success,
    required T Function(Failure failure) error,
  }) {
    return switch (this) {
      Success(value: final v) => success(v),
      Error(failure: final f) => error(f),
    };
  }

  /// Transforms a [Success] value, leaving an [Error] untouched. Useful for
  /// projecting one result into several derived results (e.g. splitting a
  /// combined payload into per-section states).
  Result<T> map<T>(T Function(S value) transform) => switch (this) {
        Success(value: final v) => Success(transform(v)),
        Error(failure: final f) => Error(f),
      };

  bool get isSuccess => this is Success<S>;
}

class Success<S> extends Result<S> {
  final S value;
  const Success(this.value);
}

class Error<S> extends Result<S> {
  final Failure failure;
  const Error(this.failure);
}

extension ResultCardX<S> on Result<S> {
  /// Maps this result to a [CardState], wiring [onRetry] into the error variant.
  CardState<S> toCard(void Function() onRetry) => when(
        success: (data) => CardData(data),
        error: (f) => CardError(message: f.message, onRetry: onRetry),
      );
}
