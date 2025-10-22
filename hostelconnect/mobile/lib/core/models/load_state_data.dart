// lib/core/models/load_state_data.dart - MISSING CLASS
import 'load_state.dart';

/// Wrapper class for LoadState with data
class LoadStateData<T> {
  final LoadState<T> state;
  final T? data;
  final String? error;

  const LoadStateData({
    required this.state,
    this.data,
    this.error,
  });

  factory LoadStateData.success(T data) {
    return LoadStateData(
      state: LoadState.data(data),
      data: data,
    );
  }

  factory LoadStateData.error(String error) {
    return LoadStateData(
      state: LoadState.error(error),
      error: error,
    );
  }

  factory LoadStateData.loading() {
    return const LoadStateData(
      state: LoadState.loading(),
    );
  }

  bool get isLoading => state.isLoading;
  bool get hasData => state.hasData;
  bool get hasError => state.hasError;
}
