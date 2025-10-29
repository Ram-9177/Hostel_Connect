// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'policy_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HostelPolicy _$HostelPolicyFromJson(Map<String, dynamic> json) {
  return _HostelPolicy.fromJson(json);
}

/// @nodoc
mixin _$HostelPolicy {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  PolicyType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get rules => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this HostelPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HostelPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HostelPolicyCopyWith<HostelPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostelPolicyCopyWith<$Res> {
  factory $HostelPolicyCopyWith(
          HostelPolicy value, $Res Function(HostelPolicy) then) =
      _$HostelPolicyCopyWithImpl<$Res, HostelPolicy>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      String name,
      String description,
      PolicyType type,
      Map<String, dynamic> rules,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$HostelPolicyCopyWithImpl<$Res, $Val extends HostelPolicy>
    implements $HostelPolicyCopyWith<$Res> {
  _$HostelPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HostelPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? rules = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PolicyType,
      rules: null == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HostelPolicyImplCopyWith<$Res>
    implements $HostelPolicyCopyWith<$Res> {
  factory _$$HostelPolicyImplCopyWith(
          _$HostelPolicyImpl value, $Res Function(_$HostelPolicyImpl) then) =
      __$$HostelPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      String name,
      String description,
      PolicyType type,
      Map<String, dynamic> rules,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$HostelPolicyImplCopyWithImpl<$Res>
    extends _$HostelPolicyCopyWithImpl<$Res, _$HostelPolicyImpl>
    implements _$$HostelPolicyImplCopyWith<$Res> {
  __$$HostelPolicyImplCopyWithImpl(
      _$HostelPolicyImpl _value, $Res Function(_$HostelPolicyImpl) _then)
      : super(_value, _then);

  /// Create a copy of HostelPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? rules = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$HostelPolicyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PolicyType,
      rules: null == rules
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HostelPolicyImpl implements _HostelPolicy {
  const _$HostelPolicyImpl(
      {required this.id,
      required this.hostelId,
      required this.name,
      required this.description,
      required this.type,
      required final Map<String, dynamic> rules,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt})
      : _rules = rules;

  factory _$HostelPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$HostelPolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final String name;
  @override
  final String description;
  @override
  final PolicyType type;
  final Map<String, dynamic> _rules;
  @override
  Map<String, dynamic> get rules {
    if (_rules is EqualUnmodifiableMapView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rules);
  }

  @override
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'HostelPolicy(id: $id, hostelId: $hostelId, name: $name, description: $description, type: $type, rules: $rules, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HostelPolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
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
      hostelId,
      name,
      description,
      type,
      const DeepCollectionEquality().hash(_rules),
      isActive,
      createdAt,
      updatedAt);

  /// Create a copy of HostelPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HostelPolicyImplCopyWith<_$HostelPolicyImpl> get copyWith =>
      __$$HostelPolicyImplCopyWithImpl<_$HostelPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HostelPolicyImplToJson(
      this,
    );
  }
}

abstract class _HostelPolicy implements HostelPolicy {
  const factory _HostelPolicy(
      {required final String id,
      required final String hostelId,
      required final String name,
      required final String description,
      required final PolicyType type,
      required final Map<String, dynamic> rules,
      required final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$HostelPolicyImpl;

  factory _HostelPolicy.fromJson(Map<String, dynamic> json) =
      _$HostelPolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  String get name;
  @override
  String get description;
  @override
  PolicyType get type;
  @override
  Map<String, dynamic> get rules;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of HostelPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HostelPolicyImplCopyWith<_$HostelPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CurfewPolicy _$CurfewPolicyFromJson(Map<String, dynamic> json) {
  return _CurfewPolicy.fromJson(json);
}

/// @nodoc
mixin _$CurfewPolicy {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  TimeOfDay get curfewTime => throw _privateConstructorUsedError;
  TimeOfDay get wakeUpTime => throw _privateConstructorUsedError;
  List<String> get allowedDays => throw _privateConstructorUsedError;
  bool get isStrict => throw _privateConstructorUsedError;
  String get violationAction => throw _privateConstructorUsedError;

  /// Serializes this CurfewPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CurfewPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurfewPolicyCopyWith<CurfewPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurfewPolicyCopyWith<$Res> {
  factory $CurfewPolicyCopyWith(
          CurfewPolicy value, $Res Function(CurfewPolicy) then) =
      _$CurfewPolicyCopyWithImpl<$Res, CurfewPolicy>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      TimeOfDay curfewTime,
      TimeOfDay wakeUpTime,
      List<String> allowedDays,
      bool isStrict,
      String violationAction});
}

/// @nodoc
class _$CurfewPolicyCopyWithImpl<$Res, $Val extends CurfewPolicy>
    implements $CurfewPolicyCopyWith<$Res> {
  _$CurfewPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurfewPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? curfewTime = null,
    Object? wakeUpTime = null,
    Object? allowedDays = null,
    Object? isStrict = null,
    Object? violationAction = null,
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
      curfewTime: null == curfewTime
          ? _value.curfewTime
          : curfewTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      wakeUpTime: null == wakeUpTime
          ? _value.wakeUpTime
          : wakeUpTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      allowedDays: null == allowedDays
          ? _value.allowedDays
          : allowedDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isStrict: null == isStrict
          ? _value.isStrict
          : isStrict // ignore: cast_nullable_to_non_nullable
              as bool,
      violationAction: null == violationAction
          ? _value.violationAction
          : violationAction // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurfewPolicyImplCopyWith<$Res>
    implements $CurfewPolicyCopyWith<$Res> {
  factory _$$CurfewPolicyImplCopyWith(
          _$CurfewPolicyImpl value, $Res Function(_$CurfewPolicyImpl) then) =
      __$$CurfewPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      TimeOfDay curfewTime,
      TimeOfDay wakeUpTime,
      List<String> allowedDays,
      bool isStrict,
      String violationAction});
}

/// @nodoc
class __$$CurfewPolicyImplCopyWithImpl<$Res>
    extends _$CurfewPolicyCopyWithImpl<$Res, _$CurfewPolicyImpl>
    implements _$$CurfewPolicyImplCopyWith<$Res> {
  __$$CurfewPolicyImplCopyWithImpl(
      _$CurfewPolicyImpl _value, $Res Function(_$CurfewPolicyImpl) _then)
      : super(_value, _then);

  /// Create a copy of CurfewPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? curfewTime = null,
    Object? wakeUpTime = null,
    Object? allowedDays = null,
    Object? isStrict = null,
    Object? violationAction = null,
  }) {
    return _then(_$CurfewPolicyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      curfewTime: null == curfewTime
          ? _value.curfewTime
          : curfewTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      wakeUpTime: null == wakeUpTime
          ? _value.wakeUpTime
          : wakeUpTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      allowedDays: null == allowedDays
          ? _value._allowedDays
          : allowedDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isStrict: null == isStrict
          ? _value.isStrict
          : isStrict // ignore: cast_nullable_to_non_nullable
              as bool,
      violationAction: null == violationAction
          ? _value.violationAction
          : violationAction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurfewPolicyImpl implements _CurfewPolicy {
  const _$CurfewPolicyImpl(
      {required this.id,
      required this.hostelId,
      required this.curfewTime,
      required this.wakeUpTime,
      required final List<String> allowedDays,
      required this.isStrict,
      required this.violationAction})
      : _allowedDays = allowedDays;

  factory _$CurfewPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurfewPolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final TimeOfDay curfewTime;
  @override
  final TimeOfDay wakeUpTime;
  final List<String> _allowedDays;
  @override
  List<String> get allowedDays {
    if (_allowedDays is EqualUnmodifiableListView) return _allowedDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedDays);
  }

  @override
  final bool isStrict;
  @override
  final String violationAction;

  @override
  String toString() {
    return 'CurfewPolicy(id: $id, hostelId: $hostelId, curfewTime: $curfewTime, wakeUpTime: $wakeUpTime, allowedDays: $allowedDays, isStrict: $isStrict, violationAction: $violationAction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurfewPolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.curfewTime, curfewTime) ||
                other.curfewTime == curfewTime) &&
            (identical(other.wakeUpTime, wakeUpTime) ||
                other.wakeUpTime == wakeUpTime) &&
            const DeepCollectionEquality()
                .equals(other._allowedDays, _allowedDays) &&
            (identical(other.isStrict, isStrict) ||
                other.isStrict == isStrict) &&
            (identical(other.violationAction, violationAction) ||
                other.violationAction == violationAction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hostelId,
      curfewTime,
      wakeUpTime,
      const DeepCollectionEquality().hash(_allowedDays),
      isStrict,
      violationAction);

  /// Create a copy of CurfewPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurfewPolicyImplCopyWith<_$CurfewPolicyImpl> get copyWith =>
      __$$CurfewPolicyImplCopyWithImpl<_$CurfewPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurfewPolicyImplToJson(
      this,
    );
  }
}

abstract class _CurfewPolicy implements CurfewPolicy {
  const factory _CurfewPolicy(
      {required final String id,
      required final String hostelId,
      required final TimeOfDay curfewTime,
      required final TimeOfDay wakeUpTime,
      required final List<String> allowedDays,
      required final bool isStrict,
      required final String violationAction}) = _$CurfewPolicyImpl;

  factory _CurfewPolicy.fromJson(Map<String, dynamic> json) =
      _$CurfewPolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  TimeOfDay get curfewTime;
  @override
  TimeOfDay get wakeUpTime;
  @override
  List<String> get allowedDays;
  @override
  bool get isStrict;
  @override
  String get violationAction;

  /// Create a copy of CurfewPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurfewPolicyImplCopyWith<_$CurfewPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendancePolicy _$AttendancePolicyFromJson(Map<String, dynamic> json) {
  return _AttendancePolicy.fromJson(json);
}

/// @nodoc
mixin _$AttendancePolicy {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  double get minimumAttendance => throw _privateConstructorUsedError;
  List<String> get exemptedDays => throw _privateConstructorUsedError;
  String get violationAction => throw _privateConstructorUsedError;
  bool get allowLateEntry => throw _privateConstructorUsedError;
  Duration get lateEntryGracePeriod => throw _privateConstructorUsedError;

  /// Serializes this AttendancePolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendancePolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendancePolicyCopyWith<AttendancePolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendancePolicyCopyWith<$Res> {
  factory $AttendancePolicyCopyWith(
          AttendancePolicy value, $Res Function(AttendancePolicy) then) =
      _$AttendancePolicyCopyWithImpl<$Res, AttendancePolicy>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      double minimumAttendance,
      List<String> exemptedDays,
      String violationAction,
      bool allowLateEntry,
      Duration lateEntryGracePeriod});
}

