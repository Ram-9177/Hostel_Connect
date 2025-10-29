// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardTile _$DashboardTileFromJson(Map<String, dynamic> json) {
  return _DashboardTile.fromJson(json);
}

/// @nodoc
mixin _$DashboardTile {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DashboardTileType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this DashboardTile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardTileCopyWith<DashboardTile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardTileCopyWith<$Res> {
  factory $DashboardTileCopyWith(
          DashboardTile value, $Res Function(DashboardTile) then) =
      _$DashboardTileCopyWithImpl<$Res, DashboardTile>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DashboardTileType type,
      Map<String, dynamic> data,
      DateTime lastUpdated,
      bool isActive});
}

/// @nodoc
class _$DashboardTileCopyWithImpl<$Res, $Val extends DashboardTile>
    implements $DashboardTileCopyWith<$Res> {
  _$DashboardTileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? data = null,
    Object? lastUpdated = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DashboardTileType,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardTileImplCopyWith<$Res>
    implements $DashboardTileCopyWith<$Res> {
  factory _$$DashboardTileImplCopyWith(
          _$DashboardTileImpl value, $Res Function(_$DashboardTileImpl) then) =
      __$$DashboardTileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DashboardTileType type,
      Map<String, dynamic> data,
      DateTime lastUpdated,
      bool isActive});
}

/// @nodoc
class __$$DashboardTileImplCopyWithImpl<$Res>
    extends _$DashboardTileCopyWithImpl<$Res, _$DashboardTileImpl>
    implements _$$DashboardTileImplCopyWith<$Res> {
  __$$DashboardTileImplCopyWithImpl(
      _$DashboardTileImpl _value, $Res Function(_$DashboardTileImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? data = null,
    Object? lastUpdated = null,
    Object? isActive = null,
  }) {
    return _then(_$DashboardTileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DashboardTileType,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardTileImpl implements _DashboardTile {
  const _$DashboardTileImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required final Map<String, dynamic> data,
      required this.lastUpdated,
      this.isActive = true})
      : _data = data;

  factory _$DashboardTileImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardTileImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DashboardTileType type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final DateTime lastUpdated;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'DashboardTile(id: $id, title: $title, description: $description, type: $type, data: $data, lastUpdated: $lastUpdated, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardTileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, type,
      const DeepCollectionEquality().hash(_data), lastUpdated, isActive);

  /// Create a copy of DashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardTileImplCopyWith<_$DashboardTileImpl> get copyWith =>
      __$$DashboardTileImplCopyWithImpl<_$DashboardTileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardTileImplToJson(
      this,
    );
  }
}

abstract class _DashboardTile implements DashboardTile {
  const factory _DashboardTile(
      {required final String id,
      required final String title,
      required final String description,
      required final DashboardTileType type,
      required final Map<String, dynamic> data,
      required final DateTime lastUpdated,
      final bool isActive}) = _$DashboardTileImpl;

  factory _DashboardTile.fromJson(Map<String, dynamic> json) =
      _$DashboardTileImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DashboardTileType get type;
  @override
  Map<String, dynamic> get data;
  @override
  DateTime get lastUpdated;
  @override
  bool get isActive;

  /// Create a copy of DashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardTileImplCopyWith<_$DashboardTileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DrillDownRequest _$DrillDownRequestFromJson(Map<String, dynamic> json) {
  return _DrillDownRequest.fromJson(json);
}

