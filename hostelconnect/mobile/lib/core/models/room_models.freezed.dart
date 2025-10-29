// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get blockId => throw _privateConstructorUsedError;
  String get floorId => throw _privateConstructorUsedError;
  RoomType get type => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  int get currentOccupancy => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  List<Bed> get beds => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call(
      {String id,
      String roomNumber,
      String blockId,
      String floorId,
      RoomType type,
      int capacity,
      int currentOccupancy,
      bool isAvailable,
      List<Bed> beds,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomNumber = null,
    Object? blockId = null,
    Object? floorId = null,
    Object? type = null,
    Object? capacity = null,
    Object? currentOccupancy = null,
    Object? isAvailable = null,
    Object? beds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      floorId: null == floorId
          ? _value.floorId
          : floorId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RoomType,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      currentOccupancy: null == currentOccupancy
          ? _value.currentOccupancy
          : currentOccupancy // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      beds: null == beds
          ? _value.beds
          : beds // ignore: cast_nullable_to_non_nullable
              as List<Bed>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
          _$RoomImpl value, $Res Function(_$RoomImpl) then) =
      __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String roomNumber,
      String blockId,
      String floorId,
      RoomType type,
      int capacity,
      int currentOccupancy,
      bool isAvailable,
      List<Bed> beds,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomNumber = null,
    Object? blockId = null,
    Object? floorId = null,
    Object? type = null,
    Object? capacity = null,
    Object? currentOccupancy = null,
    Object? isAvailable = null,
    Object? beds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$RoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      floorId: null == floorId
          ? _value.floorId
          : floorId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RoomType,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      currentOccupancy: null == currentOccupancy
          ? _value.currentOccupancy
          : currentOccupancy // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      beds: null == beds
          ? _value._beds
          : beds // ignore: cast_nullable_to_non_nullable
              as List<Bed>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl(
      {required this.id,
      required this.roomNumber,
      required this.blockId,
      required this.floorId,
      required this.type,
      required this.capacity,
      required this.currentOccupancy,
      required this.isAvailable,
      required final List<Bed> beds,
      this.createdAt,
      this.updatedAt})
      : _beds = beds;

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String roomNumber;
  @override
  final String blockId;
  @override
  final String floorId;
  @override
  final RoomType type;
  @override
  final int capacity;
  @override
  final int currentOccupancy;
  @override
  final bool isAvailable;
  final List<Bed> _beds;
  @override
  List<Bed> get beds {
    if (_beds is EqualUnmodifiableListView) return _beds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_beds);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Room(id: $id, roomNumber: $roomNumber, blockId: $blockId, floorId: $floorId, type: $type, capacity: $capacity, currentOccupancy: $currentOccupancy, isAvailable: $isAvailable, beds: $beds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.blockId, blockId) || other.blockId == blockId) &&
            (identical(other.floorId, floorId) || other.floorId == floorId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.currentOccupancy, currentOccupancy) ||
                other.currentOccupancy == currentOccupancy) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality().equals(other._beds, _beds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roomNumber,
      blockId,
      floorId,
      type,
      capacity,
      currentOccupancy,
      isAvailable,
      const DeepCollectionEquality().hash(_beds),
      createdAt,
      updatedAt);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(
      this,
    );
  }
}

