// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gatepass_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GatePassRequest _$GatePassRequestFromJson(Map<String, dynamic> json) {
  return _GatePassRequest.fromJson(json);
}

/// @nodoc
mixin _$GatePassRequest {
  String get studentId => throw _privateConstructorUsedError;
  String get studentName => throw _privateConstructorUsedError;
  String get studentRollNumber => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime get departureTime => throw _privateConstructorUsedError;
  DateTime get expectedReturnTime => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  String get contactNumber => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  GatePassType get type => throw _privateConstructorUsedError;
  GatePassPriority get priority => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

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
      String studentName,
      String studentRollNumber,
      String hostelId,
      String reason,
      DateTime departureTime,
      DateTime expectedReturnTime,
      String destination,
      String contactNumber,
      String? emergencyContact,
      String? notes,
      GatePassType type,
      GatePassPriority priority,
      Map<String, dynamic>? metadata});
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
    Object? studentName = null,
    Object? studentRollNumber = null,
    Object? hostelId = null,
    Object? reason = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
    Object? destination = null,
    Object? contactNumber = null,
    Object? emergencyContact = freezed,
    Object? notes = freezed,
    Object? type = null,
    Object? priority = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
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
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GatePassType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GatePassPriority,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
      String studentName,
      String studentRollNumber,
      String hostelId,
      String reason,
      DateTime departureTime,
      DateTime expectedReturnTime,
      String destination,
      String contactNumber,
      String? emergencyContact,
      String? notes,
      GatePassType type,
      GatePassPriority priority,
      Map<String, dynamic>? metadata});
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
    Object? studentName = null,
    Object? studentRollNumber = null,
    Object? hostelId = null,
    Object? reason = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
    Object? destination = null,
    Object? contactNumber = null,
    Object? emergencyContact = freezed,
    Object? notes = freezed,
    Object? type = null,
    Object? priority = null,
    Object? metadata = freezed,
  }) {
    return _then(_$GatePassRequestImpl(
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
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GatePassType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GatePassPriority,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GatePassRequestImpl implements _GatePassRequest {
  const _$GatePassRequestImpl(
      {required this.studentId,
      required this.studentName,
      required this.studentRollNumber,
      required this.hostelId,
      required this.reason,
      required this.departureTime,
      required this.expectedReturnTime,
      required this.destination,
      required this.contactNumber,
      this.emergencyContact,
      this.notes,
      required this.type,
      required this.priority,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$GatePassRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassRequestImplFromJson(json);

  @override
  final String studentId;
  @override
  final String studentName;
  @override
  final String studentRollNumber;
  @override
  final String hostelId;
  @override
  final String reason;
  @override
  final DateTime departureTime;
  @override
  final DateTime expectedReturnTime;
  @override
  final String destination;
  @override
  final String contactNumber;
  @override
  final String? emergencyContact;
  @override
  final String? notes;
  @override
  final GatePassType type;
  @override
  final GatePassPriority priority;
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
    return 'GatePassRequest(studentId: $studentId, studentName: $studentName, studentRollNumber: $studentRollNumber, hostelId: $hostelId, reason: $reason, departureTime: $departureTime, expectedReturnTime: $expectedReturnTime, destination: $destination, contactNumber: $contactNumber, emergencyContact: $emergencyContact, notes: $notes, type: $type, priority: $priority, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassRequestImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentRollNumber, studentRollNumber) ||
                other.studentRollNumber == studentRollNumber) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.expectedReturnTime, expectedReturnTime) ||
                other.expectedReturnTime == expectedReturnTime) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      studentId,
      studentName,
      studentRollNumber,
      hostelId,
      reason,
      departureTime,
      expectedReturnTime,
      destination,
      contactNumber,
      emergencyContact,
      notes,
      type,
      priority,
      const DeepCollectionEquality().hash(_metadata));

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
      required final String studentName,
      required final String studentRollNumber,
      required final String hostelId,
      required final String reason,
      required final DateTime departureTime,
      required final DateTime expectedReturnTime,
      required final String destination,
      required final String contactNumber,
      final String? emergencyContact,
      final String? notes,
      required final GatePassType type,
      required final GatePassPriority priority,
      final Map<String, dynamic>? metadata}) = _$GatePassRequestImpl;

  factory _GatePassRequest.fromJson(Map<String, dynamic> json) =
      _$GatePassRequestImpl.fromJson;

  @override
  String get studentId;
  @override
  String get studentName;
  @override
  String get studentRollNumber;
  @override
  String get hostelId;
  @override
  String get reason;
  @override
  DateTime get departureTime;
  @override
  DateTime get expectedReturnTime;
  @override
  String get destination;
  @override
  String get contactNumber;
  @override
  String? get emergencyContact;
  @override
  String? get notes;
  @override
  GatePassType get type;
  @override
  GatePassPriority get priority;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of GatePassRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassRequestImplCopyWith<_$GatePassRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GatePass _$GatePassFromJson(Map<String, dynamic> json) {
  return _GatePass.fromJson(json);
}

