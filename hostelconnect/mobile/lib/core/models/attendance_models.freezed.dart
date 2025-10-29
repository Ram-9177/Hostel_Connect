// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) {
  return _AttendanceRecord.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRecord {
  String get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  AttendanceSessionType get session => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  AttendanceStatus get status => throw _privateConstructorUsedError;
  DateTime get recordedAt => throw _privateConstructorUsedError;
  String? get recordedBy => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  bool get isAdjusted => throw _privateConstructorUsedError;
  DateTime? get adjustedAt => throw _privateConstructorUsedError;
  String? get adjustedBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Student? get student => throw _privateConstructorUsedError;

  /// Serializes this AttendanceRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceRecordCopyWith<AttendanceRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRecordCopyWith<$Res> {
  factory $AttendanceRecordCopyWith(
          AttendanceRecord value, $Res Function(AttendanceRecord) then) =
      _$AttendanceRecordCopyWithImpl<$Res, AttendanceRecord>;
  @useResult
  $Res call(
      {String id,
      String studentId,
      String sessionId,
      AttendanceSessionType session,
      DateTime date,
      AttendanceStatus status,
      DateTime recordedAt,
      String? recordedBy,
      String? reason,
      String? photoUrl,
      bool isAdjusted,
      DateTime? adjustedAt,
      String? adjustedBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      Student? student});

  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class _$AttendanceRecordCopyWithImpl<$Res, $Val extends AttendanceRecord>
    implements $AttendanceRecordCopyWith<$Res> {
  _$AttendanceRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? sessionId = null,
    Object? session = null,
    Object? date = null,
    Object? status = null,
    Object? recordedAt = null,
    Object? recordedBy = freezed,
    Object? reason = freezed,
    Object? photoUrl = freezed,
    Object? isAdjusted = null,
    Object? adjustedAt = freezed,
    Object? adjustedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? student = freezed,
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
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as AttendanceSessionType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AttendanceStatus,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recordedBy: freezed == recordedBy
          ? _value.recordedBy
          : recordedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdjusted: null == isAdjusted
          ? _value.isAdjusted
          : isAdjusted // ignore: cast_nullable_to_non_nullable
              as bool,
      adjustedAt: freezed == adjustedAt
          ? _value.adjustedAt
          : adjustedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adjustedBy: freezed == adjustedBy
          ? _value.adjustedBy
          : adjustedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      student: freezed == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student?,
    ) as $Val);
  }

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudentCopyWith<$Res>? get student {
    if (_value.student == null) {
      return null;
    }

    return $StudentCopyWith<$Res>(_value.student!, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttendanceRecordImplCopyWith<$Res>
    implements $AttendanceRecordCopyWith<$Res> {
  factory _$$AttendanceRecordImplCopyWith(_$AttendanceRecordImpl value,
          $Res Function(_$AttendanceRecordImpl) then) =
      __$$AttendanceRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String studentId,
      String sessionId,
      AttendanceSessionType session,
      DateTime date,
      AttendanceStatus status,
      DateTime recordedAt,
      String? recordedBy,
      String? reason,
      String? photoUrl,
      bool isAdjusted,
      DateTime? adjustedAt,
      String? adjustedBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      Student? student});

  @override
  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class __$$AttendanceRecordImplCopyWithImpl<$Res>
    extends _$AttendanceRecordCopyWithImpl<$Res, _$AttendanceRecordImpl>
    implements _$$AttendanceRecordImplCopyWith<$Res> {
  __$$AttendanceRecordImplCopyWithImpl(_$AttendanceRecordImpl _value,
      $Res Function(_$AttendanceRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? sessionId = null,
    Object? session = null,
    Object? date = null,
    Object? status = null,
    Object? recordedAt = null,
    Object? recordedBy = freezed,
    Object? reason = freezed,
    Object? photoUrl = freezed,
    Object? isAdjusted = null,
    Object? adjustedAt = freezed,
    Object? adjustedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? student = freezed,
  }) {
    return _then(_$AttendanceRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as AttendanceSessionType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AttendanceStatus,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recordedBy: freezed == recordedBy
          ? _value.recordedBy
          : recordedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdjusted: null == isAdjusted
          ? _value.isAdjusted
          : isAdjusted // ignore: cast_nullable_to_non_nullable
              as bool,
      adjustedAt: freezed == adjustedAt
          ? _value.adjustedAt
          : adjustedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adjustedBy: freezed == adjustedBy
          ? _value.adjustedBy
          : adjustedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      student: freezed == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceRecordImpl implements _AttendanceRecord {
  const _$AttendanceRecordImpl(
      {required this.id,
      required this.studentId,
      required this.sessionId,
      required this.session,
      required this.date,
      required this.status,
      required this.recordedAt,
      this.recordedBy,
      this.reason,
      this.photoUrl,
      this.isAdjusted = false,
      this.adjustedAt,
      this.adjustedBy,
      this.createdAt,
      this.updatedAt,
      this.student});

  factory _$AttendanceRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String studentId;
  @override
  final String sessionId;
  @override
  final AttendanceSessionType session;
  @override
  final DateTime date;
  @override
  final AttendanceStatus status;
  @override
  final DateTime recordedAt;
  @override
  final String? recordedBy;
  @override
  final String? reason;
  @override
  final String? photoUrl;
  @override
  @JsonKey()
  final bool isAdjusted;
  @override
  final DateTime? adjustedAt;
  @override
  final String? adjustedBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final Student? student;

  @override
  String toString() {
    return 'AttendanceRecord(id: $id, studentId: $studentId, sessionId: $sessionId, session: $session, date: $date, status: $status, recordedAt: $recordedAt, recordedBy: $recordedBy, reason: $reason, photoUrl: $photoUrl, isAdjusted: $isAdjusted, adjustedAt: $adjustedAt, adjustedBy: $adjustedBy, createdAt: $createdAt, updatedAt: $updatedAt, student: $student)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.recordedBy, recordedBy) ||
                other.recordedBy == recordedBy) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.isAdjusted, isAdjusted) ||
                other.isAdjusted == isAdjusted) &&
            (identical(other.adjustedAt, adjustedAt) ||
                other.adjustedAt == adjustedAt) &&
            (identical(other.adjustedBy, adjustedBy) ||
                other.adjustedBy == adjustedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.student, student) || other.student == student));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studentId,
      sessionId,
      session,
      date,
      status,
      recordedAt,
      recordedBy,
      reason,
      photoUrl,
      isAdjusted,
      adjustedAt,
      adjustedBy,
      createdAt,
      updatedAt,
      student);

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRecordImplCopyWith<_$AttendanceRecordImpl> get copyWith =>
      __$$AttendanceRecordImplCopyWithImpl<_$AttendanceRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRecordImplToJson(
      this,
    );
  }
}

