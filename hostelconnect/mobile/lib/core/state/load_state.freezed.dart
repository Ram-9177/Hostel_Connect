// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'load_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoadState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String message, T? previousData) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String message, T? previousData)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String message, T? previousData)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadStateCopyWith<T, $Res> {
  factory $LoadStateCopyWith(
          LoadState<T> value, $Res Function(LoadState<T>) then) =
      _$LoadStateCopyWithImpl<T, $Res, LoadState<T>>;
}

/// @nodoc
class _$LoadStateCopyWithImpl<T, $Res, $Val extends LoadState<T>>
    implements $LoadStateCopyWith<T, $Res> {
  _$LoadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleImplCopyWith<T, $Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl<T> value, $Res Function(_$IdleImpl<T>) then) =
      __$$IdleImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<T, $Res>
    extends _$LoadStateCopyWithImpl<T, $Res, _$IdleImpl<T>>
    implements _$$IdleImplCopyWith<T, $Res> {
  __$$IdleImplCopyWithImpl(
      _$IdleImpl<T> _value, $Res Function(_$IdleImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl<T> extends _Idle<T> {
  const _$IdleImpl() : super._();

  @override
  String toString() {
    return 'LoadState<$T>.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String message, T? previousData) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String message, T? previousData)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String message, T? previousData)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle<T> extends LoadState<T> {
  const factory _Idle() = _$IdleImpl<T>;
  const _Idle._() : super._();
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$LoadStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl<T> extends _Loading<T> {
  const _$LoadingImpl() : super._();

  @override
  String toString() {
    return 'LoadState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String message, T? previousData) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String message, T? previousData)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String message, T? previousData)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<T> extends LoadState<T> {
  const factory _Loading() = _$LoadingImpl<T>;
  const _Loading._() : super._();
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<T, $Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl<T> value, $Res Function(_$SuccessImpl<T>) then) =
      __$$SuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<T, $Res>
    extends _$LoadStateCopyWithImpl<T, $Res, _$SuccessImpl<T>>
    implements _$$SuccessImplCopyWith<T, $Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl<T> _value, $Res Function(_$SuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<T> extends _Success<T> {
  const _$SuccessImpl(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'LoadState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      __$$SuccessImplCopyWithImpl<T, _$SuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String message, T? previousData) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String message, T? previousData)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String message, T? previousData)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<T> extends LoadState<T> {
  const factory _Success(final T data) = _$SuccessImpl<T>;
  const _Success._() : super._();

  T get data;

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, T? previousData});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$LoadStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? previousData = freezed,
  }) {
    return _then(_$ErrorImpl<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      previousData: freezed == previousData
          ? _value.previousData
          : previousData // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> extends _Error<T> {
  const _$ErrorImpl(this.message, {this.previousData}) : super._();

  @override
  final String message;
  @override
  final T? previousData;

  @override
  String toString() {
    return 'LoadState<$T>.error(message: $message, previousData: $previousData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.previousData, previousData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(previousData));

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String message, T? previousData) error,
  }) {
    return error(message, previousData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String message, T? previousData)? error,
  }) {
    return error?.call(message, previousData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String message, T? previousData)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, previousData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> extends LoadState<T> {
  const factory _Error(final String message, {final T? previousData}) =
      _$ErrorImpl<T>;
  const _Error._() : super._();

  String get message;
  T? get previousData;

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaginationState<T> {
  List<T> get items => throw _privateConstructorUsedError;
  LoadState<List<T>> get loadState => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationStateCopyWith<T, PaginationState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationStateCopyWith<T, $Res> {
  factory $PaginationStateCopyWith(
          PaginationState<T> value, $Res Function(PaginationState<T>) then) =
      _$PaginationStateCopyWithImpl<T, $Res, PaginationState<T>>;
  @useResult
  $Res call(
      {List<T> items,
      LoadState<List<T>> loadState,
      bool hasMore,
      int currentPage,
      int pageSize});

  $LoadStateCopyWith<List<T>, $Res> get loadState;
}

/// @nodoc
class _$PaginationStateCopyWithImpl<T, $Res, $Val extends PaginationState<T>>
    implements $PaginationStateCopyWith<T, $Res> {
  _$PaginationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? loadState = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState<List<T>>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadStateCopyWith<List<T>, $Res> get loadState {
    return $LoadStateCopyWith<List<T>, $Res>(_value.loadState, (value) {
      return _then(_value.copyWith(loadState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaginationStateImplCopyWith<T, $Res>
    implements $PaginationStateCopyWith<T, $Res> {
  factory _$$PaginationStateImplCopyWith(_$PaginationStateImpl<T> value,
          $Res Function(_$PaginationStateImpl<T>) then) =
      __$$PaginationStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {List<T> items,
      LoadState<List<T>> loadState,
      bool hasMore,
      int currentPage,
      int pageSize});

  @override
  $LoadStateCopyWith<List<T>, $Res> get loadState;
}

/// @nodoc
class __$$PaginationStateImplCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$PaginationStateImpl<T>>
    implements _$$PaginationStateImplCopyWith<T, $Res> {
  __$$PaginationStateImplCopyWithImpl(_$PaginationStateImpl<T> _value,
      $Res Function(_$PaginationStateImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? loadState = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(_$PaginationStateImpl<T>(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState<List<T>>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PaginationStateImpl<T> extends _PaginationState<T> {
  const _$PaginationStateImpl(
      {final List<T> items = const [],
      this.loadState = const LoadState.idle(),
      this.hasMore = false,
      this.currentPage = 1,
      this.pageSize = 20})
      : _items = items,
        super._();

  final List<T> _items;
  @override
  @JsonKey()
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final LoadState<List<T>> loadState;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int pageSize;

  @override
  String toString() {
    return 'PaginationState<$T>(items: $items, loadState: $loadState, hasMore: $hasMore, currentPage: $currentPage, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationStateImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.loadState, loadState) ||
                other.loadState == loadState) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      loadState,
      hasMore,
      currentPage,
      pageSize);

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationStateImplCopyWith<T, _$PaginationStateImpl<T>> get copyWith =>
      __$$PaginationStateImplCopyWithImpl<T, _$PaginationStateImpl<T>>(
          this, _$identity);
}

abstract class _PaginationState<T> extends PaginationState<T> {
  const factory _PaginationState(
      {final List<T> items,
      final LoadState<List<T>> loadState,
      final bool hasMore,
      final int currentPage,
      final int pageSize}) = _$PaginationStateImpl<T>;
  const _PaginationState._() : super._();

  @override
  List<T> get items;
  @override
  LoadState<List<T>> get loadState;
  @override
  bool get hasMore;
  @override
  int get currentPage;
  @override
  int get pageSize;

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationStateImplCopyWith<T, _$PaginationStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CacheState<T> {
  T? get data => throw _privateConstructorUsedError;
  bool get isStale => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  Duration get cacheExpiry => throw _privateConstructorUsedError;

  /// Create a copy of CacheState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CacheStateCopyWith<T, CacheState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacheStateCopyWith<T, $Res> {
  factory $CacheStateCopyWith(
          CacheState<T> value, $Res Function(CacheState<T>) then) =
      _$CacheStateCopyWithImpl<T, $Res, CacheState<T>>;
  @useResult
  $Res call(
      {T? data, bool isStale, DateTime? lastUpdated, Duration cacheExpiry});
}

/// @nodoc
class _$CacheStateCopyWithImpl<T, $Res, $Val extends CacheState<T>>
    implements $CacheStateCopyWith<T, $Res> {
  _$CacheStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CacheState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? isStale = null,
    Object? lastUpdated = freezed,
    Object? cacheExpiry = null,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      isStale: null == isStale
          ? _value.isStale
          : isStale // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cacheExpiry: null == cacheExpiry
          ? _value.cacheExpiry
          : cacheExpiry // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CacheStateImplCopyWith<T, $Res>
    implements $CacheStateCopyWith<T, $Res> {
  factory _$$CacheStateImplCopyWith(
          _$CacheStateImpl<T> value, $Res Function(_$CacheStateImpl<T>) then) =
      __$$CacheStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {T? data, bool isStale, DateTime? lastUpdated, Duration cacheExpiry});
}

/// @nodoc
class __$$CacheStateImplCopyWithImpl<T, $Res>
    extends _$CacheStateCopyWithImpl<T, $Res, _$CacheStateImpl<T>>
    implements _$$CacheStateImplCopyWith<T, $Res> {
  __$$CacheStateImplCopyWithImpl(
      _$CacheStateImpl<T> _value, $Res Function(_$CacheStateImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CacheState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? isStale = null,
    Object? lastUpdated = freezed,
    Object? cacheExpiry = null,
  }) {
    return _then(_$CacheStateImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      isStale: null == isStale
          ? _value.isStale
          : isStale // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cacheExpiry: null == cacheExpiry
          ? _value.cacheExpiry
          : cacheExpiry // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$CacheStateImpl<T> extends _CacheState<T> {
  const _$CacheStateImpl(
      {this.data,
      this.isStale = false,
      this.lastUpdated,
      this.cacheExpiry = const Duration(minutes: 5)})
      : super._();

  @override
  final T? data;
  @override
  @JsonKey()
  final bool isStale;
  @override
  final DateTime? lastUpdated;
  @override
  @JsonKey()
  final Duration cacheExpiry;

  @override
  String toString() {
    return 'CacheState<$T>(data: $data, isStale: $isStale, lastUpdated: $lastUpdated, cacheExpiry: $cacheExpiry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheStateImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.isStale, isStale) || other.isStale == isStale) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.cacheExpiry, cacheExpiry) ||
                other.cacheExpiry == cacheExpiry));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      isStale,
      lastUpdated,
      cacheExpiry);

  /// Create a copy of CacheState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheStateImplCopyWith<T, _$CacheStateImpl<T>> get copyWith =>
      __$$CacheStateImplCopyWithImpl<T, _$CacheStateImpl<T>>(this, _$identity);
}

abstract class _CacheState<T> extends CacheState<T> {
  const factory _CacheState(
      {final T? data,
      final bool isStale,
      final DateTime? lastUpdated,
      final Duration cacheExpiry}) = _$CacheStateImpl<T>;
  const _CacheState._() : super._();

  @override
  T? get data;
  @override
  bool get isStale;
  @override
  DateTime? get lastUpdated;
  @override
  Duration get cacheExpiry;

  /// Create a copy of CacheState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheStateImplCopyWith<T, _$CacheStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
