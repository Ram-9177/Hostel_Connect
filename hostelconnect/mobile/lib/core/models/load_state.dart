// lib/core/models/load_state.dart
import 'package:flutter/foundation.dart';

/// Generic load state for handling async operations
@immutable
class LoadState<T> {
  final T? data;
  final String? error;
  final bool isLoading;
  final bool isRefreshing;

  const LoadState({
    this.data,
    this.error,
    this.isLoading = false,
    this.isRefreshing = false,
  });

  LoadState<T> copyWith({
    T? data,
    String? error,
    bool? isLoading,
    bool? isRefreshing,
  }) {
    return LoadState<T>(
      data: data ?? this.data,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  bool get hasData => data != null;
  bool get hasError => error != null;
  bool get isEmpty => !isLoading && !hasData && !hasError;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoadState<T> &&
        other.data == data &&
        other.error == error &&
        other.isLoading == isLoading &&
        other.isRefreshing == isRefreshing;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        error.hashCode ^
        isLoading.hashCode ^
        isRefreshing.hashCode;
  }
}

/// Load state with data wrapper
class LoadStateData<T> extends LoadState<T> {
  const LoadStateData({
    super.data,
    super.error,
    super.isLoading,
    super.isRefreshing,
  });

  factory LoadStateData.loading() {
    return const LoadStateData(isLoading: true);
  }

  factory LoadStateData.data(T data) {
    return LoadStateData(data: data);
  }

  factory LoadStateData.error(String error) {
    return LoadStateData(error: error);
  }

  factory LoadStateData.refreshing(T data) {
    return LoadStateData(data: data, isRefreshing: true);
  }
}