abstract class _Room implements Room {
  const factory _Room(
      {required final String id,
      required final String roomNumber,
      required final String blockId,
      required final String floorId,
      required final RoomType type,
      required final int capacity,
      required final int currentOccupancy,
      required final bool isAvailable,
      required final List<Bed> beds,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get roomNumber;
  @override
  String get blockId;
  @override
  String get floorId;
  @override
  RoomType get type;
  @override
  int get capacity;
  @override
  int get currentOccupancy;
  @override
  bool get isAvailable;
  @override
  List<Bed> get beds;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bed _$BedFromJson(Map<String, dynamic> json) {
  return _Bed.fromJson(json);
}

/// @nodoc
mixin _$Bed {
  String get id => throw _privateConstructorUsedError;
  String get bedNumber => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  BedType get type => throw _privateConstructorUsedError;
  bool get isOccupied => throw _privateConstructorUsedError;
  String? get studentId => throw _privateConstructorUsedError;
  DateTime? get occupiedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Bed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BedCopyWith<Bed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BedCopyWith<$Res> {
  factory $BedCopyWith(Bed value, $Res Function(Bed) then) =
      _$BedCopyWithImpl<$Res, Bed>;
  @useResult
  $Res call(
      {String id,
      String bedNumber,
      String roomId,
      BedType type,
      bool isOccupied,
      String? studentId,
      DateTime? occupiedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$BedCopyWithImpl<$Res, $Val extends Bed> implements $BedCopyWith<$Res> {
  _$BedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bedNumber = null,
    Object? roomId = null,
    Object? type = null,
    Object? isOccupied = null,
    Object? studentId = freezed,
    Object? occupiedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bedNumber: null == bedNumber
          ? _value.bedNumber
          : bedNumber // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BedType,
      isOccupied: null == isOccupied
          ? _value.isOccupied
          : isOccupied // ignore: cast_nullable_to_non_nullable
              as bool,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      occupiedAt: freezed == occupiedAt
          ? _value.occupiedAt
          : occupiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BedImplCopyWith<$Res> implements $BedCopyWith<$Res> {
  factory _$$BedImplCopyWith(_$BedImpl value, $Res Function(_$BedImpl) then) =
      __$$BedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bedNumber,
      String roomId,
      BedType type,
      bool isOccupied,
      String? studentId,
      DateTime? occupiedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$BedImplCopyWithImpl<$Res> extends _$BedCopyWithImpl<$Res, _$BedImpl>
    implements _$$BedImplCopyWith<$Res> {
  __$$BedImplCopyWithImpl(_$BedImpl _value, $Res Function(_$BedImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bedNumber = null,
    Object? roomId = null,
    Object? type = null,
    Object? isOccupied = null,
    Object? studentId = freezed,
    Object? occupiedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$BedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bedNumber: null == bedNumber
          ? _value.bedNumber
          : bedNumber // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BedType,
      isOccupied: null == isOccupied
          ? _value.isOccupied
          : isOccupied // ignore: cast_nullable_to_non_nullable
              as bool,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      occupiedAt: freezed == occupiedAt
          ? _value.occupiedAt
          : occupiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BedImpl implements _Bed {
  const _$BedImpl(
      {required this.id,
      required this.bedNumber,
      required this.roomId,
      required this.type,
      required this.isOccupied,
      this.studentId,
      this.occupiedAt,
      this.createdAt,
      this.updatedAt});

  factory _$BedImpl.fromJson(Map<String, dynamic> json) =>
      _$$BedImplFromJson(json);

  @override
  final String id;
  @override
  final String bedNumber;
  @override
  final String roomId;
  @override
  final BedType type;
  @override
  final bool isOccupied;
  @override
  final String? studentId;
  @override
  final DateTime? occupiedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Bed(id: $id, bedNumber: $bedNumber, roomId: $roomId, type: $type, isOccupied: $isOccupied, studentId: $studentId, occupiedAt: $occupiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bedNumber, bedNumber) ||
                other.bedNumber == bedNumber) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isOccupied, isOccupied) ||
                other.isOccupied == isOccupied) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.occupiedAt, occupiedAt) ||
                other.occupiedAt == occupiedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, bedNumber, roomId, type,
      isOccupied, studentId, occupiedAt, createdAt, updatedAt);

  /// Create a copy of Bed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BedImplCopyWith<_$BedImpl> get copyWith =>
      __$$BedImplCopyWithImpl<_$BedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BedImplToJson(
      this,
    );
  }
}

abstract class _Bed implements Bed {
  const factory _Bed(
      {required final String id,
      required final String bedNumber,
      required final String roomId,
      required final BedType type,
      required final bool isOccupied,
      final String? studentId,
      final DateTime? occupiedAt,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$BedImpl;

  factory _Bed.fromJson(Map<String, dynamic> json) = _$BedImpl.fromJson;

  @override
  String get id;
  @override
  String get bedNumber;
  @override
  String get roomId;
  @override
  BedType get type;
  @override
  bool get isOccupied;
  @override
  String? get studentId;
  @override
  DateTime? get occupiedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Bed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BedImplCopyWith<_$BedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoomMapData _$RoomMapDataFromJson(Map<String, dynamic> json) {
  return _RoomMapData.fromJson(json);
}

/// @nodoc
mixin _$RoomMapData {
  String get id => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get blockId => throw _privateConstructorUsedError;
  String get floorId => throw _privateConstructorUsedError;
  RoomType get type => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  int get currentOccupancy => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  List<Bed> get beds => throw _privateConstructorUsedError;

  /// Serializes this RoomMapData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomMapData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomMapDataCopyWith<RoomMapData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomMapDataCopyWith<$Res> {
  factory $RoomMapDataCopyWith(
          RoomMapData value, $Res Function(RoomMapData) then) =
      _$RoomMapDataCopyWithImpl<$Res, RoomMapData>;
  @useResult
  $Res call(
      {String id,
      String roomNumber,
      String blockId,
      String floorId,
      RoomType type,
      int capacity,
      int currentOccupancy,
      bool isAvailable,
      List<Bed> beds});
}

/// @nodoc
class _$RoomMapDataCopyWithImpl<$Res, $Val extends RoomMapData>
    implements $RoomMapDataCopyWith<$Res> {
  _$RoomMapDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomMapData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomNumber = null,
    Object? blockId = null,
    Object? floorId = null,
    Object? type = null,
    Object? capacity = null,
    Object? currentOccupancy = null,
    Object? isAvailable = null,
    Object? beds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      floorId: null == floorId
          ? _value.floorId
          : floorId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RoomType,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      currentOccupancy: null == currentOccupancy
          ? _value.currentOccupancy
          : currentOccupancy // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      beds: null == beds
          ? _value.beds
          : beds // ignore: cast_nullable_to_non_nullable
              as List<Bed>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomMapDataImplCopyWith<$Res>
    implements $RoomMapDataCopyWith<$Res> {
  factory _$$RoomMapDataImplCopyWith(
          _$RoomMapDataImpl value, $Res Function(_$RoomMapDataImpl) then) =
      __$$RoomMapDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String roomNumber,
      String blockId,
      String floorId,
      RoomType type,
      int capacity,
      int currentOccupancy,
      bool isAvailable,
      List<Bed> beds});
}

/// @nodoc
class __$$RoomMapDataImplCopyWithImpl<$Res>
    extends _$RoomMapDataCopyWithImpl<$Res, _$RoomMapDataImpl>
    implements _$$RoomMapDataImplCopyWith<$Res> {
  __$$RoomMapDataImplCopyWithImpl(
      _$RoomMapDataImpl _value, $Res Function(_$RoomMapDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoomMapData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomNumber = null,
    Object? blockId = null,
    Object? floorId = null,
    Object? type = null,
    Object? capacity = null,
    Object? currentOccupancy = null,
    Object? isAvailable = null,
    Object? beds = null,
  }) {
    return _then(_$RoomMapDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      floorId: null == floorId
          ? _value.floorId
          : floorId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RoomType,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      currentOccupancy: null == currentOccupancy
          ? _value.currentOccupancy
          : currentOccupancy // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      beds: null == beds
          ? _value._beds
          : beds // ignore: cast_nullable_to_non_nullable
              as List<Bed>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomMapDataImpl implements _RoomMapData {
  const _$RoomMapDataImpl(
      {required this.id,
      required this.roomNumber,
      required this.blockId,
      required this.floorId,
      required this.type,
      required this.capacity,
      required this.currentOccupancy,
      required this.isAvailable,
      required final List<Bed> beds})
      : _beds = beds;

  factory _$RoomMapDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomMapDataImplFromJson(json);

  @override
  final String id;
  @override
  final String roomNumber;
  @override
  final String blockId;
  @override
  final String floorId;
  @override
  final RoomType type;
  @override
  final int capacity;
  @override
  final int currentOccupancy;
  @override
  final bool isAvailable;
  final List<Bed> _beds;
  @override
  List<Bed> get beds {
    if (_beds is EqualUnmodifiableListView) return _beds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_beds);
  }

  @override
  String toString() {
    return 'RoomMapData(id: $id, roomNumber: $roomNumber, blockId: $blockId, floorId: $floorId, type: $type, capacity: $capacity, currentOccupancy: $currentOccupancy, isAvailable: $isAvailable, beds: $beds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomMapDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.blockId, blockId) || other.blockId == blockId) &&
            (identical(other.floorId, floorId) || other.floorId == floorId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.currentOccupancy, currentOccupancy) ||
                other.currentOccupancy == currentOccupancy) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality().equals(other._beds, _beds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roomNumber,
      blockId,
      floorId,
      type,
      capacity,
      currentOccupancy,
      isAvailable,
      const DeepCollectionEquality().hash(_beds));

  /// Create a copy of RoomMapData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomMapDataImplCopyWith<_$RoomMapDataImpl> get copyWith =>
      __$$RoomMapDataImplCopyWithImpl<_$RoomMapDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomMapDataImplToJson(
      this,
    );
  }
}

abstract class _RoomMapData implements RoomMapData {
  const factory _RoomMapData(
      {required final String id,
      required final String roomNumber,
      required final String blockId,
      required final String floorId,
      required final RoomType type,
      required final int capacity,
      required final int currentOccupancy,
      required final bool isAvailable,
      required final List<Bed> beds}) = _$RoomMapDataImpl;

  factory _RoomMapData.fromJson(Map<String, dynamic> json) =
      _$RoomMapDataImpl.fromJson;

  @override
  String get id;
  @override
  String get roomNumber;
  @override
  String get blockId;
  @override
  String get floorId;
  @override
  RoomType get type;
  @override
  int get capacity;
  @override
  int get currentOccupancy;
  @override
  bool get isAvailable;
  @override
  List<Bed> get beds;

  /// Create a copy of RoomMapData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomMapDataImplCopyWith<_$RoomMapDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Block _$BlockFromJson(Map<String, dynamic> json) {
  return _Block.fromJson(json);
}

/// @nodoc
mixin _$Block {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  int get totalFloors => throw _privateConstructorUsedError;
  int get totalRooms => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Block to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Block
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlockCopyWith<Block> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockCopyWith<$Res> {
  factory $BlockCopyWith(Block value, $Res Function(Block) then) =
      _$BlockCopyWithImpl<$Res, Block>;
  @useResult
  $Res call(
      {String id,
      String name,
      String hostelId,
      int totalFloors,
      int totalRooms,
      bool isActive,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$BlockCopyWithImpl<$Res, $Val extends Block>
    implements $BlockCopyWith<$Res> {
  _$BlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Block
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hostelId = null,
    Object? totalFloors = null,
    Object? totalRooms = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      totalFloors: null == totalFloors
          ? _value.totalFloors
          : totalFloors // ignore: cast_nullable_to_non_nullable
              as int,
      totalRooms: null == totalRooms
          ? _value.totalRooms
          : totalRooms // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlockImplCopyWith<$Res> implements $BlockCopyWith<$Res> {
  factory _$$BlockImplCopyWith(
          _$BlockImpl value, $Res Function(_$BlockImpl) then) =
      __$$BlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String hostelId,
      int totalFloors,
      int totalRooms,
      bool isActive,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$BlockImplCopyWithImpl<$Res>
    extends _$BlockCopyWithImpl<$Res, _$BlockImpl>
    implements _$$BlockImplCopyWith<$Res> {
  __$$BlockImplCopyWithImpl(
      _$BlockImpl _value, $Res Function(_$BlockImpl) _then)
      : super(_value, _then);

  /// Create a copy of Block
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hostelId = null,
    Object? totalFloors = null,
    Object? totalRooms = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$BlockImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      totalFloors: null == totalFloors
          ? _value.totalFloors
          : totalFloors // ignore: cast_nullable_to_non_nullable
              as int,
      totalRooms: null == totalRooms
          ? _value.totalRooms
          : totalRooms // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlockImpl implements _Block {
  const _$BlockImpl(
      {required this.id,
      required this.name,
      required this.hostelId,
      required this.totalFloors,
      required this.totalRooms,
      required this.isActive,
      this.createdAt,
      this.updatedAt});

  factory _$BlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String hostelId;
  @override
  final int totalFloors;
  @override
  final int totalRooms;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Block(id: $id, name: $name, hostelId: $hostelId, totalFloors: $totalFloors, totalRooms: $totalRooms, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.totalFloors, totalFloors) ||
                other.totalFloors == totalFloors) &&
            (identical(other.totalRooms, totalRooms) ||
                other.totalRooms == totalRooms) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, hostelId, totalFloors,
      totalRooms, isActive, createdAt, updatedAt);

  /// Create a copy of Block
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockImplCopyWith<_$BlockImpl> get copyWith =>
      __$$BlockImplCopyWithImpl<_$BlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockImplToJson(
      this,
    );
  }
}

abstract class _Block implements Block {
  const factory _Block(
      {required final String id,
      required final String name,
      required final String hostelId,
      required final int totalFloors,
      required final int totalRooms,
      required final bool isActive,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$BlockImpl;

  factory _Block.fromJson(Map<String, dynamic> json) = _$BlockImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get hostelId;
  @override
  int get totalFloors;
  @override
  int get totalRooms;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Block
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockImplCopyWith<_$BlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Floor _$FloorFromJson(Map<String, dynamic> json) {
  return _Floor.fromJson(json);
}

/// @nodoc
mixin _$Floor {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get blockId => throw _privateConstructorUsedError;
  int get floorNumber => throw _privateConstructorUsedError;
  int get totalRooms => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Floor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FloorCopyWith<Floor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorCopyWith<$Res> {
  factory $FloorCopyWith(Floor value, $Res Function(Floor) then) =
      _$FloorCopyWithImpl<$Res, Floor>;
  @useResult
  $Res call(
      {String id,
      String name,
      String blockId,
      int floorNumber,
      int totalRooms,
      bool isActive,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$FloorCopyWithImpl<$Res, $Val extends Floor>
    implements $FloorCopyWith<$Res> {
  _$FloorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? blockId = null,
    Object? floorNumber = null,
    Object? totalRooms = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      floorNumber: null == floorNumber
          ? _value.floorNumber
          : floorNumber // ignore: cast_nullable_to_non_nullable
              as int,
      totalRooms: null == totalRooms
          ? _value.totalRooms
          : totalRooms // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FloorImplCopyWith<$Res> implements $FloorCopyWith<$Res> {
  factory _$$FloorImplCopyWith(
          _$FloorImpl value, $Res Function(_$FloorImpl) then) =
      __$$FloorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String blockId,
      int floorNumber,
      int totalRooms,
      bool isActive,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$FloorImplCopyWithImpl<$Res>
    extends _$FloorCopyWithImpl<$Res, _$FloorImpl>
    implements _$$FloorImplCopyWith<$Res> {
  __$$FloorImplCopyWithImpl(
      _$FloorImpl _value, $Res Function(_$FloorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? blockId = null,
    Object? floorNumber = null,
    Object? totalRooms = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$FloorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      floorNumber: null == floorNumber
          ? _value.floorNumber
          : floorNumber // ignore: cast_nullable_to_non_nullable
              as int,
      totalRooms: null == totalRooms
          ? _value.totalRooms
          : totalRooms // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FloorImpl implements _Floor {
  const _$FloorImpl(
      {required this.id,
      required this.name,
      required this.blockId,
      required this.floorNumber,
      required this.totalRooms,
      required this.isActive,
      this.createdAt,
      this.updatedAt});

  factory _$FloorImpl.fromJson(Map<String, dynamic> json) =>
      _$$FloorImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String blockId;
  @override
  final int floorNumber;
  @override
  final int totalRooms;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Floor(id: $id, name: $name, blockId: $blockId, floorNumber: $floorNumber, totalRooms: $totalRooms, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.blockId, blockId) || other.blockId == blockId) &&
            (identical(other.floorNumber, floorNumber) ||
                other.floorNumber == floorNumber) &&
            (identical(other.totalRooms, totalRooms) ||
                other.totalRooms == totalRooms) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, blockId, floorNumber,
      totalRooms, isActive, createdAt, updatedAt);

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FloorImplCopyWith<_$FloorImpl> get copyWith =>
      __$$FloorImplCopyWithImpl<_$FloorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FloorImplToJson(
      this,
    );
  }
}

abstract class _Floor implements Floor {
  const factory _Floor(
      {required final String id,
      required final String name,
      required final String blockId,
      required final int floorNumber,
      required final int totalRooms,
      required final bool isActive,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$FloorImpl;

  factory _Floor.fromJson(Map<String, dynamic> json) = _$FloorImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get blockId;
  @override
  int get floorNumber;
  @override
  int get totalRooms;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FloorImplCopyWith<_$FloorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
