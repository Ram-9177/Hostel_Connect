// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Notice _$NoticeFromJson(Map<String, dynamic> json) {
  return _Notice.fromJson(json);
}

/// @nodoc
mixin _$Notice {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get createdByName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  NoticePriority get priority => throw _privateConstructorUsedError;
  NoticeType get type => throw _privateConstructorUsedError;
  NoticeAudience get audience => throw _privateConstructorUsedError;
  List<String> get targetIds => throw _privateConstructorUsedError;
  Map<String, dynamic> get targetDetails => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String>? get attachments => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  NoticeStats? get stats => throw _privateConstructorUsedError;

  /// Serializes this Notice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeCopyWith<Notice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeCopyWith<$Res> {
  factory $NoticeCopyWith(Notice value, $Res Function(Notice) then) =
      _$NoticeCopyWithImpl<$Res, Notice>;
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      String createdBy,
      String createdByName,
      DateTime createdAt,
      NoticePriority priority,
      NoticeType type,
      NoticeAudience audience,
      List<String> targetIds,
      Map<String, dynamic> targetDetails,
      bool isActive,
      DateTime? expiresAt,
      String? imageUrl,
      List<String>? attachments,
      Map<String, dynamic>? metadata,
      NoticeStats? stats});

  $NoticeAudienceCopyWith<$Res> get audience;
  $NoticeStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$NoticeCopyWithImpl<$Res, $Val extends Notice>
    implements $NoticeCopyWith<$Res> {
  _$NoticeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdBy = null,
    Object? createdByName = null,
    Object? createdAt = null,
    Object? priority = null,
    Object? type = null,
    Object? audience = null,
    Object? targetIds = null,
    Object? targetDetails = null,
    Object? isActive = null,
    Object? expiresAt = freezed,
    Object? imageUrl = freezed,
    Object? attachments = freezed,
    Object? metadata = freezed,
    Object? stats = freezed,
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
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdByName: null == createdByName
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType,
      audience: null == audience
          ? _value.audience
          : audience // ignore: cast_nullable_to_non_nullable
              as NoticeAudience,
      targetIds: null == targetIds
          ? _value.targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targetDetails: null == targetDetails
          ? _value.targetDetails
          : targetDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as NoticeStats?,
    ) as $Val);
  }

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NoticeAudienceCopyWith<$Res> get audience {
    return $NoticeAudienceCopyWith<$Res>(_value.audience, (value) {
      return _then(_value.copyWith(audience: value) as $Val);
    });
  }

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NoticeStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $NoticeStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoticeImplCopyWith<$Res> implements $NoticeCopyWith<$Res> {
  factory _$$NoticeImplCopyWith(
          _$NoticeImpl value, $Res Function(_$NoticeImpl) then) =
      __$$NoticeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      String createdBy,
      String createdByName,
      DateTime createdAt,
      NoticePriority priority,
      NoticeType type,
      NoticeAudience audience,
      List<String> targetIds,
      Map<String, dynamic> targetDetails,
      bool isActive,
      DateTime? expiresAt,
      String? imageUrl,
      List<String>? attachments,
      Map<String, dynamic>? metadata,
      NoticeStats? stats});

  @override
  $NoticeAudienceCopyWith<$Res> get audience;
  @override
  $NoticeStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$NoticeImplCopyWithImpl<$Res>
    extends _$NoticeCopyWithImpl<$Res, _$NoticeImpl>
    implements _$$NoticeImplCopyWith<$Res> {
  __$$NoticeImplCopyWithImpl(
      _$NoticeImpl _value, $Res Function(_$NoticeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdBy = null,
    Object? createdByName = null,
    Object? createdAt = null,
    Object? priority = null,
    Object? type = null,
    Object? audience = null,
    Object? targetIds = null,
    Object? targetDetails = null,
    Object? isActive = null,
    Object? expiresAt = freezed,
    Object? imageUrl = freezed,
    Object? attachments = freezed,
    Object? metadata = freezed,
    Object? stats = freezed,
  }) {
    return _then(_$NoticeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdByName: null == createdByName
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType,
      audience: null == audience
          ? _value.audience
          : audience // ignore: cast_nullable_to_non_nullable
              as NoticeAudience,
      targetIds: null == targetIds
          ? _value._targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targetDetails: null == targetDetails
          ? _value._targetDetails
          : targetDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as NoticeStats?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeImpl implements _Notice {
  const _$NoticeImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdBy,
      required this.createdByName,
      required this.createdAt,
      required this.priority,
      required this.type,
      required this.audience,
      required final List<String> targetIds,
      required final Map<String, dynamic> targetDetails,
      required this.isActive,
      this.expiresAt,
      this.imageUrl,
      final List<String>? attachments,
      final Map<String, dynamic>? metadata,
      this.stats})
      : _targetIds = targetIds,
        _targetDetails = targetDetails,
        _attachments = attachments,
        _metadata = metadata;

  factory _$NoticeImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String createdBy;
  @override
  final String createdByName;
  @override
  final DateTime createdAt;
  @override
  final NoticePriority priority;
  @override
  final NoticeType type;
  @override
  final NoticeAudience audience;
  final List<String> _targetIds;
  @override
  List<String> get targetIds {
    if (_targetIds is EqualUnmodifiableListView) return _targetIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetIds);
  }

  final Map<String, dynamic> _targetDetails;
  @override
  Map<String, dynamic> get targetDetails {
    if (_targetDetails is EqualUnmodifiableMapView) return _targetDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_targetDetails);
  }

  @override
  final bool isActive;
  @override
  final DateTime? expiresAt;
  @override
  final String? imageUrl;
  final List<String>? _attachments;
  @override
  List<String>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
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
  final NoticeStats? stats;

  @override
  String toString() {
    return 'Notice(id: $id, title: $title, content: $content, createdBy: $createdBy, createdByName: $createdByName, createdAt: $createdAt, priority: $priority, type: $type, audience: $audience, targetIds: $targetIds, targetDetails: $targetDetails, isActive: $isActive, expiresAt: $expiresAt, imageUrl: $imageUrl, attachments: $attachments, metadata: $metadata, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdByName, createdByName) ||
                other.createdByName == createdByName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.audience, audience) ||
                other.audience == audience) &&
            const DeepCollectionEquality()
                .equals(other._targetIds, _targetIds) &&
            const DeepCollectionEquality()
                .equals(other._targetDetails, _targetDetails) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      createdBy,
      createdByName,
      createdAt,
      priority,
      type,
      audience,
      const DeepCollectionEquality().hash(_targetIds),
      const DeepCollectionEquality().hash(_targetDetails),
      isActive,
      expiresAt,
      imageUrl,
      const DeepCollectionEquality().hash(_attachments),
      const DeepCollectionEquality().hash(_metadata),
      stats);

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeImplCopyWith<_$NoticeImpl> get copyWith =>
      __$$NoticeImplCopyWithImpl<_$NoticeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeImplToJson(
      this,
    );
  }
}

abstract class _Notice implements Notice {
  const factory _Notice(
      {required final String id,
      required final String title,
      required final String content,
      required final String createdBy,
      required final String createdByName,
      required final DateTime createdAt,
      required final NoticePriority priority,
      required final NoticeType type,
      required final NoticeAudience audience,
      required final List<String> targetIds,
      required final Map<String, dynamic> targetDetails,
      required final bool isActive,
      final DateTime? expiresAt,
      final String? imageUrl,
      final List<String>? attachments,
      final Map<String, dynamic>? metadata,
      final NoticeStats? stats}) = _$NoticeImpl;

  factory _Notice.fromJson(Map<String, dynamic> json) = _$NoticeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  String get createdBy;
  @override
  String get createdByName;
  @override
  DateTime get createdAt;
  @override
  NoticePriority get priority;
  @override
  NoticeType get type;
  @override
  NoticeAudience get audience;
  @override
  List<String> get targetIds;
  @override
  Map<String, dynamic> get targetDetails;
  @override
  bool get isActive;
  @override
  DateTime? get expiresAt;
  @override
  String? get imageUrl;
  @override
  List<String>? get attachments;
  @override
  Map<String, dynamic>? get metadata;
  @override
  NoticeStats? get stats;

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeImplCopyWith<_$NoticeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeAudience _$NoticeAudienceFromJson(Map<String, dynamic> json) {
  return _NoticeAudience.fromJson(json);
}

/// @nodoc
mixin _$NoticeAudience {
  NoticeAudienceType get type => throw _privateConstructorUsedError;
  List<String> get targetIds => throw _privateConstructorUsedError;
  Map<String, dynamic> get targetDetails => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this NoticeAudience to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeAudience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeAudienceCopyWith<NoticeAudience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeAudienceCopyWith<$Res> {
  factory $NoticeAudienceCopyWith(
          NoticeAudience value, $Res Function(NoticeAudience) then) =
      _$NoticeAudienceCopyWithImpl<$Res, NoticeAudience>;
  @useResult
  $Res call(
      {NoticeAudienceType type,
      List<String> targetIds,
      Map<String, dynamic> targetDetails,
      String? description});
}

/// @nodoc
class _$NoticeAudienceCopyWithImpl<$Res, $Val extends NoticeAudience>
    implements $NoticeAudienceCopyWith<$Res> {
  _$NoticeAudienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeAudience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? targetIds = null,
    Object? targetDetails = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeAudienceType,
      targetIds: null == targetIds
          ? _value.targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targetDetails: null == targetDetails
          ? _value.targetDetails
          : targetDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoticeAudienceImplCopyWith<$Res>
    implements $NoticeAudienceCopyWith<$Res> {
  factory _$$NoticeAudienceImplCopyWith(_$NoticeAudienceImpl value,
          $Res Function(_$NoticeAudienceImpl) then) =
      __$$NoticeAudienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NoticeAudienceType type,
      List<String> targetIds,
      Map<String, dynamic> targetDetails,
      String? description});
}

/// @nodoc
class __$$NoticeAudienceImplCopyWithImpl<$Res>
    extends _$NoticeAudienceCopyWithImpl<$Res, _$NoticeAudienceImpl>
    implements _$$NoticeAudienceImplCopyWith<$Res> {
  __$$NoticeAudienceImplCopyWithImpl(
      _$NoticeAudienceImpl _value, $Res Function(_$NoticeAudienceImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeAudience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? targetIds = null,
    Object? targetDetails = null,
    Object? description = freezed,
  }) {
    return _then(_$NoticeAudienceImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeAudienceType,
      targetIds: null == targetIds
          ? _value._targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targetDetails: null == targetDetails
          ? _value._targetDetails
          : targetDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeAudienceImpl implements _NoticeAudience {
  const _$NoticeAudienceImpl(
      {required this.type,
      required final List<String> targetIds,
      required final Map<String, dynamic> targetDetails,
      this.description})
      : _targetIds = targetIds,
        _targetDetails = targetDetails;

  factory _$NoticeAudienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeAudienceImplFromJson(json);

  @override
  final NoticeAudienceType type;
  final List<String> _targetIds;
  @override
  List<String> get targetIds {
    if (_targetIds is EqualUnmodifiableListView) return _targetIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetIds);
  }

  final Map<String, dynamic> _targetDetails;
  @override
  Map<String, dynamic> get targetDetails {
    if (_targetDetails is EqualUnmodifiableMapView) return _targetDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_targetDetails);
  }

  @override
  final String? description;

  @override
  String toString() {
    return 'NoticeAudience(type: $type, targetIds: $targetIds, targetDetails: $targetDetails, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeAudienceImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._targetIds, _targetIds) &&
            const DeepCollectionEquality()
                .equals(other._targetDetails, _targetDetails) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_targetIds),
      const DeepCollectionEquality().hash(_targetDetails),
      description);

  /// Create a copy of NoticeAudience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeAudienceImplCopyWith<_$NoticeAudienceImpl> get copyWith =>
      __$$NoticeAudienceImplCopyWithImpl<_$NoticeAudienceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeAudienceImplToJson(
      this,
    );
  }
}