/// @nodoc
mixin _$DrillDownRequest {
  String get tileId => throw _privateConstructorUsedError;
  DrillDownType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get filters => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this DrillDownRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DrillDownRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrillDownRequestCopyWith<DrillDownRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrillDownRequestCopyWith<$Res> {
  factory $DrillDownRequestCopyWith(
          DrillDownRequest value, $Res Function(DrillDownRequest) then) =
      _$DrillDownRequestCopyWithImpl<$Res, DrillDownRequest>;
  @useResult
  $Res call(
      {String tileId,
      DrillDownType type,
      Map<String, dynamic> filters,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class _$DrillDownRequestCopyWithImpl<$Res, $Val extends DrillDownRequest>
    implements $DrillDownRequestCopyWith<$Res> {
  _$DrillDownRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrillDownRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tileId = null,
    Object? type = null,
    Object? filters = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      tileId: null == tileId
          ? _value.tileId
          : tileId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DrillDownType,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrillDownRequestImplCopyWith<$Res>
    implements $DrillDownRequestCopyWith<$Res> {
  factory _$$DrillDownRequestImplCopyWith(_$DrillDownRequestImpl value,
          $Res Function(_$DrillDownRequestImpl) then) =
      __$$DrillDownRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tileId,
      DrillDownType type,
      Map<String, dynamic> filters,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class __$$DrillDownRequestImplCopyWithImpl<$Res>
    extends _$DrillDownRequestCopyWithImpl<$Res, _$DrillDownRequestImpl>
    implements _$$DrillDownRequestImplCopyWith<$Res> {
  __$$DrillDownRequestImplCopyWithImpl(_$DrillDownRequestImpl _value,
      $Res Function(_$DrillDownRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrillDownRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tileId = null,
    Object? type = null,
    Object? filters = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$DrillDownRequestImpl(
      tileId: null == tileId
          ? _value.tileId
          : tileId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DrillDownType,
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrillDownRequestImpl implements _DrillDownRequest {
  const _$DrillDownRequestImpl(
      {required this.tileId,
      required this.type,
      required final Map<String, dynamic> filters,
      required this.startDate,
      required this.endDate})
      : _filters = filters;

  factory _$DrillDownRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrillDownRequestImplFromJson(json);

  @override
  final String tileId;
  @override
  final DrillDownType type;
  final Map<String, dynamic> _filters;
  @override
  Map<String, dynamic> get filters {
    if (_filters is EqualUnmodifiableMapView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_filters);
  }

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'DrillDownRequest(tileId: $tileId, type: $type, filters: $filters, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrillDownRequestImpl &&
            (identical(other.tileId, tileId) || other.tileId == tileId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tileId, type,
      const DeepCollectionEquality().hash(_filters), startDate, endDate);

  /// Create a copy of DrillDownRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrillDownRequestImplCopyWith<_$DrillDownRequestImpl> get copyWith =>
      __$$DrillDownRequestImplCopyWithImpl<_$DrillDownRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrillDownRequestImplToJson(
      this,
    );
  }
}

abstract class _DrillDownRequest implements DrillDownRequest {
  const factory _DrillDownRequest(
      {required final String tileId,
      required final DrillDownType type,
      required final Map<String, dynamic> filters,
      required final DateTime startDate,
      required final DateTime endDate}) = _$DrillDownRequestImpl;

  factory _DrillDownRequest.fromJson(Map<String, dynamic> json) =
      _$DrillDownRequestImpl.fromJson;

  @override
  String get tileId;
  @override
  DrillDownType get type;
  @override
  Map<String, dynamic> get filters;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of DrillDownRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrillDownRequestImplCopyWith<_$DrillDownRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DrillDownResult _$DrillDownResultFromJson(Map<String, dynamic> json) {
  return _DrillDownResult.fromJson(json);
}

/// @nodoc
mixin _$DrillDownResult {
  String get id => throw _privateConstructorUsedError;
  String get tileId => throw _privateConstructorUsedError;
  DrillDownType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this DrillDownResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DrillDownResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrillDownResultCopyWith<DrillDownResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrillDownResultCopyWith<$Res> {
  factory $DrillDownResultCopyWith(
          DrillDownResult value, $Res Function(DrillDownResult) then) =
      _$DrillDownResultCopyWithImpl<$Res, DrillDownResult>;
  @useResult
  $Res call(
      {String id,
      String tileId,
      DrillDownType type,
      Map<String, dynamic> data,
      DateTime generatedAt});
}

/// @nodoc
class _$DrillDownResultCopyWithImpl<$Res, $Val extends DrillDownResult>
    implements $DrillDownResultCopyWith<$Res> {
  _$DrillDownResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrillDownResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tileId = null,
    Object? type = null,
    Object? data = null,
    Object? generatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tileId: null == tileId
          ? _value.tileId
          : tileId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DrillDownType,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrillDownResultImplCopyWith<$Res>
    implements $DrillDownResultCopyWith<$Res> {
  factory _$$DrillDownResultImplCopyWith(_$DrillDownResultImpl value,
          $Res Function(_$DrillDownResultImpl) then) =
      __$$DrillDownResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String tileId,
      DrillDownType type,
      Map<String, dynamic> data,
      DateTime generatedAt});
}

/// @nodoc
class __$$DrillDownResultImplCopyWithImpl<$Res>
    extends _$DrillDownResultCopyWithImpl<$Res, _$DrillDownResultImpl>
    implements _$$DrillDownResultImplCopyWith<$Res> {
  __$$DrillDownResultImplCopyWithImpl(
      _$DrillDownResultImpl _value, $Res Function(_$DrillDownResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrillDownResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tileId = null,
    Object? type = null,
    Object? data = null,
    Object? generatedAt = null,
  }) {
    return _then(_$DrillDownResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tileId: null == tileId
          ? _value.tileId
          : tileId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DrillDownType,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrillDownResultImpl implements _DrillDownResult {
  const _$DrillDownResultImpl(
      {required this.id,
      required this.tileId,
      required this.type,
      required final Map<String, dynamic> data,
      required this.generatedAt})
      : _data = data;

  factory _$DrillDownResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrillDownResultImplFromJson(json);

  @override
  final String id;
  @override
  final String tileId;
  @override
  final DrillDownType type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'DrillDownResult(id: $id, tileId: $tileId, type: $type, data: $data, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrillDownResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tileId, tileId) || other.tileId == tileId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, tileId, type,
      const DeepCollectionEquality().hash(_data), generatedAt);

  /// Create a copy of DrillDownResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrillDownResultImplCopyWith<_$DrillDownResultImpl> get copyWith =>
      __$$DrillDownResultImplCopyWithImpl<_$DrillDownResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrillDownResultImplToJson(
      this,
    );
  }
}

abstract class _DrillDownResult implements DrillDownResult {
  const factory _DrillDownResult(
      {required final String id,
      required final String tileId,
      required final DrillDownType type,
      required final Map<String, dynamic> data,
      required final DateTime generatedAt}) = _$DrillDownResultImpl;

  factory _DrillDownResult.fromJson(Map<String, dynamic> json) =
      _$DrillDownResultImpl.fromJson;

  @override
  String get id;
  @override
  String get tileId;
  @override
  DrillDownType get type;
  @override
  Map<String, dynamic> get data;
  @override
  DateTime get generatedAt;

  /// Create a copy of DrillDownResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrillDownResultImplCopyWith<_$DrillDownResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LiveDashboardTile _$LiveDashboardTileFromJson(Map<String, dynamic> json) {
  return _LiveDashboardTile.fromJson(json);
}

/// @nodoc
mixin _$LiveDashboardTile {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get trend => throw _privateConstructorUsedError;
  double? get trendValue => throw _privateConstructorUsedError;
  bool get isAlert => throw _privateConstructorUsedError;

  /// Serializes this LiveDashboardTile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LiveDashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiveDashboardTileCopyWith<LiveDashboardTile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveDashboardTileCopyWith<$Res> {
  factory $LiveDashboardTileCopyWith(
          LiveDashboardTile value, $Res Function(LiveDashboardTile) then) =
      _$LiveDashboardTileCopyWithImpl<$Res, LiveDashboardTile>;
  @useResult
  $Res call(
      {String id,
      String title,
      String value,
      String? subtitle,
      String icon,
      String trend,
      double? trendValue,
      bool isAlert});
}

/// @nodoc
class _$LiveDashboardTileCopyWithImpl<$Res, $Val extends LiveDashboardTile>
    implements $LiveDashboardTileCopyWith<$Res> {
  _$LiveDashboardTileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveDashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? value = null,
    Object? subtitle = freezed,
    Object? icon = null,
    Object? trend = null,
    Object? trendValue = freezed,
    Object? isAlert = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      trendValue: freezed == trendValue
          ? _value.trendValue
          : trendValue // ignore: cast_nullable_to_non_nullable
              as double?,
      isAlert: null == isAlert
          ? _value.isAlert
          : isAlert // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveDashboardTileImplCopyWith<$Res>
    implements $LiveDashboardTileCopyWith<$Res> {
  factory _$$LiveDashboardTileImplCopyWith(_$LiveDashboardTileImpl value,
          $Res Function(_$LiveDashboardTileImpl) then) =
      __$$LiveDashboardTileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String value,
      String? subtitle,
      String icon,
      String trend,
      double? trendValue,
      bool isAlert});
}

/// @nodoc
class __$$LiveDashboardTileImplCopyWithImpl<$Res>
    extends _$LiveDashboardTileCopyWithImpl<$Res, _$LiveDashboardTileImpl>
    implements _$$LiveDashboardTileImplCopyWith<$Res> {
  __$$LiveDashboardTileImplCopyWithImpl(_$LiveDashboardTileImpl _value,
      $Res Function(_$LiveDashboardTileImpl) _then)
      : super(_value, _then);

  /// Create a copy of LiveDashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? value = null,
    Object? subtitle = freezed,
    Object? icon = null,
    Object? trend = null,
    Object? trendValue = freezed,
    Object? isAlert = null,
  }) {
    return _then(_$LiveDashboardTileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      trendValue: freezed == trendValue
          ? _value.trendValue
          : trendValue // ignore: cast_nullable_to_non_nullable
              as double?,
      isAlert: null == isAlert
          ? _value.isAlert
          : isAlert // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveDashboardTileImpl implements _LiveDashboardTile {
  const _$LiveDashboardTileImpl(
      {required this.id,
      required this.title,
      required this.value,
      required this.subtitle,
      required this.icon,
      required this.trend,
      required this.trendValue,
      this.isAlert = false});

  factory _$LiveDashboardTileImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveDashboardTileImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String value;
  @override
  final String? subtitle;
  @override
  final String icon;
  @override
  final String trend;
  @override
  final double? trendValue;
  @override
  @JsonKey()
  final bool isAlert;

  @override
  String toString() {
    return 'LiveDashboardTile(id: $id, title: $title, value: $value, subtitle: $subtitle, icon: $icon, trend: $trend, trendValue: $trendValue, isAlert: $isAlert)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveDashboardTileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.trendValue, trendValue) ||
                other.trendValue == trendValue) &&
            (identical(other.isAlert, isAlert) || other.isAlert == isAlert));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, value, subtitle, icon,
      trend, trendValue, isAlert);

  /// Create a copy of LiveDashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveDashboardTileImplCopyWith<_$LiveDashboardTileImpl> get copyWith =>
      __$$LiveDashboardTileImplCopyWithImpl<_$LiveDashboardTileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveDashboardTileImplToJson(
      this,
    );
  }
}

abstract class _LiveDashboardTile implements LiveDashboardTile {
  const factory _LiveDashboardTile(
      {required final String id,
      required final String title,
      required final String value,
      required final String? subtitle,
      required final String icon,
      required final String trend,
      required final double? trendValue,
      final bool isAlert}) = _$LiveDashboardTileImpl;

  factory _LiveDashboardTile.fromJson(Map<String, dynamic> json) =
      _$LiveDashboardTileImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get value;
  @override
  String? get subtitle;
  @override
  String get icon;
  @override
  String get trend;
  @override
  double? get trendValue;
  @override
  bool get isAlert;

  /// Create a copy of LiveDashboardTile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveDashboardTileImplCopyWith<_$LiveDashboardTileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyAnalytics _$MonthlyAnalyticsFromJson(Map<String, dynamic> json) {
  return _MonthlyAnalytics.fromJson(json);
}

/// @nodoc
mixin _$MonthlyAnalytics {
  String get hostelId => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  Map<String, dynamic> get attendance => throw _privateConstructorUsedError;
  Map<String, dynamic> get gatePasses => throw _privateConstructorUsedError;
  Map<String, dynamic> get meals => throw _privateConstructorUsedError;
  Map<String, dynamic> get occupancy => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this MonthlyAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyAnalyticsCopyWith<MonthlyAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyAnalyticsCopyWith<$Res> {
  factory $MonthlyAnalyticsCopyWith(
          MonthlyAnalytics value, $Res Function(MonthlyAnalytics) then) =
      _$MonthlyAnalyticsCopyWithImpl<$Res, MonthlyAnalytics>;
  @useResult
  $Res call(
      {String hostelId,
      int month,
      int year,
      Map<String, dynamic> attendance,
      Map<String, dynamic> gatePasses,
      Map<String, dynamic> meals,
      Map<String, dynamic> occupancy,
      DateTime generatedAt});
}

/// @nodoc
class _$MonthlyAnalyticsCopyWithImpl<$Res, $Val extends MonthlyAnalytics>
    implements $MonthlyAnalyticsCopyWith<$Res> {
  _$MonthlyAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? month = null,
    Object? year = null,
    Object? attendance = null,
    Object? gatePasses = null,
    Object? meals = null,
    Object? occupancy = null,
    Object? generatedAt = null,
  }) {
    return _then(_value.copyWith(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      attendance: null == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      gatePasses: null == gatePasses
          ? _value.gatePasses
          : gatePasses // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      meals: null == meals
          ? _value.meals
          : meals // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      occupancy: null == occupancy
          ? _value.occupancy
          : occupancy // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyAnalyticsImplCopyWith<$Res>
    implements $MonthlyAnalyticsCopyWith<$Res> {
  factory _$$MonthlyAnalyticsImplCopyWith(_$MonthlyAnalyticsImpl value,
          $Res Function(_$MonthlyAnalyticsImpl) then) =
      __$$MonthlyAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String hostelId,
      int month,
      int year,
      Map<String, dynamic> attendance,
      Map<String, dynamic> gatePasses,
      Map<String, dynamic> meals,
      Map<String, dynamic> occupancy,
      DateTime generatedAt});
}

/// @nodoc
class __$$MonthlyAnalyticsImplCopyWithImpl<$Res>
    extends _$MonthlyAnalyticsCopyWithImpl<$Res, _$MonthlyAnalyticsImpl>
    implements _$$MonthlyAnalyticsImplCopyWith<$Res> {
  __$$MonthlyAnalyticsImplCopyWithImpl(_$MonthlyAnalyticsImpl _value,
      $Res Function(_$MonthlyAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? month = null,
    Object? year = null,
    Object? attendance = null,
    Object? gatePasses = null,
    Object? meals = null,
    Object? occupancy = null,
    Object? generatedAt = null,
  }) {
    return _then(_$MonthlyAnalyticsImpl(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      attendance: null == attendance
          ? _value._attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      gatePasses: null == gatePasses
          ? _value._gatePasses
          : gatePasses // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      meals: null == meals
          ? _value._meals
          : meals // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      occupancy: null == occupancy
          ? _value._occupancy
          : occupancy // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyAnalyticsImpl implements _MonthlyAnalytics {
  const _$MonthlyAnalyticsImpl(
      {required this.hostelId,
      required this.month,
      required this.year,
      required final Map<String, dynamic> attendance,
      required final Map<String, dynamic> gatePasses,
      required final Map<String, dynamic> meals,
      required final Map<String, dynamic> occupancy,
      required this.generatedAt})
      : _attendance = attendance,
        _gatePasses = gatePasses,
        _meals = meals,
        _occupancy = occupancy;

  factory _$MonthlyAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyAnalyticsImplFromJson(json);

  @override
  final String hostelId;
  @override
  final int month;
  @override
  final int year;
  final Map<String, dynamic> _attendance;
  @override
  Map<String, dynamic> get attendance {
    if (_attendance is EqualUnmodifiableMapView) return _attendance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attendance);
  }

  final Map<String, dynamic> _gatePasses;
  @override
  Map<String, dynamic> get gatePasses {
    if (_gatePasses is EqualUnmodifiableMapView) return _gatePasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_gatePasses);
  }

  final Map<String, dynamic> _meals;
  @override
  Map<String, dynamic> get meals {
    if (_meals is EqualUnmodifiableMapView) return _meals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_meals);
  }

  final Map<String, dynamic> _occupancy;
  @override
  Map<String, dynamic> get occupancy {
    if (_occupancy is EqualUnmodifiableMapView) return _occupancy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_occupancy);
  }

  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'MonthlyAnalytics(hostelId: $hostelId, month: $month, year: $year, attendance: $attendance, gatePasses: $gatePasses, meals: $meals, occupancy: $occupancy, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyAnalyticsImpl &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            const DeepCollectionEquality()
                .equals(other._attendance, _attendance) &&
            const DeepCollectionEquality()
                .equals(other._gatePasses, _gatePasses) &&
            const DeepCollectionEquality().equals(other._meals, _meals) &&
            const DeepCollectionEquality()
                .equals(other._occupancy, _occupancy) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hostelId,
      month,
      year,
      const DeepCollectionEquality().hash(_attendance),
      const DeepCollectionEquality().hash(_gatePasses),
      const DeepCollectionEquality().hash(_meals),
      const DeepCollectionEquality().hash(_occupancy),
      generatedAt);

  /// Create a copy of MonthlyAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyAnalyticsImplCopyWith<_$MonthlyAnalyticsImpl> get copyWith =>
      __$$MonthlyAnalyticsImplCopyWithImpl<_$MonthlyAnalyticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _MonthlyAnalytics implements MonthlyAnalytics {
  const factory _MonthlyAnalytics(
      {required final String hostelId,
      required final int month,
      required final int year,
      required final Map<String, dynamic> attendance,
      required final Map<String, dynamic> gatePasses,
      required final Map<String, dynamic> meals,
      required final Map<String, dynamic> occupancy,
      required final DateTime generatedAt}) = _$MonthlyAnalyticsImpl;

  factory _MonthlyAnalytics.fromJson(Map<String, dynamic> json) =
      _$MonthlyAnalyticsImpl.fromJson;

  @override
  String get hostelId;
  @override
  int get month;
  @override
  int get year;
  @override
  Map<String, dynamic> get attendance;
  @override
  Map<String, dynamic> get gatePasses;
  @override
  Map<String, dynamic> get meals;
  @override
  Map<String, dynamic> get occupancy;
  @override
  DateTime get generatedAt;

  /// Create a copy of MonthlyAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyAnalyticsImplCopyWith<_$MonthlyAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
