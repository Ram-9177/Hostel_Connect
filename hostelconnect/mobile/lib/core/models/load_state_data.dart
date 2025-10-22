// lib/core/models/load_state_data.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'load_state_data.freezed.dart';

@freezed
class LoadState<T> with _$LoadState<T> {
  const factory LoadState.loading() = _Loading<T>;
  const factory LoadState.success(T data) = _Success<T>;
  const factory LoadState.error(String message) = _Error<T>;
}

extension LoadStateExtension<T> on LoadState<T> {
  bool get isLoading => this is _Loading<T>;
  bool get isSuccess => this is _Success<T>;
  bool get isError => this is _Error<T>;
  
  T? get data => when(
    loading: () => null,
    success: (data) => data,
    error: (_) => null,
  );
  
  String? get errorMessage => when(
    loading: () => null,
    success: (_) => null,
    error: (message) => message,
  );
}