abstract class _NoticeAudience implements NoticeAudience {
  const factory _NoticeAudience(
      {required final NoticeAudienceType type,
      required final List<String> targetIds,
      required final Map<String, dynamic> targetDetails,
      final String? description}) = _$NoticeAudienceImpl;

  factory _NoticeAudience.fromJson(Map<String, dynamic> json) =
      _$NoticeAudienceImpl.fromJson;

  @override
  NoticeAudienceType get type;
  @override
  List<String> get targetIds;
  @override
  Map<String, dynamic> get targetDetails;
  @override
  String? get description;

  /// Create a copy of NoticeAudience
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeAudienceImplCopyWith<_$NoticeAudienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeStats _$NoticeStatsFromJson(Map<String, dynamic> json) {
  return _NoticeStats.fromJson(json);
}

/// @nodoc
mixin _$NoticeStats {
  int get totalSent => throw _privateConstructorUsedError;
  int get totalDelivered => throw _privateConstructorUsedError;
  int get totalRead => throw _privateConstructorUsedError;
  int get totalFailed => throw _privateConstructorUsedError;
  double get deliveryRate => throw _privateConstructorUsedError;
  double get readRate => throw _privateConstructorUsedError;
  Map<String, int> get deliveryByRole => throw _privateConstructorUsedError;
  Map<String, int> get readByRole => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this NoticeStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeStatsCopyWith<NoticeStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeStatsCopyWith<$Res> {
  factory $NoticeStatsCopyWith(
          NoticeStats value, $Res Function(NoticeStats) then) =
      _$NoticeStatsCopyWithImpl<$Res, NoticeStats>;
  @useResult
  $Res call(
      {int totalSent,
      int totalDelivered,
      int totalRead,
      int totalFailed,
      double deliveryRate,
      double readRate,
      Map<String, int> deliveryByRole,
      Map<String, int> readByRole,
      DateTime lastUpdated});
}

/// @nodoc
class _$NoticeStatsCopyWithImpl<$Res, $Val extends NoticeStats>
    implements $NoticeStatsCopyWith<$Res> {
  _$NoticeStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSent = null,
    Object? totalDelivered = null,
    Object? totalRead = null,
    Object? totalFailed = null,
    Object? deliveryRate = null,
    Object? readRate = null,
    Object? deliveryByRole = null,
    Object? readByRole = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      totalSent: null == totalSent
          ? _value.totalSent
          : totalSent // ignore: cast_nullable_to_non_nullable
              as int,
      totalDelivered: null == totalDelivered
          ? _value.totalDelivered
          : totalDelivered // ignore: cast_nullable_to_non_nullable
              as int,
      totalRead: null == totalRead
          ? _value.totalRead
          : totalRead // ignore: cast_nullable_to_non_nullable
              as int,
      totalFailed: null == totalFailed
          ? _value.totalFailed
          : totalFailed // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryRate: null == deliveryRate
          ? _value.deliveryRate
          : deliveryRate // ignore: cast_nullable_to_non_nullable
              as double,
      readRate: null == readRate
          ? _value.readRate
          : readRate // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryByRole: null == deliveryByRole
          ? _value.deliveryByRole
          : deliveryByRole // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      readByRole: null == readByRole
          ? _value.readByRole
          : readByRole // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoticeStatsImplCopyWith<$Res>
    implements $NoticeStatsCopyWith<$Res> {
  factory _$$NoticeStatsImplCopyWith(
          _$NoticeStatsImpl value, $Res Function(_$NoticeStatsImpl) then) =
      __$$NoticeStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalSent,
      int totalDelivered,
      int totalRead,
      int totalFailed,
      double deliveryRate,
      double readRate,
      Map<String, int> deliveryByRole,
      Map<String, int> readByRole,
      DateTime lastUpdated});
}

/// @nodoc
class __$$NoticeStatsImplCopyWithImpl<$Res>
    extends _$NoticeStatsCopyWithImpl<$Res, _$NoticeStatsImpl>
    implements _$$NoticeStatsImplCopyWith<$Res> {
  __$$NoticeStatsImplCopyWithImpl(
      _$NoticeStatsImpl _value, $Res Function(_$NoticeStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSent = null,
    Object? totalDelivered = null,
    Object? totalRead = null,
    Object? totalFailed = null,
    Object? deliveryRate = null,
    Object? readRate = null,
    Object? deliveryByRole = null,
    Object? readByRole = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$NoticeStatsImpl(
      totalSent: null == totalSent
          ? _value.totalSent
          : totalSent // ignore: cast_nullable_to_non_nullable
              as int,
      totalDelivered: null == totalDelivered
          ? _value.totalDelivered
          : totalDelivered // ignore: cast_nullable_to_non_nullable
              as int,
      totalRead: null == totalRead
          ? _value.totalRead
          : totalRead // ignore: cast_nullable_to_non_nullable
              as int,
      totalFailed: null == totalFailed
          ? _value.totalFailed
          : totalFailed // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryRate: null == deliveryRate
          ? _value.deliveryRate
          : deliveryRate // ignore: cast_nullable_to_non_nullable
              as double,
      readRate: null == readRate
          ? _value.readRate
          : readRate // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryByRole: null == deliveryByRole
          ? _value._deliveryByRole
          : deliveryByRole // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      readByRole: null == readByRole
          ? _value._readByRole
          : readByRole // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeStatsImpl implements _NoticeStats {
  const _$NoticeStatsImpl(
      {required this.totalSent,
      required this.totalDelivered,
      required this.totalRead,
      required this.totalFailed,
      required this.deliveryRate,
      required this.readRate,
      required final Map<String, int> deliveryByRole,
      required final Map<String, int> readByRole,
      required this.lastUpdated})
      : _deliveryByRole = deliveryByRole,
        _readByRole = readByRole;

  factory _$NoticeStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeStatsImplFromJson(json);

  @override
  final int totalSent;
  @override
  final int totalDelivered;
  @override
  final int totalRead;
  @override
  final int totalFailed;
  @override
  final double deliveryRate;
  @override
  final double readRate;
  final Map<String, int> _deliveryByRole;
  @override
  Map<String, int> get deliveryByRole {
    if (_deliveryByRole is EqualUnmodifiableMapView) return _deliveryByRole;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_deliveryByRole);
  }

  final Map<String, int> _readByRole;
  @override
  Map<String, int> get readByRole {
    if (_readByRole is EqualUnmodifiableMapView) return _readByRole;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_readByRole);
  }

  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'NoticeStats(totalSent: $totalSent, totalDelivered: $totalDelivered, totalRead: $totalRead, totalFailed: $totalFailed, deliveryRate: $deliveryRate, readRate: $readRate, deliveryByRole: $deliveryByRole, readByRole: $readByRole, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeStatsImpl &&
            (identical(other.totalSent, totalSent) ||
                other.totalSent == totalSent) &&
            (identical(other.totalDelivered, totalDelivered) ||
                other.totalDelivered == totalDelivered) &&
            (identical(other.totalRead, totalRead) ||
                other.totalRead == totalRead) &&
            (identical(other.totalFailed, totalFailed) ||
                other.totalFailed == totalFailed) &&
            (identical(other.deliveryRate, deliveryRate) ||
                other.deliveryRate == deliveryRate) &&
            (identical(other.readRate, readRate) ||
                other.readRate == readRate) &&
            const DeepCollectionEquality()
                .equals(other._deliveryByRole, _deliveryByRole) &&
            const DeepCollectionEquality()
                .equals(other._readByRole, _readByRole) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalSent,
      totalDelivered,
      totalRead,
      totalFailed,
      deliveryRate,
      readRate,
      const DeepCollectionEquality().hash(_deliveryByRole),
      const DeepCollectionEquality().hash(_readByRole),
      lastUpdated);

  /// Create a copy of NoticeStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeStatsImplCopyWith<_$NoticeStatsImpl> get copyWith =>
      __$$NoticeStatsImplCopyWithImpl<_$NoticeStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeStatsImplToJson(
      this,
    );
  }
}

abstract class _NoticeStats implements NoticeStats {
  const factory _NoticeStats(
      {required final int totalSent,
      required final int totalDelivered,
      required final int totalRead,
      required final int totalFailed,
      required final double deliveryRate,
      required final double readRate,
      required final Map<String, int> deliveryByRole,
      required final Map<String, int> readByRole,
      required final DateTime lastUpdated}) = _$NoticeStatsImpl;