/// @nodoc
class _$AttendancePolicyCopyWithImpl<$Res, $Val extends AttendancePolicy>
    implements $AttendancePolicyCopyWith<$Res> {
  _$AttendancePolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendancePolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? minimumAttendance = null,
    Object? exemptedDays = null,
    Object? violationAction = null,
    Object? allowLateEntry = null,
    Object? lateEntryGracePeriod = null,
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
      minimumAttendance: null == minimumAttendance
          ? _value.minimumAttendance
          : minimumAttendance // ignore: cast_nullable_to_non_nullable
              as double,
      exemptedDays: null == exemptedDays
          ? _value.exemptedDays
          : exemptedDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      violationAction: null == violationAction
          ? _value.violationAction
          : violationAction // ignore: cast_nullable_to_non_nullable
              as String,
      allowLateEntry: null == allowLateEntry
          ? _value.allowLateEntry
          : allowLateEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      lateEntryGracePeriod: null == lateEntryGracePeriod
          ? _value.lateEntryGracePeriod
          : lateEntryGracePeriod // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendancePolicyImplCopyWith<$Res>
    implements $AttendancePolicyCopyWith<$Res> {
  factory _$$AttendancePolicyImplCopyWith(_$AttendancePolicyImpl value,
          $Res Function(_$AttendancePolicyImpl) then) =
      __$$AttendancePolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      double minimumAttendance,
      List<String> exemptedDays,
      String violationAction,
      bool allowLateEntry,
      Duration lateEntryGracePeriod});
}

