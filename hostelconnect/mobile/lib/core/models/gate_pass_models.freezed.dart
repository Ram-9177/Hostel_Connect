// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gate_pass_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GatePass _$GatePassFromJson(Map<String, dynamic> json) {
  return _GatePass.fromJson(json);
}

/// @nodoc
mixin _$GatePass {
  String get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime get requestedAt => throw _privateConstructorUsedError;
  DateTime get departureTime => throw _privateConstructorUsedError;
  DateTime get expectedReturnTime => throw _privateConstructorUsedError;
  DateTime? get actualReturnTime => throw _privateConstructorUsedError;
  GatePassStatus get status => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  String? get rejectedBy => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Student? get student => throw _privateConstructorUsedError;

  /// Serializes this GatePass to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GatePass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatePassCopyWith<GatePass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatePassCopyWith<$Res> {
  factory $GatePassCopyWith(GatePass value, $Res Function(GatePass) then) =
      _$GatePassCopyWithImpl<$Res, GatePass>;
  @useResult
  $Res call(
      {String id,
      String studentId,
      String reason,
      DateTime requestedAt,
      DateTime departureTime,
      DateTime expectedReturnTime,
      DateTime? actualReturnTime,
      GatePassStatus status,
      String? approvedBy,
      String? rejectedBy,
      String? remarks,
      DateTime? createdAt,
      DateTime? updatedAt,
      Student? student});

  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class _$GatePassCopyWithImpl<$Res, $Val extends GatePass>
    implements $GatePassCopyWith<$Res> {
  _$GatePassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatePass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? reason = null,
    Object? requestedAt = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
    Object? actualReturnTime = freezed,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? rejectedBy = freezed,
    Object? remarks = freezed,
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
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      departureTime: null == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedReturnTime: null == expectedReturnTime
          ? _value.expectedReturnTime
          : expectedReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualReturnTime: freezed == actualReturnTime
          ? _value.actualReturnTime
          : actualReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GatePassStatus,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of GatePass
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
abstract class _$$GatePassImplCopyWith<$Res>
    implements $GatePassCopyWith<$Res> {
  factory _$$GatePassImplCopyWith(
          _$GatePassImpl value, $Res Function(_$GatePassImpl) then) =
      __$$GatePassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String studentId,
      String reason,
      DateTime requestedAt,
      DateTime departureTime,
      DateTime expectedReturnTime,
      DateTime? actualReturnTime,
      GatePassStatus status,
      String? approvedBy,
      String? rejectedBy,
      String? remarks,
      DateTime? createdAt,
      DateTime? updatedAt,
      Student? student});

  @override
  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class __$$GatePassImplCopyWithImpl<$Res>
    extends _$GatePassCopyWithImpl<$Res, _$GatePassImpl>
    implements _$$GatePassImplCopyWith<$Res> {
  __$$GatePassImplCopyWithImpl(
      _$GatePassImpl _value, $Res Function(_$GatePassImpl) _then)
      : super(_value, _then);

  /// Create a copy of GatePass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? reason = null,
    Object? requestedAt = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
    Object? actualReturnTime = freezed,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? rejectedBy = freezed,
    Object? remarks = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? student = freezed,
  }) {
    return _then(_$GatePassImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      departureTime: null == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedReturnTime: null == expectedReturnTime
          ? _value.expectedReturnTime
          : expectedReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualReturnTime: freezed == actualReturnTime
          ? _value.actualReturnTime
          : actualReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GatePassStatus,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
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
class _$GatePassImpl implements _GatePass {
  const _$GatePassImpl(
      {required this.id,
      required this.studentId,
      required this.reason,
      required this.requestedAt,
      required this.departureTime,
      required this.expectedReturnTime,
      this.actualReturnTime,
      this.status = GatePassStatus.pending,
      this.approvedBy,
      this.rejectedBy,
      this.remarks,
      this.createdAt,
      this.updatedAt,
      this.student});

  factory _$GatePassImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassImplFromJson(json);

  @override
  final String id;
  @override
  final String studentId;
  @override
  final String reason;
  @override
  final DateTime requestedAt;
  @override
  final DateTime departureTime;
  @override
  final DateTime expectedReturnTime;
  @override
  final DateTime? actualReturnTime;
  @override
  @JsonKey()
  final GatePassStatus status;
  @override
  final String? approvedBy;
  @override
  final String? rejectedBy;
  @override
  final String? remarks;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final Student? student;

  @override
  String toString() {
    return 'GatePass(id: $id, studentId: $studentId, reason: $reason, requestedAt: $requestedAt, departureTime: $departureTime, expectedReturnTime: $expectedReturnTime, actualReturnTime: $actualReturnTime, status: $status, approvedBy: $approvedBy, rejectedBy: $rejectedBy, remarks: $remarks, createdAt: $createdAt, updatedAt: $updatedAt, student: $student)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.expectedReturnTime, expectedReturnTime) ||
                other.expectedReturnTime == expectedReturnTime) &&
            (identical(other.actualReturnTime, actualReturnTime) ||
                other.actualReturnTime == actualReturnTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.rejectedBy, rejectedBy) ||
                other.rejectedBy == rejectedBy) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
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
      reason,
      requestedAt,
      departureTime,
      expectedReturnTime,
      actualReturnTime,
      status,
      approvedBy,
      rejectedBy,
      remarks,
      createdAt,
      updatedAt,
      student);

  /// Create a copy of GatePass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatePassImplCopyWith<_$GatePassImpl> get copyWith =>
      __$$GatePassImplCopyWithImpl<_$GatePassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GatePassImplToJson(
      this,
    );
  }
}

