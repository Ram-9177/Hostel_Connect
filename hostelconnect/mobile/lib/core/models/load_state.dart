// lib/core/models/load_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'load_state.freezed.dart';

@freezed
class LoadState<T> with _$LoadState<T> {
  const factory LoadState.loading() = _Loading<T>;
  const factory LoadState.data(T data) = _Data<T>;
  const factory LoadState.error(String error) = _Error<T>;
}