/// @nodoc
class __$$AttendancePolicyImplCopyWithImpl<$Res>
    extends _$AttendancePolicyCopyWithImpl<$Res, _$AttendancePolicyImpl>
    implements _$$AttendancePolicyImplCopyWith<$Res> {
  __$$AttendancePolicyImplCopyWithImpl(_$AttendancePolicyImpl _value,
      $Res Function(_$AttendancePolicyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendancePolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? minimumAttendance = null,
    Object? exemptedDays = null,
    Object? violationAction = null,
    Object? allowLateEntry = null,
    Object? lateEntryGracePeriod = null,
  }) {
    return _then(_$AttendancePolicyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      minimumAttendance: null == minimumAttendance
          ? _value.minimumAttendance
          : minimumAttendance // ignore: cast_nullable_to_non_nullable
              as double,
      exemptedDays: null == exemptedDays
          ? _value._exemptedDays
          : exemptedDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      violationAction: null == violationAction
          ? _value.violationAction
          : violationAction // ignore: cast_nullable_to_non_nullable
              as String,
      allowLateEntry: null == allowLateEntry
          ? _value.allowLateEntry
          : allowLateEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      lateEntryGracePeriod: null == lateEntryGracePeriod
          ? _value.lateEntryGracePeriod
          : lateEntryGracePeriod // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendancePolicyImpl implements _AttendancePolicy {
  const _$AttendancePolicyImpl(
      {required this.id,
      required this.hostelId,
      required this.minimumAttendance,
      required final List<String> exemptedDays,
      required this.violationAction,
      required this.allowLateEntry,
      required this.lateEntryGracePeriod})
      : _exemptedDays = exemptedDays;

  factory _$AttendancePolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendancePolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final double minimumAttendance;
  final List<String> _exemptedDays;
  @override
  List<String> get exemptedDays {
    if (_exemptedDays is EqualUnmodifiableListView) return _exemptedDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exemptedDays);
  }

  @override
  final String violationAction;
  @override
  final bool allowLateEntry;
  @override
  final Duration lateEntryGracePeriod;

  @override
  String toString() {
    return 'AttendancePolicy(id: $id, hostelId: $hostelId, minimumAttendance: $minimumAttendance, exemptedDays: $exemptedDays, violationAction: $violationAction, allowLateEntry: $allowLateEntry, lateEntryGracePeriod: $lateEntryGracePeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendancePolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.minimumAttendance, minimumAttendance) ||
                other.minimumAttendance == minimumAttendance) &&
            const DeepCollectionEquality()
                .equals(other._exemptedDays, _exemptedDays) &&
            (identical(other.violationAction, violationAction) ||
                other.violationAction == violationAction) &&
            (identical(other.allowLateEntry, allowLateEntry) ||
                other.allowLateEntry == allowLateEntry) &&
            (identical(other.lateEntryGracePeriod, lateEntryGracePeriod) ||
                other.lateEntryGracePeriod == lateEntryGracePeriod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hostelId,
      minimumAttendance,
      const DeepCollectionEquality().hash(_exemptedDays),
      violationAction,
      allowLateEntry,
      lateEntryGracePeriod);

  /// Create a copy of AttendancePolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendancePolicyImplCopyWith<_$AttendancePolicyImpl> get copyWith =>
      __$$AttendancePolicyImplCopyWithImpl<_$AttendancePolicyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendancePolicyImplToJson(
      this,
    );
  }
}