abstract class _GatePass implements GatePass {
  const factory _GatePass(
      {required final String id,
      required final String studentId,
      required final String reason,
      required final DateTime requestedAt,
      required final DateTime departureTime,
      required final DateTime expectedReturnTime,
      final DateTime? actualReturnTime,
      final GatePassStatus status,
      final String? approvedBy,
      final String? rejectedBy,
      final String? remarks,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final Student? student}) = _$GatePassImpl;

  factory _GatePass.fromJson(Map<String, dynamic> json) =
      _$GatePassImpl.fromJson;

  @override
  String get id;
  @override
  String get studentId;
  @override
  String get reason;
  @override
  DateTime get requestedAt;
  @override
  DateTime get departureTime;
  @override
  DateTime get expectedReturnTime;
  @override
  DateTime? get actualReturnTime;
  @override
  GatePassStatus get status;
  @override
  String? get approvedBy;
  @override
  String? get rejectedBy;
  @override
  String? get remarks;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  Student? get student;

  /// Create a copy of GatePass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassImplCopyWith<_$GatePassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GatePassRequest _$GatePassRequestFromJson(Map<String, dynamic> json) {
  return _GatePassRequest.fromJson(json);
}

/// @nodoc
mixin _$GatePassRequest {
  String get studentId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime get departureTime => throw _privateConstructorUsedError;
  DateTime get expectedReturnTime => throw _privateConstructorUsedError;

  /// Serializes this GatePassRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GatePassRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatePassRequestCopyWith<GatePassRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatePassRequestCopyWith<$Res> {
  factory $GatePassRequestCopyWith(
          GatePassRequest value, $Res Function(GatePassRequest) then) =
      _$GatePassRequestCopyWithImpl<$Res, GatePassRequest>;
  @useResult
  $Res call(
      {String studentId,
      String reason,
      DateTime departureTime,
      DateTime expectedReturnTime});
}

/// @nodoc
class _$GatePassRequestCopyWithImpl<$Res, $Val extends GatePassRequest>
    implements $GatePassRequestCopyWith<$Res> {
  _$GatePassRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatePassRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? reason = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      departureTime: null == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedReturnTime: null == expectedReturnTime
          ? _value.expectedReturnTime
          : expectedReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GatePassRequestImplCopyWith<$Res>
    implements $GatePassRequestCopyWith<$Res> {
  factory _$$GatePassRequestImplCopyWith(_$GatePassRequestImpl value,
          $Res Function(_$GatePassRequestImpl) then) =
      __$$GatePassRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String studentId,
      String reason,
      DateTime departureTime,
      DateTime expectedReturnTime});
}