/// @nodoc
mixin _$GatePass {
  String get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get studentName => throw _privateConstructorUsedError;
  String get studentRollNumber => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime get departureTime => throw _privateConstructorUsedError;
  DateTime get expectedReturnTime => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  String get contactNumber => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  GatePassType get type => throw _privateConstructorUsedError;
  GatePassPriority get priority => throw _privateConstructorUsedError;
  GatePassStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get rejectedBy => throw _privateConstructorUsedError;
  DateTime? get rejectedAt => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime? get actualDepartureTime => throw _privateConstructorUsedError;
  DateTime? get actualReturnTime => throw _privateConstructorUsedError;
  String? get qrCode => throw _privateConstructorUsedError;
  String? get qrNonce => throw _privateConstructorUsedError;
  DateTime? get qrGeneratedAt => throw _privateConstructorUsedError;
  DateTime? get qrExpiresAt => throw _privateConstructorUsedError;
  bool? get adCompleted => throw _privateConstructorUsedError;
  DateTime? get adCompletedAt => throw _privateConstructorUsedError;
  String? get adId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

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
      String studentName,
      String studentRollNumber,
      String hostelId,
      String reason,
      DateTime departureTime,
      DateTime expectedReturnTime,
      String destination,
      String contactNumber,
      String? emergencyContact,
      String? notes,
      GatePassType type,
      GatePassPriority priority,
      GatePassStatus status,
      DateTime createdAt,
      String createdBy,
      String? approvedBy,
      DateTime? approvedAt,
      String? rejectedBy,
      DateTime? rejectedAt,
      String? rejectionReason,
      DateTime? actualDepartureTime,
      DateTime? actualReturnTime,
      String? qrCode,
      String? qrNonce,
      DateTime? qrGeneratedAt,
      DateTime? qrExpiresAt,
      bool? adCompleted,
      DateTime? adCompletedAt,
      String? adId,
      Map<String, dynamic>? metadata});
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
    Object? studentName = null,
    Object? studentRollNumber = null,
    Object? hostelId = null,
    Object? reason = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
    Object? destination = null,
    Object? contactNumber = null,
    Object? emergencyContact = freezed,
    Object? notes = freezed,
    Object? type = null,
    Object? priority = null,
    Object? status = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? rejectedBy = freezed,
    Object? rejectedAt = freezed,
    Object? rejectionReason = freezed,
    Object? actualDepartureTime = freezed,
    Object? actualReturnTime = freezed,
    Object? qrCode = freezed,
    Object? qrNonce = freezed,
    Object? qrGeneratedAt = freezed,
    Object? qrExpiresAt = freezed,
    Object? adCompleted = freezed,
    Object? adCompletedAt = freezed,
    Object? adId = freezed,
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
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GatePassType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GatePassPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GatePassStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      actualDepartureTime: freezed == actualDepartureTime
          ? _value.actualDepartureTime
          : actualDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualReturnTime: freezed == actualReturnTime
          ? _value.actualReturnTime
          : actualReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      qrNonce: freezed == qrNonce
          ? _value.qrNonce
          : qrNonce // ignore: cast_nullable_to_non_nullable
              as String?,
      qrGeneratedAt: freezed == qrGeneratedAt
          ? _value.qrGeneratedAt
          : qrGeneratedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qrExpiresAt: freezed == qrExpiresAt
          ? _value.qrExpiresAt
          : qrExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adCompleted: freezed == adCompleted
          ? _value.adCompleted
          : adCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      adCompletedAt: freezed == adCompletedAt
          ? _value.adCompletedAt
          : adCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adId: freezed == adId
          ? _value.adId
          : adId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
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
      String studentName,
      String studentRollNumber,
      String hostelId,
      String reason,
      DateTime departureTime,
      DateTime expectedReturnTime,
      String destination,
      String contactNumber,
      String? emergencyContact,
      String? notes,
      GatePassType type,
      GatePassPriority priority,
      GatePassStatus status,
      DateTime createdAt,
      String createdBy,
      String? approvedBy,
      DateTime? approvedAt,
      String? rejectedBy,
      DateTime? rejectedAt,
      String? rejectionReason,
      DateTime? actualDepartureTime,
      DateTime? actualReturnTime,
      String? qrCode,
      String? qrNonce,
      DateTime? qrGeneratedAt,
      DateTime? qrExpiresAt,
      bool? adCompleted,
      DateTime? adCompletedAt,
      String? adId,
      Map<String, dynamic>? metadata});
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
    Object? studentName = null,
    Object? studentRollNumber = null,
    Object? hostelId = null,
    Object? reason = null,
    Object? departureTime = null,
    Object? expectedReturnTime = null,
    Object? destination = null,
    Object? contactNumber = null,
    Object? emergencyContact = freezed,
    Object? notes = freezed,
    Object? type = null,
    Object? priority = null,
    Object? status = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? rejectedBy = freezed,
    Object? rejectedAt = freezed,
    Object? rejectionReason = freezed,
    Object? actualDepartureTime = freezed,
    Object? actualReturnTime = freezed,
    Object? qrCode = freezed,
    Object? qrNonce = freezed,
    Object? qrGeneratedAt = freezed,
    Object? qrExpiresAt = freezed,
    Object? adCompleted = freezed,
    Object? adCompletedAt = freezed,
    Object? adId = freezed,
    Object? metadata = freezed,
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
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GatePassType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GatePassPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GatePassStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      actualDepartureTime: freezed == actualDepartureTime
          ? _value.actualDepartureTime
          : actualDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualReturnTime: freezed == actualReturnTime
          ? _value.actualReturnTime
          : actualReturnTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      qrNonce: freezed == qrNonce
          ? _value.qrNonce
          : qrNonce // ignore: cast_nullable_to_non_nullable
              as String?,
      qrGeneratedAt: freezed == qrGeneratedAt
          ? _value.qrGeneratedAt
          : qrGeneratedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qrExpiresAt: freezed == qrExpiresAt
          ? _value.qrExpiresAt
          : qrExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adCompleted: freezed == adCompleted
          ? _value.adCompleted
          : adCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      adCompletedAt: freezed == adCompletedAt
          ? _value.adCompletedAt
          : adCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adId: freezed == adId
          ? _value.adId
          : adId // ignore: cast_nullable_to_non_nullable
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
class _$GatePassImpl implements _GatePass {
  const _$GatePassImpl(
      {required this.id,
      required this.studentId,
      required this.studentName,
      required this.studentRollNumber,
      required this.hostelId,
      required this.reason,
      required this.departureTime,
      required this.expectedReturnTime,
      required this.destination,
      required this.contactNumber,
      this.emergencyContact,
      this.notes,
      required this.type,
      required this.priority,
      required this.status,
      required this.createdAt,
      required this.createdBy,
      this.approvedBy,
      this.approvedAt,
      this.rejectedBy,
      this.rejectedAt,
      this.rejectionReason,
      this.actualDepartureTime,
      this.actualReturnTime,
      this.qrCode,
      this.qrNonce,
      this.qrGeneratedAt,
      this.qrExpiresAt,
      this.adCompleted,
      this.adCompletedAt,
      this.adId,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$GatePassImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassImplFromJson(json);

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
  final String reason;
  @override
  final DateTime departureTime;
  @override
  final DateTime expectedReturnTime;
  @override
  final String destination;
  @override
  final String contactNumber;
  @override
  final String? emergencyContact;
  @override
  final String? notes;
  @override
  final GatePassType type;
  @override
  final GatePassPriority priority;
  @override
  final GatePassStatus status;
  @override
  final DateTime createdAt;
  @override
  final String createdBy;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final String? rejectedBy;
  @override
  final DateTime? rejectedAt;
  @override
  final String? rejectionReason;
  @override
  final DateTime? actualDepartureTime;
  @override
  final DateTime? actualReturnTime;
  @override
  final String? qrCode;
  @override
  final String? qrNonce;
  @override
  final DateTime? qrGeneratedAt;
  @override
  final DateTime? qrExpiresAt;
  @override
  final bool? adCompleted;
  @override
  final DateTime? adCompletedAt;
  @override
  final String? adId;
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
    return 'GatePass(id: $id, studentId: $studentId, studentName: $studentName, studentRollNumber: $studentRollNumber, hostelId: $hostelId, reason: $reason, departureTime: $departureTime, expectedReturnTime: $expectedReturnTime, destination: $destination, contactNumber: $contactNumber, emergencyContact: $emergencyContact, notes: $notes, type: $type, priority: $priority, status: $status, createdAt: $createdAt, createdBy: $createdBy, approvedBy: $approvedBy, approvedAt: $approvedAt, rejectedBy: $rejectedBy, rejectedAt: $rejectedAt, rejectionReason: $rejectionReason, actualDepartureTime: $actualDepartureTime, actualReturnTime: $actualReturnTime, qrCode: $qrCode, qrNonce: $qrNonce, qrGeneratedAt: $qrGeneratedAt, qrExpiresAt: $qrExpiresAt, adCompleted: $adCompleted, adCompletedAt: $adCompletedAt, adId: $adId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentRollNumber, studentRollNumber) ||
                other.studentRollNumber == studentRollNumber) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.expectedReturnTime, expectedReturnTime) ||
                other.expectedReturnTime == expectedReturnTime) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.rejectedBy, rejectedBy) ||
                other.rejectedBy == rejectedBy) &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.actualDepartureTime, actualDepartureTime) ||
                other.actualDepartureTime == actualDepartureTime) &&
            (identical(other.actualReturnTime, actualReturnTime) ||
                other.actualReturnTime == actualReturnTime) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.qrNonce, qrNonce) || other.qrNonce == qrNonce) &&
            (identical(other.qrGeneratedAt, qrGeneratedAt) ||
                other.qrGeneratedAt == qrGeneratedAt) &&
            (identical(other.qrExpiresAt, qrExpiresAt) ||
                other.qrExpiresAt == qrExpiresAt) &&
            (identical(other.adCompleted, adCompleted) ||
                other.adCompleted == adCompleted) &&
            (identical(other.adCompletedAt, adCompletedAt) ||
                other.adCompletedAt == adCompletedAt) &&
            (identical(other.adId, adId) || other.adId == adId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        studentId,
        studentName,
        studentRollNumber,
        hostelId,
        reason,
        departureTime,
        expectedReturnTime,
        destination,
        contactNumber,
        emergencyContact,
        notes,
        type,
        priority,
        status,
        createdAt,
        createdBy,
        approvedBy,
        approvedAt,
        rejectedBy,
        rejectedAt,
        rejectionReason,
        actualDepartureTime,
        actualReturnTime,
        qrCode,
        qrNonce,
        qrGeneratedAt,
        qrExpiresAt,
        adCompleted,
        adCompletedAt,
        adId,
        const DeepCollectionEquality().hash(_metadata)
      ]);

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
      required final String studentName,
      required final String studentRollNumber,
      required final String hostelId,
      required final String reason,
      required final DateTime departureTime,
      required final DateTime expectedReturnTime,
      required final String destination,
      required final String contactNumber,
      final String? emergencyContact,
      final String? notes,
      required final GatePassType type,
      required final GatePassPriority priority,
      required final GatePassStatus status,
      required final DateTime createdAt,
      required final String createdBy,
      final String? approvedBy,
      final DateTime? approvedAt,
      final String? rejectedBy,
      final DateTime? rejectedAt,
      final String? rejectionReason,
      final DateTime? actualDepartureTime,
      final DateTime? actualReturnTime,
      final String? qrCode,
      final String? qrNonce,
      final DateTime? qrGeneratedAt,
      final DateTime? qrExpiresAt,
      final bool? adCompleted,
      final DateTime? adCompletedAt,
      final String? adId,
      final Map<String, dynamic>? metadata}) = _$GatePassImpl;

  factory _GatePass.fromJson(Map<String, dynamic> json) =
      _$GatePassImpl.fromJson;

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
  String get reason;
  @override
  DateTime get departureTime;
  @override
  DateTime get expectedReturnTime;
  @override
  String get destination;
  @override
  String get contactNumber;
  @override
  String? get emergencyContact;
  @override
  String? get notes;
  @override
  GatePassType get type;
  @override
  GatePassPriority get priority;
  @override
  GatePassStatus get status;
  @override
  DateTime get createdAt;
  @override
  String get createdBy;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  String? get rejectedBy;
  @override
  DateTime? get rejectedAt;
  @override
  String? get rejectionReason;
  @override
  DateTime? get actualDepartureTime;
  @override
  DateTime? get actualReturnTime;
  @override
  String? get qrCode;
  @override
  String? get qrNonce;
  @override
  DateTime? get qrGeneratedAt;
  @override
  DateTime? get qrExpiresAt;
  @override
  bool? get adCompleted;
  @override
  DateTime? get adCompletedAt;
  @override
  String? get adId;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of GatePass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassImplCopyWith<_$GatePassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GateScanEvent _$GateScanEventFromJson(Map<String, dynamic> json) {
  return _GateScanEvent.fromJson(json);
}