abstract class _AttendancePolicy implements AttendancePolicy {
  const factory _AttendancePolicy(
      {required final String id,
      required final String hostelId,
      required final double minimumAttendance,
      required final List<String> exemptedDays,
      required final String violationAction,
      required final bool allowLateEntry,
      required final Duration lateEntryGracePeriod}) = _$AttendancePolicyImpl;

  factory _AttendancePolicy.fromJson(Map<String, dynamic> json) =
      _$AttendancePolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  double get minimumAttendance;
  @override
  List<String> get exemptedDays;
  @override
  String get violationAction;
  @override
  bool get allowLateEntry;
  @override
  Duration get lateEntryGracePeriod;

  /// Create a copy of AttendancePolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendancePolicyImplCopyWith<_$AttendancePolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPolicy _$MealPolicyFromJson(Map<String, dynamic> json) {
  return _MealPolicy.fromJson(json);
}

/// @nodoc
mixin _$MealPolicy {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  TimeOfDay get breakfastTime => throw _privateConstructorUsedError;
  TimeOfDay get lunchTime => throw _privateConstructorUsedError;
  TimeOfDay get dinnerTime => throw _privateConstructorUsedError;
  Duration get mealWindow => throw _privateConstructorUsedError;
  bool get allowOptOut => throw _privateConstructorUsedError;
  String get optOutDeadline => throw _privateConstructorUsedError;

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
      TimeOfDay breakfastTime,
      TimeOfDay lunchTime,
      TimeOfDay dinnerTime,
      Duration mealWindow,
      bool allowOptOut,
      String optOutDeadline});
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
    Object? breakfastTime = null,
    Object? lunchTime = null,
    Object? dinnerTime = null,
    Object? mealWindow = null,
    Object? allowOptOut = null,
    Object? optOutDeadline = null,
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
      breakfastTime: null == breakfastTime
          ? _value.breakfastTime
          : breakfastTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      lunchTime: null == lunchTime
          ? _value.lunchTime
          : lunchTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      dinnerTime: null == dinnerTime
          ? _value.dinnerTime
          : dinnerTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      mealWindow: null == mealWindow
          ? _value.mealWindow
          : mealWindow // ignore: cast_nullable_to_non_nullable
              as Duration,
      allowOptOut: null == allowOptOut
          ? _value.allowOptOut
          : allowOptOut // ignore: cast_nullable_to_non_nullable
              as bool,
      optOutDeadline: null == optOutDeadline
          ? _value.optOutDeadline
          : optOutDeadline // ignore: cast_nullable_to_non_nullable
              as String,
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
      TimeOfDay breakfastTime,
      TimeOfDay lunchTime,
      TimeOfDay dinnerTime,
      Duration mealWindow,
      bool allowOptOut,
      String optOutDeadline});
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
    Object? breakfastTime = null,
    Object? lunchTime = null,
    Object? dinnerTime = null,
    Object? mealWindow = null,
    Object? allowOptOut = null,
    Object? optOutDeadline = null,
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
      breakfastTime: null == breakfastTime
          ? _value.breakfastTime
          : breakfastTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      lunchTime: null == lunchTime
          ? _value.lunchTime
          : lunchTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      dinnerTime: null == dinnerTime
          ? _value.dinnerTime
          : dinnerTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      mealWindow: null == mealWindow
          ? _value.mealWindow
          : mealWindow // ignore: cast_nullable_to_non_nullable
              as Duration,
      allowOptOut: null == allowOptOut
          ? _value.allowOptOut
          : allowOptOut // ignore: cast_nullable_to_non_nullable
              as bool,
      optOutDeadline: null == optOutDeadline
          ? _value.optOutDeadline
          : optOutDeadline // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPolicyImpl implements _MealPolicy {
  const _$MealPolicyImpl(
      {required this.id,
      required this.hostelId,
      required this.breakfastTime,
      required this.lunchTime,
      required this.dinnerTime,
      required this.mealWindow,
      required this.allowOptOut,
      required this.optOutDeadline});

  factory _$MealPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final TimeOfDay breakfastTime;
  @override
  final TimeOfDay lunchTime;
  @override
  final TimeOfDay dinnerTime;
  @override
  final Duration mealWindow;
  @override
  final bool allowOptOut;
  @override
  final String optOutDeadline;

  @override
  String toString() {
    return 'MealPolicy(id: $id, hostelId: $hostelId, breakfastTime: $breakfastTime, lunchTime: $lunchTime, dinnerTime: $dinnerTime, mealWindow: $mealWindow, allowOptOut: $allowOptOut, optOutDeadline: $optOutDeadline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.breakfastTime, breakfastTime) ||
                other.breakfastTime == breakfastTime) &&
            (identical(other.lunchTime, lunchTime) ||
                other.lunchTime == lunchTime) &&
            (identical(other.dinnerTime, dinnerTime) ||
                other.dinnerTime == dinnerTime) &&
            (identical(other.mealWindow, mealWindow) ||
                other.mealWindow == mealWindow) &&
            (identical(other.allowOptOut, allowOptOut) ||
                other.allowOptOut == allowOptOut) &&
            (identical(other.optOutDeadline, optOutDeadline) ||
                other.optOutDeadline == optOutDeadline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, hostelId, breakfastTime,
      lunchTime, dinnerTime, mealWindow, allowOptOut, optOutDeadline);

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
      required final TimeOfDay breakfastTime,
      required final TimeOfDay lunchTime,
      required final TimeOfDay dinnerTime,
      required final Duration mealWindow,
      required final bool allowOptOut,
      required final String optOutDeadline}) = _$MealPolicyImpl;

  factory _MealPolicy.fromJson(Map<String, dynamic> json) =
      _$MealPolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  TimeOfDay get breakfastTime;
  @override
  TimeOfDay get lunchTime;
  @override
  TimeOfDay get dinnerTime;
  @override
  Duration get mealWindow;
  @override
  bool get allowOptOut;
  @override
  String get optOutDeadline;

  /// Create a copy of MealPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPolicyImplCopyWith<_$MealPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoomPolicy _$RoomPolicyFromJson(Map<String, dynamic> json) {
  return _RoomPolicy.fromJson(json);
}