  factory _NoticeStats.fromJson(Map<String, dynamic> json) =
      _$NoticeStatsImpl.fromJson;

  @override
  int get totalSent;
  @override
  int get totalDelivered;
  @override
  int get totalRead;
  @override
  int get totalFailed;
  @override
  double get deliveryRate;
  @override
  double get readRate;
  @override
  Map<String, int> get deliveryByRole;
  @override
  Map<String, int> get readByRole;
  @override
  DateTime get lastUpdated;

  /// Create a copy of NoticeStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeStatsImplCopyWith<_$NoticeStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeReadReceipt _$NoticeReadReceiptFromJson(Map<String, dynamic> json) {
  return _NoticeReadReceipt.fromJson(json);
}

/// @nodoc
mixin _$NoticeReadReceipt {
  String get id => throw _privateConstructorUsedError;
  String get noticeId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  DateTime get readAt => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get deviceType => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this NoticeReadReceipt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeReadReceipt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeReadReceiptCopyWith<NoticeReadReceipt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeReadReceiptCopyWith<$Res> {
  factory $NoticeReadReceiptCopyWith(
          NoticeReadReceipt value, $Res Function(NoticeReadReceipt) then) =
      _$NoticeReadReceiptCopyWithImpl<$Res, NoticeReadReceipt>;
  @useResult
  $Res call(
      {String id,
      String noticeId,
      String userId,
      String userName,
      DateTime readAt,
      String deviceId,
      String deviceType,
      String? location,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$NoticeReadReceiptCopyWithImpl<$Res, $Val extends NoticeReadReceipt>
    implements $NoticeReadReceiptCopyWith<$Res> {
  _$NoticeReadReceiptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeReadReceipt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? noticeId = null,
    Object? userId = null,
    Object? userName = null,
    Object? readAt = null,
    Object? deviceId = null,
    Object? deviceType = null,
    Object? location = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      noticeId: null == noticeId
          ? _value.noticeId
          : noticeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: null == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoticeReadReceiptImplCopyWith<$Res>
    implements $NoticeReadReceiptCopyWith<$Res> {
  factory _$$NoticeReadReceiptImplCopyWith(_$NoticeReadReceiptImpl value,
          $Res Function(_$NoticeReadReceiptImpl) then) =
      __$$NoticeReadReceiptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String noticeId,
      String userId,
      String userName,
      DateTime readAt,
      String deviceId,
      String deviceType,
      String? location,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$NoticeReadReceiptImplCopyWithImpl<$Res>
    extends _$NoticeReadReceiptCopyWithImpl<$Res, _$NoticeReadReceiptImpl>
    implements _$$NoticeReadReceiptImplCopyWith<$Res> {
  __$$NoticeReadReceiptImplCopyWithImpl(_$NoticeReadReceiptImpl _value,
      $Res Function(_$NoticeReadReceiptImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeReadReceipt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? noticeId = null,
    Object? userId = null,
    Object? userName = null,
    Object? readAt = null,
    Object? deviceId = null,
    Object? deviceType = null,
    Object? location = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$NoticeReadReceiptImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      noticeId: null == noticeId
          ? _value.noticeId
          : noticeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: null == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
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
class _$NoticeReadReceiptImpl implements _NoticeReadReceipt {
  const _$NoticeReadReceiptImpl(
      {required this.id,
      required this.noticeId,
      required this.userId,
      required this.userName,
      required this.readAt,
      required this.deviceId,
      required this.deviceType,
      this.location,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$NoticeReadReceiptImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeReadReceiptImplFromJson(json);

  @override
  final String id;
  @override
  final String noticeId;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final DateTime readAt;
  @override
  final String deviceId;
  @override
  final String deviceType;
  @override
  final String? location;
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
    return 'NoticeReadReceipt(id: $id, noticeId: $noticeId, userId: $userId, userName: $userName, readAt: $readAt, deviceId: $deviceId, deviceType: $deviceType, location: $location, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeReadReceiptImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.noticeId, noticeId) ||
                other.noticeId == noticeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      noticeId,
      userId,
      userName,
      readAt,
      deviceId,
      deviceType,
      location,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of NoticeReadReceipt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeReadReceiptImplCopyWith<_$NoticeReadReceiptImpl> get copyWith =>
      __$$NoticeReadReceiptImplCopyWithImpl<_$NoticeReadReceiptImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeReadReceiptImplToJson(
      this,
    );
  }
}

abstract class _NoticeReadReceipt implements NoticeReadReceipt {
  const factory _NoticeReadReceipt(
      {required final String id,
      required final String noticeId,
      required final String userId,
      required final String userName,
      required final DateTime readAt,
      required final String deviceId,
      required final String deviceType,
      final String? location,
      final Map<String, dynamic>? metadata}) = _$NoticeReadReceiptImpl;

  factory _NoticeReadReceipt.fromJson(Map<String, dynamic> json) =
      _$NoticeReadReceiptImpl.fromJson;

  @override
  String get id;
  @override
  String get noticeId;
  @override
  String get userId;
  @override
  String get userName;
  @override
  DateTime get readAt;
  @override
  String get deviceId;
  @override
  String get deviceType;
  @override
  String? get location;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of NoticeReadReceipt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeReadReceiptImplCopyWith<_$NoticeReadReceiptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceToken _$DeviceTokenFromJson(Map<String, dynamic> json) {
  return _DeviceToken.fromJson(json);
}

/// @nodoc
mixin _$DeviceToken {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get deviceType => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get appVersion => throw _privateConstructorUsedError;
  String get osVersion => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get registeredAt => throw _privateConstructorUsedError;
  DateTime? get lastUsedAt => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this DeviceToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceTokenCopyWith<DeviceToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceTokenCopyWith<$Res> {
  factory $DeviceTokenCopyWith(
          DeviceToken value, $Res Function(DeviceToken) then) =
      _$DeviceTokenCopyWithImpl<$Res, DeviceToken>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String token,
      String deviceType,
      String deviceId,
      String appVersion,
      String osVersion,
      bool isActive,
      DateTime registeredAt,
      DateTime? lastUsedAt,
      String? fcmToken,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$DeviceTokenCopyWithImpl<$Res, $Val extends DeviceToken>
    implements $DeviceTokenCopyWith<$Res> {
  _$DeviceTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? token = null,
    Object? deviceType = null,
    Object? deviceId = null,
    Object? appVersion = null,
    Object? osVersion = null,
    Object? isActive = null,
    Object? registeredAt = null,
    Object? lastUsedAt = freezed,
    Object? fcmToken = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      registeredAt: null == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceTokenImplCopyWith<$Res>
    implements $DeviceTokenCopyWith<$Res> {
  factory _$$DeviceTokenImplCopyWith(
          _$DeviceTokenImpl value, $Res Function(_$DeviceTokenImpl) then) =
      __$$DeviceTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String token,
      String deviceType,
      String deviceId,
      String appVersion,
      String osVersion,
      bool isActive,
      DateTime registeredAt,
      DateTime? lastUsedAt,
      String? fcmToken,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$DeviceTokenImplCopyWithImpl<$Res>
    extends _$DeviceTokenCopyWithImpl<$Res, _$DeviceTokenImpl>
    implements _$$DeviceTokenImplCopyWith<$Res> {
  __$$DeviceTokenImplCopyWithImpl(
      _$DeviceTokenImpl _value, $Res Function(_$DeviceTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeviceToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? token = null,
    Object? deviceType = null,
    Object? deviceId = null,
    Object? appVersion = null,
    Object? osVersion = null,
    Object? isActive = null,
    Object? registeredAt = null,
    Object? lastUsedAt = freezed,
    Object? fcmToken = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$DeviceTokenImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      registeredAt: null == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
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
class _$DeviceTokenImpl implements _DeviceToken {
  const _$DeviceTokenImpl(
      {required this.id,
      required this.userId,
      required this.token,
      required this.deviceType,
      required this.deviceId,
      required this.appVersion,
      required this.osVersion,
      required this.isActive,
      required this.registeredAt,
      this.lastUsedAt,
      this.fcmToken,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$DeviceTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceTokenImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String token;
  @override
  final String deviceType;
  @override
  final String deviceId;
  @override
  final String appVersion;
  @override
  final String osVersion;
  @override
  final bool isActive;
  @override
  final DateTime registeredAt;
  @override
  final DateTime? lastUsedAt;
  @override
  final String? fcmToken;
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
    return 'DeviceToken(id: $id, userId: $userId, token: $token, deviceType: $deviceType, deviceId: $deviceId, appVersion: $appVersion, osVersion: $osVersion, isActive: $isActive, registeredAt: $registeredAt, lastUsedAt: $lastUsedAt, fcmToken: $fcmToken, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceTokenImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      token,
      deviceType,
      deviceId,
      appVersion,
      osVersion,
      isActive,
      registeredAt,
      lastUsedAt,
      fcmToken,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of DeviceToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceTokenImplCopyWith<_$DeviceTokenImpl> get copyWith =>
      __$$DeviceTokenImplCopyWithImpl<_$DeviceTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceTokenImplToJson(
      this,
    );
  }
}

abstract class _DeviceToken implements DeviceToken {
  const factory _DeviceToken(
      {required final String id,
      required final String userId,
      required final String token,
      required final String deviceType,
      required final String deviceId,
      required final String appVersion,
      required final String osVersion,
      required final bool isActive,
      required final DateTime registeredAt,
      final DateTime? lastUsedAt,
      final String? fcmToken,
      final Map<String, dynamic>? metadata}) = _$DeviceTokenImpl;

  factory _DeviceToken.fromJson(Map<String, dynamic> json) =
      _$DeviceTokenImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get token;
  @override
  String get deviceType;
  @override
  String get deviceId;
  @override
  String get appVersion;
  @override
  String get osVersion;
  @override
  bool get isActive;
  @override
  DateTime get registeredAt;
  @override
  DateTime? get lastUsedAt;
  @override
  String? get fcmToken;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of DeviceToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceTokenImplCopyWith<_$DeviceTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PushNotification _$PushNotificationFromJson(Map<String, dynamic> json) {
  return _PushNotification.fromJson(json);
}

/// @nodoc
mixin _$PushNotification {
  String get id => throw _privateConstructorUsedError;
  String get noticeId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  List<String> get targetTokens => throw _privateConstructorUsedError;
  PushNotificationStatus get status => throw _privateConstructorUsedError;
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  int? get retryCount => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PushNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushNotificationCopyWith<PushNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationCopyWith<$Res> {
  factory $PushNotificationCopyWith(
          PushNotification value, $Res Function(PushNotification) then) =
      _$PushNotificationCopyWithImpl<$Res, PushNotification>;
  @useResult
  $Res call(
      {String id,
      String noticeId,
      String title,
      String body,
      Map<String, dynamic> data,
      List<String> targetTokens,
      PushNotificationStatus status,
      DateTime scheduledAt,
      DateTime? sentAt,
      DateTime? deliveredAt,
      int? retryCount,
      String? errorMessage,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$PushNotificationCopyWithImpl<$Res, $Val extends PushNotification>
    implements $PushNotificationCopyWith<$Res> {
  _$PushNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? noticeId = null,
    Object? title = null,
    Object? body = null,
    Object? data = null,
    Object? targetTokens = null,
    Object? status = null,
    Object? scheduledAt = null,
    Object? sentAt = freezed,
    Object? deliveredAt = freezed,
    Object? retryCount = freezed,
    Object? errorMessage = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      noticeId: null == noticeId
          ? _value.noticeId
          : noticeId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      targetTokens: null == targetTokens
          ? _value.targetTokens
          : targetTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PushNotificationStatus,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      retryCount: freezed == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushNotificationImplCopyWith<$Res>
    implements $PushNotificationCopyWith<$Res> {
  factory _$$PushNotificationImplCopyWith(_$PushNotificationImpl value,
          $Res Function(_$PushNotificationImpl) then) =
      __$$PushNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String noticeId,
      String title,
      String body,
      Map<String, dynamic> data,
      List<String> targetTokens,
      PushNotificationStatus status,
      DateTime scheduledAt,
      DateTime? sentAt,
      DateTime? deliveredAt,
      int? retryCount,
      String? errorMessage,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$PushNotificationImplCopyWithImpl<$Res>
    extends _$PushNotificationCopyWithImpl<$Res, _$PushNotificationImpl>
    implements _$$PushNotificationImplCopyWith<$Res> {
  __$$PushNotificationImplCopyWithImpl(_$PushNotificationImpl _value,
      $Res Function(_$PushNotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? noticeId = null,
    Object? title = null,
    Object? body = null,
    Object? data = null,
    Object? targetTokens = null,
    Object? status = null,
    Object? scheduledAt = null,
    Object? sentAt = freezed,
    Object? deliveredAt = freezed,
    Object? retryCount = freezed,
    Object? errorMessage = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$PushNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      noticeId: null == noticeId
          ? _value.noticeId
          : noticeId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      targetTokens: null == targetTokens
          ? _value._targetTokens
          : targetTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PushNotificationStatus,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      retryCount: freezed == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
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
class _$PushNotificationImpl implements _PushNotification {
  const _$PushNotificationImpl(
      {required this.id,
      required this.noticeId,
      required this.title,
      required this.body,
      required final Map<String, dynamic> data,
      required final List<String> targetTokens,
      required this.status,
      required this.scheduledAt,
      this.sentAt,
      this.deliveredAt,
      this.retryCount,
      this.errorMessage,
      final Map<String, dynamic>? metadata})
      : _data = data,
        _targetTokens = targetTokens,
        _metadata = metadata;

  factory _$PushNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String noticeId;
  @override
  final String title;
  @override
  final String body;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  final List<String> _targetTokens;
  @override
  List<String> get targetTokens {
    if (_targetTokens is EqualUnmodifiableListView) return _targetTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetTokens);
  }

  @override
  final PushNotificationStatus status;
  @override
  final DateTime scheduledAt;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? deliveredAt;
  @override
  final int? retryCount;
  @override
  final String? errorMessage;
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
    return 'PushNotification(id: $id, noticeId: $noticeId, title: $title, body: $body, data: $data, targetTokens: $targetTokens, status: $status, scheduledAt: $scheduledAt, sentAt: $sentAt, deliveredAt: $deliveredAt, retryCount: $retryCount, errorMessage: $errorMessage, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.noticeId, noticeId) ||
                other.noticeId == noticeId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._targetTokens, _targetTokens) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      noticeId,
      title,
      body,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_targetTokens),
      status,
      scheduledAt,
      sentAt,
      deliveredAt,
      retryCount,
      errorMessage,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      __$$PushNotificationImplCopyWithImpl<_$PushNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationImplToJson(
      this,
    );
  }
}

abstract class _PushNotification implements PushNotification {
  const factory _PushNotification(
      {required final String id,
      required final String noticeId,
      required final String title,
      required final String body,
      required final Map<String, dynamic> data,
      required final List<String> targetTokens,
      required final PushNotificationStatus status,
      required final DateTime scheduledAt,
      final DateTime? sentAt,
      final DateTime? deliveredAt,
      final int? retryCount,
      final String? errorMessage,
      final Map<String, dynamic>? metadata}) = _$PushNotificationImpl;

  factory _PushNotification.fromJson(Map<String, dynamic> json) =
      _$PushNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get noticeId;
  @override
  String get title;
  @override
  String get body;
  @override
  Map<String, dynamic> get data;
  @override
  List<String> get targetTokens;
  @override
  PushNotificationStatus get status;
  @override
  DateTime get scheduledAt;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get deliveredAt;
  @override
  int? get retryCount;
  @override
  String? get errorMessage;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineQueueItem _$OfflineQueueItemFromJson(Map<String, dynamic> json) {
  return _OfflineQueueItem.fromJson(json);
}

/// @nodoc
mixin _$OfflineQueueItem {
  String get id => throw _privateConstructorUsedError;
  OfflineActionType get actionType => throw _privateConstructorUsedError;
  String get noticeId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  OfflineQueueStatus get status => throw _privateConstructorUsedError;
  DateTime? get lastRetryAt => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this OfflineQueueItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfflineQueueItemCopyWith<OfflineQueueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineQueueItemCopyWith<$Res> {
  factory $OfflineQueueItemCopyWith(
          OfflineQueueItem value, $Res Function(OfflineQueueItem) then) =
      _$OfflineQueueItemCopyWithImpl<$Res, OfflineQueueItem>;
  @useResult
  $Res call(
      {String id,
      OfflineActionType actionType,
      String noticeId,
      String userId,
      DateTime createdAt,
      Map<String, dynamic> payload,
      int retryCount,
      OfflineQueueStatus status,
      DateTime? lastRetryAt,
      String? errorMessage,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$OfflineQueueItemCopyWithImpl<$Res, $Val extends OfflineQueueItem>
    implements $OfflineQueueItemCopyWith<$Res> {
  _$OfflineQueueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actionType = null,
    Object? noticeId = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? payload = null,
    Object? retryCount = null,
    Object? status = null,
    Object? lastRetryAt = freezed,
    Object? errorMessage = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as OfflineActionType,
      noticeId: null == noticeId
          ? _value.noticeId
          : noticeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OfflineQueueStatus,
      lastRetryAt: freezed == lastRetryAt
          ? _value.lastRetryAt
          : lastRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineQueueItemImplCopyWith<$Res>
    implements $OfflineQueueItemCopyWith<$Res> {
  factory _$$OfflineQueueItemImplCopyWith(_$OfflineQueueItemImpl value,
          $Res Function(_$OfflineQueueItemImpl) then) =
      __$$OfflineQueueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      OfflineActionType actionType,
      String noticeId,
      String userId,
      DateTime createdAt,
      Map<String, dynamic> payload,
      int retryCount,
      OfflineQueueStatus status,
      DateTime? lastRetryAt,
      String? errorMessage,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$OfflineQueueItemImplCopyWithImpl<$Res>
    extends _$OfflineQueueItemCopyWithImpl<$Res, _$OfflineQueueItemImpl>
    implements _$$OfflineQueueItemImplCopyWith<$Res> {
  __$$OfflineQueueItemImplCopyWithImpl(_$OfflineQueueItemImpl _value,
      $Res Function(_$OfflineQueueItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actionType = null,
    Object? noticeId = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? payload = null,
    Object? retryCount = null,
    Object? status = null,
    Object? lastRetryAt = freezed,
    Object? errorMessage = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$OfflineQueueItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as OfflineActionType,
      noticeId: null == noticeId
          ? _value.noticeId
          : noticeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OfflineQueueStatus,
      lastRetryAt: freezed == lastRetryAt
          ? _value.lastRetryAt
          : lastRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
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
class _$OfflineQueueItemImpl implements _OfflineQueueItem {
  const _$OfflineQueueItemImpl(
      {required this.id,
      required this.actionType,
      required this.noticeId,
      required this.userId,
      required this.createdAt,
      required final Map<String, dynamic> payload,
      required this.retryCount,
      required this.status,
      this.lastRetryAt,
      this.errorMessage,
      final Map<String, dynamic>? metadata})
      : _payload = payload,
        _metadata = metadata;

  factory _$OfflineQueueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineQueueItemImplFromJson(json);

  @override
  final String id;
  @override
  final OfflineActionType actionType;
  @override
  final String noticeId;
  @override
  final String userId;
  @override
  final DateTime createdAt;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  final int retryCount;
  @override
  final OfflineQueueStatus status;
  @override
  final DateTime? lastRetryAt;
  @override
  final String? errorMessage;
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
    return 'OfflineQueueItem(id: $id, actionType: $actionType, noticeId: $noticeId, userId: $userId, createdAt: $createdAt, payload: $payload, retryCount: $retryCount, status: $status, lastRetryAt: $lastRetryAt, errorMessage: $errorMessage, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineQueueItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.noticeId, noticeId) ||
                other.noticeId == noticeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastRetryAt, lastRetryAt) ||
                other.lastRetryAt == lastRetryAt) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      actionType,
      noticeId,
      userId,
      createdAt,
      const DeepCollectionEquality().hash(_payload),
      retryCount,
      status,
      lastRetryAt,
      errorMessage,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineQueueItemImplCopyWith<_$OfflineQueueItemImpl> get copyWith =>
      __$$OfflineQueueItemImplCopyWithImpl<_$OfflineQueueItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineQueueItemImplToJson(
      this,
    );
  }
}

abstract class _OfflineQueueItem implements OfflineQueueItem {
  const factory _OfflineQueueItem(
      {required final String id,
      required final OfflineActionType actionType,
      required final String noticeId,
      required final String userId,
      required final DateTime createdAt,
      required final Map<String, dynamic> payload,
      required final int retryCount,
      required final OfflineQueueStatus status,
      final DateTime? lastRetryAt,
      final String? errorMessage,
      final Map<String, dynamic>? metadata}) = _$OfflineQueueItemImpl;

  factory _OfflineQueueItem.fromJson(Map<String, dynamic> json) =
      _$OfflineQueueItemImpl.fromJson;

  @override
  String get id;
  @override
  OfflineActionType get actionType;
  @override
  String get noticeId;
  @override
  String get userId;
  @override
  DateTime get createdAt;
  @override
  Map<String, dynamic> get payload;
  @override
  int get retryCount;
  @override
  OfflineQueueStatus get status;
  @override
  DateTime? get lastRetryAt;
  @override
  String? get errorMessage;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfflineQueueItemImplCopyWith<_$OfflineQueueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeCreationRequest _$NoticeCreationRequestFromJson(
    Map<String, dynamic> json) {
  return _NoticeCreationRequest.fromJson(json);
}

/// @nodoc
mixin _$NoticeCreationRequest {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  NoticePriority get priority => throw _privateConstructorUsedError;
  NoticeType get type => throw _privateConstructorUsedError;
  NoticeAudience get audience => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String>? get attachments => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this NoticeCreationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeCreationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeCreationRequestCopyWith<NoticeCreationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeCreationRequestCopyWith<$Res> {
  factory $NoticeCreationRequestCopyWith(NoticeCreationRequest value,
          $Res Function(NoticeCreationRequest) then) =
      _$NoticeCreationRequestCopyWithImpl<$Res, NoticeCreationRequest>;
  @useResult
  $Res call(
      {String title,
      String content,
      NoticePriority priority,
      NoticeType type,
      NoticeAudience audience,
      DateTime? expiresAt,
      String? imageUrl,
      List<String>? attachments,
      Map<String, dynamic>? metadata});

  $NoticeAudienceCopyWith<$Res> get audience;
}

/// @nodoc
class _$NoticeCreationRequestCopyWithImpl<$Res,
        $Val extends NoticeCreationRequest>
    implements $NoticeCreationRequestCopyWith<$Res> {
  _$NoticeCreationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeCreationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? priority = null,
    Object? type = null,
    Object? audience = null,
    Object? expiresAt = freezed,
    Object? imageUrl = freezed,
    Object? attachments = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType,
      audience: null == audience
          ? _value.audience
          : audience // ignore: cast_nullable_to_non_nullable
              as NoticeAudience,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of NoticeCreationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NoticeAudienceCopyWith<$Res> get audience {
    return $NoticeAudienceCopyWith<$Res>(_value.audience, (value) {
      return _then(_value.copyWith(audience: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoticeCreationRequestImplCopyWith<$Res>
    implements $NoticeCreationRequestCopyWith<$Res> {
  factory _$$NoticeCreationRequestImplCopyWith(
          _$NoticeCreationRequestImpl value,
          $Res Function(_$NoticeCreationRequestImpl) then) =
      __$$NoticeCreationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String content,
      NoticePriority priority,
      NoticeType type,
      NoticeAudience audience,
      DateTime? expiresAt,
      String? imageUrl,
      List<String>? attachments,
      Map<String, dynamic>? metadata});

  @override
  $NoticeAudienceCopyWith<$Res> get audience;
}

/// @nodoc
class __$$NoticeCreationRequestImplCopyWithImpl<$Res>
    extends _$NoticeCreationRequestCopyWithImpl<$Res,
        _$NoticeCreationRequestImpl>
    implements _$$NoticeCreationRequestImplCopyWith<$Res> {
  __$$NoticeCreationRequestImplCopyWithImpl(_$NoticeCreationRequestImpl _value,
      $Res Function(_$NoticeCreationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeCreationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? priority = null,
    Object? type = null,
    Object? audience = null,
    Object? expiresAt = freezed,
    Object? imageUrl = freezed,
    Object? attachments = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$NoticeCreationRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType,
      audience: null == audience
          ? _value.audience
          : audience // ignore: cast_nullable_to_non_nullable
              as NoticeAudience,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
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
class _$NoticeCreationRequestImpl implements _NoticeCreationRequest {
  const _$NoticeCreationRequestImpl(
      {required this.title,
      required this.content,
      required this.priority,
      required this.type,
      required this.audience,
      this.expiresAt,
      this.imageUrl,
      final List<String>? attachments,
      final Map<String, dynamic>? metadata})
      : _attachments = attachments,
        _metadata = metadata;

  factory _$NoticeCreationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeCreationRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String content;
  @override
  final NoticePriority priority;
  @override
  final NoticeType type;
  @override
  final NoticeAudience audience;
  @override
  final DateTime? expiresAt;
  @override
  final String? imageUrl;
  final List<String>? _attachments;
  @override
  List<String>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
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
    return 'NoticeCreationRequest(title: $title, content: $content, priority: $priority, type: $type, audience: $audience, expiresAt: $expiresAt, imageUrl: $imageUrl, attachments: $attachments, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeCreationRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.audience, audience) ||
                other.audience == audience) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      content,
      priority,
      type,
      audience,
      expiresAt,
      imageUrl,
      const DeepCollectionEquality().hash(_attachments),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of NoticeCreationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeCreationRequestImplCopyWith<_$NoticeCreationRequestImpl>
      get copyWith => __$$NoticeCreationRequestImplCopyWithImpl<
          _$NoticeCreationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeCreationRequestImplToJson(
      this,
    );
  }
}

abstract class _NoticeCreationRequest implements NoticeCreationRequest {
  const factory _NoticeCreationRequest(
      {required final String title,
      required final String content,
      required final NoticePriority priority,
      required final NoticeType type,
      required final NoticeAudience audience,
      final DateTime? expiresAt,
      final String? imageUrl,
      final List<String>? attachments,
      final Map<String, dynamic>? metadata}) = _$NoticeCreationRequestImpl;

  factory _NoticeCreationRequest.fromJson(Map<String, dynamic> json) =
      _$NoticeCreationRequestImpl.fromJson;

  @override
  String get title;
  @override
  String get content;
  @override
  NoticePriority get priority;
  @override
  NoticeType get type;
  @override
  NoticeAudience get audience;
  @override
  DateTime? get expiresAt;
  @override
  String? get imageUrl;
  @override
  List<String>? get attachments;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of NoticeCreationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeCreationRequestImplCopyWith<_$NoticeCreationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NoticeUpdateRequest _$NoticeUpdateRequestFromJson(Map<String, dynamic> json) {
  return _NoticeUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$NoticeUpdateRequest {
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  NoticePriority? get priority => throw _privateConstructorUsedError;
  NoticeType? get type => throw _privateConstructorUsedError;
  NoticeAudience? get audience => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String>? get attachments => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this NoticeUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeUpdateRequestCopyWith<NoticeUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeUpdateRequestCopyWith<$Res> {
  factory $NoticeUpdateRequestCopyWith(
          NoticeUpdateRequest value, $Res Function(NoticeUpdateRequest) then) =
      _$NoticeUpdateRequestCopyWithImpl<$Res, NoticeUpdateRequest>;
  @useResult
  $Res call(
      {String? title,
      String? content,
      NoticePriority? priority,
      NoticeType? type,
      NoticeAudience? audience,
      DateTime? expiresAt,
      String? imageUrl,
      List<String>? attachments,
      bool? isActive,
      Map<String, dynamic>? metadata});

  $NoticeAudienceCopyWith<$Res>? get audience;
}

/// @nodoc
class _$NoticeUpdateRequestCopyWithImpl<$Res, $Val extends NoticeUpdateRequest>
    implements $NoticeUpdateRequestCopyWith<$Res> {
  _$NoticeUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? content = freezed,
    Object? priority = freezed,
    Object? type = freezed,
    Object? audience = freezed,
    Object? expiresAt = freezed,
    Object? imageUrl = freezed,
    Object? attachments = freezed,
    Object? isActive = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType?,
      audience: freezed == audience
          ? _value.audience
          : audience // ignore: cast_nullable_to_non_nullable
              as NoticeAudience?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of NoticeUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NoticeAudienceCopyWith<$Res>? get audience {
    if (_value.audience == null) {
      return null;
    }

    return $NoticeAudienceCopyWith<$Res>(_value.audience!, (value) {
      return _then(_value.copyWith(audience: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoticeUpdateRequestImplCopyWith<$Res>
    implements $NoticeUpdateRequestCopyWith<$Res> {
  factory _$$NoticeUpdateRequestImplCopyWith(_$NoticeUpdateRequestImpl value,
          $Res Function(_$NoticeUpdateRequestImpl) then) =
      __$$NoticeUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? content,
      NoticePriority? priority,
      NoticeType? type,
      NoticeAudience? audience,
      DateTime? expiresAt,
      String? imageUrl,
      List<String>? attachments,
      bool? isActive,
      Map<String, dynamic>? metadata});

  @override
  $NoticeAudienceCopyWith<$Res>? get audience;
}

/// @nodoc
class __$$NoticeUpdateRequestImplCopyWithImpl<$Res>
    extends _$NoticeUpdateRequestCopyWithImpl<$Res, _$NoticeUpdateRequestImpl>
    implements _$$NoticeUpdateRequestImplCopyWith<$Res> {
  __$$NoticeUpdateRequestImplCopyWithImpl(_$NoticeUpdateRequestImpl _value,
      $Res Function(_$NoticeUpdateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? content = freezed,
    Object? priority = freezed,
    Object? type = freezed,
    Object? audience = freezed,
    Object? expiresAt = freezed,
    Object? imageUrl = freezed,
    Object? attachments = freezed,
    Object? isActive = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$NoticeUpdateRequestImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType?,
      audience: freezed == audience
          ? _value.audience
          : audience // ignore: cast_nullable_to_non_nullable
              as NoticeAudience?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeUpdateRequestImpl implements _NoticeUpdateRequest {
  const _$NoticeUpdateRequestImpl(
      {this.title,
      this.content,
      this.priority,
      this.type,
      this.audience,
      this.expiresAt,
      this.imageUrl,
      final List<String>? attachments,
      this.isActive,
      final Map<String, dynamic>? metadata})
      : _attachments = attachments,
        _metadata = metadata;

  factory _$NoticeUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeUpdateRequestImplFromJson(json);

  @override
  final String? title;
  @override
  final String? content;
  @override
  final NoticePriority? priority;
  @override
  final NoticeType? type;
  @override
  final NoticeAudience? audience;
  @override
  final DateTime? expiresAt;
  @override
  final String? imageUrl;
  final List<String>? _attachments;
  @override
  List<String>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isActive;
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
    return 'NoticeUpdateRequest(title: $title, content: $content, priority: $priority, type: $type, audience: $audience, expiresAt: $expiresAt, imageUrl: $imageUrl, attachments: $attachments, isActive: $isActive, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeUpdateRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.audience, audience) ||
                other.audience == audience) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      content,
      priority,
      type,
      audience,
      expiresAt,
      imageUrl,
      const DeepCollectionEquality().hash(_attachments),
      isActive,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of NoticeUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeUpdateRequestImplCopyWith<_$NoticeUpdateRequestImpl> get copyWith =>
      __$$NoticeUpdateRequestImplCopyWithImpl<_$NoticeUpdateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeUpdateRequestImplToJson(
      this,
    );
  }
}

abstract class _NoticeUpdateRequest implements NoticeUpdateRequest {
  const factory _NoticeUpdateRequest(
      {final String? title,
      final String? content,
      final NoticePriority? priority,
      final NoticeType? type,
      final NoticeAudience? audience,
      final DateTime? expiresAt,
      final String? imageUrl,
      final List<String>? attachments,
      final bool? isActive,
      final Map<String, dynamic>? metadata}) = _$NoticeUpdateRequestImpl;

  factory _NoticeUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$NoticeUpdateRequestImpl.fromJson;

  @override
  String? get title;
  @override
  String? get content;
  @override
  NoticePriority? get priority;
  @override
  NoticeType? get type;
  @override
  NoticeAudience? get audience;
  @override
  DateTime? get expiresAt;
  @override
  String? get imageUrl;
  @override
  List<String>? get attachments;
  @override
  bool? get isActive;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of NoticeUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeUpdateRequestImplCopyWith<_$NoticeUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceTokenRegistrationRequest _$DeviceTokenRegistrationRequestFromJson(
    Map<String, dynamic> json) {
  return _DeviceTokenRegistrationRequest.fromJson(json);
}

/// @nodoc
mixin _$DeviceTokenRegistrationRequest {
  String get token => throw _privateConstructorUsedError;
  String get deviceType => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get appVersion => throw _privateConstructorUsedError;
  String get osVersion => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this DeviceTokenRegistrationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceTokenRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceTokenRegistrationRequestCopyWith<DeviceTokenRegistrationRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceTokenRegistrationRequestCopyWith<$Res> {
  factory $DeviceTokenRegistrationRequestCopyWith(
          DeviceTokenRegistrationRequest value,
          $Res Function(DeviceTokenRegistrationRequest) then) =
      _$DeviceTokenRegistrationRequestCopyWithImpl<$Res,
          DeviceTokenRegistrationRequest>;
  @useResult
  $Res call(
      {String token,
      String deviceType,
      String deviceId,
      String appVersion,
      String osVersion,
      String? fcmToken,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$DeviceTokenRegistrationRequestCopyWithImpl<$Res,
        $Val extends DeviceTokenRegistrationRequest>
    implements $DeviceTokenRegistrationRequestCopyWith<$Res> {
  _$DeviceTokenRegistrationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceTokenRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? deviceType = null,
    Object? deviceId = null,
    Object? appVersion = null,
    Object? osVersion = null,
    Object? fcmToken = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceTokenRegistrationRequestImplCopyWith<$Res>
    implements $DeviceTokenRegistrationRequestCopyWith<$Res> {
  factory _$$DeviceTokenRegistrationRequestImplCopyWith(
          _$DeviceTokenRegistrationRequestImpl value,
          $Res Function(_$DeviceTokenRegistrationRequestImpl) then) =
      __$$DeviceTokenRegistrationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token,
      String deviceType,
      String deviceId,
      String appVersion,
      String osVersion,
      String? fcmToken,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$DeviceTokenRegistrationRequestImplCopyWithImpl<$Res>
    extends _$DeviceTokenRegistrationRequestCopyWithImpl<$Res,
        _$DeviceTokenRegistrationRequestImpl>
    implements _$$DeviceTokenRegistrationRequestImplCopyWith<$Res> {
  __$$DeviceTokenRegistrationRequestImplCopyWithImpl(
      _$DeviceTokenRegistrationRequestImpl _value,
      $Res Function(_$DeviceTokenRegistrationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeviceTokenRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? deviceType = null,
    Object? deviceId = null,
    Object? appVersion = null,
    Object? osVersion = null,
    Object? fcmToken = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$DeviceTokenRegistrationRequestImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
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
class _$DeviceTokenRegistrationRequestImpl
    implements _DeviceTokenRegistrationRequest {
  const _$DeviceTokenRegistrationRequestImpl(
      {required this.token,
      required this.deviceType,
      required this.deviceId,
      required this.appVersion,
      required this.osVersion,
      this.fcmToken,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$DeviceTokenRegistrationRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeviceTokenRegistrationRequestImplFromJson(json);

  @override
  final String token;
  @override
  final String deviceType;
  @override
  final String deviceId;
  @override
  final String appVersion;
  @override
  final String osVersion;
  @override
  final String? fcmToken;
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
    return 'DeviceTokenRegistrationRequest(token: $token, deviceType: $deviceType, deviceId: $deviceId, appVersion: $appVersion, osVersion: $osVersion, fcmToken: $fcmToken, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceTokenRegistrationRequestImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      token,
      deviceType,
      deviceId,
      appVersion,
      osVersion,
      fcmToken,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of DeviceTokenRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceTokenRegistrationRequestImplCopyWith<
          _$DeviceTokenRegistrationRequestImpl>
      get copyWith => __$$DeviceTokenRegistrationRequestImplCopyWithImpl<
          _$DeviceTokenRegistrationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceTokenRegistrationRequestImplToJson(
      this,
    );
  }
}

abstract class _DeviceTokenRegistrationRequest
    implements DeviceTokenRegistrationRequest {
  const factory _DeviceTokenRegistrationRequest(
          {required final String token,
          required final String deviceType,
          required final String deviceId,
          required final String appVersion,
          required final String osVersion,
          final String? fcmToken,
          final Map<String, dynamic>? metadata}) =
      _$DeviceTokenRegistrationRequestImpl;

  factory _DeviceTokenRegistrationRequest.fromJson(Map<String, dynamic> json) =
      _$DeviceTokenRegistrationRequestImpl.fromJson;

  @override
  String get token;
  @override
  String get deviceType;
  @override
  String get deviceId;
  @override
  String get appVersion;
  @override
  String get osVersion;
  @override
  String? get fcmToken;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of DeviceTokenRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceTokenRegistrationRequestImplCopyWith<
          _$DeviceTokenRegistrationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NoticeInboxItem _$NoticeInboxItemFromJson(Map<String, dynamic> json) {
  return _NoticeInboxItem.fromJson(json);
}

/// @nodoc
mixin _$NoticeInboxItem {
  Notice get notice => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  bool get isDelivered => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  bool get isFailed => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;

  /// Serializes this NoticeInboxItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeInboxItemCopyWith<NoticeInboxItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeInboxItemCopyWith<$Res> {
  factory $NoticeInboxItemCopyWith(
          NoticeInboxItem value, $Res Function(NoticeInboxItem) then) =
      _$NoticeInboxItemCopyWithImpl<$Res, NoticeInboxItem>;
  @useResult
  $Res call(
      {Notice notice,
      bool isRead,
      DateTime? readAt,
      bool isDelivered,
      DateTime? deliveredAt,
      bool isFailed,
      String? failureReason});

  $NoticeCopyWith<$Res> get notice;
}

/// @nodoc
class _$NoticeInboxItemCopyWithImpl<$Res, $Val extends NoticeInboxItem>
    implements $NoticeInboxItemCopyWith<$Res> {
  _$NoticeInboxItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notice = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? isDelivered = null,
    Object? deliveredAt = freezed,
    Object? isFailed = null,
    Object? failureReason = freezed,
  }) {
    return _then(_value.copyWith(
      notice: null == notice
          ? _value.notice
          : notice // ignore: cast_nullable_to_non_nullable
              as Notice,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDelivered: null == isDelivered
          ? _value.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFailed: null == isFailed
          ? _value.isFailed
          : isFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of NoticeInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NoticeCopyWith<$Res> get notice {
    return $NoticeCopyWith<$Res>(_value.notice, (value) {
      return _then(_value.copyWith(notice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoticeInboxItemImplCopyWith<$Res>
    implements $NoticeInboxItemCopyWith<$Res> {
  factory _$$NoticeInboxItemImplCopyWith(_$NoticeInboxItemImpl value,
          $Res Function(_$NoticeInboxItemImpl) then) =
      __$$NoticeInboxItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Notice notice,
      bool isRead,
      DateTime? readAt,
      bool isDelivered,
      DateTime? deliveredAt,
      bool isFailed,
      String? failureReason});

  @override
  $NoticeCopyWith<$Res> get notice;
}

/// @nodoc
class __$$NoticeInboxItemImplCopyWithImpl<$Res>
    extends _$NoticeInboxItemCopyWithImpl<$Res, _$NoticeInboxItemImpl>
    implements _$$NoticeInboxItemImplCopyWith<$Res> {
  __$$NoticeInboxItemImplCopyWithImpl(
      _$NoticeInboxItemImpl _value, $Res Function(_$NoticeInboxItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notice = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? isDelivered = null,
    Object? deliveredAt = freezed,
    Object? isFailed = null,
    Object? failureReason = freezed,
  }) {
    return _then(_$NoticeInboxItemImpl(
      notice: null == notice
          ? _value.notice
          : notice // ignore: cast_nullable_to_non_nullable
              as Notice,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDelivered: null == isDelivered
          ? _value.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFailed: null == isFailed
          ? _value.isFailed
          : isFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeInboxItemImpl implements _NoticeInboxItem {
  const _$NoticeInboxItemImpl(
      {required this.notice,
      required this.isRead,
      this.readAt,
      required this.isDelivered,
      this.deliveredAt,
      required this.isFailed,
      this.failureReason});

  factory _$NoticeInboxItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeInboxItemImplFromJson(json);

  @override
  final Notice notice;
  @override
  final bool isRead;
  @override
  final DateTime? readAt;
  @override
  final bool isDelivered;
  @override
  final DateTime? deliveredAt;
  @override
  final bool isFailed;
  @override
  final String? failureReason;

  @override
  String toString() {
    return 'NoticeInboxItem(notice: $notice, isRead: $isRead, readAt: $readAt, isDelivered: $isDelivered, deliveredAt: $deliveredAt, isFailed: $isFailed, failureReason: $failureReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeInboxItemImpl &&
            (identical(other.notice, notice) || other.notice == notice) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.isDelivered, isDelivered) ||
                other.isDelivered == isDelivered) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.isFailed, isFailed) ||
                other.isFailed == isFailed) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, notice, isRead, readAt,
      isDelivered, deliveredAt, isFailed, failureReason);

  /// Create a copy of NoticeInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeInboxItemImplCopyWith<_$NoticeInboxItemImpl> get copyWith =>
      __$$NoticeInboxItemImplCopyWithImpl<_$NoticeInboxItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeInboxItemImplToJson(
      this,
    );
  }
}

abstract class _NoticeInboxItem implements NoticeInboxItem {
  const factory _NoticeInboxItem(
      {required final Notice notice,
      required final bool isRead,
      final DateTime? readAt,
      required final bool isDelivered,
      final DateTime? deliveredAt,
      required final bool isFailed,
      final String? failureReason}) = _$NoticeInboxItemImpl;

  factory _NoticeInboxItem.fromJson(Map<String, dynamic> json) =
      _$NoticeInboxItemImpl.fromJson;

  @override
  Notice get notice;
  @override
  bool get isRead;
  @override
  DateTime? get readAt;
  @override
  bool get isDelivered;
  @override
  DateTime? get deliveredAt;
  @override
  bool get isFailed;
  @override
  String? get failureReason;

  /// Create a copy of NoticeInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeInboxItemImplCopyWith<_$NoticeInboxItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeTemplate _$NoticeTemplateFromJson(Map<String, dynamic> json) {
  return _NoticeTemplate.fromJson(json);
}

/// @nodoc
mixin _$NoticeTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  NoticeType get type => throw _privateConstructorUsedError;
  NoticePriority get priority => throw _privateConstructorUsedError;
  NoticeAudienceType get audienceType => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get usageCount => throw _privateConstructorUsedError;

  /// Serializes this NoticeTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeTemplateCopyWith<NoticeTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeTemplateCopyWith<$Res> {
  factory $NoticeTemplateCopyWith(
          NoticeTemplate value, $Res Function(NoticeTemplate) then) =
      _$NoticeTemplateCopyWithImpl<$Res, NoticeTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String title,
      String content,
      NoticeType type,
      NoticePriority priority,
      NoticeAudienceType audienceType,
      List<String> tags,
      bool isPublic,
      String createdBy,
      DateTime? createdAt,
      int? usageCount});
}

/// @nodoc
class _$NoticeTemplateCopyWithImpl<$Res, $Val extends NoticeTemplate>
    implements $NoticeTemplateCopyWith<$Res> {
  _$NoticeTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? content = null,
    Object? type = null,
    Object? priority = null,
    Object? audienceType = null,
    Object? tags = null,
    Object? isPublic = null,
    Object? createdBy = null,
    Object? createdAt = freezed,
    Object? usageCount = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority,
      audienceType: null == audienceType
          ? _value.audienceType
          : audienceType // ignore: cast_nullable_to_non_nullable
              as NoticeAudienceType,
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
      usageCount: freezed == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoticeTemplateImplCopyWith<$Res>
    implements $NoticeTemplateCopyWith<$Res> {
  factory _$$NoticeTemplateImplCopyWith(_$NoticeTemplateImpl value,
          $Res Function(_$NoticeTemplateImpl) then) =
      __$$NoticeTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String title,
      String content,
      NoticeType type,
      NoticePriority priority,
      NoticeAudienceType audienceType,
      List<String> tags,
      bool isPublic,
      String createdBy,
      DateTime? createdAt,
      int? usageCount});
}

/// @nodoc
class __$$NoticeTemplateImplCopyWithImpl<$Res>
    extends _$NoticeTemplateCopyWithImpl<$Res, _$NoticeTemplateImpl>
    implements _$$NoticeTemplateImplCopyWith<$Res> {
  __$$NoticeTemplateImplCopyWithImpl(
      _$NoticeTemplateImpl _value, $Res Function(_$NoticeTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? content = null,
    Object? type = null,
    Object? priority = null,
    Object? audienceType = null,
    Object? tags = null,
    Object? isPublic = null,
    Object? createdBy = null,
    Object? createdAt = freezed,
    Object? usageCount = freezed,
  }) {
    return _then(_$NoticeTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoticeType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NoticePriority,
      audienceType: null == audienceType
          ? _value.audienceType
          : audienceType // ignore: cast_nullable_to_non_nullable
              as NoticeAudienceType,
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
      usageCount: freezed == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeTemplateImpl implements _NoticeTemplate {
  const _$NoticeTemplateImpl(
      {required this.id,
      required this.name,
      required this.title,
      required this.content,
      required this.type,
      required this.priority,
      required this.audienceType,
      required final List<String> tags,
      required this.isPublic,
      required this.createdBy,
      this.createdAt,
      this.usageCount})
      : _tags = tags;

  factory _$NoticeTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String title;
  @override
  final String content;
  @override
  final NoticeType type;
  @override
  final NoticePriority priority;
  @override
  final NoticeAudienceType audienceType;
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
  final int? usageCount;

  @override
  String toString() {
    return 'NoticeTemplate(id: $id, name: $name, title: $title, content: $content, type: $type, priority: $priority, audienceType: $audienceType, tags: $tags, isPublic: $isPublic, createdBy: $createdBy, createdAt: $createdAt, usageCount: $usageCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.audienceType, audienceType) ||
                other.audienceType == audienceType) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      title,
      content,
      type,
      priority,
      audienceType,
      const DeepCollectionEquality().hash(_tags),
      isPublic,
      createdBy,
      createdAt,
      usageCount);

  /// Create a copy of NoticeTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeTemplateImplCopyWith<_$NoticeTemplateImpl> get copyWith =>
      __$$NoticeTemplateImplCopyWithImpl<_$NoticeTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeTemplateImplToJson(
      this,
    );
  }
}

abstract class _NoticeTemplate implements NoticeTemplate {
  const factory _NoticeTemplate(
      {required final String id,
      required final String name,
      required final String title,
      required final String content,
      required final NoticeType type,
      required final NoticePriority priority,
      required final NoticeAudienceType audienceType,
      required final List<String> tags,
      required final bool isPublic,
      required final String createdBy,
      final DateTime? createdAt,
      final int? usageCount}) = _$NoticeTemplateImpl;

  factory _NoticeTemplate.fromJson(Map<String, dynamic> json) =
      _$NoticeTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get title;
  @override
  String get content;
  @override
  NoticeType get type;
  @override
  NoticePriority get priority;
  @override
  NoticeAudienceType get audienceType;
  @override
  List<String> get tags;
  @override
  bool get isPublic;
  @override
  String get createdBy;
  @override
  DateTime? get createdAt;
  @override
  int? get usageCount;

  /// Create a copy of NoticeTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeTemplateImplCopyWith<_$NoticeTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeAnalytics _$NoticeAnalyticsFromJson(Map<String, dynamic> json) {
  return _NoticeAnalytics.fromJson(json);
}

/// @nodoc
mixin _$NoticeAnalytics {
  String get period => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get totalNotices => throw _privateConstructorUsedError;
  int get totalSent => throw _privateConstructorUsedError;
  int get totalDelivered => throw _privateConstructorUsedError;
  int get totalRead => throw _privateConstructorUsedError;
  double get deliveryRate => throw _privateConstructorUsedError;
  double get readRate => throw _privateConstructorUsedError;
  Map<NoticeType, int> get noticesByType => throw _privateConstructorUsedError;
  Map<NoticePriority, int> get noticesByPriority =>
      throw _privateConstructorUsedError;
  Map<NoticeAudienceType, int> get noticesByAudience =>
      throw _privateConstructorUsedError;
  List<String> get topNotices => throw _privateConstructorUsedError;
  Map<String, dynamic> get trends => throw _privateConstructorUsedError;

  /// Serializes this NoticeAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeAnalyticsCopyWith<NoticeAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeAnalyticsCopyWith<$Res> {
  factory $NoticeAnalyticsCopyWith(
          NoticeAnalytics value, $Res Function(NoticeAnalytics) then) =
      _$NoticeAnalyticsCopyWithImpl<$Res, NoticeAnalytics>;
  @useResult
  $Res call(
      {String period,
      DateTime startDate,
      DateTime endDate,
      int totalNotices,
      int totalSent,
      int totalDelivered,
      int totalRead,
      double deliveryRate,
      double readRate,
      Map<NoticeType, int> noticesByType,
      Map<NoticePriority, int> noticesByPriority,
      Map<NoticeAudienceType, int> noticesByAudience,
      List<String> topNotices,
      Map<String, dynamic> trends});
}

/// @nodoc
class _$NoticeAnalyticsCopyWithImpl<$Res, $Val extends NoticeAnalytics>
    implements $NoticeAnalyticsCopyWith<$Res> {
  _$NoticeAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalNotices = null,
    Object? totalSent = null,
    Object? totalDelivered = null,
    Object? totalRead = null,
    Object? deliveryRate = null,
    Object? readRate = null,
    Object? noticesByType = null,
    Object? noticesByPriority = null,
    Object? noticesByAudience = null,
    Object? topNotices = null,
    Object? trends = null,
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
      totalNotices: null == totalNotices
          ? _value.totalNotices
          : totalNotices // ignore: cast_nullable_to_non_nullable
              as int,
      totalSent: null == totalSent
          ? _value.totalSent
          : totalSent // ignore: cast_nullable_to_non_nullable
              as int,
      totalDelivered: null == totalDelivered
          ? _value.totalDelivered
          : totalDelivered // ignore: cast_nullable_to_non_nullable
              as int,
      totalRead: null == totalRead
          ? _value.totalRead
          : totalRead // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryRate: null == deliveryRate
          ? _value.deliveryRate
          : deliveryRate // ignore: cast_nullable_to_non_nullable
              as double,
      readRate: null == readRate
          ? _value.readRate
          : readRate // ignore: cast_nullable_to_non_nullable
              as double,
      noticesByType: null == noticesByType
          ? _value.noticesByType
          : noticesByType // ignore: cast_nullable_to_non_nullable
              as Map<NoticeType, int>,
      noticesByPriority: null == noticesByPriority
          ? _value.noticesByPriority
          : noticesByPriority // ignore: cast_nullable_to_non_nullable
              as Map<NoticePriority, int>,
      noticesByAudience: null == noticesByAudience
          ? _value.noticesByAudience
          : noticesByAudience // ignore: cast_nullable_to_non_nullable
              as Map<NoticeAudienceType, int>,
      topNotices: null == topNotices
          ? _value.topNotices
          : topNotices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoticeAnalyticsImplCopyWith<$Res>
    implements $NoticeAnalyticsCopyWith<$Res> {
  factory _$$NoticeAnalyticsImplCopyWith(_$NoticeAnalyticsImpl value,
          $Res Function(_$NoticeAnalyticsImpl) then) =
      __$$NoticeAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String period,
      DateTime startDate,
      DateTime endDate,
      int totalNotices,
      int totalSent,
      int totalDelivered,
      int totalRead,
      double deliveryRate,
      double readRate,
      Map<NoticeType, int> noticesByType,
      Map<NoticePriority, int> noticesByPriority,
      Map<NoticeAudienceType, int> noticesByAudience,
      List<String> topNotices,
      Map<String, dynamic> trends});
}

/// @nodoc
class __$$NoticeAnalyticsImplCopyWithImpl<$Res>
    extends _$NoticeAnalyticsCopyWithImpl<$Res, _$NoticeAnalyticsImpl>
    implements _$$NoticeAnalyticsImplCopyWith<$Res> {
  __$$NoticeAnalyticsImplCopyWithImpl(
      _$NoticeAnalyticsImpl _value, $Res Function(_$NoticeAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoticeAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalNotices = null,
    Object? totalSent = null,
    Object? totalDelivered = null,
    Object? totalRead = null,
    Object? deliveryRate = null,
    Object? readRate = null,
    Object? noticesByType = null,
    Object? noticesByPriority = null,
    Object? noticesByAudience = null,
    Object? topNotices = null,
    Object? trends = null,
  }) {
    return _then(_$NoticeAnalyticsImpl(
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
      totalNotices: null == totalNotices
          ? _value.totalNotices
          : totalNotices // ignore: cast_nullable_to_non_nullable
              as int,
      totalSent: null == totalSent
          ? _value.totalSent
          : totalSent // ignore: cast_nullable_to_non_nullable
              as int,
      totalDelivered: null == totalDelivered
          ? _value.totalDelivered
          : totalDelivered // ignore: cast_nullable_to_non_nullable
              as int,
      totalRead: null == totalRead
          ? _value.totalRead
          : totalRead // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryRate: null == deliveryRate
          ? _value.deliveryRate
          : deliveryRate // ignore: cast_nullable_to_non_nullable
              as double,
      readRate: null == readRate
          ? _value.readRate
          : readRate // ignore: cast_nullable_to_non_nullable
              as double,
      noticesByType: null == noticesByType
          ? _value._noticesByType
          : noticesByType // ignore: cast_nullable_to_non_nullable
              as Map<NoticeType, int>,
      noticesByPriority: null == noticesByPriority
          ? _value._noticesByPriority
          : noticesByPriority // ignore: cast_nullable_to_non_nullable
              as Map<NoticePriority, int>,
      noticesByAudience: null == noticesByAudience
          ? _value._noticesByAudience
          : noticesByAudience // ignore: cast_nullable_to_non_nullable
              as Map<NoticeAudienceType, int>,
      topNotices: null == topNotices
          ? _value._topNotices
          : topNotices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeAnalyticsImpl implements _NoticeAnalytics {
  const _$NoticeAnalyticsImpl(
      {required this.period,
      required this.startDate,
      required this.endDate,
      required this.totalNotices,
      required this.totalSent,
      required this.totalDelivered,
      required this.totalRead,
      required this.deliveryRate,
      required this.readRate,
      required final Map<NoticeType, int> noticesByType,
      required final Map<NoticePriority, int> noticesByPriority,
      required final Map<NoticeAudienceType, int> noticesByAudience,
      required final List<String> topNotices,
      required final Map<String, dynamic> trends})
      : _noticesByType = noticesByType,
        _noticesByPriority = noticesByPriority,
        _noticesByAudience = noticesByAudience,
        _topNotices = topNotices,
        _trends = trends;

  factory _$NoticeAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeAnalyticsImplFromJson(json);

  @override
  final String period;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int totalNotices;
  @override
  final int totalSent;
  @override
  final int totalDelivered;
  @override
  final int totalRead;
  @override
  final double deliveryRate;
  @override
  final double readRate;
  final Map<NoticeType, int> _noticesByType;
  @override
  Map<NoticeType, int> get noticesByType {
    if (_noticesByType is EqualUnmodifiableMapView) return _noticesByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_noticesByType);
  }

  final Map<NoticePriority, int> _noticesByPriority;
  @override
  Map<NoticePriority, int> get noticesByPriority {
    if (_noticesByPriority is EqualUnmodifiableMapView)
      return _noticesByPriority;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_noticesByPriority);
  }

  final Map<NoticeAudienceType, int> _noticesByAudience;
  @override
  Map<NoticeAudienceType, int> get noticesByAudience {
    if (_noticesByAudience is EqualUnmodifiableMapView)
      return _noticesByAudience;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_noticesByAudience);
  }

  final List<String> _topNotices;
  @override
  List<String> get topNotices {
    if (_topNotices is EqualUnmodifiableListView) return _topNotices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topNotices);
  }

  final Map<String, dynamic> _trends;
  @override
  Map<String, dynamic> get trends {
    if (_trends is EqualUnmodifiableMapView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trends);
  }

  @override
  String toString() {
    return 'NoticeAnalytics(period: $period, startDate: $startDate, endDate: $endDate, totalNotices: $totalNotices, totalSent: $totalSent, totalDelivered: $totalDelivered, totalRead: $totalRead, deliveryRate: $deliveryRate, readRate: $readRate, noticesByType: $noticesByType, noticesByPriority: $noticesByPriority, noticesByAudience: $noticesByAudience, topNotices: $topNotices, trends: $trends)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeAnalyticsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalNotices, totalNotices) ||
                other.totalNotices == totalNotices) &&
            (identical(other.totalSent, totalSent) ||
                other.totalSent == totalSent) &&
            (identical(other.totalDelivered, totalDelivered) ||
                other.totalDelivered == totalDelivered) &&
            (identical(other.totalRead, totalRead) ||
                other.totalRead == totalRead) &&
            (identical(other.deliveryRate, deliveryRate) ||
                other.deliveryRate == deliveryRate) &&
            (identical(other.readRate, readRate) ||
                other.readRate == readRate) &&
            const DeepCollectionEquality()
                .equals(other._noticesByType, _noticesByType) &&
            const DeepCollectionEquality()
                .equals(other._noticesByPriority, _noticesByPriority) &&
            const DeepCollectionEquality()
                .equals(other._noticesByAudience, _noticesByAudience) &&
            const DeepCollectionEquality()
                .equals(other._topNotices, _topNotices) &&
            const DeepCollectionEquality().equals(other._trends, _trends));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      period,
      startDate,
      endDate,
      totalNotices,
      totalSent,
      totalDelivered,
      totalRead,
      deliveryRate,
      readRate,
      const DeepCollectionEquality().hash(_noticesByType),
      const DeepCollectionEquality().hash(_noticesByPriority),
      const DeepCollectionEquality().hash(_noticesByAudience),
      const DeepCollectionEquality().hash(_topNotices),
      const DeepCollectionEquality().hash(_trends));

  /// Create a copy of NoticeAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeAnalyticsImplCopyWith<_$NoticeAnalyticsImpl> get copyWith =>
      __$$NoticeAnalyticsImplCopyWithImpl<_$NoticeAnalyticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _NoticeAnalytics implements NoticeAnalytics {
  const factory _NoticeAnalytics(
      {required final String period,
      required final DateTime startDate,
      required final DateTime endDate,
      required final int totalNotices,
      required final int totalSent,
      required final int totalDelivered,
      required final int totalRead,
      required final double deliveryRate,
      required final double readRate,
      required final Map<NoticeType, int> noticesByType,
      required final Map<NoticePriority, int> noticesByPriority,
      required final Map<NoticeAudienceType, int> noticesByAudience,
      required final List<String> topNotices,
      required final Map<String, dynamic> trends}) = _$NoticeAnalyticsImpl;

  factory _NoticeAnalytics.fromJson(Map<String, dynamic> json) =
      _$NoticeAnalyticsImpl.fromJson;

  @override
  String get period;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get totalNotices;
  @override
  int get totalSent;
  @override
  int get totalDelivered;
  @override
  int get totalRead;
  @override
  double get deliveryRate;
  @override
  double get readRate;
  @override
  Map<NoticeType, int> get noticesByType;
  @override
  Map<NoticePriority, int> get noticesByPriority;
  @override
  Map<NoticeAudienceType, int> get noticesByAudience;
  @override
  List<String> get topNotices;
  @override
  Map<String, dynamic> get trends;

  /// Create a copy of NoticeAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeAnalyticsImplCopyWith<_$NoticeAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