abstract class _AttendanceRecord implements AttendanceRecord {
  const factory _AttendanceRecord(
      {required final String id,
      required final String studentId,
      required final String sessionId,
      required final AttendanceSessionType session,
      required final DateTime date,
      required final AttendanceStatus status,
      required final DateTime recordedAt,
      final String? recordedBy,
      final String? reason,
      final String? photoUrl,
      final bool isAdjusted,
      final DateTime? adjustedAt,
      final String? adjustedBy,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final Student? student}) = _$AttendanceRecordImpl;

  factory _AttendanceRecord.fromJson(Map<String, dynamic> json) =
      _$AttendanceRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get studentId;
  @override
  String get sessionId;
  @override
  AttendanceSessionType get session;
  @override
  DateTime get date;
  @override
  AttendanceStatus get status;
  @override
  DateTime get recordedAt;
  @override
  String? get recordedBy;
  @override
  String? get reason;
  @override
  String? get photoUrl;
  @override
  bool get isAdjusted;
  @override
  DateTime? get adjustedAt;
  @override
  String? get adjustedBy;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  Student? get student;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceRecordImplCopyWith<_$AttendanceRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceSession _$AttendanceSessionFromJson(Map<String, dynamic> json) {
  return _AttendanceSession.fromJson(json);
}

/// @nodoc
mixin _$AttendanceSession {
  String get id => throw _privateConstructorUsedError;
  AttendanceSessionType get session => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  AttendanceMode get mode => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AttendanceSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceSessionCopyWith<AttendanceSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceSessionCopyWith<$Res> {
  factory $AttendanceSessionCopyWith(
          AttendanceSession value, $Res Function(AttendanceSession) then) =
      _$AttendanceSessionCopyWithImpl<$Res, AttendanceSession>;
  @useResult
  $Res call(
      {String id,
      AttendanceSessionType session,
      DateTime date,
      AttendanceMode mode,
      DateTime startTime,
      DateTime endTime,
      bool isActive,
      String? createdBy,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$AttendanceSessionCopyWithImpl<$Res, $Val extends AttendanceSession>
    implements $AttendanceSessionCopyWith<$Res> {
  _$AttendanceSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? session = null,
    Object? date = null,
    Object? mode = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isActive = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as AttendanceSessionType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AttendanceMode,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$AttendanceSessionImplCopyWith<$Res>
    implements $AttendanceSessionCopyWith<$Res> {
  factory _$$AttendanceSessionImplCopyWith(_$AttendanceSessionImpl value,
          $Res Function(_$AttendanceSessionImpl) then) =
      __$$AttendanceSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      AttendanceSessionType session,
      DateTime date,
      AttendanceMode mode,
      DateTime startTime,
      DateTime endTime,
      bool isActive,
      String? createdBy,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$AttendanceSessionImplCopyWithImpl<$Res>
    extends _$AttendanceSessionCopyWithImpl<$Res, _$AttendanceSessionImpl>
    implements _$$AttendanceSessionImplCopyWith<$Res> {
  __$$AttendanceSessionImplCopyWithImpl(_$AttendanceSessionImpl _value,
      $Res Function(_$AttendanceSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? session = null,
    Object? date = null,
    Object? mode = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isActive = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AttendanceSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as AttendanceSessionType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AttendanceMode,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$AttendanceSessionImpl implements _AttendanceSession {
  const _$AttendanceSessionImpl(
      {required this.id,
      required this.session,
      required this.date,
      required this.mode,
      required this.startTime,
      required this.endTime,
      this.isActive = false,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  factory _$AttendanceSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceSessionImplFromJson(json);

  @override
  final String id;
  @override
  final AttendanceSessionType session;
  @override
  final DateTime date;
  @override
  final AttendanceMode mode;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AttendanceSession(id: $id, session: $session, date: $date, mode: $mode, startTime: $startTime, endTime: $endTime, isActive: $isActive, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, session, date, mode,
      startTime, endTime, isActive, createdBy, createdAt, updatedAt);

  /// Create a copy of AttendanceSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceSessionImplCopyWith<_$AttendanceSessionImpl> get copyWith =>
      __$$AttendanceSessionImplCopyWithImpl<_$AttendanceSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceSessionImplToJson(
      this,
    );
  }
}

abstract class _AttendanceSession implements AttendanceSession {
  const factory _AttendanceSession(
      {required final String id,
      required final AttendanceSessionType session,
      required final DateTime date,
      required final AttendanceMode mode,
      required final DateTime startTime,
      required final DateTime endTime,
      final bool isActive,
      final String? createdBy,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$AttendanceSessionImpl;

  factory _AttendanceSession.fromJson(Map<String, dynamic> json) =
      _$AttendanceSessionImpl.fromJson;

  @override
  String get id;
  @override
  AttendanceSessionType get session;
  @override
  DateTime get date;
  @override
  AttendanceMode get mode;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  bool get isActive;
  @override
  String? get createdBy;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of AttendanceSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceSessionImplCopyWith<_$AttendanceSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceSummary _$AttendanceSummaryFromJson(Map<String, dynamic> json) {
  return _AttendanceSummary.fromJson(json);
}

/// @nodoc
mixin _$AttendanceSummary {
  String get studentId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get totalSessions => throw _privateConstructorUsedError;
  int get presentCount => throw _privateConstructorUsedError;
  int get absentCount => throw _privateConstructorUsedError;
  int get lateCount => throw _privateConstructorUsedError;
  int get excusedCount => throw _privateConstructorUsedError;
  double get attendancePercentage => throw _privateConstructorUsedError;
  List<AttendanceRecord> get records => throw _privateConstructorUsedError;

  /// Serializes this AttendanceSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceSummaryCopyWith<AttendanceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceSummaryCopyWith<$Res> {
  factory $AttendanceSummaryCopyWith(
          AttendanceSummary value, $Res Function(AttendanceSummary) then) =
      _$AttendanceSummaryCopyWithImpl<$Res, AttendanceSummary>;
  @useResult
  $Res call(
      {String studentId,
      DateTime date,
      int totalSessions,
      int presentCount,
      int absentCount,
      int lateCount,
      int excusedCount,
      double attendancePercentage,
      List<AttendanceRecord> records});
}

/// @nodoc
class _$AttendanceSummaryCopyWithImpl<$Res, $Val extends AttendanceSummary>
    implements $AttendanceSummaryCopyWith<$Res> {
  _$AttendanceSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? date = null,
    Object? totalSessions = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? lateCount = null,
    Object? excusedCount = null,
    Object? attendancePercentage = null,
    Object? records = null,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lateCount: null == lateCount
          ? _value.lateCount
          : lateCount // ignore: cast_nullable_to_non_nullable
              as int,
      excusedCount: null == excusedCount
          ? _value.excusedCount
          : excusedCount // ignore: cast_nullable_to_non_nullable
              as int,
      attendancePercentage: null == attendancePercentage
          ? _value.attendancePercentage
          : attendancePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceSummaryImplCopyWith<$Res>
    implements $AttendanceSummaryCopyWith<$Res> {
  factory _$$AttendanceSummaryImplCopyWith(_$AttendanceSummaryImpl value,
          $Res Function(_$AttendanceSummaryImpl) then) =
      __$$AttendanceSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String studentId,
      DateTime date,
      int totalSessions,
      int presentCount,
      int absentCount,
      int lateCount,
      int excusedCount,
      double attendancePercentage,
      List<AttendanceRecord> records});
}

/// @nodoc
class __$$AttendanceSummaryImplCopyWithImpl<$Res>
    extends _$AttendanceSummaryCopyWithImpl<$Res, _$AttendanceSummaryImpl>
    implements _$$AttendanceSummaryImplCopyWith<$Res> {
  __$$AttendanceSummaryImplCopyWithImpl(_$AttendanceSummaryImpl _value,
      $Res Function(_$AttendanceSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? date = null,
    Object? totalSessions = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? lateCount = null,
    Object? excusedCount = null,
    Object? attendancePercentage = null,
    Object? records = null,
  }) {
    return _then(_$AttendanceSummaryImpl(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lateCount: null == lateCount
          ? _value.lateCount
          : lateCount // ignore: cast_nullable_to_non_nullable
              as int,
      excusedCount: null == excusedCount
          ? _value.excusedCount
          : excusedCount // ignore: cast_nullable_to_non_nullable
              as int,
      attendancePercentage: null == attendancePercentage
          ? _value.attendancePercentage
          : attendancePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceSummaryImpl implements _AttendanceSummary {
  const _$AttendanceSummaryImpl(
      {required this.studentId,
      required this.date,
      required this.totalSessions,
      required this.presentCount,
      required this.absentCount,
      required this.lateCount,
      required this.excusedCount,
      required this.attendancePercentage,
      required final List<AttendanceRecord> records})
      : _records = records;

  factory _$AttendanceSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceSummaryImplFromJson(json);

  @override
  final String studentId;
  @override
  final DateTime date;
  @override
  final int totalSessions;
  @override
  final int presentCount;
  @override
  final int absentCount;
  @override
  final int lateCount;
  @override
  final int excusedCount;
  @override
  final double attendancePercentage;
  final List<AttendanceRecord> _records;
  @override
  List<AttendanceRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  String toString() {
    return 'AttendanceSummary(studentId: $studentId, date: $date, totalSessions: $totalSessions, presentCount: $presentCount, absentCount: $absentCount, lateCount: $lateCount, excusedCount: $excusedCount, attendancePercentage: $attendancePercentage, records: $records)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceSummaryImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.presentCount, presentCount) ||
                other.presentCount == presentCount) &&
            (identical(other.absentCount, absentCount) ||
                other.absentCount == absentCount) &&
            (identical(other.lateCount, lateCount) ||
                other.lateCount == lateCount) &&
            (identical(other.excusedCount, excusedCount) ||
                other.excusedCount == excusedCount) &&
            (identical(other.attendancePercentage, attendancePercentage) ||
                other.attendancePercentage == attendancePercentage) &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      studentId,
      date,
      totalSessions,
      presentCount,
      absentCount,
      lateCount,
      excusedCount,
      attendancePercentage,
      const DeepCollectionEquality().hash(_records));

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceSummaryImplCopyWith<_$AttendanceSummaryImpl> get copyWith =>
      __$$AttendanceSummaryImplCopyWithImpl<_$AttendanceSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceSummaryImplToJson(
      this,
    );
  }
}

abstract class _AttendanceSummary implements AttendanceSummary {
  const factory _AttendanceSummary(
      {required final String studentId,
      required final DateTime date,
      required final int totalSessions,
      required final int presentCount,
      required final int absentCount,
      required final int lateCount,
      required final int excusedCount,
      required final double attendancePercentage,
      required final List<AttendanceRecord> records}) = _$AttendanceSummaryImpl;

  factory _AttendanceSummary.fromJson(Map<String, dynamic> json) =
      _$AttendanceSummaryImpl.fromJson;

  @override
  String get studentId;
  @override
  DateTime get date;
  @override
  int get totalSessions;
  @override
  int get presentCount;
  @override
  int get absentCount;
  @override
  int get lateCount;
  @override
  int get excusedCount;
  @override
  double get attendancePercentage;
  @override
  List<AttendanceRecord> get records;

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceSummaryImplCopyWith<_$AttendanceSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceStats _$AttendanceStatsFromJson(Map<String, dynamic> json) {
  return _AttendanceStats.fromJson(json);
}

/// @nodoc
mixin _$AttendanceStats {
  DateTime get date => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;
  int get presentStudents => throw _privateConstructorUsedError;
  int get absentStudents => throw _privateConstructorUsedError;
  int get lateStudents => throw _privateConstructorUsedError;
  int get excusedStudents => throw _privateConstructorUsedError;
  double get overallPercentage => throw _privateConstructorUsedError;
  Map<AttendanceSessionType, int> get sessionBreakdown =>
      throw _privateConstructorUsedError;

  /// Serializes this AttendanceStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceStatsCopyWith<AttendanceStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceStatsCopyWith<$Res> {
  factory $AttendanceStatsCopyWith(
          AttendanceStats value, $Res Function(AttendanceStats) then) =
      _$AttendanceStatsCopyWithImpl<$Res, AttendanceStats>;
  @useResult
  $Res call(
      {DateTime date,
      int totalStudents,
      int presentStudents,
      int absentStudents,
      int lateStudents,
      int excusedStudents,
      double overallPercentage,
      Map<AttendanceSessionType, int> sessionBreakdown});
}

/// @nodoc
class _$AttendanceStatsCopyWithImpl<$Res, $Val extends AttendanceStats>
    implements $AttendanceStatsCopyWith<$Res> {
  _$AttendanceStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalStudents = null,
    Object? presentStudents = null,
    Object? absentStudents = null,
    Object? lateStudents = null,
    Object? excusedStudents = null,
    Object? overallPercentage = null,
    Object? sessionBreakdown = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      presentStudents: null == presentStudents
          ? _value.presentStudents
          : presentStudents // ignore: cast_nullable_to_non_nullable
              as int,
      absentStudents: null == absentStudents
          ? _value.absentStudents
          : absentStudents // ignore: cast_nullable_to_non_nullable
              as int,
      lateStudents: null == lateStudents
          ? _value.lateStudents
          : lateStudents // ignore: cast_nullable_to_non_nullable
              as int,
      excusedStudents: null == excusedStudents
          ? _value.excusedStudents
          : excusedStudents // ignore: cast_nullable_to_non_nullable
              as int,
      overallPercentage: null == overallPercentage
          ? _value.overallPercentage
          : overallPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      sessionBreakdown: null == sessionBreakdown
          ? _value.sessionBreakdown
          : sessionBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<AttendanceSessionType, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceStatsImplCopyWith<$Res>
    implements $AttendanceStatsCopyWith<$Res> {
  factory _$$AttendanceStatsImplCopyWith(_$AttendanceStatsImpl value,
          $Res Function(_$AttendanceStatsImpl) then) =
      __$$AttendanceStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int totalStudents,
      int presentStudents,
      int absentStudents,
      int lateStudents,
      int excusedStudents,
      double overallPercentage,
      Map<AttendanceSessionType, int> sessionBreakdown});
}

/// @nodoc
class __$$AttendanceStatsImplCopyWithImpl<$Res>
    extends _$AttendanceStatsCopyWithImpl<$Res, _$AttendanceStatsImpl>
    implements _$$AttendanceStatsImplCopyWith<$Res> {
  __$$AttendanceStatsImplCopyWithImpl(
      _$AttendanceStatsImpl _value, $Res Function(_$AttendanceStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalStudents = null,
    Object? presentStudents = null,
    Object? absentStudents = null,
    Object? lateStudents = null,
    Object? excusedStudents = null,
    Object? overallPercentage = null,
    Object? sessionBreakdown = null,
  }) {
    return _then(_$AttendanceStatsImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      presentStudents: null == presentStudents
          ? _value.presentStudents
          : presentStudents // ignore: cast_nullable_to_non_nullable
              as int,
      absentStudents: null == absentStudents
          ? _value.absentStudents
          : absentStudents // ignore: cast_nullable_to_non_nullable
              as int,
      lateStudents: null == lateStudents
          ? _value.lateStudents
          : lateStudents // ignore: cast_nullable_to_non_nullable
              as int,
      excusedStudents: null == excusedStudents
          ? _value.excusedStudents
          : excusedStudents // ignore: cast_nullable_to_non_nullable
              as int,
      overallPercentage: null == overallPercentage
          ? _value.overallPercentage
          : overallPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      sessionBreakdown: null == sessionBreakdown
          ? _value._sessionBreakdown
          : sessionBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<AttendanceSessionType, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceStatsImpl implements _AttendanceStats {
  const _$AttendanceStatsImpl(
      {required this.date,
      required this.totalStudents,
      required this.presentStudents,
      required this.absentStudents,
      required this.lateStudents,
      required this.excusedStudents,
      required this.overallPercentage,
      required final Map<AttendanceSessionType, int> sessionBreakdown})
      : _sessionBreakdown = sessionBreakdown;

  factory _$AttendanceStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceStatsImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int totalStudents;
  @override
  final int presentStudents;
  @override
  final int absentStudents;
  @override
  final int lateStudents;
  @override
  final int excusedStudents;
  @override
  final double overallPercentage;
  final Map<AttendanceSessionType, int> _sessionBreakdown;
  @override
  Map<AttendanceSessionType, int> get sessionBreakdown {
    if (_sessionBreakdown is EqualUnmodifiableMapView) return _sessionBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sessionBreakdown);
  }

  @override
  String toString() {
    return 'AttendanceStats(date: $date, totalStudents: $totalStudents, presentStudents: $presentStudents, absentStudents: $absentStudents, lateStudents: $lateStudents, excusedStudents: $excusedStudents, overallPercentage: $overallPercentage, sessionBreakdown: $sessionBreakdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceStatsImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.presentStudents, presentStudents) ||
                other.presentStudents == presentStudents) &&
            (identical(other.absentStudents, absentStudents) ||
                other.absentStudents == absentStudents) &&
            (identical(other.lateStudents, lateStudents) ||
                other.lateStudents == lateStudents) &&
            (identical(other.excusedStudents, excusedStudents) ||
                other.excusedStudents == excusedStudents) &&
            (identical(other.overallPercentage, overallPercentage) ||
                other.overallPercentage == overallPercentage) &&
            const DeepCollectionEquality()
                .equals(other._sessionBreakdown, _sessionBreakdown));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      totalStudents,
      presentStudents,
      absentStudents,
      lateStudents,
      excusedStudents,
      overallPercentage,
      const DeepCollectionEquality().hash(_sessionBreakdown));

  /// Create a copy of AttendanceStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceStatsImplCopyWith<_$AttendanceStatsImpl> get copyWith =>
      __$$AttendanceStatsImplCopyWithImpl<_$AttendanceStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceStatsImplToJson(
      this,
    );
  }
}

abstract class _AttendanceStats implements AttendanceStats {
  const factory _AttendanceStats(
          {required final DateTime date,
          required final int totalStudents,
          required final int presentStudents,
          required final int absentStudents,
          required final int lateStudents,
          required final int excusedStudents,
          required final double overallPercentage,
          required final Map<AttendanceSessionType, int> sessionBreakdown}) =
      _$AttendanceStatsImpl;

  factory _AttendanceStats.fromJson(Map<String, dynamic> json) =
      _$AttendanceStatsImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get totalStudents;
  @override
  int get presentStudents;
  @override
  int get absentStudents;
  @override
  int get lateStudents;
  @override
  int get excusedStudents;
  @override
  double get overallPercentage;
  @override
  Map<AttendanceSessionType, int> get sessionBreakdown;

  /// Create a copy of AttendanceStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceStatsImplCopyWith<_$AttendanceStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Student _$StudentFromJson(Map<String, dynamic> json) {
  return _Student.fromJson(json);
}

/// @nodoc
mixin _$Student {
  String get id => throw _privateConstructorUsedError;
  String get rollNumber => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get roomId => throw _privateConstructorUsedError;
  String? get bedId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Student to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentCopyWith<Student> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res, Student>;
  @useResult
  $Res call(
      {String id,
      String rollNumber,
      String firstName,
      String lastName,
      String email,
      String? phone,
      String? roomId,
      String? bedId,
      bool isActive,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$StudentCopyWithImpl<$Res, $Val extends Student>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? rollNumber = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? roomId = freezed,
    Object? bedId = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      rollNumber: null == rollNumber
          ? _value.rollNumber
          : rollNumber // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      bedId: freezed == bedId
          ? _value.bedId
          : bedId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$StudentImplCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
          _$StudentImpl value, $Res Function(_$StudentImpl) then) =
      __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String rollNumber,
      String firstName,
      String lastName,
      String email,
      String? phone,
      String? roomId,
      String? bedId,
      bool isActive,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$StudentCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
      _$StudentImpl _value, $Res Function(_$StudentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? rollNumber = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? roomId = freezed,
    Object? bedId = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StudentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      rollNumber: null == rollNumber
          ? _value.rollNumber
          : rollNumber // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      bedId: freezed == bedId
          ? _value.bedId
          : bedId // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$StudentImpl implements _Student {
  const _$StudentImpl(
      {required this.id,
      required this.rollNumber,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.phone,
      this.roomId,
      this.bedId,
      this.isActive = true,
      this.createdAt,
      this.updatedAt});

  factory _$StudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentImplFromJson(json);

  @override
  final String id;
  @override
  final String rollNumber;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String? phone;
  @override
  final String? roomId;
  @override
  final String? bedId;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Student(id: $id, rollNumber: $rollNumber, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, roomId: $roomId, bedId: $bedId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.rollNumber, rollNumber) ||
                other.rollNumber == rollNumber) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.bedId, bedId) || other.bedId == bedId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, rollNumber, firstName,
      lastName, email, phone, roomId, bedId, isActive, createdAt, updatedAt);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentImplToJson(
      this,
    );
  }
}

abstract class _Student implements Student {
  const factory _Student(
      {required final String id,
      required final String rollNumber,
      required final String firstName,
      required final String lastName,
      required final String email,
      final String? phone,
      final String? roomId,
      final String? bedId,
      final bool isActive,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$StudentImpl;

  factory _Student.fromJson(Map<String, dynamic> json) = _$StudentImpl.fromJson;

  @override
  String get id;
  @override
  String get rollNumber;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String? get phone;
  @override
  String? get roomId;
  @override
  String? get bedId;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
