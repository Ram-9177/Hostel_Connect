// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MealIntent _$MealIntentFromJson(Map<String, dynamic> json) {
  return _MealIntent.fromJson(json);
}

/// @nodoc
mixin _$MealIntent {
  String get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get studentName => throw _privateConstructorUsedError;
  String get studentRollNumber => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  bool get willEat => throw _privateConstructorUsedError;
  DateTime get submittedAt => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool? get isOverride => throw _privateConstructorUsedError;
  String? get overriddenBy => throw _privateConstructorUsedError;
  DateTime? get overriddenAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MealIntent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealIntentCopyWith<MealIntent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealIntentCopyWith<$Res> {
  factory $MealIntentCopyWith(
          MealIntent value, $Res Function(MealIntent) then) =
      _$MealIntentCopyWithImpl<$Res, MealIntent>;
  @useResult
  $Res call(
      {String id,
      String studentId,
      String studentName,
      String studentRollNumber,
      String hostelId,
      DateTime date,
      MealType mealType,
      bool willEat,
      DateTime submittedAt,
      String? reason,
      String? notes,
      bool? isOverride,
      String? overriddenBy,
      DateTime? overriddenAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MealIntentCopyWithImpl<$Res, $Val extends MealIntent>
    implements $MealIntentCopyWith<$Res> {
  _$MealIntentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? studentRollNumber = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? willEat = null,
    Object? submittedAt = null,
    Object? reason = freezed,
    Object? notes = freezed,
    Object? isOverride = freezed,
    Object? overriddenBy = freezed,
    Object? overriddenAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      studentRollNumber: null == studentRollNumber
          ? _value.studentRollNumber
          : studentRollNumber // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      willEat: null == willEat
          ? _value.willEat
          : willEat // ignore: cast_nullable_to_non_nullable
              as bool,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isOverride: freezed == isOverride
          ? _value.isOverride
          : isOverride // ignore: cast_nullable_to_non_nullable
              as bool?,
      overriddenBy: freezed == overriddenBy
          ? _value.overriddenBy
          : overriddenBy // ignore: cast_nullable_to_non_nullable
              as String?,
      overriddenAt: freezed == overriddenAt
          ? _value.overriddenAt
          : overriddenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealIntentImplCopyWith<$Res>
    implements $MealIntentCopyWith<$Res> {
  factory _$$MealIntentImplCopyWith(
          _$MealIntentImpl value, $Res Function(_$MealIntentImpl) then) =
      __$$MealIntentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String studentId,
      String studentName,
      String studentRollNumber,
      String hostelId,
      DateTime date,
      MealType mealType,
      bool willEat,
      DateTime submittedAt,
      String? reason,
      String? notes,
      bool? isOverride,
      String? overriddenBy,
      DateTime? overriddenAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MealIntentImplCopyWithImpl<$Res>
    extends _$MealIntentCopyWithImpl<$Res, _$MealIntentImpl>
    implements _$$MealIntentImplCopyWith<$Res> {
  __$$MealIntentImplCopyWithImpl(
      _$MealIntentImpl _value, $Res Function(_$MealIntentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? studentRollNumber = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? willEat = null,
    Object? submittedAt = null,
    Object? reason = freezed,
    Object? notes = freezed,
    Object? isOverride = freezed,
    Object? overriddenBy = freezed,
    Object? overriddenAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MealIntentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      studentRollNumber: null == studentRollNumber
          ? _value.studentRollNumber
          : studentRollNumber // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      willEat: null == willEat
          ? _value.willEat
          : willEat // ignore: cast_nullable_to_non_nullable
              as bool,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isOverride: freezed == isOverride
          ? _value.isOverride
          : isOverride // ignore: cast_nullable_to_non_nullable
              as bool?,
      overriddenBy: freezed == overriddenBy
          ? _value.overriddenBy
          : overriddenBy // ignore: cast_nullable_to_non_nullable
              as String?,
      overriddenAt: freezed == overriddenAt
          ? _value.overriddenAt
          : overriddenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealIntentImpl implements _MealIntent {
  const _$MealIntentImpl(
      {required this.id,
      required this.studentId,
      required this.studentName,
      required this.studentRollNumber,
      required this.hostelId,
      required this.date,
      required this.mealType,
      required this.willEat,
      required this.submittedAt,
      this.reason,
      this.notes,
      this.isOverride,
      this.overriddenBy,
      this.overriddenAt,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$MealIntentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealIntentImplFromJson(json);

  @override
  final String id;
  @override
  final String studentId;
  @override
  final String studentName;
  @override
  final String studentRollNumber;
  @override
  final String hostelId;
  @override
  final DateTime date;
  @override
  final MealType mealType;
  @override
  final bool willEat;
  @override
  final DateTime submittedAt;
  @override
  final String? reason;
  @override
  final String? notes;
  @override
  final bool? isOverride;
  @override
  final String? overriddenBy;
  @override
  final DateTime? overriddenAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MealIntent(id: $id, studentId: $studentId, studentName: $studentName, studentRollNumber: $studentRollNumber, hostelId: $hostelId, date: $date, mealType: $mealType, willEat: $willEat, submittedAt: $submittedAt, reason: $reason, notes: $notes, isOverride: $isOverride, overriddenBy: $overriddenBy, overriddenAt: $overriddenAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealIntentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentRollNumber, studentRollNumber) ||
                other.studentRollNumber == studentRollNumber) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.willEat, willEat) || other.willEat == willEat) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isOverride, isOverride) ||
                other.isOverride == isOverride) &&
            (identical(other.overriddenBy, overriddenBy) ||
                other.overriddenBy == overriddenBy) &&
            (identical(other.overriddenAt, overriddenAt) ||
                other.overriddenAt == overriddenAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studentId,
      studentName,
      studentRollNumber,
      hostelId,
      date,
      mealType,
      willEat,
      submittedAt,
      reason,
      notes,
      isOverride,
      overriddenBy,
      overriddenAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MealIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealIntentImplCopyWith<_$MealIntentImpl> get copyWith =>
      __$$MealIntentImplCopyWithImpl<_$MealIntentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealIntentImplToJson(
      this,
    );
  }
}

abstract class _MealIntent implements MealIntent {
  const factory _MealIntent(
      {required final String id,
      required final String studentId,
      required final String studentName,
      required final String studentRollNumber,
      required final String hostelId,
      required final DateTime date,
      required final MealType mealType,
      required final bool willEat,
      required final DateTime submittedAt,
      final String? reason,
      final String? notes,
      final bool? isOverride,
      final String? overriddenBy,
      final DateTime? overriddenAt,
      final Map<String, dynamic>? metadata}) = _$MealIntentImpl;

  factory _MealIntent.fromJson(Map<String, dynamic> json) =
      _$MealIntentImpl.fromJson;

  @override
  String get id;
  @override
  String get studentId;
  @override
  String get studentName;
  @override
  String get studentRollNumber;
  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  MealType get mealType;
  @override
  bool get willEat;
  @override
  DateTime get submittedAt;
  @override
  String? get reason;
  @override
  String? get notes;
  @override
  bool? get isOverride;
  @override
  String? get overriddenBy;
  @override
  DateTime? get overriddenAt;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MealIntent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealIntentImplCopyWith<_$MealIntentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealForecast _$MealForecastFromJson(Map<String, dynamic> json) {
  return _MealForecast.fromJson(json);
}

/// @nodoc
mixin _$MealForecast {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;
  int get confirmedCount => throw _privateConstructorUsedError;
  int get bufferCount => throw _privateConstructorUsedError;
  int get overrideCount => throw _privateConstructorUsedError;
  int get finalCount => throw _privateConstructorUsedError;
  double get bufferPercentage => throw _privateConstructorUsedError;
  DateTime get calculatedAt => throw _privateConstructorUsedError;
  String get calculatedBy => throw _privateConstructorUsedError;
  List<MealOverride>? get overrides => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MealForecast to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealForecastCopyWith<MealForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealForecastCopyWith<$Res> {
  factory $MealForecastCopyWith(
          MealForecast value, $Res Function(MealForecast) then) =
      _$MealForecastCopyWithImpl<$Res, MealForecast>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      DateTime date,
      MealType mealType,
      int totalStudents,
      int confirmedCount,
      int bufferCount,
      int overrideCount,
      int finalCount,
      double bufferPercentage,
      DateTime calculatedAt,
      String calculatedBy,
      List<MealOverride>? overrides,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MealForecastCopyWithImpl<$Res, $Val extends MealForecast>
    implements $MealForecastCopyWith<$Res> {
  _$MealForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? totalStudents = null,
    Object? confirmedCount = null,
    Object? bufferCount = null,
    Object? overrideCount = null,
    Object? finalCount = null,
    Object? bufferPercentage = null,
    Object? calculatedAt = null,
    Object? calculatedBy = null,
    Object? overrides = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      confirmedCount: null == confirmedCount
          ? _value.confirmedCount
          : confirmedCount // ignore: cast_nullable_to_non_nullable
              as int,
      bufferCount: null == bufferCount
          ? _value.bufferCount
          : bufferCount // ignore: cast_nullable_to_non_nullable
              as int,
      overrideCount: null == overrideCount
          ? _value.overrideCount
          : overrideCount // ignore: cast_nullable_to_non_nullable
              as int,
      finalCount: null == finalCount
          ? _value.finalCount
          : finalCount // ignore: cast_nullable_to_non_nullable
              as int,
      bufferPercentage: null == bufferPercentage
          ? _value.bufferPercentage
          : bufferPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calculatedBy: null == calculatedBy
          ? _value.calculatedBy
          : calculatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      overrides: freezed == overrides
          ? _value.overrides
          : overrides // ignore: cast_nullable_to_non_nullable
              as List<MealOverride>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealForecastImplCopyWith<$Res>
    implements $MealForecastCopyWith<$Res> {
  factory _$$MealForecastImplCopyWith(
          _$MealForecastImpl value, $Res Function(_$MealForecastImpl) then) =
      __$$MealForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      DateTime date,
      MealType mealType,
      int totalStudents,
      int confirmedCount,
      int bufferCount,
      int overrideCount,
      int finalCount,
      double bufferPercentage,
      DateTime calculatedAt,
      String calculatedBy,
      List<MealOverride>? overrides,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MealForecastImplCopyWithImpl<$Res>
    extends _$MealForecastCopyWithImpl<$Res, _$MealForecastImpl>
    implements _$$MealForecastImplCopyWith<$Res> {
  __$$MealForecastImplCopyWithImpl(
      _$MealForecastImpl _value, $Res Function(_$MealForecastImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? totalStudents = null,
    Object? confirmedCount = null,
    Object? bufferCount = null,
    Object? overrideCount = null,
    Object? finalCount = null,
    Object? bufferPercentage = null,
    Object? calculatedAt = null,
    Object? calculatedBy = null,
    Object? overrides = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MealForecastImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      confirmedCount: null == confirmedCount
          ? _value.confirmedCount
          : confirmedCount // ignore: cast_nullable_to_non_nullable
              as int,
      bufferCount: null == bufferCount
          ? _value.bufferCount
          : bufferCount // ignore: cast_nullable_to_non_nullable
              as int,
      overrideCount: null == overrideCount
          ? _value.overrideCount
          : overrideCount // ignore: cast_nullable_to_non_nullable
              as int,
      finalCount: null == finalCount
          ? _value.finalCount
          : finalCount // ignore: cast_nullable_to_non_nullable
              as int,
      bufferPercentage: null == bufferPercentage
          ? _value.bufferPercentage
          : bufferPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calculatedBy: null == calculatedBy
          ? _value.calculatedBy
          : calculatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      overrides: freezed == overrides
          ? _value._overrides
          : overrides // ignore: cast_nullable_to_non_nullable
              as List<MealOverride>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealForecastImpl implements _MealForecast {
  const _$MealForecastImpl(
      {required this.id,
      required this.hostelId,
      required this.date,
      required this.mealType,
      required this.totalStudents,
      required this.confirmedCount,
      required this.bufferCount,
      required this.overrideCount,
      required this.finalCount,
      required this.bufferPercentage,
      required this.calculatedAt,
      required this.calculatedBy,
      final List<MealOverride>? overrides,
      final Map<String, dynamic>? metadata})
      : _overrides = overrides,
        _metadata = metadata;

  factory _$MealForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealForecastImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final DateTime date;
  @override
  final MealType mealType;
  @override
  final int totalStudents;
  @override
  final int confirmedCount;
  @override
  final int bufferCount;
  @override
  final int overrideCount;
  @override
  final int finalCount;
  @override
  final double bufferPercentage;
  @override
  final DateTime calculatedAt;
  @override
  final String calculatedBy;
  final List<MealOverride>? _overrides;
  @override
  List<MealOverride>? get overrides {
    final value = _overrides;
    if (value == null) return null;
    if (_overrides is EqualUnmodifiableListView) return _overrides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MealForecast(id: $id, hostelId: $hostelId, date: $date, mealType: $mealType, totalStudents: $totalStudents, confirmedCount: $confirmedCount, bufferCount: $bufferCount, overrideCount: $overrideCount, finalCount: $finalCount, bufferPercentage: $bufferPercentage, calculatedAt: $calculatedAt, calculatedBy: $calculatedBy, overrides: $overrides, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealForecastImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.confirmedCount, confirmedCount) ||
                other.confirmedCount == confirmedCount) &&
            (identical(other.bufferCount, bufferCount) ||
                other.bufferCount == bufferCount) &&
            (identical(other.overrideCount, overrideCount) ||
                other.overrideCount == overrideCount) &&
            (identical(other.finalCount, finalCount) ||
                other.finalCount == finalCount) &&
            (identical(other.bufferPercentage, bufferPercentage) ||
                other.bufferPercentage == bufferPercentage) &&
            (identical(other.calculatedAt, calculatedAt) ||
                other.calculatedAt == calculatedAt) &&
            (identical(other.calculatedBy, calculatedBy) ||
                other.calculatedBy == calculatedBy) &&
            const DeepCollectionEquality()
                .equals(other._overrides, _overrides) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hostelId,
      date,
      mealType,
      totalStudents,
      confirmedCount,
      bufferCount,
      overrideCount,
      finalCount,
      bufferPercentage,
      calculatedAt,
      calculatedBy,
      const DeepCollectionEquality().hash(_overrides),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MealForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealForecastImplCopyWith<_$MealForecastImpl> get copyWith =>
      __$$MealForecastImplCopyWithImpl<_$MealForecastImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealForecastImplToJson(
      this,
    );
  }
}

abstract class _MealForecast implements MealForecast {
  const factory _MealForecast(
      {required final String id,
      required final String hostelId,
      required final DateTime date,
      required final MealType mealType,
      required final int totalStudents,
      required final int confirmedCount,
      required final int bufferCount,
      required final int overrideCount,
      required final int finalCount,
      required final double bufferPercentage,
      required final DateTime calculatedAt,
      required final String calculatedBy,
      final List<MealOverride>? overrides,
      final Map<String, dynamic>? metadata}) = _$MealForecastImpl;

  factory _MealForecast.fromJson(Map<String, dynamic> json) =
      _$MealForecastImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  MealType get mealType;
  @override
  int get totalStudents;
  @override
  int get confirmedCount;
  @override
  int get bufferCount;
  @override
  int get overrideCount;
  @override
  int get finalCount;
  @override
  double get bufferPercentage;
  @override
  DateTime get calculatedAt;
  @override
  String get calculatedBy;
  @override
  List<MealOverride>? get overrides;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MealForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealForecastImplCopyWith<_$MealForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealOverride _$MealOverrideFromJson(Map<String, dynamic> json) {
  return _MealOverride.fromJson(json);
}

/// @nodoc
mixin _$MealOverride {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  int get additionalCount => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String get overriddenBy => throw _privateConstructorUsedError;
  String get overriddenByName => throw _privateConstructorUsedError;
  DateTime get overriddenAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MealOverride to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealOverride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealOverrideCopyWith<MealOverride> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealOverrideCopyWith<$Res> {
  factory $MealOverrideCopyWith(
          MealOverride value, $Res Function(MealOverride) then) =
      _$MealOverrideCopyWithImpl<$Res, MealOverride>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      DateTime date,
      MealType mealType,
      int additionalCount,
      String reason,
      String overriddenBy,
      String overriddenByName,
      DateTime overriddenAt,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MealOverrideCopyWithImpl<$Res, $Val extends MealOverride>
    implements $MealOverrideCopyWith<$Res> {
  _$MealOverrideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealOverride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? additionalCount = null,
    Object? reason = null,
    Object? overriddenBy = null,
    Object? overriddenByName = null,
    Object? overriddenAt = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      additionalCount: null == additionalCount
          ? _value.additionalCount
          : additionalCount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      overriddenBy: null == overriddenBy
          ? _value.overriddenBy
          : overriddenBy // ignore: cast_nullable_to_non_nullable
              as String,
      overriddenByName: null == overriddenByName
          ? _value.overriddenByName
          : overriddenByName // ignore: cast_nullable_to_non_nullable
              as String,
      overriddenAt: null == overriddenAt
          ? _value.overriddenAt
          : overriddenAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealOverrideImplCopyWith<$Res>
    implements $MealOverrideCopyWith<$Res> {
  factory _$$MealOverrideImplCopyWith(
          _$MealOverrideImpl value, $Res Function(_$MealOverrideImpl) then) =
      __$$MealOverrideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      DateTime date,
      MealType mealType,
      int additionalCount,
      String reason,
      String overriddenBy,
      String overriddenByName,
      DateTime overriddenAt,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MealOverrideImplCopyWithImpl<$Res>
    extends _$MealOverrideCopyWithImpl<$Res, _$MealOverrideImpl>
    implements _$$MealOverrideImplCopyWith<$Res> {
  __$$MealOverrideImplCopyWithImpl(
      _$MealOverrideImpl _value, $Res Function(_$MealOverrideImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealOverride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? additionalCount = null,
    Object? reason = null,
    Object? overriddenBy = null,
    Object? overriddenByName = null,
    Object? overriddenAt = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MealOverrideImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      additionalCount: null == additionalCount
          ? _value.additionalCount
          : additionalCount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      overriddenBy: null == overriddenBy
          ? _value.overriddenBy
          : overriddenBy // ignore: cast_nullable_to_non_nullable
              as String,
      overriddenByName: null == overriddenByName
          ? _value.overriddenByName
          : overriddenByName // ignore: cast_nullable_to_non_nullable
              as String,
      overriddenAt: null == overriddenAt
          ? _value.overriddenAt
          : overriddenAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealOverrideImpl implements _MealOverride {
  const _$MealOverrideImpl(
      {required this.id,
      required this.hostelId,
      required this.date,
      required this.mealType,
      required this.additionalCount,
      required this.reason,
      required this.overriddenBy,
      required this.overriddenByName,
      required this.overriddenAt,
      this.notes,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$MealOverrideImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealOverrideImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final DateTime date;
  @override
  final MealType mealType;
  @override
  final int additionalCount;
  @override
  final String reason;
  @override
  final String overriddenBy;
  @override
  final String overriddenByName;
  @override
  final DateTime overriddenAt;
  @override
  final String? notes;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MealOverride(id: $id, hostelId: $hostelId, date: $date, mealType: $mealType, additionalCount: $additionalCount, reason: $reason, overriddenBy: $overriddenBy, overriddenByName: $overriddenByName, overriddenAt: $overriddenAt, notes: $notes, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealOverrideImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.additionalCount, additionalCount) ||
                other.additionalCount == additionalCount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.overriddenBy, overriddenBy) ||
                other.overriddenBy == overriddenBy) &&
            (identical(other.overriddenByName, overriddenByName) ||
                other.overriddenByName == overriddenByName) &&
            (identical(other.overriddenAt, overriddenAt) ||
                other.overriddenAt == overriddenAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hostelId,
      date,
      mealType,
      additionalCount,
      reason,
      overriddenBy,
      overriddenByName,
      overriddenAt,
      notes,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MealOverride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealOverrideImplCopyWith<_$MealOverrideImpl> get copyWith =>
      __$$MealOverrideImplCopyWithImpl<_$MealOverrideImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealOverrideImplToJson(
      this,
    );
  }
}

abstract class _MealOverride implements MealOverride {
  const factory _MealOverride(
      {required final String id,
      required final String hostelId,
      required final DateTime date,
      required final MealType mealType,
      required final int additionalCount,
      required final String reason,
      required final String overriddenBy,
      required final String overriddenByName,
      required final DateTime overriddenAt,
      final String? notes,
      final Map<String, dynamic>? metadata}) = _$MealOverrideImpl;

  factory _MealOverride.fromJson(Map<String, dynamic> json) =
      _$MealOverrideImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  MealType get mealType;
  @override
  int get additionalCount;
  @override
  String get reason;
  @override
  String get overriddenBy;
  @override
  String get overriddenByName;
  @override
  DateTime get overriddenAt;
  @override
  String? get notes;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MealOverride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealOverrideImplCopyWith<_$MealOverrideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPolicy _$MealPolicyFromJson(Map<String, dynamic> json) {
  return _MealPolicy.fromJson(json);
}

/// @nodoc
mixin _$MealPolicy {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  String get cutoffTime =>
      throw _privateConstructorUsedError; // Format: "HH:mm" e.g., "14:30"
  double get bufferPercentage => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MealPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPolicyCopyWith<MealPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPolicyCopyWith<$Res> {
  factory $MealPolicyCopyWith(
          MealPolicy value, $Res Function(MealPolicy) then) =
      _$MealPolicyCopyWithImpl<$Res, MealPolicy>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      MealType mealType,
      String cutoffTime,
      double bufferPercentage,
      bool isActive,
      DateTime createdAt,
      String createdBy,
      DateTime? updatedAt,
      String? updatedBy,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MealPolicyCopyWithImpl<$Res, $Val extends MealPolicy>
    implements $MealPolicyCopyWith<$Res> {
  _$MealPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? mealType = null,
    Object? cutoffTime = null,
    Object? bufferPercentage = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      cutoffTime: null == cutoffTime
          ? _value.cutoffTime
          : cutoffTime // ignore: cast_nullable_to_non_nullable
              as String,
      bufferPercentage: null == bufferPercentage
          ? _value.bufferPercentage
          : bufferPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealPolicyImplCopyWith<$Res>
    implements $MealPolicyCopyWith<$Res> {
  factory _$$MealPolicyImplCopyWith(
          _$MealPolicyImpl value, $Res Function(_$MealPolicyImpl) then) =
      __$$MealPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      MealType mealType,
      String cutoffTime,
      double bufferPercentage,
      bool isActive,
      DateTime createdAt,
      String createdBy,
      DateTime? updatedAt,
      String? updatedBy,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MealPolicyImplCopyWithImpl<$Res>
    extends _$MealPolicyCopyWithImpl<$Res, _$MealPolicyImpl>
    implements _$$MealPolicyImplCopyWith<$Res> {
  __$$MealPolicyImplCopyWithImpl(
      _$MealPolicyImpl _value, $Res Function(_$MealPolicyImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? mealType = null,
    Object? cutoffTime = null,
    Object? bufferPercentage = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MealPolicyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      cutoffTime: null == cutoffTime
          ? _value.cutoffTime
          : cutoffTime // ignore: cast_nullable_to_non_nullable
              as String,
      bufferPercentage: null == bufferPercentage
          ? _value.bufferPercentage
          : bufferPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPolicyImpl implements _MealPolicy {
  const _$MealPolicyImpl(
      {required this.id,
      required this.hostelId,
      required this.mealType,
      required this.cutoffTime,
      required this.bufferPercentage,
      required this.isActive,
      required this.createdAt,
      required this.createdBy,
      this.updatedAt,
      this.updatedBy,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$MealPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final MealType mealType;
  @override
  final String cutoffTime;
// Format: "HH:mm" e.g., "14:30"
  @override
  final double bufferPercentage;
  @override
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final String createdBy;
  @override
  final DateTime? updatedAt;
  @override
  final String? updatedBy;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MealPolicy(id: $id, hostelId: $hostelId, mealType: $mealType, cutoffTime: $cutoffTime, bufferPercentage: $bufferPercentage, isActive: $isActive, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.cutoffTime, cutoffTime) ||
                other.cutoffTime == cutoffTime) &&
            (identical(other.bufferPercentage, bufferPercentage) ||
                other.bufferPercentage == bufferPercentage) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hostelId,
      mealType,
      cutoffTime,
      bufferPercentage,
      isActive,
      createdAt,
      createdBy,
      updatedAt,
      updatedBy,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MealPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPolicyImplCopyWith<_$MealPolicyImpl> get copyWith =>
      __$$MealPolicyImplCopyWithImpl<_$MealPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPolicyImplToJson(
      this,
    );
  }
}

abstract class _MealPolicy implements MealPolicy {
  const factory _MealPolicy(
      {required final String id,
      required final String hostelId,
      required final MealType mealType,
      required final String cutoffTime,
      required final double bufferPercentage,
      required final bool isActive,
      required final DateTime createdAt,
      required final String createdBy,
      final DateTime? updatedAt,
      final String? updatedBy,
      final Map<String, dynamic>? metadata}) = _$MealPolicyImpl;

  factory _MealPolicy.fromJson(Map<String, dynamic> json) =
      _$MealPolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  MealType get mealType;
  @override
  String get cutoffTime; // Format: "HH:mm" e.g., "14:30"
  @override
  double get bufferPercentage;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  String get createdBy;
  @override
  DateTime? get updatedAt;
  @override
  String? get updatedBy;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MealPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPolicyImplCopyWith<_$MealPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChefBoard _$ChefBoardFromJson(Map<String, dynamic> json) {
  return _ChefBoard.fromJson(json);
}

/// @nodoc
mixin _$ChefBoard {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<MealForecast> get forecasts => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get lockedCounts => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get actualCounts => throw _privateConstructorUsedError;
  DateTime get lockedAt => throw _privateConstructorUsedError;
  String get lockedBy => throw _privateConstructorUsedError;
  bool get isLocked => throw _privateConstructorUsedError;
  List<String>? get exportUrls => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ChefBoard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChefBoard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChefBoardCopyWith<ChefBoard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChefBoardCopyWith<$Res> {
  factory $ChefBoardCopyWith(ChefBoard value, $Res Function(ChefBoard) then) =
      _$ChefBoardCopyWithImpl<$Res, ChefBoard>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      DateTime date,
      List<MealForecast> forecasts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> lockedCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> actualCounts,
      DateTime lockedAt,
      String lockedBy,
      bool isLocked,
      List<String>? exportUrls,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ChefBoardCopyWithImpl<$Res, $Val extends ChefBoard>
    implements $ChefBoardCopyWith<$Res> {
  _$ChefBoardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChefBoard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? date = null,
    Object? forecasts = null,
    Object? lockedCounts = null,
    Object? actualCounts = null,
    Object? lockedAt = null,
    Object? lockedBy = null,
    Object? isLocked = null,
    Object? exportUrls = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      forecasts: null == forecasts
          ? _value.forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<MealForecast>,
      lockedCounts: null == lockedCounts
          ? _value.lockedCounts
          : lockedCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      actualCounts: null == actualCounts
          ? _value.actualCounts
          : actualCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      lockedAt: null == lockedAt
          ? _value.lockedAt
          : lockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lockedBy: null == lockedBy
          ? _value.lockedBy
          : lockedBy // ignore: cast_nullable_to_non_nullable
              as String,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      exportUrls: freezed == exportUrls
          ? _value.exportUrls
          : exportUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChefBoardImplCopyWith<$Res>
    implements $ChefBoardCopyWith<$Res> {
  factory _$$ChefBoardImplCopyWith(
          _$ChefBoardImpl value, $Res Function(_$ChefBoardImpl) then) =
      __$$ChefBoardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      DateTime date,
      List<MealForecast> forecasts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> lockedCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> actualCounts,
      DateTime lockedAt,
      String lockedBy,
      bool isLocked,
      List<String>? exportUrls,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ChefBoardImplCopyWithImpl<$Res>
    extends _$ChefBoardCopyWithImpl<$Res, _$ChefBoardImpl>
    implements _$$ChefBoardImplCopyWith<$Res> {
  __$$ChefBoardImplCopyWithImpl(
      _$ChefBoardImpl _value, $Res Function(_$ChefBoardImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChefBoard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? date = null,
    Object? forecasts = null,
    Object? lockedCounts = null,
    Object? actualCounts = null,
    Object? lockedAt = null,
    Object? lockedBy = null,
    Object? isLocked = null,
    Object? exportUrls = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ChefBoardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      forecasts: null == forecasts
          ? _value._forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<MealForecast>,
      lockedCounts: null == lockedCounts
          ? _value._lockedCounts
          : lockedCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      actualCounts: null == actualCounts
          ? _value._actualCounts
          : actualCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      lockedAt: null == lockedAt
          ? _value.lockedAt
          : lockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lockedBy: null == lockedBy
          ? _value.lockedBy
          : lockedBy // ignore: cast_nullable_to_non_nullable
              as String,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      exportUrls: freezed == exportUrls
          ? _value._exportUrls
          : exportUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChefBoardImpl implements _ChefBoard {
  const _$ChefBoardImpl(
      {required this.id,
      required this.hostelId,
      required this.date,
      required final List<MealForecast> forecasts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> lockedCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> actualCounts,
      required this.lockedAt,
      required this.lockedBy,
      required this.isLocked,
      final List<String>? exportUrls,
      final Map<String, dynamic>? metadata})
      : _forecasts = forecasts,
        _lockedCounts = lockedCounts,
        _actualCounts = actualCounts,
        _exportUrls = exportUrls,
        _metadata = metadata;

  factory _$ChefBoardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChefBoardImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final DateTime date;
  final List<MealForecast> _forecasts;
  @override
  List<MealForecast> get forecasts {
    if (_forecasts is EqualUnmodifiableListView) return _forecasts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forecasts);
  }

  final Map<MealType, int> _lockedCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get lockedCounts {
    if (_lockedCounts is EqualUnmodifiableMapView) return _lockedCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lockedCounts);
  }

  final Map<MealType, int> _actualCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get actualCounts {
    if (_actualCounts is EqualUnmodifiableMapView) return _actualCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actualCounts);
  }

  @override
  final DateTime lockedAt;
  @override
  final String lockedBy;
  @override
  final bool isLocked;
  final List<String>? _exportUrls;
  @override
  List<String>? get exportUrls {
    final value = _exportUrls;
    if (value == null) return null;
    if (_exportUrls is EqualUnmodifiableListView) return _exportUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ChefBoard(id: $id, hostelId: $hostelId, date: $date, forecasts: $forecasts, lockedCounts: $lockedCounts, actualCounts: $actualCounts, lockedAt: $lockedAt, lockedBy: $lockedBy, isLocked: $isLocked, exportUrls: $exportUrls, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChefBoardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality()
                .equals(other._forecasts, _forecasts) &&
            const DeepCollectionEquality()
                .equals(other._lockedCounts, _lockedCounts) &&
            const DeepCollectionEquality()
                .equals(other._actualCounts, _actualCounts) &&
            (identical(other.lockedAt, lockedAt) ||
                other.lockedAt == lockedAt) &&
            (identical(other.lockedBy, lockedBy) ||
                other.lockedBy == lockedBy) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            const DeepCollectionEquality()
                .equals(other._exportUrls, _exportUrls) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hostelId,
      date,
      const DeepCollectionEquality().hash(_forecasts),
      const DeepCollectionEquality().hash(_lockedCounts),
      const DeepCollectionEquality().hash(_actualCounts),
      lockedAt,
      lockedBy,
      isLocked,
      const DeepCollectionEquality().hash(_exportUrls),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ChefBoard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChefBoardImplCopyWith<_$ChefBoardImpl> get copyWith =>
      __$$ChefBoardImplCopyWithImpl<_$ChefBoardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChefBoardImplToJson(
      this,
    );
  }
}

abstract class _ChefBoard implements ChefBoard {
  const factory _ChefBoard(
      {required final String id,
      required final String hostelId,
      required final DateTime date,
      required final List<MealForecast> forecasts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> lockedCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> actualCounts,
      required final DateTime lockedAt,
      required final String lockedBy,
      required final bool isLocked,
      final List<String>? exportUrls,
      final Map<String, dynamic>? metadata}) = _$ChefBoardImpl;

  factory _ChefBoard.fromJson(Map<String, dynamic> json) =
      _$ChefBoardImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  List<MealForecast> get forecasts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get lockedCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get actualCounts;
  @override
  DateTime get lockedAt;
  @override
  String get lockedBy;
  @override
  bool get isLocked;
  @override
  List<String>? get exportUrls;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ChefBoard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChefBoardImplCopyWith<_$ChefBoardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyMealSummary _$DailyMealSummaryFromJson(Map<String, dynamic> json) {
  return _DailyMealSummary.fromJson(json);
}

/// @nodoc
mixin _$DailyMealSummary {
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get intentCounts => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get forecastCounts => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get overrideCounts => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _mealTypeBoolMapFromJson, toJson: _mealTypeBoolMapToJson)
  Map<MealType, bool> get cutoffPassed => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this DailyMealSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyMealSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyMealSummaryCopyWith<DailyMealSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyMealSummaryCopyWith<$Res> {
  factory $DailyMealSummaryCopyWith(
          DailyMealSummary value, $Res Function(DailyMealSummary) then) =
      _$DailyMealSummaryCopyWithImpl<$Res, DailyMealSummary>;
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> intentCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> forecastCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> overrideCounts,
      @JsonKey(
          fromJson: _mealTypeBoolMapFromJson, toJson: _mealTypeBoolMapToJson)
      Map<MealType, bool> cutoffPassed,
      int totalStudents,
      DateTime lastUpdated});
}

/// @nodoc
class _$DailyMealSummaryCopyWithImpl<$Res, $Val extends DailyMealSummary>
    implements $DailyMealSummaryCopyWith<$Res> {
  _$DailyMealSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyMealSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? intentCounts = null,
    Object? forecastCounts = null,
    Object? overrideCounts = null,
    Object? cutoffPassed = null,
    Object? totalStudents = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intentCounts: null == intentCounts
          ? _value.intentCounts
          : intentCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      forecastCounts: null == forecastCounts
          ? _value.forecastCounts
          : forecastCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      overrideCounts: null == overrideCounts
          ? _value.overrideCounts
          : overrideCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      cutoffPassed: null == cutoffPassed
          ? _value.cutoffPassed
          : cutoffPassed // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyMealSummaryImplCopyWith<$Res>
    implements $DailyMealSummaryCopyWith<$Res> {
  factory _$$DailyMealSummaryImplCopyWith(_$DailyMealSummaryImpl value,
          $Res Function(_$DailyMealSummaryImpl) then) =
      __$$DailyMealSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> intentCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> forecastCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      Map<MealType, int> overrideCounts,
      @JsonKey(
          fromJson: _mealTypeBoolMapFromJson, toJson: _mealTypeBoolMapToJson)
      Map<MealType, bool> cutoffPassed,
      int totalStudents,
      DateTime lastUpdated});
}

/// @nodoc
class __$$DailyMealSummaryImplCopyWithImpl<$Res>
    extends _$DailyMealSummaryCopyWithImpl<$Res, _$DailyMealSummaryImpl>
    implements _$$DailyMealSummaryImplCopyWith<$Res> {
  __$$DailyMealSummaryImplCopyWithImpl(_$DailyMealSummaryImpl _value,
      $Res Function(_$DailyMealSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyMealSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? intentCounts = null,
    Object? forecastCounts = null,
    Object? overrideCounts = null,
    Object? cutoffPassed = null,
    Object? totalStudents = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$DailyMealSummaryImpl(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intentCounts: null == intentCounts
          ? _value._intentCounts
          : intentCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      forecastCounts: null == forecastCounts
          ? _value._forecastCounts
          : forecastCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      overrideCounts: null == overrideCounts
          ? _value._overrideCounts
          : overrideCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      cutoffPassed: null == cutoffPassed
          ? _value._cutoffPassed
          : cutoffPassed // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyMealSummaryImpl implements _DailyMealSummary {
  const _$DailyMealSummaryImpl(
      {required this.hostelId,
      required this.date,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> intentCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> forecastCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> overrideCounts,
      @JsonKey(
          fromJson: _mealTypeBoolMapFromJson, toJson: _mealTypeBoolMapToJson)
      required final Map<MealType, bool> cutoffPassed,
      required this.totalStudents,
      required this.lastUpdated})
      : _intentCounts = intentCounts,
        _forecastCounts = forecastCounts,
        _overrideCounts = overrideCounts,
        _cutoffPassed = cutoffPassed;

  factory _$DailyMealSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyMealSummaryImplFromJson(json);

  @override
  final String hostelId;
  @override
  final DateTime date;
  final Map<MealType, int> _intentCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get intentCounts {
    if (_intentCounts is EqualUnmodifiableMapView) return _intentCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_intentCounts);
  }

  final Map<MealType, int> _forecastCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get forecastCounts {
    if (_forecastCounts is EqualUnmodifiableMapView) return _forecastCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_forecastCounts);
  }

  final Map<MealType, int> _overrideCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get overrideCounts {
    if (_overrideCounts is EqualUnmodifiableMapView) return _overrideCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_overrideCounts);
  }

  final Map<MealType, bool> _cutoffPassed;
  @override
  @JsonKey(fromJson: _mealTypeBoolMapFromJson, toJson: _mealTypeBoolMapToJson)
  Map<MealType, bool> get cutoffPassed {
    if (_cutoffPassed is EqualUnmodifiableMapView) return _cutoffPassed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cutoffPassed);
  }

  @override
  final int totalStudents;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'DailyMealSummary(hostelId: $hostelId, date: $date, intentCounts: $intentCounts, forecastCounts: $forecastCounts, overrideCounts: $overrideCounts, cutoffPassed: $cutoffPassed, totalStudents: $totalStudents, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyMealSummaryImpl &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality()
                .equals(other._intentCounts, _intentCounts) &&
            const DeepCollectionEquality()
                .equals(other._forecastCounts, _forecastCounts) &&
            const DeepCollectionEquality()
                .equals(other._overrideCounts, _overrideCounts) &&
            const DeepCollectionEquality()
                .equals(other._cutoffPassed, _cutoffPassed) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hostelId,
      date,
      const DeepCollectionEquality().hash(_intentCounts),
      const DeepCollectionEquality().hash(_forecastCounts),
      const DeepCollectionEquality().hash(_overrideCounts),
      const DeepCollectionEquality().hash(_cutoffPassed),
      totalStudents,
      lastUpdated);

  /// Create a copy of DailyMealSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyMealSummaryImplCopyWith<_$DailyMealSummaryImpl> get copyWith =>
      __$$DailyMealSummaryImplCopyWithImpl<_$DailyMealSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyMealSummaryImplToJson(
      this,
    );
  }
}

abstract class _DailyMealSummary implements DailyMealSummary {
  const factory _DailyMealSummary(
      {required final String hostelId,
      required final DateTime date,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> intentCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> forecastCounts,
      @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
      required final Map<MealType, int> overrideCounts,
      @JsonKey(
          fromJson: _mealTypeBoolMapFromJson, toJson: _mealTypeBoolMapToJson)
      required final Map<MealType, bool> cutoffPassed,
      required final int totalStudents,
      required final DateTime lastUpdated}) = _$DailyMealSummaryImpl;

  factory _DailyMealSummary.fromJson(Map<String, dynamic> json) =
      _$DailyMealSummaryImpl.fromJson;

  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get intentCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get forecastCounts;
  @override
  @JsonKey(fromJson: _mealTypeIntMapFromJson, toJson: _mealTypeIntMapToJson)
  Map<MealType, int> get overrideCounts;
  @override
  @JsonKey(fromJson: _mealTypeBoolMapFromJson, toJson: _mealTypeBoolMapToJson)
  Map<MealType, bool> get cutoffPassed;
  @override
  int get totalStudents;
  @override
  DateTime get lastUpdated;

  /// Create a copy of DailyMealSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyMealSummaryImplCopyWith<_$DailyMealSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealIntentRequest _$MealIntentRequestFromJson(Map<String, dynamic> json) {
  return _MealIntentRequest.fromJson(json);
}

/// @nodoc
mixin _$MealIntentRequest {
  String get studentId => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  bool get willEat => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this MealIntentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealIntentRequestCopyWith<MealIntentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealIntentRequestCopyWith<$Res> {
  factory $MealIntentRequestCopyWith(
          MealIntentRequest value, $Res Function(MealIntentRequest) then) =
      _$MealIntentRequestCopyWithImpl<$Res, MealIntentRequest>;
  @useResult
  $Res call(
      {String studentId,
      String hostelId,
      DateTime date,
      MealType mealType,
      bool willEat,
      String? reason,
      String? notes});
}

/// @nodoc
class _$MealIntentRequestCopyWithImpl<$Res, $Val extends MealIntentRequest>
    implements $MealIntentRequestCopyWith<$Res> {
  _$MealIntentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? willEat = null,
    Object? reason = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      willEat: null == willEat
          ? _value.willEat
          : willEat // ignore: cast_nullable_to_non_nullable
              as bool,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealIntentRequestImplCopyWith<$Res>
    implements $MealIntentRequestCopyWith<$Res> {
  factory _$$MealIntentRequestImplCopyWith(_$MealIntentRequestImpl value,
          $Res Function(_$MealIntentRequestImpl) then) =
      __$$MealIntentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String studentId,
      String hostelId,
      DateTime date,
      MealType mealType,
      bool willEat,
      String? reason,
      String? notes});
}

/// @nodoc
class __$$MealIntentRequestImplCopyWithImpl<$Res>
    extends _$MealIntentRequestCopyWithImpl<$Res, _$MealIntentRequestImpl>
    implements _$$MealIntentRequestImplCopyWith<$Res> {
  __$$MealIntentRequestImplCopyWithImpl(_$MealIntentRequestImpl _value,
      $Res Function(_$MealIntentRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? willEat = null,
    Object? reason = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$MealIntentRequestImpl(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      willEat: null == willEat
          ? _value.willEat
          : willEat // ignore: cast_nullable_to_non_nullable
              as bool,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealIntentRequestImpl implements _MealIntentRequest {
  const _$MealIntentRequestImpl(
      {required this.studentId,
      required this.hostelId,
      required this.date,
      required this.mealType,
      required this.willEat,
      this.reason,
      this.notes});

  factory _$MealIntentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealIntentRequestImplFromJson(json);

  @override
  final String studentId;
  @override
  final String hostelId;
  @override
  final DateTime date;
  @override
  final MealType mealType;
  @override
  final bool willEat;
  @override
  final String? reason;
  @override
  final String? notes;

  @override
  String toString() {
    return 'MealIntentRequest(studentId: $studentId, hostelId: $hostelId, date: $date, mealType: $mealType, willEat: $willEat, reason: $reason, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealIntentRequestImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.willEat, willEat) || other.willEat == willEat) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, studentId, hostelId, date, mealType, willEat, reason, notes);

  /// Create a copy of MealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealIntentRequestImplCopyWith<_$MealIntentRequestImpl> get copyWith =>
      __$$MealIntentRequestImplCopyWithImpl<_$MealIntentRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealIntentRequestImplToJson(
      this,
    );
  }
}

abstract class _MealIntentRequest implements MealIntentRequest {
  const factory _MealIntentRequest(
      {required final String studentId,
      required final String hostelId,
      required final DateTime date,
      required final MealType mealType,
      required final bool willEat,
      final String? reason,
      final String? notes}) = _$MealIntentRequestImpl;

  factory _MealIntentRequest.fromJson(Map<String, dynamic> json) =
      _$MealIntentRequestImpl.fromJson;

  @override
  String get studentId;
  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  MealType get mealType;
  @override
  bool get willEat;
  @override
  String? get reason;
  @override
  String? get notes;

  /// Create a copy of MealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealIntentRequestImplCopyWith<_$MealIntentRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkMealIntentRequest _$BulkMealIntentRequestFromJson(
    Map<String, dynamic> json) {
  return _BulkMealIntentRequest.fromJson(json);
}

/// @nodoc
mixin _$BulkMealIntentRequest {
  String get studentId => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  Map<MealType, bool> get intents => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this BulkMealIntentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BulkMealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BulkMealIntentRequestCopyWith<BulkMealIntentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkMealIntentRequestCopyWith<$Res> {
  factory $BulkMealIntentRequestCopyWith(BulkMealIntentRequest value,
          $Res Function(BulkMealIntentRequest) then) =
      _$BulkMealIntentRequestCopyWithImpl<$Res, BulkMealIntentRequest>;
  @useResult
  $Res call(
      {String studentId,
      String hostelId,
      DateTime date,
      Map<MealType, bool> intents,
      String? reason,
      String? notes});
}

/// @nodoc
class _$BulkMealIntentRequestCopyWithImpl<$Res,
        $Val extends BulkMealIntentRequest>
    implements $BulkMealIntentRequestCopyWith<$Res> {
  _$BulkMealIntentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BulkMealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? hostelId = null,
    Object? date = null,
    Object? intents = null,
    Object? reason = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intents: null == intents
          ? _value.intents
          : intents // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkMealIntentRequestImplCopyWith<$Res>
    implements $BulkMealIntentRequestCopyWith<$Res> {
  factory _$$BulkMealIntentRequestImplCopyWith(
          _$BulkMealIntentRequestImpl value,
          $Res Function(_$BulkMealIntentRequestImpl) then) =
      __$$BulkMealIntentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String studentId,
      String hostelId,
      DateTime date,
      Map<MealType, bool> intents,
      String? reason,
      String? notes});
}

/// @nodoc
class __$$BulkMealIntentRequestImplCopyWithImpl<$Res>
    extends _$BulkMealIntentRequestCopyWithImpl<$Res,
        _$BulkMealIntentRequestImpl>
    implements _$$BulkMealIntentRequestImplCopyWith<$Res> {
  __$$BulkMealIntentRequestImplCopyWithImpl(_$BulkMealIntentRequestImpl _value,
      $Res Function(_$BulkMealIntentRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of BulkMealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? hostelId = null,
    Object? date = null,
    Object? intents = null,
    Object? reason = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$BulkMealIntentRequestImpl(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intents: null == intents
          ? _value._intents
          : intents // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkMealIntentRequestImpl implements _BulkMealIntentRequest {
  const _$BulkMealIntentRequestImpl(
      {required this.studentId,
      required this.hostelId,
      required this.date,
      required final Map<MealType, bool> intents,
      this.reason,
      this.notes})
      : _intents = intents;

  factory _$BulkMealIntentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkMealIntentRequestImplFromJson(json);

  @override
  final String studentId;
  @override
  final String hostelId;
  @override
  final DateTime date;
  final Map<MealType, bool> _intents;
  @override
  Map<MealType, bool> get intents {
    if (_intents is EqualUnmodifiableMapView) return _intents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_intents);
  }

  @override
  final String? reason;
  @override
  final String? notes;

  @override
  String toString() {
    return 'BulkMealIntentRequest(studentId: $studentId, hostelId: $hostelId, date: $date, intents: $intents, reason: $reason, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkMealIntentRequestImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._intents, _intents) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, studentId, hostelId, date,
      const DeepCollectionEquality().hash(_intents), reason, notes);

  /// Create a copy of BulkMealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkMealIntentRequestImplCopyWith<_$BulkMealIntentRequestImpl>
      get copyWith => __$$BulkMealIntentRequestImplCopyWithImpl<
          _$BulkMealIntentRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkMealIntentRequestImplToJson(
      this,
    );
  }
}

abstract class _BulkMealIntentRequest implements BulkMealIntentRequest {
  const factory _BulkMealIntentRequest(
      {required final String studentId,
      required final String hostelId,
      required final DateTime date,
      required final Map<MealType, bool> intents,
      final String? reason,
      final String? notes}) = _$BulkMealIntentRequestImpl;

  factory _BulkMealIntentRequest.fromJson(Map<String, dynamic> json) =
      _$BulkMealIntentRequestImpl.fromJson;

  @override
  String get studentId;
  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  Map<MealType, bool> get intents;
  @override
  String? get reason;
  @override
  String? get notes;

  /// Create a copy of BulkMealIntentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BulkMealIntentRequestImplCopyWith<_$BulkMealIntentRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MealOverrideRequest _$MealOverrideRequestFromJson(Map<String, dynamic> json) {
  return _MealOverrideRequest.fromJson(json);
}

/// @nodoc
mixin _$MealOverrideRequest {
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  int get additionalCount => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get overriddenBy => throw _privateConstructorUsedError;

  /// Serializes this MealOverrideRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealOverrideRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealOverrideRequestCopyWith<MealOverrideRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealOverrideRequestCopyWith<$Res> {
  factory $MealOverrideRequestCopyWith(
          MealOverrideRequest value, $Res Function(MealOverrideRequest) then) =
      _$MealOverrideRequestCopyWithImpl<$Res, MealOverrideRequest>;
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      MealType mealType,
      int additionalCount,
      String reason,
      String? notes,
      String overriddenBy});
}

/// @nodoc
class _$MealOverrideRequestCopyWithImpl<$Res, $Val extends MealOverrideRequest>
    implements $MealOverrideRequestCopyWith<$Res> {
  _$MealOverrideRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealOverrideRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? additionalCount = null,
    Object? reason = null,
    Object? notes = freezed,
    Object? overriddenBy = null,
  }) {
    return _then(_value.copyWith(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      additionalCount: null == additionalCount
          ? _value.additionalCount
          : additionalCount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      overriddenBy: null == overriddenBy
          ? _value.overriddenBy
          : overriddenBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealOverrideRequestImplCopyWith<$Res>
    implements $MealOverrideRequestCopyWith<$Res> {
  factory _$$MealOverrideRequestImplCopyWith(_$MealOverrideRequestImpl value,
          $Res Function(_$MealOverrideRequestImpl) then) =
      __$$MealOverrideRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      MealType mealType,
      int additionalCount,
      String reason,
      String? notes,
      String overriddenBy});
}

/// @nodoc
class __$$MealOverrideRequestImplCopyWithImpl<$Res>
    extends _$MealOverrideRequestCopyWithImpl<$Res, _$MealOverrideRequestImpl>
    implements _$$MealOverrideRequestImplCopyWith<$Res> {
  __$$MealOverrideRequestImplCopyWithImpl(_$MealOverrideRequestImpl _value,
      $Res Function(_$MealOverrideRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealOverrideRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? mealType = null,
    Object? additionalCount = null,
    Object? reason = null,
    Object? notes = freezed,
    Object? overriddenBy = null,
  }) {
    return _then(_$MealOverrideRequestImpl(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      additionalCount: null == additionalCount
          ? _value.additionalCount
          : additionalCount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      overriddenBy: null == overriddenBy
          ? _value.overriddenBy
          : overriddenBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealOverrideRequestImpl implements _MealOverrideRequest {
  const _$MealOverrideRequestImpl(
      {required this.hostelId,
      required this.date,
      required this.mealType,
      required this.additionalCount,
      required this.reason,
      this.notes,
      required this.overriddenBy});

  factory _$MealOverrideRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealOverrideRequestImplFromJson(json);

  @override
  final String hostelId;
  @override
  final DateTime date;
  @override
  final MealType mealType;
  @override
  final int additionalCount;
  @override
  final String reason;
  @override
  final String? notes;
  @override
  final String overriddenBy;

  @override
  String toString() {
    return 'MealOverrideRequest(hostelId: $hostelId, date: $date, mealType: $mealType, additionalCount: $additionalCount, reason: $reason, notes: $notes, overriddenBy: $overriddenBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealOverrideRequestImpl &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.additionalCount, additionalCount) ||
                other.additionalCount == additionalCount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.overriddenBy, overriddenBy) ||
                other.overriddenBy == overriddenBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hostelId, date, mealType,
      additionalCount, reason, notes, overriddenBy);

  /// Create a copy of MealOverrideRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealOverrideRequestImplCopyWith<_$MealOverrideRequestImpl> get copyWith =>
      __$$MealOverrideRequestImplCopyWithImpl<_$MealOverrideRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealOverrideRequestImplToJson(
      this,
    );
  }
}

abstract class _MealOverrideRequest implements MealOverrideRequest {
  const factory _MealOverrideRequest(
      {required final String hostelId,
      required final DateTime date,
      required final MealType mealType,
      required final int additionalCount,
      required final String reason,
      final String? notes,
      required final String overriddenBy}) = _$MealOverrideRequestImpl;

  factory _MealOverrideRequest.fromJson(Map<String, dynamic> json) =
      _$MealOverrideRequestImpl.fromJson;

  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  MealType get mealType;
  @override
  int get additionalCount;
  @override
  String get reason;
  @override
  String? get notes;
  @override
  String get overriddenBy;

  /// Create a copy of MealOverrideRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealOverrideRequestImplCopyWith<_$MealOverrideRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealStatistics _$MealStatisticsFromJson(Map<String, dynamic> json) {
  return _MealStatistics.fromJson(json);
}

/// @nodoc
mixin _$MealStatistics {
  String get period => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get totalIntents => throw _privateConstructorUsedError;
  int get totalForecasts => throw _privateConstructorUsedError;
  int get totalOverrides => throw _privateConstructorUsedError;
  double get averageAttendance => throw _privateConstructorUsedError;
  Map<MealType, int> get mealTypeCounts => throw _privateConstructorUsedError;
  Map<MealType, double> get mealTypePercentages =>
      throw _privateConstructorUsedError;
  List<String> get topReasons => throw _privateConstructorUsedError;
  Map<String, int> get dailyAttendance => throw _privateConstructorUsedError;
  Map<String, dynamic>? get trends => throw _privateConstructorUsedError;

  /// Serializes this MealStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealStatisticsCopyWith<MealStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealStatisticsCopyWith<$Res> {
  factory $MealStatisticsCopyWith(
          MealStatistics value, $Res Function(MealStatistics) then) =
      _$MealStatisticsCopyWithImpl<$Res, MealStatistics>;
  @useResult
  $Res call(
      {String period,
      DateTime startDate,
      DateTime endDate,
      int totalIntents,
      int totalForecasts,
      int totalOverrides,
      double averageAttendance,
      Map<MealType, int> mealTypeCounts,
      Map<MealType, double> mealTypePercentages,
      List<String> topReasons,
      Map<String, int> dailyAttendance,
      Map<String, dynamic>? trends});
}

/// @nodoc
class _$MealStatisticsCopyWithImpl<$Res, $Val extends MealStatistics>
    implements $MealStatisticsCopyWith<$Res> {
  _$MealStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalIntents = null,
    Object? totalForecasts = null,
    Object? totalOverrides = null,
    Object? averageAttendance = null,
    Object? mealTypeCounts = null,
    Object? mealTypePercentages = null,
    Object? topReasons = null,
    Object? dailyAttendance = null,
    Object? trends = freezed,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalIntents: null == totalIntents
          ? _value.totalIntents
          : totalIntents // ignore: cast_nullable_to_non_nullable
              as int,
      totalForecasts: null == totalForecasts
          ? _value.totalForecasts
          : totalForecasts // ignore: cast_nullable_to_non_nullable
              as int,
      totalOverrides: null == totalOverrides
          ? _value.totalOverrides
          : totalOverrides // ignore: cast_nullable_to_non_nullable
              as int,
      averageAttendance: null == averageAttendance
          ? _value.averageAttendance
          : averageAttendance // ignore: cast_nullable_to_non_nullable
              as double,
      mealTypeCounts: null == mealTypeCounts
          ? _value.mealTypeCounts
          : mealTypeCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      mealTypePercentages: null == mealTypePercentages
          ? _value.mealTypePercentages
          : mealTypePercentages // ignore: cast_nullable_to_non_nullable
              as Map<MealType, double>,
      topReasons: null == topReasons
          ? _value.topReasons
          : topReasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dailyAttendance: null == dailyAttendance
          ? _value.dailyAttendance
          : dailyAttendance // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      trends: freezed == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealStatisticsImplCopyWith<$Res>
    implements $MealStatisticsCopyWith<$Res> {
  factory _$$MealStatisticsImplCopyWith(_$MealStatisticsImpl value,
          $Res Function(_$MealStatisticsImpl) then) =
      __$$MealStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String period,
      DateTime startDate,
      DateTime endDate,
      int totalIntents,
      int totalForecasts,
      int totalOverrides,
      double averageAttendance,
      Map<MealType, int> mealTypeCounts,
      Map<MealType, double> mealTypePercentages,
      List<String> topReasons,
      Map<String, int> dailyAttendance,
      Map<String, dynamic>? trends});
}

/// @nodoc
class __$$MealStatisticsImplCopyWithImpl<$Res>
    extends _$MealStatisticsCopyWithImpl<$Res, _$MealStatisticsImpl>
    implements _$$MealStatisticsImplCopyWith<$Res> {
  __$$MealStatisticsImplCopyWithImpl(
      _$MealStatisticsImpl _value, $Res Function(_$MealStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalIntents = null,
    Object? totalForecasts = null,
    Object? totalOverrides = null,
    Object? averageAttendance = null,
    Object? mealTypeCounts = null,
    Object? mealTypePercentages = null,
    Object? topReasons = null,
    Object? dailyAttendance = null,
    Object? trends = freezed,
  }) {
    return _then(_$MealStatisticsImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalIntents: null == totalIntents
          ? _value.totalIntents
          : totalIntents // ignore: cast_nullable_to_non_nullable
              as int,
      totalForecasts: null == totalForecasts
          ? _value.totalForecasts
          : totalForecasts // ignore: cast_nullable_to_non_nullable
              as int,
      totalOverrides: null == totalOverrides
          ? _value.totalOverrides
          : totalOverrides // ignore: cast_nullable_to_non_nullable
              as int,
      averageAttendance: null == averageAttendance
          ? _value.averageAttendance
          : averageAttendance // ignore: cast_nullable_to_non_nullable
              as double,
      mealTypeCounts: null == mealTypeCounts
          ? _value._mealTypeCounts
          : mealTypeCounts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      mealTypePercentages: null == mealTypePercentages
          ? _value._mealTypePercentages
          : mealTypePercentages // ignore: cast_nullable_to_non_nullable
              as Map<MealType, double>,
      topReasons: null == topReasons
          ? _value._topReasons
          : topReasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dailyAttendance: null == dailyAttendance
          ? _value._dailyAttendance
          : dailyAttendance // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      trends: freezed == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealStatisticsImpl implements _MealStatistics {
  const _$MealStatisticsImpl(
      {required this.period,
      required this.startDate,
      required this.endDate,
      required this.totalIntents,
      required this.totalForecasts,
      required this.totalOverrides,
      required this.averageAttendance,
      required final Map<MealType, int> mealTypeCounts,
      required final Map<MealType, double> mealTypePercentages,
      required final List<String> topReasons,
      required final Map<String, int> dailyAttendance,
      final Map<String, dynamic>? trends})
      : _mealTypeCounts = mealTypeCounts,
        _mealTypePercentages = mealTypePercentages,
        _topReasons = topReasons,
        _dailyAttendance = dailyAttendance,
        _trends = trends;

  factory _$MealStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealStatisticsImplFromJson(json);

  @override
  final String period;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int totalIntents;
  @override
  final int totalForecasts;
  @override
  final int totalOverrides;
  @override
  final double averageAttendance;
  final Map<MealType, int> _mealTypeCounts;
  @override
  Map<MealType, int> get mealTypeCounts {
    if (_mealTypeCounts is EqualUnmodifiableMapView) return _mealTypeCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mealTypeCounts);
  }

  final Map<MealType, double> _mealTypePercentages;
  @override
  Map<MealType, double> get mealTypePercentages {
    if (_mealTypePercentages is EqualUnmodifiableMapView)
      return _mealTypePercentages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mealTypePercentages);
  }

  final List<String> _topReasons;
  @override
  List<String> get topReasons {
    if (_topReasons is EqualUnmodifiableListView) return _topReasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topReasons);
  }

  final Map<String, int> _dailyAttendance;
  @override
  Map<String, int> get dailyAttendance {
    if (_dailyAttendance is EqualUnmodifiableMapView) return _dailyAttendance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dailyAttendance);
  }

  final Map<String, dynamic>? _trends;
  @override
  Map<String, dynamic>? get trends {
    final value = _trends;
    if (value == null) return null;
    if (_trends is EqualUnmodifiableMapView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MealStatistics(period: $period, startDate: $startDate, endDate: $endDate, totalIntents: $totalIntents, totalForecasts: $totalForecasts, totalOverrides: $totalOverrides, averageAttendance: $averageAttendance, mealTypeCounts: $mealTypeCounts, mealTypePercentages: $mealTypePercentages, topReasons: $topReasons, dailyAttendance: $dailyAttendance, trends: $trends)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealStatisticsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalIntents, totalIntents) ||
                other.totalIntents == totalIntents) &&
            (identical(other.totalForecasts, totalForecasts) ||
                other.totalForecasts == totalForecasts) &&
            (identical(other.totalOverrides, totalOverrides) ||
                other.totalOverrides == totalOverrides) &&
            (identical(other.averageAttendance, averageAttendance) ||
                other.averageAttendance == averageAttendance) &&
            const DeepCollectionEquality()
                .equals(other._mealTypeCounts, _mealTypeCounts) &&
            const DeepCollectionEquality()
                .equals(other._mealTypePercentages, _mealTypePercentages) &&
            const DeepCollectionEquality()
                .equals(other._topReasons, _topReasons) &&
            const DeepCollectionEquality()
                .equals(other._dailyAttendance, _dailyAttendance) &&
            const DeepCollectionEquality().equals(other._trends, _trends));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      period,
      startDate,
      endDate,
      totalIntents,
      totalForecasts,
      totalOverrides,
      averageAttendance,
      const DeepCollectionEquality().hash(_mealTypeCounts),
      const DeepCollectionEquality().hash(_mealTypePercentages),
      const DeepCollectionEquality().hash(_topReasons),
      const DeepCollectionEquality().hash(_dailyAttendance),
      const DeepCollectionEquality().hash(_trends));

  /// Create a copy of MealStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealStatisticsImplCopyWith<_$MealStatisticsImpl> get copyWith =>
      __$$MealStatisticsImplCopyWithImpl<_$MealStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealStatisticsImplToJson(
      this,
    );
  }
}

abstract class _MealStatistics implements MealStatistics {
  const factory _MealStatistics(
      {required final String period,
      required final DateTime startDate,
      required final DateTime endDate,
      required final int totalIntents,
      required final int totalForecasts,
      required final int totalOverrides,
      required final double averageAttendance,
      required final Map<MealType, int> mealTypeCounts,
      required final Map<MealType, double> mealTypePercentages,
      required final List<String> topReasons,
      required final Map<String, int> dailyAttendance,
      final Map<String, dynamic>? trends}) = _$MealStatisticsImpl;

  factory _MealStatistics.fromJson(Map<String, dynamic> json) =
      _$MealStatisticsImpl.fromJson;

  @override
  String get period;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get totalIntents;
  @override
  int get totalForecasts;
  @override
  int get totalOverrides;
  @override
  double get averageAttendance;
  @override
  Map<MealType, int> get mealTypeCounts;
  @override
  Map<MealType, double> get mealTypePercentages;
  @override
  List<String> get topReasons;
  @override
  Map<String, int> get dailyAttendance;
  @override
  Map<String, dynamic>? get trends;

  /// Create a copy of MealStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealStatisticsImplCopyWith<_$MealStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealDashboardData _$MealDashboardDataFromJson(Map<String, dynamic> json) {
  return _MealDashboardData.fromJson(json);
}

/// @nodoc
mixin _$MealDashboardData {
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  Map<MealType, int> get todayIntents => throw _privateConstructorUsedError;
  Map<MealType, int> get todayForecasts => throw _privateConstructorUsedError;
  Map<MealType, int> get todayOverrides => throw _privateConstructorUsedError;
  Map<MealType, bool> get cutoffStatus => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;
  int get studentsWithIntents => throw _privateConstructorUsedError;
  List<MealIntent> get recentIntents => throw _privateConstructorUsedError;
  List<MealOverride> get recentOverrides => throw _privateConstructorUsedError;
  Map<String, dynamic> get hourlyStats => throw _privateConstructorUsedError;

  /// Serializes this MealDashboardData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealDashboardDataCopyWith<MealDashboardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealDashboardDataCopyWith<$Res> {
  factory $MealDashboardDataCopyWith(
          MealDashboardData value, $Res Function(MealDashboardData) then) =
      _$MealDashboardDataCopyWithImpl<$Res, MealDashboardData>;
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      Map<MealType, int> todayIntents,
      Map<MealType, int> todayForecasts,
      Map<MealType, int> todayOverrides,
      Map<MealType, bool> cutoffStatus,
      int totalStudents,
      int studentsWithIntents,
      List<MealIntent> recentIntents,
      List<MealOverride> recentOverrides,
      Map<String, dynamic> hourlyStats});
}

/// @nodoc
class _$MealDashboardDataCopyWithImpl<$Res, $Val extends MealDashboardData>
    implements $MealDashboardDataCopyWith<$Res> {
  _$MealDashboardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? todayIntents = null,
    Object? todayForecasts = null,
    Object? todayOverrides = null,
    Object? cutoffStatus = null,
    Object? totalStudents = null,
    Object? studentsWithIntents = null,
    Object? recentIntents = null,
    Object? recentOverrides = null,
    Object? hourlyStats = null,
  }) {
    return _then(_value.copyWith(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      todayIntents: null == todayIntents
          ? _value.todayIntents
          : todayIntents // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      todayForecasts: null == todayForecasts
          ? _value.todayForecasts
          : todayForecasts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      todayOverrides: null == todayOverrides
          ? _value.todayOverrides
          : todayOverrides // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      cutoffStatus: null == cutoffStatus
          ? _value.cutoffStatus
          : cutoffStatus // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      studentsWithIntents: null == studentsWithIntents
          ? _value.studentsWithIntents
          : studentsWithIntents // ignore: cast_nullable_to_non_nullable
              as int,
      recentIntents: null == recentIntents
          ? _value.recentIntents
          : recentIntents // ignore: cast_nullable_to_non_nullable
              as List<MealIntent>,
      recentOverrides: null == recentOverrides
          ? _value.recentOverrides
          : recentOverrides // ignore: cast_nullable_to_non_nullable
              as List<MealOverride>,
      hourlyStats: null == hourlyStats
          ? _value.hourlyStats
          : hourlyStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealDashboardDataImplCopyWith<$Res>
    implements $MealDashboardDataCopyWith<$Res> {
  factory _$$MealDashboardDataImplCopyWith(_$MealDashboardDataImpl value,
          $Res Function(_$MealDashboardDataImpl) then) =
      __$$MealDashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      Map<MealType, int> todayIntents,
      Map<MealType, int> todayForecasts,
      Map<MealType, int> todayOverrides,
      Map<MealType, bool> cutoffStatus,
      int totalStudents,
      int studentsWithIntents,
      List<MealIntent> recentIntents,
      List<MealOverride> recentOverrides,
      Map<String, dynamic> hourlyStats});
}

/// @nodoc
class __$$MealDashboardDataImplCopyWithImpl<$Res>
    extends _$MealDashboardDataCopyWithImpl<$Res, _$MealDashboardDataImpl>
    implements _$$MealDashboardDataImplCopyWith<$Res> {
  __$$MealDashboardDataImplCopyWithImpl(_$MealDashboardDataImpl _value,
      $Res Function(_$MealDashboardDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? todayIntents = null,
    Object? todayForecasts = null,
    Object? todayOverrides = null,
    Object? cutoffStatus = null,
    Object? totalStudents = null,
    Object? studentsWithIntents = null,
    Object? recentIntents = null,
    Object? recentOverrides = null,
    Object? hourlyStats = null,
  }) {
    return _then(_$MealDashboardDataImpl(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      todayIntents: null == todayIntents
          ? _value._todayIntents
          : todayIntents // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      todayForecasts: null == todayForecasts
          ? _value._todayForecasts
          : todayForecasts // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      todayOverrides: null == todayOverrides
          ? _value._todayOverrides
          : todayOverrides // ignore: cast_nullable_to_non_nullable
              as Map<MealType, int>,
      cutoffStatus: null == cutoffStatus
          ? _value._cutoffStatus
          : cutoffStatus // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      studentsWithIntents: null == studentsWithIntents
          ? _value.studentsWithIntents
          : studentsWithIntents // ignore: cast_nullable_to_non_nullable
              as int,
      recentIntents: null == recentIntents
          ? _value._recentIntents
          : recentIntents // ignore: cast_nullable_to_non_nullable
              as List<MealIntent>,
      recentOverrides: null == recentOverrides
          ? _value._recentOverrides
          : recentOverrides // ignore: cast_nullable_to_non_nullable
              as List<MealOverride>,
      hourlyStats: null == hourlyStats
          ? _value._hourlyStats
          : hourlyStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealDashboardDataImpl implements _MealDashboardData {
  const _$MealDashboardDataImpl(
      {required this.hostelId,
      required this.date,
      required final Map<MealType, int> todayIntents,
      required final Map<MealType, int> todayForecasts,
      required final Map<MealType, int> todayOverrides,
      required final Map<MealType, bool> cutoffStatus,
      required this.totalStudents,
      required this.studentsWithIntents,
      required final List<MealIntent> recentIntents,
      required final List<MealOverride> recentOverrides,
      required final Map<String, dynamic> hourlyStats})
      : _todayIntents = todayIntents,
        _todayForecasts = todayForecasts,
        _todayOverrides = todayOverrides,
        _cutoffStatus = cutoffStatus,
        _recentIntents = recentIntents,
        _recentOverrides = recentOverrides,
        _hourlyStats = hourlyStats;

  factory _$MealDashboardDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealDashboardDataImplFromJson(json);

  @override
  final String hostelId;
  @override
  final DateTime date;
  final Map<MealType, int> _todayIntents;
  @override
  Map<MealType, int> get todayIntents {
    if (_todayIntents is EqualUnmodifiableMapView) return _todayIntents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_todayIntents);
  }

  final Map<MealType, int> _todayForecasts;
  @override
  Map<MealType, int> get todayForecasts {
    if (_todayForecasts is EqualUnmodifiableMapView) return _todayForecasts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_todayForecasts);
  }

  final Map<MealType, int> _todayOverrides;
  @override
  Map<MealType, int> get todayOverrides {
    if (_todayOverrides is EqualUnmodifiableMapView) return _todayOverrides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_todayOverrides);
  }

  final Map<MealType, bool> _cutoffStatus;
  @override
  Map<MealType, bool> get cutoffStatus {
    if (_cutoffStatus is EqualUnmodifiableMapView) return _cutoffStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cutoffStatus);
  }

  @override
  final int totalStudents;
  @override
  final int studentsWithIntents;
  final List<MealIntent> _recentIntents;
  @override
  List<MealIntent> get recentIntents {
    if (_recentIntents is EqualUnmodifiableListView) return _recentIntents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentIntents);
  }

  final List<MealOverride> _recentOverrides;
  @override
  List<MealOverride> get recentOverrides {
    if (_recentOverrides is EqualUnmodifiableListView) return _recentOverrides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentOverrides);
  }

  final Map<String, dynamic> _hourlyStats;
  @override
  Map<String, dynamic> get hourlyStats {
    if (_hourlyStats is EqualUnmodifiableMapView) return _hourlyStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hourlyStats);
  }

  @override
  String toString() {
    return 'MealDashboardData(hostelId: $hostelId, date: $date, todayIntents: $todayIntents, todayForecasts: $todayForecasts, todayOverrides: $todayOverrides, cutoffStatus: $cutoffStatus, totalStudents: $totalStudents, studentsWithIntents: $studentsWithIntents, recentIntents: $recentIntents, recentOverrides: $recentOverrides, hourlyStats: $hourlyStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealDashboardDataImpl &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality()
                .equals(other._todayIntents, _todayIntents) &&
            const DeepCollectionEquality()
                .equals(other._todayForecasts, _todayForecasts) &&
            const DeepCollectionEquality()
                .equals(other._todayOverrides, _todayOverrides) &&
            const DeepCollectionEquality()
                .equals(other._cutoffStatus, _cutoffStatus) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.studentsWithIntents, studentsWithIntents) ||
                other.studentsWithIntents == studentsWithIntents) &&
            const DeepCollectionEquality()
                .equals(other._recentIntents, _recentIntents) &&
            const DeepCollectionEquality()
                .equals(other._recentOverrides, _recentOverrides) &&
            const DeepCollectionEquality()
                .equals(other._hourlyStats, _hourlyStats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hostelId,
      date,
      const DeepCollectionEquality().hash(_todayIntents),
      const DeepCollectionEquality().hash(_todayForecasts),
      const DeepCollectionEquality().hash(_todayOverrides),
      const DeepCollectionEquality().hash(_cutoffStatus),
      totalStudents,
      studentsWithIntents,
      const DeepCollectionEquality().hash(_recentIntents),
      const DeepCollectionEquality().hash(_recentOverrides),
      const DeepCollectionEquality().hash(_hourlyStats));

  /// Create a copy of MealDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealDashboardDataImplCopyWith<_$MealDashboardDataImpl> get copyWith =>
      __$$MealDashboardDataImplCopyWithImpl<_$MealDashboardDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealDashboardDataImplToJson(
      this,
    );
  }
}

abstract class _MealDashboardData implements MealDashboardData {
  const factory _MealDashboardData(
          {required final String hostelId,
          required final DateTime date,
          required final Map<MealType, int> todayIntents,
          required final Map<MealType, int> todayForecasts,
          required final Map<MealType, int> todayOverrides,
          required final Map<MealType, bool> cutoffStatus,
          required final int totalStudents,
          required final int studentsWithIntents,
          required final List<MealIntent> recentIntents,
          required final List<MealOverride> recentOverrides,
          required final Map<String, dynamic> hourlyStats}) =
      _$MealDashboardDataImpl;

  factory _MealDashboardData.fromJson(Map<String, dynamic> json) =
      _$MealDashboardDataImpl.fromJson;

  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  Map<MealType, int> get todayIntents;
  @override
  Map<MealType, int> get todayForecasts;
  @override
  Map<MealType, int> get todayOverrides;
  @override
  Map<MealType, bool> get cutoffStatus;
  @override
  int get totalStudents;
  @override
  int get studentsWithIntents;
  @override
  List<MealIntent> get recentIntents;
  @override
  List<MealOverride> get recentOverrides;
  @override
  Map<String, dynamic> get hourlyStats;

  /// Create a copy of MealDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealDashboardDataImplCopyWith<_$MealDashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealExportRequest _$MealExportRequestFromJson(Map<String, dynamic> json) {
  return _MealExportRequest.fromJson(json);
}

/// @nodoc
mixin _$MealExportRequest {
  String get hostelId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  List<MealType> get mealTypes => throw _privateConstructorUsedError;
  bool? get includeForecasts => throw _privateConstructorUsedError;
  bool? get includeOverrides => throw _privateConstructorUsedError;
  bool? get includeIntents => throw _privateConstructorUsedError;

  /// Serializes this MealExportRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealExportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealExportRequestCopyWith<MealExportRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealExportRequestCopyWith<$Res> {
  factory $MealExportRequestCopyWith(
          MealExportRequest value, $Res Function(MealExportRequest) then) =
      _$MealExportRequestCopyWithImpl<$Res, MealExportRequest>;
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      String format,
      List<MealType> mealTypes,
      bool? includeForecasts,
      bool? includeOverrides,
      bool? includeIntents});
}

/// @nodoc
class _$MealExportRequestCopyWithImpl<$Res, $Val extends MealExportRequest>
    implements $MealExportRequestCopyWith<$Res> {
  _$MealExportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealExportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? format = null,
    Object? mealTypes = null,
    Object? includeForecasts = freezed,
    Object? includeOverrides = freezed,
    Object? includeIntents = freezed,
  }) {
    return _then(_value.copyWith(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      mealTypes: null == mealTypes
          ? _value.mealTypes
          : mealTypes // ignore: cast_nullable_to_non_nullable
              as List<MealType>,
      includeForecasts: freezed == includeForecasts
          ? _value.includeForecasts
          : includeForecasts // ignore: cast_nullable_to_non_nullable
              as bool?,
      includeOverrides: freezed == includeOverrides
          ? _value.includeOverrides
          : includeOverrides // ignore: cast_nullable_to_non_nullable
              as bool?,
      includeIntents: freezed == includeIntents
          ? _value.includeIntents
          : includeIntents // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealExportRequestImplCopyWith<$Res>
    implements $MealExportRequestCopyWith<$Res> {
  factory _$$MealExportRequestImplCopyWith(_$MealExportRequestImpl value,
          $Res Function(_$MealExportRequestImpl) then) =
      __$$MealExportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String hostelId,
      DateTime date,
      String format,
      List<MealType> mealTypes,
      bool? includeForecasts,
      bool? includeOverrides,
      bool? includeIntents});
}

/// @nodoc
class __$$MealExportRequestImplCopyWithImpl<$Res>
    extends _$MealExportRequestCopyWithImpl<$Res, _$MealExportRequestImpl>
    implements _$$MealExportRequestImplCopyWith<$Res> {
  __$$MealExportRequestImplCopyWithImpl(_$MealExportRequestImpl _value,
      $Res Function(_$MealExportRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealExportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostelId = null,
    Object? date = null,
    Object? format = null,
    Object? mealTypes = null,
    Object? includeForecasts = freezed,
    Object? includeOverrides = freezed,
    Object? includeIntents = freezed,
  }) {
    return _then(_$MealExportRequestImpl(
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      mealTypes: null == mealTypes
          ? _value._mealTypes
          : mealTypes // ignore: cast_nullable_to_non_nullable
              as List<MealType>,
      includeForecasts: freezed == includeForecasts
          ? _value.includeForecasts
          : includeForecasts // ignore: cast_nullable_to_non_nullable
              as bool?,
      includeOverrides: freezed == includeOverrides
          ? _value.includeOverrides
          : includeOverrides // ignore: cast_nullable_to_non_nullable
              as bool?,
      includeIntents: freezed == includeIntents
          ? _value.includeIntents
          : includeIntents // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealExportRequestImpl implements _MealExportRequest {
  const _$MealExportRequestImpl(
      {required this.hostelId,
      required this.date,
      required this.format,
      required final List<MealType> mealTypes,
      this.includeForecasts,
      this.includeOverrides,
      this.includeIntents})
      : _mealTypes = mealTypes;

  factory _$MealExportRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealExportRequestImplFromJson(json);

  @override
  final String hostelId;
  @override
  final DateTime date;
  @override
  final String format;
  final List<MealType> _mealTypes;
  @override
  List<MealType> get mealTypes {
    if (_mealTypes is EqualUnmodifiableListView) return _mealTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mealTypes);
  }

  @override
  final bool? includeForecasts;
  @override
  final bool? includeOverrides;
  @override
  final bool? includeIntents;

  @override
  String toString() {
    return 'MealExportRequest(hostelId: $hostelId, date: $date, format: $format, mealTypes: $mealTypes, includeForecasts: $includeForecasts, includeOverrides: $includeOverrides, includeIntents: $includeIntents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealExportRequestImpl &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.format, format) || other.format == format) &&
            const DeepCollectionEquality()
                .equals(other._mealTypes, _mealTypes) &&
            (identical(other.includeForecasts, includeForecasts) ||
                other.includeForecasts == includeForecasts) &&
            (identical(other.includeOverrides, includeOverrides) ||
                other.includeOverrides == includeOverrides) &&
            (identical(other.includeIntents, includeIntents) ||
                other.includeIntents == includeIntents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hostelId,
      date,
      format,
      const DeepCollectionEquality().hash(_mealTypes),
      includeForecasts,
      includeOverrides,
      includeIntents);

  /// Create a copy of MealExportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealExportRequestImplCopyWith<_$MealExportRequestImpl> get copyWith =>
      __$$MealExportRequestImplCopyWithImpl<_$MealExportRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealExportRequestImplToJson(
      this,
    );
  }
}

abstract class _MealExportRequest implements MealExportRequest {
  const factory _MealExportRequest(
      {required final String hostelId,
      required final DateTime date,
      required final String format,
      required final List<MealType> mealTypes,
      final bool? includeForecasts,
      final bool? includeOverrides,
      final bool? includeIntents}) = _$MealExportRequestImpl;

  factory _MealExportRequest.fromJson(Map<String, dynamic> json) =
      _$MealExportRequestImpl.fromJson;

  @override
  String get hostelId;
  @override
  DateTime get date;
  @override
  String get format;
  @override
  List<MealType> get mealTypes;
  @override
  bool? get includeForecasts;
  @override
  bool? get includeOverrides;
  @override
  bool? get includeIntents;

  /// Create a copy of MealExportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealExportRequestImplCopyWith<_$MealExportRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealTemplate _$MealTemplateFromJson(Map<String, dynamic> json) {
  return _MealTemplate.fromJson(json);
}

/// @nodoc
mixin _$MealTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<MealType, bool> get defaultIntents => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MealTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealTemplateCopyWith<MealTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealTemplateCopyWith<$Res> {
  factory $MealTemplateCopyWith(
          MealTemplate value, $Res Function(MealTemplate) then) =
      _$MealTemplateCopyWithImpl<$Res, MealTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Map<MealType, bool> defaultIntents,
      List<String> tags,
      bool isPublic,
      String createdBy,
      DateTime? createdAt});
}

/// @nodoc
class _$MealTemplateCopyWithImpl<$Res, $Val extends MealTemplate>
    implements $MealTemplateCopyWith<$Res> {
  _$MealTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? defaultIntents = null,
    Object? tags = null,
    Object? isPublic = null,
    Object? createdBy = null,
    Object? createdAt = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      defaultIntents: null == defaultIntents
          ? _value.defaultIntents
          : defaultIntents // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealTemplateImplCopyWith<$Res>
    implements $MealTemplateCopyWith<$Res> {
  factory _$$MealTemplateImplCopyWith(
          _$MealTemplateImpl value, $Res Function(_$MealTemplateImpl) then) =
      __$$MealTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Map<MealType, bool> defaultIntents,
      List<String> tags,
      bool isPublic,
      String createdBy,
      DateTime? createdAt});
}

/// @nodoc
class __$$MealTemplateImplCopyWithImpl<$Res>
    extends _$MealTemplateCopyWithImpl<$Res, _$MealTemplateImpl>
    implements _$$MealTemplateImplCopyWith<$Res> {
  __$$MealTemplateImplCopyWithImpl(
      _$MealTemplateImpl _value, $Res Function(_$MealTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? defaultIntents = null,
    Object? tags = null,
    Object? isPublic = null,
    Object? createdBy = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$MealTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      defaultIntents: null == defaultIntents
          ? _value._defaultIntents
          : defaultIntents // ignore: cast_nullable_to_non_nullable
              as Map<MealType, bool>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealTemplateImpl implements _MealTemplate {
  const _$MealTemplateImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final Map<MealType, bool> defaultIntents,
      required final List<String> tags,
      required this.isPublic,
      required this.createdBy,
      this.createdAt})
      : _defaultIntents = defaultIntents,
        _tags = tags;

  factory _$MealTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final Map<MealType, bool> _defaultIntents;
  @override
  Map<MealType, bool> get defaultIntents {
    if (_defaultIntents is EqualUnmodifiableMapView) return _defaultIntents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_defaultIntents);
  }

  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final bool isPublic;
  @override
  final String createdBy;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MealTemplate(id: $id, name: $name, description: $description, defaultIntents: $defaultIntents, tags: $tags, isPublic: $isPublic, createdBy: $createdBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._defaultIntents, _defaultIntents) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_defaultIntents),
      const DeepCollectionEquality().hash(_tags),
      isPublic,
      createdBy,
      createdAt);

  /// Create a copy of MealTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealTemplateImplCopyWith<_$MealTemplateImpl> get copyWith =>
      __$$MealTemplateImplCopyWithImpl<_$MealTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealTemplateImplToJson(
      this,
    );
  }
}

abstract class _MealTemplate implements MealTemplate {
  const factory _MealTemplate(
      {required final String id,
      required final String name,
      required final String description,
      required final Map<MealType, bool> defaultIntents,
      required final List<String> tags,
      required final bool isPublic,
      required final String createdBy,
      final DateTime? createdAt}) = _$MealTemplateImpl;

  factory _MealTemplate.fromJson(Map<String, dynamic> json) =
      _$MealTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  Map<MealType, bool> get defaultIntents;
  @override
  List<String> get tags;
  @override
  bool get isPublic;
  @override
  String get createdBy;
  @override
  DateTime? get createdAt;

  /// Create a copy of MealTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealTemplateImplCopyWith<_$MealTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