/// @nodoc
mixin _$RoomPolicy {
  String get id => throw _privateConstructorUsedError;
  String get hostelId => throw _privateConstructorUsedError;
  bool get allowGuests => throw _privateConstructorUsedError;
  int get maxGuests => throw _privateConstructorUsedError;
  Duration get guestStayLimit => throw _privateConstructorUsedError;
  bool get allowRoomChange => throw _privateConstructorUsedError;
  String get roomChangeProcess => throw _privateConstructorUsedError;

  /// Serializes this RoomPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomPolicyCopyWith<RoomPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomPolicyCopyWith<$Res> {
  factory $RoomPolicyCopyWith(
          RoomPolicy value, $Res Function(RoomPolicy) then) =
      _$RoomPolicyCopyWithImpl<$Res, RoomPolicy>;
  @useResult
  $Res call(
      {String id,
      String hostelId,
      bool allowGuests,
      int maxGuests,
      Duration guestStayLimit,
      bool allowRoomChange,
      String roomChangeProcess});
}

/// @nodoc
class _$RoomPolicyCopyWithImpl<$Res, $Val extends RoomPolicy>
    implements $RoomPolicyCopyWith<$Res> {
  _$RoomPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? allowGuests = null,
    Object? maxGuests = null,
    Object? guestStayLimit = null,
    Object? allowRoomChange = null,
    Object? roomChangeProcess = null,
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
      allowGuests: null == allowGuests
          ? _value.allowGuests
          : allowGuests // ignore: cast_nullable_to_non_nullable
              as bool,
      maxGuests: null == maxGuests
          ? _value.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int,
      guestStayLimit: null == guestStayLimit
          ? _value.guestStayLimit
          : guestStayLimit // ignore: cast_nullable_to_non_nullable
              as Duration,
      allowRoomChange: null == allowRoomChange
          ? _value.allowRoomChange
          : allowRoomChange // ignore: cast_nullable_to_non_nullable
              as bool,
      roomChangeProcess: null == roomChangeProcess
          ? _value.roomChangeProcess
          : roomChangeProcess // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomPolicyImplCopyWith<$Res>
    implements $RoomPolicyCopyWith<$Res> {
  factory _$$RoomPolicyImplCopyWith(
          _$RoomPolicyImpl value, $Res Function(_$RoomPolicyImpl) then) =
      __$$RoomPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostelId,
      bool allowGuests,
      int maxGuests,
      Duration guestStayLimit,
      bool allowRoomChange,
      String roomChangeProcess});
}

