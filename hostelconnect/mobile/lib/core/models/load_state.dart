// lib/core/models/load_state.dart
import 'package:flutter/material.dart';

/// Generic load state for handling async operations
abstract class LoadState<T> {
  const LoadState();
}

/// Initial state - no data loaded yet
class LoadStateInitial<T> extends LoadState<T> {
  const LoadStateInitial();
}

/// Loading state - data is being fetched
class LoadStateLoading<T> extends LoadState<T> {
  const LoadStateLoading();
}

/// Success state - data loaded successfully
class LoadStateSuccess<T> extends LoadState<T> {
  final T data;
  const LoadStateSuccess(this.data);
}

/// Error state - data loading failed
class LoadStateError<T> extends LoadState<T> {
  final String message;
  final Object? error;
  const LoadStateError(this.message, [this.error]);
}

/// Extension methods for LoadState
extension LoadStateExtensions<T> on LoadState<T> {
  /// Check if state is initial
  bool get isInitial => this is LoadStateInitial<T>;
  
  /// Check if state is loading
  bool get isLoading => this is LoadStateLoading<T>;
  
  /// Check if state is success
  bool get isSuccess => this is LoadStateSuccess<T>;
  
  /// Check if state is error
  bool get isError => this is LoadStateError<T>;
  
  /// Get data if success, null otherwise
  T? get data => isSuccess ? (this as LoadStateSuccess<T>).data : null;
  
  /// Get error message if error, null otherwise
  String? get errorMessage => isError ? (this as LoadStateError<T>).message : null;
  
  /// Pattern matching for LoadState
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message, Object? error) error,
  }) {
    if (this is LoadStateInitial<T>) {
      return initial();
    } else if (this is LoadStateLoading<T>) {
      return loading();
    } else if (this is LoadStateSuccess<T>) {
      return success((this as LoadStateSuccess<T>).data);
    } else if (this is LoadStateError<T>) {
      return error((this as LoadStateError<T>).message, (this as LoadStateError<T>).error);
    }
    throw StateError('Unknown LoadState type');
  }
  
  /// Pattern matching with default values
  R whenOrElse<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String message, Object? error)? error,
    required R Function() orElse,
  }) {
    if (this is LoadStateInitial<T>) {
      return initial?.call() ?? orElse();
    } else if (this is LoadStateLoading<T>) {
      return loading?.call() ?? orElse();
    } else if (this is LoadStateSuccess<T>) {
      return success?.call((this as LoadStateSuccess<T>).data) ?? orElse();
    } else if (this is LoadStateError<T>) {
      return error?.call((this as LoadStateError<T>).message, (this as LoadStateError<T>).error) ?? orElse();
    }
    return orElse();
  }
}