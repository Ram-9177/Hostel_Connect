// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoticeImpl _$$NoticeImplFromJson(Map<String, dynamic> json) => _$NoticeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdBy: json['createdBy'] as String,
      createdByName: json['createdByName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      priority: $enumDecode(_$NoticePriorityEnumMap, json['priority']),
      type: $enumDecode(_$NoticeTypeEnumMap, json['type']),
      audience:
          NoticeAudience.fromJson(json['audience'] as Map<String, dynamic>),
      targetIds:
          (json['targetIds'] as List<dynamic>).map((e) => e as String).toList(),
      targetDetails: json['targetDetails'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      stats: json['stats'] == null
          ? null
          : NoticeStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NoticeImplToJson(_$NoticeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdBy': instance.createdBy,
      'createdByName': instance.createdByName,
      'createdAt': instance.createdAt.toIso8601String(),
      'priority': _$NoticePriorityEnumMap[instance.priority]!,
      'type': _$NoticeTypeEnumMap[instance.type]!,
      'audience': instance.audience,
      'targetIds': instance.targetIds,
      'targetDetails': instance.targetDetails,
      'isActive': instance.isActive,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'attachments': instance.attachments,
      'metadata': instance.metadata,
      'stats': instance.stats,
    };

const _$NoticePriorityEnumMap = {
  NoticePriority.low: 'low',
  NoticePriority.medium: 'medium',
  NoticePriority.high: 'high',
  NoticePriority.urgent: 'urgent',
};

const _$NoticeTypeEnumMap = {
  NoticeType.general: 'general',
  NoticeType.emergency: 'emergency',
  NoticeType.maintenance: 'maintenance',
  NoticeType.event: 'event',
  NoticeType.policy: 'policy',
  NoticeType.reminder: 'reminder',
  NoticeType.announcement: 'announcement',
};

_$NoticeAudienceImpl _$$NoticeAudienceImplFromJson(Map<String, dynamic> json) =>
    _$NoticeAudienceImpl(
      type: $enumDecode(_$NoticeAudienceTypeEnumMap, json['type']),
      targetIds:
          (json['targetIds'] as List<dynamic>).map((e) => e as String).toList(),
      targetDetails: json['targetDetails'] as Map<String, dynamic>,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$NoticeAudienceImplToJson(
        _$NoticeAudienceImpl instance) =>
    <String, dynamic>{
      'type': _$NoticeAudienceTypeEnumMap[instance.type]!,
      'targetIds': instance.targetIds,
      'targetDetails': instance.targetDetails,
      'description': instance.description,
    };

const _$NoticeAudienceTypeEnumMap = {
  NoticeAudienceType.all: 'all',
  NoticeAudienceType.hostel: 'hostel',
  NoticeAudienceType.wing: 'wing',
  NoticeAudienceType.room: 'room',
  NoticeAudienceType.role: 'role',
  NoticeAudienceType.individual: 'individual',
};

_$NoticeStatsImpl _$$NoticeStatsImplFromJson(Map<String, dynamic> json) =>
    _$NoticeStatsImpl(
      totalSent: (json['totalSent'] as num).toInt(),
      totalDelivered: (json['totalDelivered'] as num).toInt(),
      totalRead: (json['totalRead'] as num).toInt(),
      totalFailed: (json['totalFailed'] as num).toInt(),
      deliveryRate: (json['deliveryRate'] as num).toDouble(),
      readRate: (json['readRate'] as num).toDouble(),
      deliveryByRole: Map<String, int>.from(json['deliveryByRole'] as Map),
      readByRole: Map<String, int>.from(json['readByRole'] as Map),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$NoticeStatsImplToJson(_$NoticeStatsImpl instance) =>
    <String, dynamic>{
      'totalSent': instance.totalSent,
      'totalDelivered': instance.totalDelivered,
      'totalRead': instance.totalRead,
      'totalFailed': instance.totalFailed,
      'deliveryRate': instance.deliveryRate,
      'readRate': instance.readRate,
      'deliveryByRole': instance.deliveryByRole,
      'readByRole': instance.readByRole,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

_$NoticeReadReceiptImpl _$$NoticeReadReceiptImplFromJson(
        Map<String, dynamic> json) =>
    _$NoticeReadReceiptImpl(
      id: json['id'] as String,
      noticeId: json['noticeId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      readAt: DateTime.parse(json['readAt'] as String),
      deviceId: json['deviceId'] as String,
      deviceType: json['deviceType'] as String,
      location: json['location'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NoticeReadReceiptImplToJson(
        _$NoticeReadReceiptImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'noticeId': instance.noticeId,
      'userId': instance.userId,
      'userName': instance.userName,
      'readAt': instance.readAt.toIso8601String(),
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'location': instance.location,
      'metadata': instance.metadata,
    };

_$DeviceTokenImpl _$$DeviceTokenImplFromJson(Map<String, dynamic> json) =>
    _$DeviceTokenImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      token: json['token'] as String,
      deviceType: json['deviceType'] as String,
      deviceId: json['deviceId'] as String,
      appVersion: json['appVersion'] as String,
      osVersion: json['osVersion'] as String,
      isActive: json['isActive'] as bool,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
      fcmToken: json['fcmToken'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$DeviceTokenImplToJson(_$DeviceTokenImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'token': instance.token,
      'deviceType': instance.deviceType,
      'deviceId': instance.deviceId,
      'appVersion': instance.appVersion,
      'osVersion': instance.osVersion,
      'isActive': instance.isActive,
      'registeredAt': instance.registeredAt.toIso8601String(),
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'fcmToken': instance.fcmToken,
      'metadata': instance.metadata,
    };

_$PushNotificationImpl _$$PushNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationImpl(
      id: json['id'] as String,
      noticeId: json['noticeId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'] as Map<String, dynamic>,
      targetTokens: (json['targetTokens'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: $enumDecode(_$PushNotificationStatusEnumMap, json['status']),
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt(),
      errorMessage: json['errorMessage'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PushNotificationImplToJson(
        _$PushNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'noticeId': instance.noticeId,
      'title': instance.title,
      'body': instance.body,
      'data': instance.data,
      'targetTokens': instance.targetTokens,
      'status': _$PushNotificationStatusEnumMap[instance.status]!,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'retryCount': instance.retryCount,
      'errorMessage': instance.errorMessage,
      'metadata': instance.metadata,
    };

const _$PushNotificationStatusEnumMap = {
  PushNotificationStatus.pending: 'pending',
  PushNotificationStatus.sent: 'sent',
  PushNotificationStatus.delivered: 'delivered',
  PushNotificationStatus.failed: 'failed',
  PushNotificationStatus.cancelled: 'cancelled',
};

_$OfflineQueueItemImpl _$$OfflineQueueItemImplFromJson(
        Map<String, dynamic> json) =>
    _$OfflineQueueItemImpl(
      id: json['id'] as String,
      actionType: $enumDecode(_$OfflineActionTypeEnumMap, json['actionType']),
      noticeId: json['noticeId'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      payload: json['payload'] as Map<String, dynamic>,
      retryCount: (json['retryCount'] as num).toInt(),
      status: $enumDecode(_$OfflineQueueStatusEnumMap, json['status']),
      lastRetryAt: json['lastRetryAt'] == null
          ? null
          : DateTime.parse(json['lastRetryAt'] as String),
      errorMessage: json['errorMessage'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$OfflineQueueItemImplToJson(
        _$OfflineQueueItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actionType': _$OfflineActionTypeEnumMap[instance.actionType]!,
      'noticeId': instance.noticeId,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'payload': instance.payload,
      'retryCount': instance.retryCount,
      'status': _$OfflineQueueStatusEnumMap[instance.status]!,
      'lastRetryAt': instance.lastRetryAt?.toIso8601String(),
      'errorMessage': instance.errorMessage,
      'metadata': instance.metadata,
    };

const _$OfflineActionTypeEnumMap = {
  OfflineActionType.markRead: 'mark_read',
  OfflineActionType.markDelivered: 'mark_delivered',
  OfflineActionType.syncDeviceToken: 'sync_device_token',
};

const _$OfflineQueueStatusEnumMap = {
  OfflineQueueStatus.pending: 'pending',
  OfflineQueueStatus.processing: 'processing',
  OfflineQueueStatus.completed: 'completed',
  OfflineQueueStatus.failed: 'failed',
  OfflineQueueStatus.retry: 'retry',
};

_$NoticeCreationRequestImpl _$$NoticeCreationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NoticeCreationRequestImpl(
      title: json['title'] as String,
      content: json['content'] as String,
      priority: $enumDecode(_$NoticePriorityEnumMap, json['priority']),
      type: $enumDecode(_$NoticeTypeEnumMap, json['type']),
      audience:
          NoticeAudience.fromJson(json['audience'] as Map<String, dynamic>),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NoticeCreationRequestImplToJson(
        _$NoticeCreationRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'priority': _$NoticePriorityEnumMap[instance.priority]!,
      'type': _$NoticeTypeEnumMap[instance.type]!,
      'audience': instance.audience,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'attachments': instance.attachments,
      'metadata': instance.metadata,
    };

_$NoticeUpdateRequestImpl _$$NoticeUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NoticeUpdateRequestImpl(
      title: json['title'] as String?,
      content: json['content'] as String?,
      priority: $enumDecodeNullable(_$NoticePriorityEnumMap, json['priority']),
      type: $enumDecodeNullable(_$NoticeTypeEnumMap, json['type']),
      audience: json['audience'] == null
          ? null
          : NoticeAudience.fromJson(json['audience'] as Map<String, dynamic>),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isActive: json['isActive'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NoticeUpdateRequestImplToJson(
        _$NoticeUpdateRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'priority': _$NoticePriorityEnumMap[instance.priority],
      'type': _$NoticeTypeEnumMap[instance.type],
      'audience': instance.audience,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'attachments': instance.attachments,
      'isActive': instance.isActive,
      'metadata': instance.metadata,
    };

_$DeviceTokenRegistrationRequestImpl
    _$$DeviceTokenRegistrationRequestImplFromJson(Map<String, dynamic> json) =>
        _$DeviceTokenRegistrationRequestImpl(
          token: json['token'] as String,
          deviceType: json['deviceType'] as String,
          deviceId: json['deviceId'] as String,
          appVersion: json['appVersion'] as String,
          osVersion: json['osVersion'] as String,
          fcmToken: json['fcmToken'] as String?,
          metadata: json['metadata'] as Map<String, dynamic>?,
        );

Map<String, dynamic> _$$DeviceTokenRegistrationRequestImplToJson(
        _$DeviceTokenRegistrationRequestImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'deviceType': instance.deviceType,
      'deviceId': instance.deviceId,
      'appVersion': instance.appVersion,
      'osVersion': instance.osVersion,
      'fcmToken': instance.fcmToken,
      'metadata': instance.metadata,
    };

_$NoticeInboxItemImpl _$$NoticeInboxItemImplFromJson(
        Map<String, dynamic> json) =>
    _$NoticeInboxItemImpl(
      notice: Notice.fromJson(json['notice'] as Map<String, dynamic>),
      isRead: json['isRead'] as bool,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      isDelivered: json['isDelivered'] as bool,
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      isFailed: json['isFailed'] as bool,
      failureReason: json['failureReason'] as String?,
    );

Map<String, dynamic> _$$NoticeInboxItemImplToJson(
        _$NoticeInboxItemImpl instance) =>
    <String, dynamic>{
      'notice': instance.notice,
      'isRead': instance.isRead,
      'readAt': instance.readAt?.toIso8601String(),
      'isDelivered': instance.isDelivered,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'isFailed': instance.isFailed,
      'failureReason': instance.failureReason,
    };

_$NoticeTemplateImpl _$$NoticeTemplateImplFromJson(Map<String, dynamic> json) =>
    _$NoticeTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      type: $enumDecode(_$NoticeTypeEnumMap, json['type']),
      priority: $enumDecode(_$NoticePriorityEnumMap, json['priority']),
      audienceType:
          $enumDecode(_$NoticeAudienceTypeEnumMap, json['audienceType']),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isPublic: json['isPublic'] as bool,
      createdBy: json['createdBy'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      usageCount: (json['usageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NoticeTemplateImplToJson(
        _$NoticeTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'content': instance.content,
      'type': _$NoticeTypeEnumMap[instance.type]!,
      'priority': _$NoticePriorityEnumMap[instance.priority]!,
      'audienceType': _$NoticeAudienceTypeEnumMap[instance.audienceType]!,
      'tags': instance.tags,
      'isPublic': instance.isPublic,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'usageCount': instance.usageCount,
    };

_$NoticeAnalyticsImpl _$$NoticeAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$NoticeAnalyticsImpl(
      period: json['period'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      totalNotices: (json['totalNotices'] as num).toInt(),
      totalSent: (json['totalSent'] as num).toInt(),
      totalDelivered: (json['totalDelivered'] as num).toInt(),
      totalRead: (json['totalRead'] as num).toInt(),
      deliveryRate: (json['deliveryRate'] as num).toDouble(),
      readRate: (json['readRate'] as num).toDouble(),
      noticesByType: (json['noticesByType'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$NoticeTypeEnumMap, k), (e as num).toInt()),
      ),
      noticesByPriority:
          (json['noticesByPriority'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$NoticePriorityEnumMap, k), (e as num).toInt()),
      ),
      noticesByAudience:
          (json['noticesByAudience'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$NoticeAudienceTypeEnumMap, k), (e as num).toInt()),
      ),
      topNotices: (json['topNotices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      trends: json['trends'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$NoticeAnalyticsImplToJson(
        _$NoticeAnalyticsImpl instance) =>
    <String, dynamic>{
      'period': instance.period,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'totalNotices': instance.totalNotices,
      'totalSent': instance.totalSent,
      'totalDelivered': instance.totalDelivered,
      'totalRead': instance.totalRead,
      'deliveryRate': instance.deliveryRate,
      'readRate': instance.readRate,
      'noticesByType': instance.noticesByType
          .map((k, e) => MapEntry(_$NoticeTypeEnumMap[k]!, e)),
      'noticesByPriority': instance.noticesByPriority
          .map((k, e) => MapEntry(_$NoticePriorityEnumMap[k]!, e)),
      'noticesByAudience': instance.noticesByAudience
          .map((k, e) => MapEntry(_$NoticeAudienceTypeEnumMap[k]!, e)),
      'topNotices': instance.topNotices,
      'trends': instance.trends,
    };