/// @nodoc
class __$$RoomPolicyImplCopyWithImpl<$Res>
    extends _$RoomPolicyCopyWithImpl<$Res, _$RoomPolicyImpl>
    implements _$$RoomPolicyImplCopyWith<$Res> {
  __$$RoomPolicyImplCopyWithImpl(
      _$RoomPolicyImpl _value, $Res Function(_$RoomPolicyImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoomPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostelId = null,
    Object? allowGuests = null,
    Object? maxGuests = null,
    Object? guestStayLimit = null,
    Object? allowRoomChange = null,
    Object? roomChangeProcess = null,
  }) {
    return _then(_$RoomPolicyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostelId: null == hostelId
          ? _value.hostelId
          : hostelId // ignore: cast_nullable_to_non_nullable
              as String,
      allowGuests: null == allowGuests
          ? _value.allowGuests
          : allowGuests // ignore: cast_nullable_to_non_nullable
              as bool,
      maxGuests: null == maxGuests
          ? _value.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int,
      guestStayLimit: null == guestStayLimit
          ? _value.guestStayLimit
          : guestStayLimit // ignore: cast_nullable_to_non_nullable
              as Duration,
      allowRoomChange: null == allowRoomChange
          ? _value.allowRoomChange
          : allowRoomChange // ignore: cast_nullable_to_non_nullable
              as bool,
      roomChangeProcess: null == roomChangeProcess
          ? _value.roomChangeProcess
          : roomChangeProcess // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomPolicyImpl implements _RoomPolicy {
  const _$RoomPolicyImpl(
      {required this.id,
      required this.hostelId,
      required this.allowGuests,
      required this.maxGuests,
      required this.guestStayLimit,
      required this.allowRoomChange,
      required this.roomChangeProcess});

  factory _$RoomPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomPolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String hostelId;
  @override
  final bool allowGuests;
  @override
  final int maxGuests;
  @override
  final Duration guestStayLimit;
  @override
  final bool allowRoomChange;
  @override
  final String roomChangeProcess;

  @override
  String toString() {
    return 'RoomPolicy(id: $id, hostelId: $hostelId, allowGuests: $allowGuests, maxGuests: $maxGuests, guestStayLimit: $guestStayLimit, allowRoomChange: $allowRoomChange, roomChangeProcess: $roomChangeProcess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomPolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostelId, hostelId) ||
                other.hostelId == hostelId) &&
            (identical(other.allowGuests, allowGuests) ||
                other.allowGuests == allowGuests) &&
            (identical(other.maxGuests, maxGuests) ||
                other.maxGuests == maxGuests) &&
            (identical(other.guestStayLimit, guestStayLimit) ||
                other.guestStayLimit == guestStayLimit) &&
            (identical(other.allowRoomChange, allowRoomChange) ||
                other.allowRoomChange == allowRoomChange) &&
            (identical(other.roomChangeProcess, roomChangeProcess) ||
                other.roomChangeProcess == roomChangeProcess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, hostelId, allowGuests,
      maxGuests, guestStayLimit, allowRoomChange, roomChangeProcess);

  /// Create a copy of RoomPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomPolicyImplCopyWith<_$RoomPolicyImpl> get copyWith =>
      __$$RoomPolicyImplCopyWithImpl<_$RoomPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomPolicyImplToJson(
      this,
    );
  }
}

abstract class _RoomPolicy implements RoomPolicy {
  const factory _RoomPolicy(
      {required final String id,
      required final String hostelId,
      required final bool allowGuests,
      required final int maxGuests,
      required final Duration guestStayLimit,
      required final bool allowRoomChange,
      required final String roomChangeProcess}) = _$RoomPolicyImpl;

  factory _RoomPolicy.fromJson(Map<String, dynamic> json) =
      _$RoomPolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get hostelId;
  @override
  bool get allowGuests;
  @override
  int get maxGuests;
  @override
  Duration get guestStayLimit;
  @override
  bool get allowRoomChange;
  @override
  String get roomChangeProcess;

  /// Create a copy of RoomPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomPolicyImplCopyWith<_$RoomPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
