// lib/core/state/load_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'load_state.freezed.dart';

@freezed
class LoadState<T> with _$LoadState<T> {
  const factory LoadState.idle() = _Idle<T>;
  const factory LoadState.loading() = _Loading<T>;
  const factory LoadState.success(T data) = _Success<T>;
  const factory LoadState.error(String message, {T? previousData}) = _Error<T>;

  const LoadState._();

  bool get isLoading => this is _Loading<T>;
  bool get isSuccess => this is _Success<T>;
  bool get isError => this is _Error<T>;
  bool get isIdle => this is _Idle<T>;

  T? get data => when(
        idle: () => null,
        loading: () => null,
        success: (data) => data,
        error: (message, previousData) => previousData,
      );

  String? get errorMessage => when(
        idle: () => null,
        loading: () => null,
        success: (data) => null,
        error: (message, previousData) => message,
      );

  bool get hasData => data != null;
  bool get isEmpty => !hasData;
}

// Extension for easier state management
extension LoadStateExtension<T> on LoadState<T> {
  LoadState<T> toLoading() => const LoadState.loading();
  
  LoadState<T> toSuccess(T data) => LoadState.success(data);
  
  LoadState<T> toError(String message) => LoadState.error(message, previousData: data);
  
  LoadState<T> toIdle() => const LoadState.idle();
}

// Pagination state for lists
@freezed
class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState({
    @Default([]) List<T> items,
    @Default(LoadState.idle()) LoadState<List<T>> loadState,
    @Default(false) bool hasMore,
    @Default(1) int currentPage,
    @Default(20) int pageSize,
  }) = _PaginationState<T>;

  const PaginationState._();

  bool get isLoading => loadState.isLoading;
  bool get isError => loadState.isError;
  bool get isEmpty => items.isEmpty && !isLoading;
  bool get canLoadMore => hasMore && !isLoading;
  
  int get totalItems => items.length;
  bool get isFirstPage => currentPage == 1;
}

// Cache state for offline support
@freezed
class CacheState<T> with _$CacheState<T> {
  const factory CacheState({
    T? data,
    @Default(false) bool isStale,
    DateTime? lastUpdated,
    @Default(Duration(minutes: 5)) Duration cacheExpiry,
  }) = _CacheState<T>;

  const CacheState._();

  bool get isExpired {
    if (lastUpdated == null) return true;
    return DateTime.now().difference(lastUpdated!) > cacheExpiry;
  }

  bool get isValid => data != null && !isExpired;
  
  CacheState<T> updateData(T newData) => copyWith(
        data: newData,
        lastUpdated: DateTime.now(),
        isStale: false,
      );
  
  CacheState<T> markStale() => copyWith(isStale: true);
}