/// @nodoc
mixin _$GateScanEvent {
  String get id => throw _privateConstructorUsedError;
  String get gatePassId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get studentName => throw _privateConstructorUsedError;
  GateScanType get scanType => throw _privateConstructorUsedError;
  DateTime get scanTime => throw _privateConstructorUsedError;
  String get scannedBy => throw _privateConstructorUsedError;
  String get scannedByName => throw _privateConstructorUsedError;
  String get gateLocation => throw _privateConstructorUsedError;
  String? get qrCode => throw _privateConstructorUsedError;
  String? get qrNonce => throw _privateConstructorUsedError;
  bool? get isEmergencyBypass => throw _privateConstructorUsedError;
  String? get emergencyReason => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this GateScanEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GateScanEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GateScanEventCopyWith<GateScanEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GateScanEventCopyWith<$Res> {
  factory $GateScanEventCopyWith(
          GateScanEvent value, $Res Function(GateScanEvent) then) =
      _$GateScanEventCopyWithImpl<$Res, GateScanEvent>;
  @useResult
  $Res call(
      {String id,
      String gatePassId,
      String studentId,
      String studentName,
      GateScanType scanType,
      DateTime scanTime,
      String scannedBy,
      String scannedByName,
      String gateLocation,
      String? qrCode,
      String? qrNonce,
      bool? isEmergencyBypass,
      String? emergencyReason,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$GateScanEventCopyWithImpl<$Res, $Val extends GateScanEvent>
    implements $GateScanEventCopyWith<$Res> {
  _$GateScanEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GateScanEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gatePassId = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? scanType = null,
    Object? scanTime = null,
    Object? scannedBy = null,
    Object? scannedByName = null,
    Object? gateLocation = null,
    Object? qrCode = freezed,
    Object? qrNonce = freezed,
    Object? isEmergencyBypass = freezed,
    Object? emergencyReason = freezed,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      scanType: null == scanType
          ? _value.scanType
          : scanType // ignore: cast_nullable_to_non_nullable
              as GateScanType,
      scanTime: null == scanTime
          ? _value.scanTime
          : scanTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scannedBy: null == scannedBy
          ? _value.scannedBy
          : scannedBy // ignore: cast_nullable_to_non_nullable
              as String,
      scannedByName: null == scannedByName
          ? _value.scannedByName
          : scannedByName // ignore: cast_nullable_to_non_nullable
              as String,
      gateLocation: null == gateLocation
          ? _value.gateLocation
          : gateLocation // ignore: cast_nullable_to_non_nullable
              as String,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      qrNonce: freezed == qrNonce
          ? _value.qrNonce
          : qrNonce // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmergencyBypass: freezed == isEmergencyBypass
          ? _value.isEmergencyBypass
          : isEmergencyBypass // ignore: cast_nullable_to_non_nullable
              as bool?,
      emergencyReason: freezed == emergencyReason
          ? _value.emergencyReason
          : emergencyReason // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$GateScanEventImplCopyWith<$Res>
    implements $GateScanEventCopyWith<$Res> {
  factory _$$GateScanEventImplCopyWith(
          _$GateScanEventImpl value, $Res Function(_$GateScanEventImpl) then) =
      __$$GateScanEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String gatePassId,
      String studentId,
      String studentName,
      GateScanType scanType,
      DateTime scanTime,
      String scannedBy,
      String scannedByName,
      String gateLocation,
      String? qrCode,
      String? qrNonce,
      bool? isEmergencyBypass,
      String? emergencyReason,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$GateScanEventImplCopyWithImpl<$Res>
    extends _$GateScanEventCopyWithImpl<$Res, _$GateScanEventImpl>
    implements _$$GateScanEventImplCopyWith<$Res> {
  __$$GateScanEventImplCopyWithImpl(
      _$GateScanEventImpl _value, $Res Function(_$GateScanEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of GateScanEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gatePassId = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? scanType = null,
    Object? scanTime = null,
    Object? scannedBy = null,
    Object? scannedByName = null,
    Object? gateLocation = null,
    Object? qrCode = freezed,
    Object? qrNonce = freezed,
    Object? isEmergencyBypass = freezed,
    Object? emergencyReason = freezed,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$GateScanEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      scanType: null == scanType
          ? _value.scanType
          : scanType // ignore: cast_nullable_to_non_nullable
              as GateScanType,
      scanTime: null == scanTime
          ? _value.scanTime
          : scanTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scannedBy: null == scannedBy
          ? _value.scannedBy
          : scannedBy // ignore: cast_nullable_to_non_nullable
              as String,
      scannedByName: null == scannedByName
          ? _value.scannedByName
          : scannedByName // ignore: cast_nullable_to_non_nullable
              as String,
      gateLocation: null == gateLocation
          ? _value.gateLocation
          : gateLocation // ignore: cast_nullable_to_non_nullable
              as String,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      qrNonce: freezed == qrNonce
          ? _value.qrNonce
          : qrNonce // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmergencyBypass: freezed == isEmergencyBypass
          ? _value.isEmergencyBypass
          : isEmergencyBypass // ignore: cast_nullable_to_non_nullable
              as bool?,
      emergencyReason: freezed == emergencyReason
          ? _value.emergencyReason
          : emergencyReason // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$GateScanEventImpl implements _GateScanEvent {
  const _$GateScanEventImpl(
      {required this.id,
      required this.gatePassId,
      required this.studentId,
      required this.studentName,
      required this.scanType,
      required this.scanTime,
      required this.scannedBy,
      required this.scannedByName,
      required this.gateLocation,
      this.qrCode,
      this.qrNonce,
      this.isEmergencyBypass,
      this.emergencyReason,
      this.notes,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$GateScanEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GateScanEventImplFromJson(json);

  @override
  final String id;
  @override
  final String gatePassId;
  @override
  final String studentId;
  @override
  final String studentName;
  @override
  final GateScanType scanType;
  @override
  final DateTime scanTime;
  @override
  final String scannedBy;
  @override
  final String scannedByName;
  @override
  final String gateLocation;
  @override
  final String? qrCode;
  @override
  final String? qrNonce;
  @override
  final bool? isEmergencyBypass;
  @override
  final String? emergencyReason;
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
    return 'GateScanEvent(id: $id, gatePassId: $gatePassId, studentId: $studentId, studentName: $studentName, scanType: $scanType, scanTime: $scanTime, scannedBy: $scannedBy, scannedByName: $scannedByName, gateLocation: $gateLocation, qrCode: $qrCode, qrNonce: $qrNonce, isEmergencyBypass: $isEmergencyBypass, emergencyReason: $emergencyReason, notes: $notes, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GateScanEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gatePassId, gatePassId) ||
                other.gatePassId == gatePassId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.scanType, scanType) ||
                other.scanType == scanType) &&
            (identical(other.scanTime, scanTime) ||
                other.scanTime == scanTime) &&
            (identical(other.scannedBy, scannedBy) ||
                other.scannedBy == scannedBy) &&
            (identical(other.scannedByName, scannedByName) ||
                other.scannedByName == scannedByName) &&
            (identical(other.gateLocation, gateLocation) ||
                other.gateLocation == gateLocation) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.qrNonce, qrNonce) || other.qrNonce == qrNonce) &&
            (identical(other.isEmergencyBypass, isEmergencyBypass) ||
                other.isEmergencyBypass == isEmergencyBypass) &&
            (identical(other.emergencyReason, emergencyReason) ||
                other.emergencyReason == emergencyReason) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      gatePassId,
      studentId,
      studentName,
      scanType,
      scanTime,
      scannedBy,
      scannedByName,
      gateLocation,
      qrCode,
      qrNonce,
      isEmergencyBypass,
      emergencyReason,
      notes,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of GateScanEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GateScanEventImplCopyWith<_$GateScanEventImpl> get copyWith =>
      __$$GateScanEventImplCopyWithImpl<_$GateScanEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GateScanEventImplToJson(
      this,
    );
  }
}

abstract class _GateScanEvent implements GateScanEvent {
  const factory _GateScanEvent(
      {required final String id,
      required final String gatePassId,
      required final String studentId,
      required final String studentName,
      required final GateScanType scanType,
      required final DateTime scanTime,
      required final String scannedBy,
      required final String scannedByName,
      required final String gateLocation,
      final String? qrCode,
      final String? qrNonce,
      final bool? isEmergencyBypass,
      final String? emergencyReason,
      final String? notes,
      final Map<String, dynamic>? metadata}) = _$GateScanEventImpl;

  factory _GateScanEvent.fromJson(Map<String, dynamic> json) =
      _$GateScanEventImpl.fromJson;

  @override
  String get id;
  @override
  String get gatePassId;
  @override
  String get studentId;
  @override
  String get studentName;
  @override
  GateScanType get scanType;
  @override
  DateTime get scanTime;
  @override
  String get scannedBy;
  @override
  String get scannedByName;
  @override
  String get gateLocation;
  @override
  String? get qrCode;
  @override
  String? get qrNonce;
  @override
  bool? get isEmergencyBypass;
  @override
  String? get emergencyReason;
  @override
  String? get notes;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of GateScanEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GateScanEventImplCopyWith<_$GateScanEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdIntegration _$AdIntegrationFromJson(Map<String, dynamic> json) {
  return _AdIntegration.fromJson(json);
}

/// @nodoc
mixin _$AdIntegration {
  String get adId => throw _privateConstructorUsedError;
  String get adType => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get adProvider => throw _privateConstructorUsedError;
  Map<String, dynamic>? get adData => throw _privateConstructorUsedError;
  bool? get isEmergencyBypass => throw _privateConstructorUsedError;
  String? get emergencyReason => throw _privateConstructorUsedError;
  DateTime? get emergencyBypassAt => throw _privateConstructorUsedError;
  String? get emergencyBypassBy => throw _privateConstructorUsedError;

  /// Serializes this AdIntegration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdIntegration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdIntegrationCopyWith<AdIntegration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdIntegrationCopyWith<$Res> {
  factory $AdIntegrationCopyWith(
          AdIntegration value, $Res Function(AdIntegration) then) =
      _$AdIntegrationCopyWithImpl<$Res, AdIntegration>;
  @useResult
  $Res call(
      {String adId,
      String adType,
      int durationSeconds,
      bool isCompleted,
      DateTime? startedAt,
      DateTime? completedAt,
      String? adProvider,
      Map<String, dynamic>? adData,
      bool? isEmergencyBypass,
      String? emergencyReason,
      DateTime? emergencyBypassAt,
      String? emergencyBypassBy});
}

/// @nodoc
class _$AdIntegrationCopyWithImpl<$Res, $Val extends AdIntegration>
    implements $AdIntegrationCopyWith<$Res> {
  _$AdIntegrationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdIntegration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adId = null,
    Object? adType = null,
    Object? durationSeconds = null,
    Object? isCompleted = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? adProvider = freezed,
    Object? adData = freezed,
    Object? isEmergencyBypass = freezed,
    Object? emergencyReason = freezed,
    Object? emergencyBypassAt = freezed,
    Object? emergencyBypassBy = freezed,
  }) {
    return _then(_value.copyWith(
      adId: null == adId
          ? _value.adId
          : adId // ignore: cast_nullable_to_non_nullable
              as String,
      adType: null == adType
          ? _value.adType
          : adType // ignore: cast_nullable_to_non_nullable
              as String,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adProvider: freezed == adProvider
          ? _value.adProvider
          : adProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      adData: freezed == adData
          ? _value.adData
          : adData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isEmergencyBypass: freezed == isEmergencyBypass
          ? _value.isEmergencyBypass
          : isEmergencyBypass // ignore: cast_nullable_to_non_nullable
              as bool?,
      emergencyReason: freezed == emergencyReason
          ? _value.emergencyReason
          : emergencyReason // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyBypassAt: freezed == emergencyBypassAt
          ? _value.emergencyBypassAt
          : emergencyBypassAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emergencyBypassBy: freezed == emergencyBypassBy
          ? _value.emergencyBypassBy
          : emergencyBypassBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdIntegrationImplCopyWith<$Res>
    implements $AdIntegrationCopyWith<$Res> {
  factory _$$AdIntegrationImplCopyWith(
          _$AdIntegrationImpl value, $Res Function(_$AdIntegrationImpl) then) =
      __$$AdIntegrationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String adId,
      String adType,
      int durationSeconds,
      bool isCompleted,
      DateTime? startedAt,
      DateTime? completedAt,
      String? adProvider,
      Map<String, dynamic>? adData,
      bool? isEmergencyBypass,
      String? emergencyReason,
      DateTime? emergencyBypassAt,
      String? emergencyBypassBy});
}

/// @nodoc
class __$$AdIntegrationImplCopyWithImpl<$Res>
    extends _$AdIntegrationCopyWithImpl<$Res, _$AdIntegrationImpl>
    implements _$$AdIntegrationImplCopyWith<$Res> {
  __$$AdIntegrationImplCopyWithImpl(
      _$AdIntegrationImpl _value, $Res Function(_$AdIntegrationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdIntegration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adId = null,
    Object? adType = null,
    Object? durationSeconds = null,
    Object? isCompleted = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? adProvider = freezed,
    Object? adData = freezed,
    Object? isEmergencyBypass = freezed,
    Object? emergencyReason = freezed,
    Object? emergencyBypassAt = freezed,
    Object? emergencyBypassBy = freezed,
  }) {
    return _then(_$AdIntegrationImpl(
      adId: null == adId
          ? _value.adId
          : adId // ignore: cast_nullable_to_non_nullable
              as String,
      adType: null == adType
          ? _value.adType
          : adType // ignore: cast_nullable_to_non_nullable
              as String,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adProvider: freezed == adProvider
          ? _value.adProvider
          : adProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      adData: freezed == adData
          ? _value._adData
          : adData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isEmergencyBypass: freezed == isEmergencyBypass
          ? _value.isEmergencyBypass
          : isEmergencyBypass // ignore: cast_nullable_to_non_nullable
              as bool?,
      emergencyReason: freezed == emergencyReason
          ? _value.emergencyReason
          : emergencyReason // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyBypassAt: freezed == emergencyBypassAt
          ? _value.emergencyBypassAt
          : emergencyBypassAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emergencyBypassBy: freezed == emergencyBypassBy
          ? _value.emergencyBypassBy
          : emergencyBypassBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdIntegrationImpl implements _AdIntegration {
  const _$AdIntegrationImpl(
      {required this.adId,
      required this.adType,
      required this.durationSeconds,
      required this.isCompleted,
      this.startedAt,
      this.completedAt,
      this.adProvider,
      final Map<String, dynamic>? adData,
      this.isEmergencyBypass,
      this.emergencyReason,
      this.emergencyBypassAt,
      this.emergencyBypassBy})
      : _adData = adData;

  factory _$AdIntegrationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdIntegrationImplFromJson(json);

  @override
  final String adId;
  @override
  final String adType;
  @override
  final int durationSeconds;
  @override
  final bool isCompleted;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String? adProvider;
  final Map<String, dynamic>? _adData;
  @override
  Map<String, dynamic>? get adData {
    final value = _adData;
    if (value == null) return null;
    if (_adData is EqualUnmodifiableMapView) return _adData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? isEmergencyBypass;
  @override
  final String? emergencyReason;
  @override
  final DateTime? emergencyBypassAt;
  @override
  final String? emergencyBypassBy;

  @override
  String toString() {
    return 'AdIntegration(adId: $adId, adType: $adType, durationSeconds: $durationSeconds, isCompleted: $isCompleted, startedAt: $startedAt, completedAt: $completedAt, adProvider: $adProvider, adData: $adData, isEmergencyBypass: $isEmergencyBypass, emergencyReason: $emergencyReason, emergencyBypassAt: $emergencyBypassAt, emergencyBypassBy: $emergencyBypassBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdIntegrationImpl &&
            (identical(other.adId, adId) || other.adId == adId) &&
            (identical(other.adType, adType) || other.adType == adType) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.adProvider, adProvider) ||
                other.adProvider == adProvider) &&
            const DeepCollectionEquality().equals(other._adData, _adData) &&
            (identical(other.isEmergencyBypass, isEmergencyBypass) ||
                other.isEmergencyBypass == isEmergencyBypass) &&
            (identical(other.emergencyReason, emergencyReason) ||
                other.emergencyReason == emergencyReason) &&
            (identical(other.emergencyBypassAt, emergencyBypassAt) ||
                other.emergencyBypassAt == emergencyBypassAt) &&
            (identical(other.emergencyBypassBy, emergencyBypassBy) ||
                other.emergencyBypassBy == emergencyBypassBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      adId,
      adType,
      durationSeconds,
      isCompleted,
      startedAt,
      completedAt,
      adProvider,
      const DeepCollectionEquality().hash(_adData),
      isEmergencyBypass,
      emergencyReason,
      emergencyBypassAt,
      emergencyBypassBy);

  /// Create a copy of AdIntegration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdIntegrationImplCopyWith<_$AdIntegrationImpl> get copyWith =>
      __$$AdIntegrationImplCopyWithImpl<_$AdIntegrationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdIntegrationImplToJson(
      this,
    );
  }
}

abstract class _AdIntegration implements AdIntegration {
  const factory _AdIntegration(
      {required final String adId,
      required final String adType,
      required final int durationSeconds,
      required final bool isCompleted,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final String? adProvider,
      final Map<String, dynamic>? adData,
      final bool? isEmergencyBypass,
      final String? emergencyReason,
      final DateTime? emergencyBypassAt,
      final String? emergencyBypassBy}) = _$AdIntegrationImpl;

  factory _AdIntegration.fromJson(Map<String, dynamic> json) =
      _$AdIntegrationImpl.fromJson;

  @override
  String get adId;
  @override
  String get adType;
  @override
  int get durationSeconds;
  @override
  bool get isCompleted;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  String? get adProvider;
  @override
  Map<String, dynamic>? get adData;
  @override
  bool? get isEmergencyBypass;
  @override
  String? get emergencyReason;
  @override
  DateTime? get emergencyBypassAt;
  @override
  String? get emergencyBypassBy;

  /// Create a copy of AdIntegration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdIntegrationImplCopyWith<_$AdIntegrationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QRGenerationRequest _$QRGenerationRequestFromJson(Map<String, dynamic> json) {
  return _QRGenerationRequest.fromJson(json);
}

/// @nodoc
mixin _$QRGenerationRequest {
  String get gatePassId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  bool get requireAdCompletion => throw _privateConstructorUsedError;
  String? get emergencyReason => throw _privateConstructorUsedError;
  String? get emergencyBypassBy => throw _privateConstructorUsedError;

  /// Serializes this QRGenerationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QRGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QRGenerationRequestCopyWith<QRGenerationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QRGenerationRequestCopyWith<$Res> {
  factory $QRGenerationRequestCopyWith(
          QRGenerationRequest value, $Res Function(QRGenerationRequest) then) =
      _$QRGenerationRequestCopyWithImpl<$Res, QRGenerationRequest>;
  @useResult
  $Res call(
      {String gatePassId,
      String studentId,
      bool requireAdCompletion,
      String? emergencyReason,
      String? emergencyBypassBy});
}

/// @nodoc
class _$QRGenerationRequestCopyWithImpl<$Res, $Val extends QRGenerationRequest>
    implements $QRGenerationRequestCopyWith<$Res> {
  _$QRGenerationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QRGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? studentId = null,
    Object? requireAdCompletion = null,
    Object? emergencyReason = freezed,
    Object? emergencyBypassBy = freezed,
  }) {
    return _then(_value.copyWith(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      requireAdCompletion: null == requireAdCompletion
          ? _value.requireAdCompletion
          : requireAdCompletion // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyReason: freezed == emergencyReason
          ? _value.emergencyReason
          : emergencyReason // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyBypassBy: freezed == emergencyBypassBy
          ? _value.emergencyBypassBy
          : emergencyBypassBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QRGenerationRequestImplCopyWith<$Res>
    implements $QRGenerationRequestCopyWith<$Res> {
  factory _$$QRGenerationRequestImplCopyWith(_$QRGenerationRequestImpl value,
          $Res Function(_$QRGenerationRequestImpl) then) =
      __$$QRGenerationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gatePassId,
      String studentId,
      bool requireAdCompletion,
      String? emergencyReason,
      String? emergencyBypassBy});
}

/// @nodoc
class __$$QRGenerationRequestImplCopyWithImpl<$Res>
    extends _$QRGenerationRequestCopyWithImpl<$Res, _$QRGenerationRequestImpl>
    implements _$$QRGenerationRequestImplCopyWith<$Res> {
  __$$QRGenerationRequestImplCopyWithImpl(_$QRGenerationRequestImpl _value,
      $Res Function(_$QRGenerationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of QRGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? studentId = null,
    Object? requireAdCompletion = null,
    Object? emergencyReason = freezed,
    Object? emergencyBypassBy = freezed,
  }) {
    return _then(_$QRGenerationRequestImpl(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      requireAdCompletion: null == requireAdCompletion
          ? _value.requireAdCompletion
          : requireAdCompletion // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyReason: freezed == emergencyReason
          ? _value.emergencyReason
          : emergencyReason // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyBypassBy: freezed == emergencyBypassBy
          ? _value.emergencyBypassBy
          : emergencyBypassBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QRGenerationRequestImpl implements _QRGenerationRequest {
  const _$QRGenerationRequestImpl(
      {required this.gatePassId,
      required this.studentId,
      required this.requireAdCompletion,
      this.emergencyReason,
      this.emergencyBypassBy});

  factory _$QRGenerationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QRGenerationRequestImplFromJson(json);

  @override
  final String gatePassId;
  @override
  final String studentId;
  @override
  final bool requireAdCompletion;
  @override
  final String? emergencyReason;
  @override
  final String? emergencyBypassBy;

  @override
  String toString() {
    return 'QRGenerationRequest(gatePassId: $gatePassId, studentId: $studentId, requireAdCompletion: $requireAdCompletion, emergencyReason: $emergencyReason, emergencyBypassBy: $emergencyBypassBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QRGenerationRequestImpl &&
            (identical(other.gatePassId, gatePassId) ||
                other.gatePassId == gatePassId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.requireAdCompletion, requireAdCompletion) ||
                other.requireAdCompletion == requireAdCompletion) &&
            (identical(other.emergencyReason, emergencyReason) ||
                other.emergencyReason == emergencyReason) &&
            (identical(other.emergencyBypassBy, emergencyBypassBy) ||
                other.emergencyBypassBy == emergencyBypassBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, gatePassId, studentId,
      requireAdCompletion, emergencyReason, emergencyBypassBy);

  /// Create a copy of QRGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QRGenerationRequestImplCopyWith<_$QRGenerationRequestImpl> get copyWith =>
      __$$QRGenerationRequestImplCopyWithImpl<_$QRGenerationRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QRGenerationRequestImplToJson(
      this,
    );
  }
}

abstract class _QRGenerationRequest implements QRGenerationRequest {
  const factory _QRGenerationRequest(
      {required final String gatePassId,
      required final String studentId,
      required final bool requireAdCompletion,
      final String? emergencyReason,
      final String? emergencyBypassBy}) = _$QRGenerationRequestImpl;

  factory _QRGenerationRequest.fromJson(Map<String, dynamic> json) =
      _$QRGenerationRequestImpl.fromJson;

  @override
  String get gatePassId;
  @override
  String get studentId;
  @override
  bool get requireAdCompletion;
  @override
  String? get emergencyReason;
  @override
  String? get emergencyBypassBy;

  /// Create a copy of QRGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QRGenerationRequestImplCopyWith<_$QRGenerationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GatePassApprovalRequest _$GatePassApprovalRequestFromJson(
    Map<String, dynamic> json) {
  return _GatePassApprovalRequest.fromJson(json);
}

/// @nodoc
mixin _$GatePassApprovalRequest {
  String get gatePassId => throw _privateConstructorUsedError;
  bool get isApproved => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;

  /// Serializes this GatePassApprovalRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GatePassApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatePassApprovalRequestCopyWith<GatePassApprovalRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatePassApprovalRequestCopyWith<$Res> {
  factory $GatePassApprovalRequestCopyWith(GatePassApprovalRequest value,
          $Res Function(GatePassApprovalRequest) then) =
      _$GatePassApprovalRequestCopyWithImpl<$Res, GatePassApprovalRequest>;
  @useResult
  $Res call(
      {String gatePassId,
      bool isApproved,
      String? reason,
      String? approvedBy,
      DateTime? approvedAt});
}

/// @nodoc
class _$GatePassApprovalRequestCopyWithImpl<$Res,
        $Val extends GatePassApprovalRequest>
    implements $GatePassApprovalRequestCopyWith<$Res> {
  _$GatePassApprovalRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatePassApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? isApproved = null,
    Object? reason = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
  }) {
    return _then(_value.copyWith(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GatePassApprovalRequestImplCopyWith<$Res>
    implements $GatePassApprovalRequestCopyWith<$Res> {
  factory _$$GatePassApprovalRequestImplCopyWith(
          _$GatePassApprovalRequestImpl value,
          $Res Function(_$GatePassApprovalRequestImpl) then) =
      __$$GatePassApprovalRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gatePassId,
      bool isApproved,
      String? reason,
      String? approvedBy,
      DateTime? approvedAt});
}

/// @nodoc
class __$$GatePassApprovalRequestImplCopyWithImpl<$Res>
    extends _$GatePassApprovalRequestCopyWithImpl<$Res,
        _$GatePassApprovalRequestImpl>
    implements _$$GatePassApprovalRequestImplCopyWith<$Res> {
  __$$GatePassApprovalRequestImplCopyWithImpl(
      _$GatePassApprovalRequestImpl _value,
      $Res Function(_$GatePassApprovalRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of GatePassApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? isApproved = null,
    Object? reason = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
  }) {
    return _then(_$GatePassApprovalRequestImpl(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GatePassApprovalRequestImpl implements _GatePassApprovalRequest {
  const _$GatePassApprovalRequestImpl(
      {required this.gatePassId,
      required this.isApproved,
      this.reason,
      this.approvedBy,
      this.approvedAt});

  factory _$GatePassApprovalRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassApprovalRequestImplFromJson(json);

  @override
  final String gatePassId;
  @override
  final bool isApproved;
  @override
  final String? reason;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;

  @override
  String toString() {
    return 'GatePassApprovalRequest(gatePassId: $gatePassId, isApproved: $isApproved, reason: $reason, approvedBy: $approvedBy, approvedAt: $approvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassApprovalRequestImpl &&
            (identical(other.gatePassId, gatePassId) ||
                other.gatePassId == gatePassId) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, gatePassId, isApproved, reason, approvedBy, approvedAt);

  /// Create a copy of GatePassApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatePassApprovalRequestImplCopyWith<_$GatePassApprovalRequestImpl>
      get copyWith => __$$GatePassApprovalRequestImplCopyWithImpl<
          _$GatePassApprovalRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GatePassApprovalRequestImplToJson(
      this,
    );
  }
}

abstract class _GatePassApprovalRequest implements GatePassApprovalRequest {
  const factory _GatePassApprovalRequest(
      {required final String gatePassId,
      required final bool isApproved,
      final String? reason,
      final String? approvedBy,
      final DateTime? approvedAt}) = _$GatePassApprovalRequestImpl;

  factory _GatePassApprovalRequest.fromJson(Map<String, dynamic> json) =
      _$GatePassApprovalRequestImpl.fromJson;

  @override
  String get gatePassId;
  @override
  bool get isApproved;
  @override
  String? get reason;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;

  /// Create a copy of GatePassApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassApprovalRequestImplCopyWith<_$GatePassApprovalRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GatePassStatistics _$GatePassStatisticsFromJson(Map<String, dynamic> json) {
  return _GatePassStatistics.fromJson(json);
}

/// @nodoc
mixin _$GatePassStatistics {
  String get period => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get totalRequests => throw _privateConstructorUsedError;
  int get approvedRequests => throw _privateConstructorUsedError;
  int get rejectedRequests => throw _privateConstructorUsedError;
  int get pendingRequests => throw _privateConstructorUsedError;
  int get activePasses => throw _privateConstructorUsedError;
  int get completedPasses => throw _privateConstructorUsedError;
  int get overduePasses => throw _privateConstructorUsedError;
  double get approvalRate => throw _privateConstructorUsedError;
  double get completionRate => throw _privateConstructorUsedError;
  Map<String, int> get requestsByType => throw _privateConstructorUsedError;
  Map<String, int> get requestsByPriority => throw _privateConstructorUsedError;
  Map<String, int> get requestsByStatus => throw _privateConstructorUsedError;
  List<String> get topReasons => throw _privateConstructorUsedError;
  List<String> get topDestinations => throw _privateConstructorUsedError;
  Map<String, dynamic>? get trends => throw _privateConstructorUsedError;

  /// Serializes this GatePassStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GatePassStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatePassStatisticsCopyWith<GatePassStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatePassStatisticsCopyWith<$Res> {
  factory $GatePassStatisticsCopyWith(
          GatePassStatistics value, $Res Function(GatePassStatistics) then) =
      _$GatePassStatisticsCopyWithImpl<$Res, GatePassStatistics>;
  @useResult
  $Res call(
      {String period,
      DateTime startDate,
      DateTime endDate,
      int totalRequests,
      int approvedRequests,
      int rejectedRequests,
      int pendingRequests,
      int activePasses,
      int completedPasses,
      int overduePasses,
      double approvalRate,
      double completionRate,
      Map<String, int> requestsByType,
      Map<String, int> requestsByPriority,
      Map<String, int> requestsByStatus,
      List<String> topReasons,
      List<String> topDestinations,
      Map<String, dynamic>? trends});
}

/// @nodoc
class _$GatePassStatisticsCopyWithImpl<$Res, $Val extends GatePassStatistics>
    implements $GatePassStatisticsCopyWith<$Res> {
  _$GatePassStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatePassStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalRequests = null,
    Object? approvedRequests = null,
    Object? rejectedRequests = null,
    Object? pendingRequests = null,
    Object? activePasses = null,
    Object? completedPasses = null,
    Object? overduePasses = null,
    Object? approvalRate = null,
    Object? completionRate = null,
    Object? requestsByType = null,
    Object? requestsByPriority = null,
    Object? requestsByStatus = null,
    Object? topReasons = null,
    Object? topDestinations = null,
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
      totalRequests: null == totalRequests
          ? _value.totalRequests
          : totalRequests // ignore: cast_nullable_to_non_nullable
              as int,
      approvedRequests: null == approvedRequests
          ? _value.approvedRequests
          : approvedRequests // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedRequests: null == rejectedRequests
          ? _value.rejectedRequests
          : rejectedRequests // ignore: cast_nullable_to_non_nullable
              as int,
      pendingRequests: null == pendingRequests
          ? _value.pendingRequests
          : pendingRequests // ignore: cast_nullable_to_non_nullable
              as int,
      activePasses: null == activePasses
          ? _value.activePasses
          : activePasses // ignore: cast_nullable_to_non_nullable
              as int,
      completedPasses: null == completedPasses
          ? _value.completedPasses
          : completedPasses // ignore: cast_nullable_to_non_nullable
              as int,
      overduePasses: null == overduePasses
          ? _value.overduePasses
          : overduePasses // ignore: cast_nullable_to_non_nullable
              as int,
      approvalRate: null == approvalRate
          ? _value.approvalRate
          : approvalRate // ignore: cast_nullable_to_non_nullable
              as double,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      requestsByType: null == requestsByType
          ? _value.requestsByType
          : requestsByType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      requestsByPriority: null == requestsByPriority
          ? _value.requestsByPriority
          : requestsByPriority // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      requestsByStatus: null == requestsByStatus
          ? _value.requestsByStatus
          : requestsByStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      topReasons: null == topReasons
          ? _value.topReasons
          : topReasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topDestinations: null == topDestinations
          ? _value.topDestinations
          : topDestinations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trends: freezed == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GatePassStatisticsImplCopyWith<$Res>
    implements $GatePassStatisticsCopyWith<$Res> {
  factory _$$GatePassStatisticsImplCopyWith(_$GatePassStatisticsImpl value,
          $Res Function(_$GatePassStatisticsImpl) then) =
      __$$GatePassStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String period,
      DateTime startDate,
      DateTime endDate,
      int totalRequests,
      int approvedRequests,
      int rejectedRequests,
      int pendingRequests,
      int activePasses,
      int completedPasses,
      int overduePasses,
      double approvalRate,
      double completionRate,
      Map<String, int> requestsByType,
      Map<String, int> requestsByPriority,
      Map<String, int> requestsByStatus,
      List<String> topReasons,
      List<String> topDestinations,
      Map<String, dynamic>? trends});
}

/// @nodoc
class __$$GatePassStatisticsImplCopyWithImpl<$Res>
    extends _$GatePassStatisticsCopyWithImpl<$Res, _$GatePassStatisticsImpl>
    implements _$$GatePassStatisticsImplCopyWith<$Res> {
  __$$GatePassStatisticsImplCopyWithImpl(_$GatePassStatisticsImpl _value,
      $Res Function(_$GatePassStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GatePassStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalRequests = null,
    Object? approvedRequests = null,
    Object? rejectedRequests = null,
    Object? pendingRequests = null,
    Object? activePasses = null,
    Object? completedPasses = null,
    Object? overduePasses = null,
    Object? approvalRate = null,
    Object? completionRate = null,
    Object? requestsByType = null,
    Object? requestsByPriority = null,
    Object? requestsByStatus = null,
    Object? topReasons = null,
    Object? topDestinations = null,
    Object? trends = freezed,
  }) {
    return _then(_$GatePassStatisticsImpl(
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
      totalRequests: null == totalRequests
          ? _value.totalRequests
          : totalRequests // ignore: cast_nullable_to_non_nullable
              as int,
      approvedRequests: null == approvedRequests
          ? _value.approvedRequests
          : approvedRequests // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedRequests: null == rejectedRequests
          ? _value.rejectedRequests
          : rejectedRequests // ignore: cast_nullable_to_non_nullable
              as int,
      pendingRequests: null == pendingRequests
          ? _value.pendingRequests
          : pendingRequests // ignore: cast_nullable_to_non_nullable
              as int,
      activePasses: null == activePasses
          ? _value.activePasses
          : activePasses // ignore: cast_nullable_to_non_nullable
              as int,
      completedPasses: null == completedPasses
          ? _value.completedPasses
          : completedPasses // ignore: cast_nullable_to_non_nullable
              as int,
      overduePasses: null == overduePasses
          ? _value.overduePasses
          : overduePasses // ignore: cast_nullable_to_non_nullable
              as int,
      approvalRate: null == approvalRate
          ? _value.approvalRate
          : approvalRate // ignore: cast_nullable_to_non_nullable
              as double,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      requestsByType: null == requestsByType
          ? _value._requestsByType
          : requestsByType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      requestsByPriority: null == requestsByPriority
          ? _value._requestsByPriority
          : requestsByPriority // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      requestsByStatus: null == requestsByStatus
          ? _value._requestsByStatus
          : requestsByStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      topReasons: null == topReasons
          ? _value._topReasons
          : topReasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topDestinations: null == topDestinations
          ? _value._topDestinations
          : topDestinations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trends: freezed == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GatePassStatisticsImpl implements _GatePassStatistics {
  const _$GatePassStatisticsImpl(
      {required this.period,
      required this.startDate,
      required this.endDate,
      required this.totalRequests,
      required this.approvedRequests,
      required this.rejectedRequests,
      required this.pendingRequests,
      required this.activePasses,
      required this.completedPasses,
      required this.overduePasses,
      required this.approvalRate,
      required this.completionRate,
      required final Map<String, int> requestsByType,
      required final Map<String, int> requestsByPriority,
      required final Map<String, int> requestsByStatus,
      required final List<String> topReasons,
      required final List<String> topDestinations,
      final Map<String, dynamic>? trends})
      : _requestsByType = requestsByType,
        _requestsByPriority = requestsByPriority,
        _requestsByStatus = requestsByStatus,
        _topReasons = topReasons,
        _topDestinations = topDestinations,
        _trends = trends;

  factory _$GatePassStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassStatisticsImplFromJson(json);

  @override
  final String period;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int totalRequests;
  @override
  final int approvedRequests;
  @override
  final int rejectedRequests;
  @override
  final int pendingRequests;
  @override
  final int activePasses;
  @override
  final int completedPasses;
  @override
  final int overduePasses;
  @override
  final double approvalRate;
  @override
  final double completionRate;
  final Map<String, int> _requestsByType;
  @override
  Map<String, int> get requestsByType {
    if (_requestsByType is EqualUnmodifiableMapView) return _requestsByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requestsByType);
  }

  final Map<String, int> _requestsByPriority;
  @override
  Map<String, int> get requestsByPriority {
    if (_requestsByPriority is EqualUnmodifiableMapView)
      return _requestsByPriority;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requestsByPriority);
  }

  final Map<String, int> _requestsByStatus;
  @override
  Map<String, int> get requestsByStatus {
    if (_requestsByStatus is EqualUnmodifiableMapView) return _requestsByStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requestsByStatus);
  }

  final List<String> _topReasons;
  @override
  List<String> get topReasons {
    if (_topReasons is EqualUnmodifiableListView) return _topReasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topReasons);
  }

  final List<String> _topDestinations;
  @override
  List<String> get topDestinations {
    if (_topDestinations is EqualUnmodifiableListView) return _topDestinations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topDestinations);
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
    return 'GatePassStatistics(period: $period, startDate: $startDate, endDate: $endDate, totalRequests: $totalRequests, approvedRequests: $approvedRequests, rejectedRequests: $rejectedRequests, pendingRequests: $pendingRequests, activePasses: $activePasses, completedPasses: $completedPasses, overduePasses: $overduePasses, approvalRate: $approvalRate, completionRate: $completionRate, requestsByType: $requestsByType, requestsByPriority: $requestsByPriority, requestsByStatus: $requestsByStatus, topReasons: $topReasons, topDestinations: $topDestinations, trends: $trends)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassStatisticsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalRequests, totalRequests) ||
                other.totalRequests == totalRequests) &&
            (identical(other.approvedRequests, approvedRequests) ||
                other.approvedRequests == approvedRequests) &&
            (identical(other.rejectedRequests, rejectedRequests) ||
                other.rejectedRequests == rejectedRequests) &&
            (identical(other.pendingRequests, pendingRequests) ||
                other.pendingRequests == pendingRequests) &&
            (identical(other.activePasses, activePasses) ||
                other.activePasses == activePasses) &&
            (identical(other.completedPasses, completedPasses) ||
                other.completedPasses == completedPasses) &&
            (identical(other.overduePasses, overduePasses) ||
                other.overduePasses == overduePasses) &&
            (identical(other.approvalRate, approvalRate) ||
                other.approvalRate == approvalRate) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            const DeepCollectionEquality()
                .equals(other._requestsByType, _requestsByType) &&
            const DeepCollectionEquality()
                .equals(other._requestsByPriority, _requestsByPriority) &&
            const DeepCollectionEquality()
                .equals(other._requestsByStatus, _requestsByStatus) &&
            const DeepCollectionEquality()
                .equals(other._topReasons, _topReasons) &&
            const DeepCollectionEquality()
                .equals(other._topDestinations, _topDestinations) &&
            const DeepCollectionEquality().equals(other._trends, _trends));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      period,
      startDate,
      endDate,
      totalRequests,
      approvedRequests,
      rejectedRequests,
      pendingRequests,
      activePasses,
      completedPasses,
      overduePasses,
      approvalRate,
      completionRate,
      const DeepCollectionEquality().hash(_requestsByType),
      const DeepCollectionEquality().hash(_requestsByPriority),
      const DeepCollectionEquality().hash(_requestsByStatus),
      const DeepCollectionEquality().hash(_topReasons),
      const DeepCollectionEquality().hash(_topDestinations),
      const DeepCollectionEquality().hash(_trends));

  /// Create a copy of GatePassStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatePassStatisticsImplCopyWith<_$GatePassStatisticsImpl> get copyWith =>
      __$$GatePassStatisticsImplCopyWithImpl<_$GatePassStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GatePassStatisticsImplToJson(
      this,
    );
  }
}

abstract class _GatePassStatistics implements GatePassStatistics {
  const factory _GatePassStatistics(
      {required final String period,
      required final DateTime startDate,
      required final DateTime endDate,
      required final int totalRequests,
      required final int approvedRequests,
      required final int rejectedRequests,
      required final int pendingRequests,
      required final int activePasses,
      required final int completedPasses,
      required final int overduePasses,
      required final double approvalRate,
      required final double completionRate,
      required final Map<String, int> requestsByType,
      required final Map<String, int> requestsByPriority,
      required final Map<String, int> requestsByStatus,
      required final List<String> topReasons,
      required final List<String> topDestinations,
      final Map<String, dynamic>? trends}) = _$GatePassStatisticsImpl;

  factory _GatePassStatistics.fromJson(Map<String, dynamic> json) =
      _$GatePassStatisticsImpl.fromJson;

  @override
  String get period;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get totalRequests;
  @override
  int get approvedRequests;
  @override
  int get rejectedRequests;
  @override
  int get pendingRequests;
  @override
  int get activePasses;
  @override
  int get completedPasses;
  @override
  int get overduePasses;
  @override
  double get approvalRate;
  @override
  double get completionRate;
  @override
  Map<String, int> get requestsByType;
  @override
  Map<String, int> get requestsByPriority;
  @override
  Map<String, int> get requestsByStatus;
  @override
  List<String> get topReasons;
  @override
  List<String> get topDestinations;
  @override
  Map<String, dynamic>? get trends;

  /// Create a copy of GatePassStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassStatisticsImplCopyWith<_$GatePassStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GatePassHistory _$GatePassHistoryFromJson(Map<String, dynamic> json) {
  return _GatePassHistory.fromJson(json);
}

/// @nodoc
mixin _$GatePassHistory {
  String get id => throw _privateConstructorUsedError;
  String get gatePassId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String get performedBy => throw _privateConstructorUsedError;
  String get performedByName => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  Map<String, dynamic>? get oldValues => throw _privateConstructorUsedError;
  Map<String, dynamic>? get newValues => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this GatePassHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GatePassHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatePassHistoryCopyWith<GatePassHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatePassHistoryCopyWith<$Res> {
  factory $GatePassHistoryCopyWith(
          GatePassHistory value, $Res Function(GatePassHistory) then) =
      _$GatePassHistoryCopyWithImpl<$Res, GatePassHistory>;
  @useResult
  $Res call(
      {String id,
      String gatePassId,
      String action,
      String performedBy,
      String performedByName,
      DateTime timestamp,
      String? reason,
      Map<String, dynamic>? oldValues,
      Map<String, dynamic>? newValues,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$GatePassHistoryCopyWithImpl<$Res, $Val extends GatePassHistory>
    implements $GatePassHistoryCopyWith<$Res> {
  _$GatePassHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatePassHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gatePassId = null,
    Object? action = null,
    Object? performedBy = null,
    Object? performedByName = null,
    Object? timestamp = null,
    Object? reason = freezed,
    Object? oldValues = freezed,
    Object? newValues = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      performedByName: null == performedByName
          ? _value.performedByName
          : performedByName // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      oldValues: freezed == oldValues
          ? _value.oldValues
          : oldValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      newValues: freezed == newValues
          ? _value.newValues
          : newValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GatePassHistoryImplCopyWith<$Res>
    implements $GatePassHistoryCopyWith<$Res> {
  factory _$$GatePassHistoryImplCopyWith(_$GatePassHistoryImpl value,
          $Res Function(_$GatePassHistoryImpl) then) =
      __$$GatePassHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String gatePassId,
      String action,
      String performedBy,
      String performedByName,
      DateTime timestamp,
      String? reason,
      Map<String, dynamic>? oldValues,
      Map<String, dynamic>? newValues,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$GatePassHistoryImplCopyWithImpl<$Res>
    extends _$GatePassHistoryCopyWithImpl<$Res, _$GatePassHistoryImpl>
    implements _$$GatePassHistoryImplCopyWith<$Res> {
  __$$GatePassHistoryImplCopyWithImpl(
      _$GatePassHistoryImpl _value, $Res Function(_$GatePassHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of GatePassHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gatePassId = null,
    Object? action = null,
    Object? performedBy = null,
    Object? performedByName = null,
    Object? timestamp = null,
    Object? reason = freezed,
    Object? oldValues = freezed,
    Object? newValues = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$GatePassHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      performedByName: null == performedByName
          ? _value.performedByName
          : performedByName // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      oldValues: freezed == oldValues
          ? _value._oldValues
          : oldValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      newValues: freezed == newValues
          ? _value._newValues
          : newValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GatePassHistoryImpl implements _GatePassHistory {
  const _$GatePassHistoryImpl(
      {required this.id,
      required this.gatePassId,
      required this.action,
      required this.performedBy,
      required this.performedByName,
      required this.timestamp,
      this.reason,
      final Map<String, dynamic>? oldValues,
      final Map<String, dynamic>? newValues,
      final Map<String, dynamic>? metadata})
      : _oldValues = oldValues,
        _newValues = newValues,
        _metadata = metadata;

  factory _$GatePassHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String gatePassId;
  @override
  final String action;
  @override
  final String performedBy;
  @override
  final String performedByName;
  @override
  final DateTime timestamp;
  @override
  final String? reason;
  final Map<String, dynamic>? _oldValues;
  @override
  Map<String, dynamic>? get oldValues {
    final value = _oldValues;
    if (value == null) return null;
    if (_oldValues is EqualUnmodifiableMapView) return _oldValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _newValues;
  @override
  Map<String, dynamic>? get newValues {
    final value = _newValues;
    if (value == null) return null;
    if (_newValues is EqualUnmodifiableMapView) return _newValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
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
    return 'GatePassHistory(id: $id, gatePassId: $gatePassId, action: $action, performedBy: $performedBy, performedByName: $performedByName, timestamp: $timestamp, reason: $reason, oldValues: $oldValues, newValues: $newValues, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gatePassId, gatePassId) ||
                other.gatePassId == gatePassId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.performedByName, performedByName) ||
                other.performedByName == performedByName) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality()
                .equals(other._oldValues, _oldValues) &&
            const DeepCollectionEquality()
                .equals(other._newValues, _newValues) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      gatePassId,
      action,
      performedBy,
      performedByName,
      timestamp,
      reason,
      const DeepCollectionEquality().hash(_oldValues),
      const DeepCollectionEquality().hash(_newValues),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of GatePassHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatePassHistoryImplCopyWith<_$GatePassHistoryImpl> get copyWith =>
      __$$GatePassHistoryImplCopyWithImpl<_$GatePassHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GatePassHistoryImplToJson(
      this,
    );
  }
}

abstract class _GatePassHistory implements GatePassHistory {
  const factory _GatePassHistory(
      {required final String id,
      required final String gatePassId,
      required final String action,
      required final String performedBy,
      required final String performedByName,
      required final DateTime timestamp,
      final String? reason,
      final Map<String, dynamic>? oldValues,
      final Map<String, dynamic>? newValues,
      final Map<String, dynamic>? metadata}) = _$GatePassHistoryImpl;

  factory _GatePassHistory.fromJson(Map<String, dynamic> json) =
      _$GatePassHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get gatePassId;
  @override
  String get action;
  @override
  String get performedBy;
  @override
  String get performedByName;
  @override
  DateTime get timestamp;
  @override
  String? get reason;
  @override
  Map<String, dynamic>? get oldValues;
  @override
  Map<String, dynamic>? get newValues;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of GatePassHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassHistoryImplCopyWith<_$GatePassHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmergencyBypassRequest _$EmergencyBypassRequestFromJson(
    Map<String, dynamic> json) {
  return _EmergencyBypassRequest.fromJson(json);
}

/// @nodoc
mixin _$EmergencyBypassRequest {
  String get gatePassId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String get bypassedBy => throw _privateConstructorUsedError;
  String get bypassedByName => throw _privateConstructorUsedError;
  DateTime get bypassedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this EmergencyBypassRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmergencyBypassRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmergencyBypassRequestCopyWith<EmergencyBypassRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmergencyBypassRequestCopyWith<$Res> {
  factory $EmergencyBypassRequestCopyWith(EmergencyBypassRequest value,
          $Res Function(EmergencyBypassRequest) then) =
      _$EmergencyBypassRequestCopyWithImpl<$Res, EmergencyBypassRequest>;
  @useResult
  $Res call(
      {String gatePassId,
      String reason,
      String bypassedBy,
      String bypassedByName,
      DateTime bypassedAt,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$EmergencyBypassRequestCopyWithImpl<$Res,
        $Val extends EmergencyBypassRequest>
    implements $EmergencyBypassRequestCopyWith<$Res> {
  _$EmergencyBypassRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmergencyBypassRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? reason = null,
    Object? bypassedBy = null,
    Object? bypassedByName = null,
    Object? bypassedAt = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      bypassedBy: null == bypassedBy
          ? _value.bypassedBy
          : bypassedBy // ignore: cast_nullable_to_non_nullable
              as String,
      bypassedByName: null == bypassedByName
          ? _value.bypassedByName
          : bypassedByName // ignore: cast_nullable_to_non_nullable
              as String,
      bypassedAt: null == bypassedAt
          ? _value.bypassedAt
          : bypassedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$EmergencyBypassRequestImplCopyWith<$Res>
    implements $EmergencyBypassRequestCopyWith<$Res> {
  factory _$$EmergencyBypassRequestImplCopyWith(
          _$EmergencyBypassRequestImpl value,
          $Res Function(_$EmergencyBypassRequestImpl) then) =
      __$$EmergencyBypassRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gatePassId,
      String reason,
      String bypassedBy,
      String bypassedByName,
      DateTime bypassedAt,
      String? notes,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$EmergencyBypassRequestImplCopyWithImpl<$Res>
    extends _$EmergencyBypassRequestCopyWithImpl<$Res,
        _$EmergencyBypassRequestImpl>
    implements _$$EmergencyBypassRequestImplCopyWith<$Res> {
  __$$EmergencyBypassRequestImplCopyWithImpl(
      _$EmergencyBypassRequestImpl _value,
      $Res Function(_$EmergencyBypassRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmergencyBypassRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatePassId = null,
    Object? reason = null,
    Object? bypassedBy = null,
    Object? bypassedByName = null,
    Object? bypassedAt = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$EmergencyBypassRequestImpl(
      gatePassId: null == gatePassId
          ? _value.gatePassId
          : gatePassId // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      bypassedBy: null == bypassedBy
          ? _value.bypassedBy
          : bypassedBy // ignore: cast_nullable_to_non_nullable
              as String,
      bypassedByName: null == bypassedByName
          ? _value.bypassedByName
          : bypassedByName // ignore: cast_nullable_to_non_nullable
              as String,
      bypassedAt: null == bypassedAt
          ? _value.bypassedAt
          : bypassedAt // ignore: cast_nullable_to_non_nullable
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
class _$EmergencyBypassRequestImpl implements _EmergencyBypassRequest {
  const _$EmergencyBypassRequestImpl(
      {required this.gatePassId,
      required this.reason,
      required this.bypassedBy,
      required this.bypassedByName,
      required this.bypassedAt,
      this.notes,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$EmergencyBypassRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmergencyBypassRequestImplFromJson(json);

  @override
  final String gatePassId;
  @override
  final String reason;
  @override
  final String bypassedBy;
  @override
  final String bypassedByName;
  @override
  final DateTime bypassedAt;
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
    return 'EmergencyBypassRequest(gatePassId: $gatePassId, reason: $reason, bypassedBy: $bypassedBy, bypassedByName: $bypassedByName, bypassedAt: $bypassedAt, notes: $notes, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmergencyBypassRequestImpl &&
            (identical(other.gatePassId, gatePassId) ||
                other.gatePassId == gatePassId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.bypassedBy, bypassedBy) ||
                other.bypassedBy == bypassedBy) &&
            (identical(other.bypassedByName, bypassedByName) ||
                other.bypassedByName == bypassedByName) &&
            (identical(other.bypassedAt, bypassedAt) ||
                other.bypassedAt == bypassedAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      gatePassId,
      reason,
      bypassedBy,
      bypassedByName,
      bypassedAt,
      notes,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of EmergencyBypassRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmergencyBypassRequestImplCopyWith<_$EmergencyBypassRequestImpl>
      get copyWith => __$$EmergencyBypassRequestImplCopyWithImpl<
          _$EmergencyBypassRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmergencyBypassRequestImplToJson(
      this,
    );
  }
}

abstract class _EmergencyBypassRequest implements EmergencyBypassRequest {
  const factory _EmergencyBypassRequest(
      {required final String gatePassId,
      required final String reason,
      required final String bypassedBy,
      required final String bypassedByName,
      required final DateTime bypassedAt,
      final String? notes,
      final Map<String, dynamic>? metadata}) = _$EmergencyBypassRequestImpl;

  factory _EmergencyBypassRequest.fromJson(Map<String, dynamic> json) =
      _$EmergencyBypassRequestImpl.fromJson;

  @override
  String get gatePassId;
  @override
  String get reason;
  @override
  String get bypassedBy;
  @override
  String get bypassedByName;
  @override
  DateTime get bypassedAt;
  @override
  String? get notes;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of EmergencyBypassRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmergencyBypassRequestImplCopyWith<_$EmergencyBypassRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GatePassDashboardData _$GatePassDashboardDataFromJson(
    Map<String, dynamic> json) {
  return _GatePassDashboardData.fromJson(json);
}

/// @nodoc
mixin _$GatePassDashboardData {
  int get pendingApprovals => throw _privateConstructorUsedError;
  int get activePasses => throw _privateConstructorUsedError;
  int get overduePasses => throw _privateConstructorUsedError;
  int get todayDepartures => throw _privateConstructorUsedError;
  int get todayReturns => throw _privateConstructorUsedError;
  int get emergencyBypasses => throw _privateConstructorUsedError;
  List<GatePass> get recentRequests => throw _privateConstructorUsedError;
  List<GateScanEvent> get recentScans => throw _privateConstructorUsedError;
  Map<String, dynamic> get hourlyStats => throw _privateConstructorUsedError;
  Map<String, dynamic> get dailyStats => throw _privateConstructorUsedError;

  /// Serializes this GatePassDashboardData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GatePassDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatePassDashboardDataCopyWith<GatePassDashboardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatePassDashboardDataCopyWith<$Res> {
  factory $GatePassDashboardDataCopyWith(GatePassDashboardData value,
          $Res Function(GatePassDashboardData) then) =
      _$GatePassDashboardDataCopyWithImpl<$Res, GatePassDashboardData>;
  @useResult
  $Res call(
      {int pendingApprovals,
      int activePasses,
      int overduePasses,
      int todayDepartures,
      int todayReturns,
      int emergencyBypasses,
      List<GatePass> recentRequests,
      List<GateScanEvent> recentScans,
      Map<String, dynamic> hourlyStats,
      Map<String, dynamic> dailyStats});
}

/// @nodoc
class _$GatePassDashboardDataCopyWithImpl<$Res,
        $Val extends GatePassDashboardData>
    implements $GatePassDashboardDataCopyWith<$Res> {
  _$GatePassDashboardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatePassDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pendingApprovals = null,
    Object? activePasses = null,
    Object? overduePasses = null,
    Object? todayDepartures = null,
    Object? todayReturns = null,
    Object? emergencyBypasses = null,
    Object? recentRequests = null,
    Object? recentScans = null,
    Object? hourlyStats = null,
    Object? dailyStats = null,
  }) {
    return _then(_value.copyWith(
      pendingApprovals: null == pendingApprovals
          ? _value.pendingApprovals
          : pendingApprovals // ignore: cast_nullable_to_non_nullable
              as int,
      activePasses: null == activePasses
          ? _value.activePasses
          : activePasses // ignore: cast_nullable_to_non_nullable
              as int,
      overduePasses: null == overduePasses
          ? _value.overduePasses
          : overduePasses // ignore: cast_nullable_to_non_nullable
              as int,
      todayDepartures: null == todayDepartures
          ? _value.todayDepartures
          : todayDepartures // ignore: cast_nullable_to_non_nullable
              as int,
      todayReturns: null == todayReturns
          ? _value.todayReturns
          : todayReturns // ignore: cast_nullable_to_non_nullable
              as int,
      emergencyBypasses: null == emergencyBypasses
          ? _value.emergencyBypasses
          : emergencyBypasses // ignore: cast_nullable_to_non_nullable
              as int,
      recentRequests: null == recentRequests
          ? _value.recentRequests
          : recentRequests // ignore: cast_nullable_to_non_nullable
              as List<GatePass>,
      recentScans: null == recentScans
          ? _value.recentScans
          : recentScans // ignore: cast_nullable_to_non_nullable
              as List<GateScanEvent>,
      hourlyStats: null == hourlyStats
          ? _value.hourlyStats
          : hourlyStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      dailyStats: null == dailyStats
          ? _value.dailyStats
          : dailyStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GatePassDashboardDataImplCopyWith<$Res>
    implements $GatePassDashboardDataCopyWith<$Res> {
  factory _$$GatePassDashboardDataImplCopyWith(
          _$GatePassDashboardDataImpl value,
          $Res Function(_$GatePassDashboardDataImpl) then) =
      __$$GatePassDashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pendingApprovals,
      int activePasses,
      int overduePasses,
      int todayDepartures,
      int todayReturns,
      int emergencyBypasses,
      List<GatePass> recentRequests,
      List<GateScanEvent> recentScans,
      Map<String, dynamic> hourlyStats,
      Map<String, dynamic> dailyStats});
}

/// @nodoc
class __$$GatePassDashboardDataImplCopyWithImpl<$Res>
    extends _$GatePassDashboardDataCopyWithImpl<$Res,
        _$GatePassDashboardDataImpl>
    implements _$$GatePassDashboardDataImplCopyWith<$Res> {
  __$$GatePassDashboardDataImplCopyWithImpl(_$GatePassDashboardDataImpl _value,
      $Res Function(_$GatePassDashboardDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of GatePassDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pendingApprovals = null,
    Object? activePasses = null,
    Object? overduePasses = null,
    Object? todayDepartures = null,
    Object? todayReturns = null,
    Object? emergencyBypasses = null,
    Object? recentRequests = null,
    Object? recentScans = null,
    Object? hourlyStats = null,
    Object? dailyStats = null,
  }) {
    return _then(_$GatePassDashboardDataImpl(
      pendingApprovals: null == pendingApprovals
          ? _value.pendingApprovals
          : pendingApprovals // ignore: cast_nullable_to_non_nullable
              as int,
      activePasses: null == activePasses
          ? _value.activePasses
          : activePasses // ignore: cast_nullable_to_non_nullable
              as int,
      overduePasses: null == overduePasses
          ? _value.overduePasses
          : overduePasses // ignore: cast_nullable_to_non_nullable
              as int,
      todayDepartures: null == todayDepartures
          ? _value.todayDepartures
          : todayDepartures // ignore: cast_nullable_to_non_nullable
              as int,
      todayReturns: null == todayReturns
          ? _value.todayReturns
          : todayReturns // ignore: cast_nullable_to_non_nullable
              as int,
      emergencyBypasses: null == emergencyBypasses
          ? _value.emergencyBypasses
          : emergencyBypasses // ignore: cast_nullable_to_non_nullable
              as int,
      recentRequests: null == recentRequests
          ? _value._recentRequests
          : recentRequests // ignore: cast_nullable_to_non_nullable
              as List<GatePass>,
      recentScans: null == recentScans
          ? _value._recentScans
          : recentScans // ignore: cast_nullable_to_non_nullable
              as List<GateScanEvent>,
      hourlyStats: null == hourlyStats
          ? _value._hourlyStats
          : hourlyStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      dailyStats: null == dailyStats
          ? _value._dailyStats
          : dailyStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GatePassDashboardDataImpl implements _GatePassDashboardData {
  const _$GatePassDashboardDataImpl(
      {required this.pendingApprovals,
      required this.activePasses,
      required this.overduePasses,
      required this.todayDepartures,
      required this.todayReturns,
      required this.emergencyBypasses,
      required final List<GatePass> recentRequests,
      required final List<GateScanEvent> recentScans,
      required final Map<String, dynamic> hourlyStats,
      required final Map<String, dynamic> dailyStats})
      : _recentRequests = recentRequests,
        _recentScans = recentScans,
        _hourlyStats = hourlyStats,
        _dailyStats = dailyStats;

  factory _$GatePassDashboardDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GatePassDashboardDataImplFromJson(json);

  @override
  final int pendingApprovals;
  @override
  final int activePasses;
  @override
  final int overduePasses;
  @override
  final int todayDepartures;
  @override
  final int todayReturns;
  @override
  final int emergencyBypasses;
  final List<GatePass> _recentRequests;
  @override
  List<GatePass> get recentRequests {
    if (_recentRequests is EqualUnmodifiableListView) return _recentRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentRequests);
  }

  final List<GateScanEvent> _recentScans;
  @override
  List<GateScanEvent> get recentScans {
    if (_recentScans is EqualUnmodifiableListView) return _recentScans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentScans);
  }

  final Map<String, dynamic> _hourlyStats;
  @override
  Map<String, dynamic> get hourlyStats {
    if (_hourlyStats is EqualUnmodifiableMapView) return _hourlyStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hourlyStats);
  }

  final Map<String, dynamic> _dailyStats;
  @override
  Map<String, dynamic> get dailyStats {
    if (_dailyStats is EqualUnmodifiableMapView) return _dailyStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dailyStats);
  }

  @override
  String toString() {
    return 'GatePassDashboardData(pendingApprovals: $pendingApprovals, activePasses: $activePasses, overduePasses: $overduePasses, todayDepartures: $todayDepartures, todayReturns: $todayReturns, emergencyBypasses: $emergencyBypasses, recentRequests: $recentRequests, recentScans: $recentScans, hourlyStats: $hourlyStats, dailyStats: $dailyStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatePassDashboardDataImpl &&
            (identical(other.pendingApprovals, pendingApprovals) ||
                other.pendingApprovals == pendingApprovals) &&
            (identical(other.activePasses, activePasses) ||
                other.activePasses == activePasses) &&
            (identical(other.overduePasses, overduePasses) ||
                other.overduePasses == overduePasses) &&
            (identical(other.todayDepartures, todayDepartures) ||
                other.todayDepartures == todayDepartures) &&
            (identical(other.todayReturns, todayReturns) ||
                other.todayReturns == todayReturns) &&
            (identical(other.emergencyBypasses, emergencyBypasses) ||
                other.emergencyBypasses == emergencyBypasses) &&
            const DeepCollectionEquality()
                .equals(other._recentRequests, _recentRequests) &&
            const DeepCollectionEquality()
                .equals(other._recentScans, _recentScans) &&
            const DeepCollectionEquality()
                .equals(other._hourlyStats, _hourlyStats) &&
            const DeepCollectionEquality()
                .equals(other._dailyStats, _dailyStats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      pendingApprovals,
      activePasses,
      overduePasses,
      todayDepartures,
      todayReturns,
      emergencyBypasses,
      const DeepCollectionEquality().hash(_recentRequests),
      const DeepCollectionEquality().hash(_recentScans),
      const DeepCollectionEquality().hash(_hourlyStats),
      const DeepCollectionEquality().hash(_dailyStats));

  /// Create a copy of GatePassDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatePassDashboardDataImplCopyWith<_$GatePassDashboardDataImpl>
      get copyWith => __$$GatePassDashboardDataImplCopyWithImpl<
          _$GatePassDashboardDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GatePassDashboardDataImplToJson(
      this,
    );
  }
}

abstract class _GatePassDashboardData implements GatePassDashboardData {
  const factory _GatePassDashboardData(
          {required final int pendingApprovals,
          required final int activePasses,
          required final int overduePasses,
          required final int todayDepartures,
          required final int todayReturns,
          required final int emergencyBypasses,
          required final List<GatePass> recentRequests,
          required final List<GateScanEvent> recentScans,
          required final Map<String, dynamic> hourlyStats,
          required final Map<String, dynamic> dailyStats}) =
      _$GatePassDashboardDataImpl;

  factory _GatePassDashboardData.fromJson(Map<String, dynamic> json) =
      _$GatePassDashboardDataImpl.fromJson;

  @override
  int get pendingApprovals;
  @override
  int get activePasses;
  @override
  int get overduePasses;
  @override
  int get todayDepartures;
  @override
  int get todayReturns;
  @override
  int get emergencyBypasses;
  @override
  List<GatePass> get recentRequests;
  @override
  List<GateScanEvent> get recentScans;
  @override
  Map<String, dynamic> get hourlyStats;
  @override
  Map<String, dynamic> get dailyStats;

  /// Create a copy of GatePassDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatePassDashboardDataImplCopyWith<_$GatePassDashboardDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