/// @nodoc
class __$$GatePassRequestImplCopyWithImpl<$Res>
    extends _$GatePassRequestCopyWithImpl<$Res, _$GatePassRequestImpl>
    implements _$$GatePassRequestImplCopyWith<$Res> {
  __$$GatePassRequestImplCopyWithImpl(
      _$GatePassRequestImpl _value, $Res Function(_$GatePassRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of GatePassRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? reason = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
  }) {
    return _then(_$GatePassRequestImpl(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      departureTime: null == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedReturnTime: null == expectedReturnTime
          ? _value.expectedReturnTime
          : expectedReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GatePassRequestImpl implements _GatePassRequest {
  const _$GatePassRequestImpl(
      {required this.studentId,
      required this.reason,
      required this.departureTime,
      required this.expectedReturnTime});

  factory _$GatePassRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassRequestImplFromJson(json);

  @override
  final String studentId;
  @override
  final String reason;
  @override
  final DateTime departureTime;
  @override
  final DateTime expectedReturnTime;

  @override
  String toString() {
    return 'GatePassRequest(studentId: $studentId, reason: $reason, departureTime: $departureTime, expectedReturnTime: $expectedReturnTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassRequestImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.expectedReturnTime, expectedReturnTime) ||
                other.expectedReturnTime == expectedReturnTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, studentId, reason, departureTime, expectedReturnTime);

  /// Create a copy of GatePassRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatePassRequestImplCopyWith<_$GatePassRequestImpl> get copyWith =>
      __$$GatePassRequestImplCopyWithImpl<_$GatePassRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GatePassRequestImplToJson(
      this,
    );
  }
}

abstract class _GatePassRequest implements GatePassRequest {
  const factory _GatePassRequest(
      {required final String studentId,
      required final String reason,
      required final DateTime departureTime,
      required final DateTime expectedReturnTime}) = _$GatePassRequestImpl;

  factory _GatePassRequest.fromJson(Map<String, dynamic> json) =
      _$GatePassRequestImpl.fromJson;

  @override
  String get studentId;
  @override
  String get reason;
  @override
  DateTime get departureTime;
  @override
  DateTime get expectedReturnTime;

  /// Create a copy of GatePassRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassRequestImplCopyWith<_$GatePassRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GatePassQRTokenPayload _$GatePassQRTokenPayloadFromJson(
    Map<String, dynamic> json) {
  return _GatePassQRTokenPayload.fromJson(json);
}

/// @nodoc
mixin _$GatePassQRTokenPayload {
  String get gatePassId => throw _privateConstructorUsedError;
  String get userId =>
      throw _privateConstructorUsedError; // User who generated the QR (e.g., student)
  DateTime get issuedAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;

  /// Serializes this GatePassQRTokenPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GatePassQRTokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatePassQRTokenPayloadCopyWith<GatePassQRTokenPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatePassQRTokenPayloadCopyWith<$Res> {
  factory $GatePassQRTokenPayloadCopyWith(GatePassQRTokenPayload value,
          $Res Function(GatePassQRTokenPayload) then) =
      _$GatePassQRTokenPayloadCopyWithImpl<$Res, GatePassQRTokenPayload>;
  @useResult
  $Res call(
      {String gatePassId,
      String userId,
      DateTime issuedAt,
      DateTime expiresAt,
      String nonce});
}

/// @nodoc
class _$GatePassQRTokenPayloadCopyWithImpl<$Res,
        $Val extends GatePassQRTokenPayload>
    implements $GatePassQRTokenPayloadCopyWith<$Res> {
  _$GatePassQRTokenPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatePassQRTokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? userId = null,
    Object? issuedAt = null,
    Object? expiresAt = null,
    Object? nonce = null,
  }) {
    return _then(_value.copyWith(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GatePassQRTokenPayloadImplCopyWith<$Res>
    implements $GatePassQRTokenPayloadCopyWith<$Res> {
  factory _$$GatePassQRTokenPayloadImplCopyWith(
          _$GatePassQRTokenPayloadImpl value,
          $Res Function(_$GatePassQRTokenPayloadImpl) then) =
      __$$GatePassQRTokenPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gatePassId,
      String userId,
      DateTime issuedAt,
      DateTime expiresAt,
      String nonce});
}

/// @nodoc
class __$$GatePassQRTokenPayloadImplCopyWithImpl<$Res>
    extends _$GatePassQRTokenPayloadCopyWithImpl<$Res,
        _$GatePassQRTokenPayloadImpl>
    implements _$$GatePassQRTokenPayloadImplCopyWith<$Res> {
  __$$GatePassQRTokenPayloadImplCopyWithImpl(
      _$GatePassQRTokenPayloadImpl _value,
      $Res Function(_$GatePassQRTokenPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of GatePassQRTokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? userId = null,
    Object? issuedAt = null,
    Object? expiresAt = null,
    Object? nonce = null,
  }) {
    return _then(_$GatePassQRTokenPayloadImpl(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GatePassQRTokenPayloadImpl implements _GatePassQRTokenPayload {
  const _$GatePassQRTokenPayloadImpl(
      {required this.gatePassId,
      required this.userId,
      required this.issuedAt,
      required this.expiresAt,
      required this.nonce});

  factory _$GatePassQRTokenPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassQRTokenPayloadImplFromJson(json);

  @override
  final String gatePassId;
  @override
  final String userId;
// User who generated the QR (e.g., student)
  @override
  final DateTime issuedAt;
  @override
  final DateTime expiresAt;
  @override
  final String nonce;

  @override
  String toString() {
    return 'GatePassQRTokenPayload(gatePassId: $gatePassId, userId: $userId, issuedAt: $issuedAt, expiresAt: $expiresAt, nonce: $nonce)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassQRTokenPayloadImpl &&
            (identical(other.gatePassId, gatePassId) ||
                other.gatePassId == gatePassId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.nonce, nonce) || other.nonce == nonce));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, gatePassId, userId, issuedAt, expiresAt, nonce);

  /// Create a copy of GatePassQRTokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatePassQRTokenPayloadImplCopyWith<_$GatePassQRTokenPayloadImpl>
      get copyWith => __$$GatePassQRTokenPayloadImplCopyWithImpl<
          _$GatePassQRTokenPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GatePassQRTokenPayloadImplToJson(
      this,
    );
  }
}

abstract class _GatePassQRTokenPayload implements GatePassQRTokenPayload {
  const factory _GatePassQRTokenPayload(
      {required final String gatePassId,
      required final String userId,
      required final DateTime issuedAt,
      required final DateTime expiresAt,
      required final String nonce}) = _$GatePassQRTokenPayloadImpl;

  factory _GatePassQRTokenPayload.fromJson(Map<String, dynamic> json) =
      _$GatePassQRTokenPayloadImpl.fromJson;

  @override
  String get gatePassId;
  @override
  String get userId; // User who generated the QR (e.g., student)
  @override
  DateTime get issuedAt;
  @override
  DateTime get expiresAt;
  @override
  String get nonce;

  /// Create a copy of GatePassQRTokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassQRTokenPayloadImplCopyWith<_$GatePassQRTokenPayloadImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GateScanResult _$GateScanResultFromJson(Map<String, dynamic> json) {
  return _GateScanResult.fromJson(json);
}

/// @nodoc
mixin _$GateScanResult {
  bool get ok => throw _privateConstructorUsedError;
  GatePassDirection get direction => throw _privateConstructorUsedError;
  Student get student => throw _privateConstructorUsedError;
  GatePass get gatePass => throw _privateConstructorUsedError;
  List<String> get warnings =>
      throw _privateConstructorUsedError; // e.g., "EXPIRED", "ALREADY_USED", "OUT_OF_WINDOW"
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this GateScanResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GateScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GateScanResultCopyWith<GateScanResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GateScanResultCopyWith<$Res> {
  factory $GateScanResultCopyWith(
          GateScanResult value, $Res Function(GateScanResult) then) =
      _$GateScanResultCopyWithImpl<$Res, GateScanResult>;
  @useResult
  $Res call(
      {bool ok,
      GatePassDirection direction,
      Student student,
      GatePass gatePass,
      List<String> warnings,
      String? message});

  $StudentCopyWith<$Res> get student;
  $GatePassCopyWith<$Res> get gatePass;
}

/// @nodoc
class _$GateScanResultCopyWithImpl<$Res, $Val extends GateScanResult>
    implements $GateScanResultCopyWith<$Res> {
  _$GateScanResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GateScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ok = null,
    Object? direction = null,
    Object? student = null,
    Object? gatePass = null,
    Object? warnings = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      ok: null == ok
          ? _value.ok
          : ok // ignore: cast_nullable_to_non_nullable
              as bool,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as GatePassDirection,
      student: null == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student,
      gatePass: null == gatePass
          ? _value.gatePass
          : gatePass // ignore: cast_nullable_to_non_nullable
              as GatePass,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of GateScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudentCopyWith<$Res> get student {
    return $StudentCopyWith<$Res>(_value.student, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }

  /// Create a copy of GateScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GatePassCopyWith<$Res> get gatePass {
    return $GatePassCopyWith<$Res>(_value.gatePass, (value) {
      return _then(_value.copyWith(gatePass: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GateScanResultImplCopyWith<$Res>
    implements $GateScanResultCopyWith<$Res> {
  factory _$$GateScanResultImplCopyWith(_$GateScanResultImpl value,
          $Res Function(_$GateScanResultImpl) then) =
      __$$GateScanResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool ok,
      GatePassDirection direction,
      Student student,
      GatePass gatePass,
      List<String> warnings,
      String? message});

  @override
  $StudentCopyWith<$Res> get student;
  @override
  $GatePassCopyWith<$Res> get gatePass;
}

/// @nodoc
class __$$GateScanResultImplCopyWithImpl<$Res>
    extends _$GateScanResultCopyWithImpl<$Res, _$GateScanResultImpl>
    implements _$$GateScanResultImplCopyWith<$Res> {
  __$$GateScanResultImplCopyWithImpl(
      _$GateScanResultImpl _value, $Res Function(_$GateScanResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of GateScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ok = null,
    Object? direction = null,
    Object? student = null,
    Object? gatePass = null,
    Object? warnings = null,
    Object? message = freezed,
  }) {
    return _then(_$GateScanResultImpl(
      ok: null == ok
          ? _value.ok
          : ok // ignore: cast_nullable_to_non_nullable
              as bool,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as GatePassDirection,
      student: null == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student,
      gatePass: null == gatePass
          ? _value.gatePass
          : gatePass // ignore: cast_nullable_to_non_nullable
              as GatePass,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GateScanResultImpl implements _GateScanResult {
  const _$GateScanResultImpl(
      {required this.ok,
      required this.direction,
      required this.student,
      required this.gatePass,
      final List<String> warnings = const [],
      this.message})
      : _warnings = warnings;

  factory _$GateScanResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$GateScanResultImplFromJson(json);

  @override
  final bool ok;
  @override
  final GatePassDirection direction;
  @override
  final Student student;
  @override
  final GatePass gatePass;
  final List<String> _warnings;
  @override
  @JsonKey()
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

// e.g., "EXPIRED", "ALREADY_USED", "OUT_OF_WINDOW"
  @override
  final String? message;

  @override
  String toString() {
    return 'GateScanResult(ok: $ok, direction: $direction, student: $student, gatePass: $gatePass, warnings: $warnings, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GateScanResultImpl &&
            (identical(other.ok, ok) || other.ok == ok) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.student, student) || other.student == student) &&
            (identical(other.gatePass, gatePass) ||
                other.gatePass == gatePass) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ok, direction, student, gatePass,
      const DeepCollectionEquality().hash(_warnings), message);

  /// Create a copy of GateScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GateScanResultImplCopyWith<_$GateScanResultImpl> get copyWith =>
      __$$GateScanResultImplCopyWithImpl<_$GateScanResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GateScanResultImplToJson(
      this,
    );
  }
}

abstract class _GateScanResult implements GateScanResult {
  const factory _GateScanResult(
      {required final bool ok,
      required final GatePassDirection direction,
      required final Student student,
      required final GatePass gatePass,
      final List<String> warnings,
      final String? message}) = _$GateScanResultImpl;

  factory _GateScanResult.fromJson(Map<String, dynamic> json) =
      _$GateScanResultImpl.fromJson;

  @override
  bool get ok;
  @override
  GatePassDirection get direction;
  @override
  Student get student;
  @override
  GatePass get gatePass;
  @override
  List<String> get warnings; // e.g., "EXPIRED", "ALREADY_USED", "OUT_OF_WINDOW"
  @override
  String? get message;

  /// Create a copy of GateScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GateScanResultImplCopyWith<_$GateScanResultImpl> get copyWith =>
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
