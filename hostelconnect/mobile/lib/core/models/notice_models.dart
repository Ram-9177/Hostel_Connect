// lib/core/models/notice_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_models.freezed.dart';
part 'notice_models.g.dart';

/// Notice Model
@freezed
class Notice with _$Notice {
  const factory Notice({
    required String id,
    required String title,
    required String content,
    required String createdBy,
    required String createdByName,
    required DateTime createdAt,
    required NoticePriority priority,
    required NoticeType type,
    required NoticeAudience audience,
    required List<String> targetIds,
    required Map<String, dynamic> targetDetails,
    required bool isActive,
    DateTime? expiresAt,
    String? imageUrl,
    List<String>? attachments,
    Map<String, dynamic>? metadata,
    NoticeStats? stats,
  }) = _Notice;

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
}

/// Notice Audience Model
@freezed
class NoticeAudience with _$NoticeAudience {
  const factory NoticeAudience({
    required NoticeAudienceType type,
    required List<String> targetIds,
    required Map<String, dynamic> targetDetails,
    String? description,
  }) = _NoticeAudience;

  factory NoticeAudience.fromJson(Map<String, dynamic> json) => _$NoticeAudienceFromJson(json);
}

/// Notice Stats Model
@freezed
class NoticeStats with _$NoticeStats {
  const factory NoticeStats({
    required int totalSent,
    required int totalDelivered,
    required int totalRead,
    required int totalFailed,
    required double deliveryRate,
    required double readRate,
    required Map<String, int> deliveryByRole,
    required Map<String, int> readByRole,
    required DateTime lastUpdated,
  }) = _NoticeStats;

  factory NoticeStats.fromJson(Map<String, dynamic> json) => _$NoticeStatsFromJson(json);
}

/// Notice Read Receipt Model
@freezed
class NoticeReadReceipt with _$NoticeReadReceipt {
  const factory NoticeReadReceipt({
    required String id,
    required String noticeId,
    required String userId,
    required String userName,
    required DateTime readAt,
    required String deviceId,
    required String deviceType,
    String? location,
    Map<String, dynamic>? metadata,
  }) = _NoticeReadReceipt;

  factory NoticeReadReceipt.fromJson(Map<String, dynamic> json) => _$NoticeReadReceiptFromJson(json);
}

/// Device Token Model
@freezed
class DeviceToken with _$DeviceToken {
  const factory DeviceToken({
    required String id,
    required String userId,
    required String token,
    required String deviceType,
    required String deviceId,
    required String appVersion,
    required String osVersion,
    required bool isActive,
    required DateTime registeredAt,
    DateTime? lastUsedAt,
    String? fcmToken,
    Map<String, dynamic>? metadata,
  }) = _DeviceToken;

  factory DeviceToken.fromJson(Map<String, dynamic> json) => _$DeviceTokenFromJson(json);
}

/// Push Notification Model
@freezed
class PushNotification with _$PushNotification {
  const factory PushNotification({
    required String id,
    required String noticeId,
    required String title,
    required String body,
    required Map<String, dynamic> data,
    required List<String> targetTokens,
    required PushNotificationStatus status,
    required DateTime scheduledAt,
    DateTime? sentAt,
    DateTime? deliveredAt,
    int? retryCount,
    String? errorMessage,
    Map<String, dynamic>? metadata,
  }) = _PushNotification;

  factory PushNotification.fromJson(Map<String, dynamic> json) => _$PushNotificationFromJson(json);
}

/// Offline Queue Item Model
@freezed
class OfflineQueueItem with _$OfflineQueueItem {
  const factory OfflineQueueItem({
    required String id,
    required OfflineActionType actionType,
    required String noticeId,
    required String userId,
    required DateTime createdAt,
    required Map<String, dynamic> payload,
    required int retryCount,
    required OfflineQueueStatus status,
    DateTime? lastRetryAt,
    String? errorMessage,
    Map<String, dynamic>? metadata,
  }) = _OfflineQueueItem;

  factory OfflineQueueItem.fromJson(Map<String, dynamic> json) => _$OfflineQueueItemFromJson(json);
}

/// Notice Creation Request Model
@freezed
class NoticeCreationRequest with _$NoticeCreationRequest {
  const factory NoticeCreationRequest({
    required String title,
    required String content,
    required NoticePriority priority,
    required NoticeType type,
    required NoticeAudience audience,
    DateTime? expiresAt,
    String? imageUrl,
    List<String>? attachments,
    Map<String, dynamic>? metadata,
  }) = _NoticeCreationRequest;

  factory NoticeCreationRequest.fromJson(Map<String, dynamic> json) => _$NoticeCreationRequestFromJson(json);
}

/// Notice Update Request Model
@freezed
class NoticeUpdateRequest with _$NoticeUpdateRequest {
  const factory NoticeUpdateRequest({
    String? title,
    String? content,
    NoticePriority? priority,
    NoticeType? type,
    NoticeAudience? audience,
    DateTime? expiresAt,
    String? imageUrl,
    List<String>? attachments,
    bool? isActive,
    Map<String, dynamic>? metadata,
  }) = _NoticeUpdateRequest;

  factory NoticeUpdateRequest.fromJson(Map<String, dynamic> json) => _$NoticeUpdateRequestFromJson(json);
}

/// Device Token Registration Request Model
@freezed
class DeviceTokenRegistrationRequest with _$DeviceTokenRegistrationRequest {
  const factory DeviceTokenRegistrationRequest({
    required String token,
    required String deviceType,
    required String deviceId,
    required String appVersion,
    required String osVersion,
    String? fcmToken,
    Map<String, dynamic>? metadata,
  }) = _DeviceTokenRegistrationRequest;

  factory DeviceTokenRegistrationRequest.fromJson(Map<String, dynamic> json) => _$DeviceTokenRegistrationRequestFromJson(json);
}

/// Notice Inbox Item Model
@freezed
class NoticeInboxItem with _$NoticeInboxItem {
  const factory NoticeInboxItem({
    required Notice notice,
    required bool isRead,
    DateTime? readAt,
    required bool isDelivered,
    DateTime? deliveredAt,
    required bool isFailed,
    String? failureReason,
  }) = _NoticeInboxItem;

  factory NoticeInboxItem.fromJson(Map<String, dynamic> json) => _$NoticeInboxItemFromJson(json);
}

/// Notice Template Model
@freezed
class NoticeTemplate with _$NoticeTemplate {
  const factory NoticeTemplate({
    required String id,
    required String name,
    required String title,
    required String content,
    required NoticeType type,
    required NoticePriority priority,
    required NoticeAudienceType audienceType,
    required List<String> tags,
    required bool isPublic,
    required String createdBy,
    DateTime? createdAt,
    int? usageCount,
  }) = _NoticeTemplate;

  factory NoticeTemplate.fromJson(Map<String, dynamic> json) => _$NoticeTemplateFromJson(json);
}

/// Notice Analytics Model
@freezed
class NoticeAnalytics with _$NoticeAnalytics {
  const factory NoticeAnalytics({
    required String period,
    required DateTime startDate,
    required DateTime endDate,
    required int totalNotices,
    required int totalSent,
    required int totalDelivered,
    required int totalRead,
    required double deliveryRate,
    required double readRate,
    required Map<NoticeType, int> noticesByType,
    required Map<NoticePriority, int> noticesByPriority,
    required Map<NoticeAudienceType, int> noticesByAudience,
    required List<String> topNotices,
    required Map<String, dynamic> trends,
  }) = _NoticeAnalytics;

  factory NoticeAnalytics.fromJson(Map<String, dynamic> json) => _$NoticeAnalyticsFromJson(json);
}

/// Enums

enum NoticeType {
  @JsonValue('general')
  general,
  @JsonValue('emergency')
  emergency,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('event')
  event,
  @JsonValue('policy')
  policy,
  @JsonValue('reminder')
  reminder,
  @JsonValue('announcement')
  announcement,
}

enum NoticePriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum NoticeAudienceType {
  @JsonValue('all')
  all,
  @JsonValue('hostel')
  hostel,
  @JsonValue('wing')
  wing,
  @JsonValue('room')
  room,
  @JsonValue('role')
  role,
  @JsonValue('individual')
  individual,
}

enum PushNotificationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('sent')
  sent,
  @JsonValue('delivered')
  delivered,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
}

enum OfflineActionType {
  @JsonValue('mark_read')
  markRead,
  @JsonValue('mark_delivered')
  markDelivered,
  @JsonValue('sync_device_token')
  syncDeviceToken,
}

enum OfflineQueueStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('retry')
  retry,
}

/// Extension methods for convenience
extension NoticeTypeExtension on NoticeType {
  String get displayName {
    switch (this) {
      case NoticeType.general:
        return 'General';
      case NoticeType.emergency:
        return 'Emergency';
      case NoticeType.maintenance:
        return 'Maintenance';
      case NoticeType.event:
        return 'Event';
      case NoticeType.policy:
        return 'Policy';
      case NoticeType.reminder:
        return 'Reminder';
      case NoticeType.announcement:
        return 'Announcement';
    }
  }
  
  String get description {
    switch (this) {
      case NoticeType.general:
        return 'General information and updates';
      case NoticeType.emergency:
        return 'Urgent emergency notifications';
      case NoticeType.maintenance:
        return 'Maintenance and service updates';
      case NoticeType.event:
        return 'Events and activities';
      case NoticeType.policy:
        return 'Policy changes and updates';
      case NoticeType.reminder:
        return 'Reminders and notifications';
      case NoticeType.announcement:
        return 'Important announcements';
    }
  }
  
  String get emoji {
    switch (this) {
      case NoticeType.general:
        return '📢';
      case NoticeType.emergency:
        return '🚨';
      case NoticeType.maintenance:
        return '🔧';
      case NoticeType.event:
        return '🎉';
      case NoticeType.policy:
        return '📋';
      case NoticeType.reminder:
        return '⏰';
      case NoticeType.announcement:
        return '📢';
    }
  }
}

extension NoticePriorityExtension on NoticePriority {
  String get displayName {
    switch (this) {
      case NoticePriority.low:
        return 'Low';
      case NoticePriority.medium:
        return 'Medium';
      case NoticePriority.high:
        return 'High';
      case NoticePriority.urgent:
        return 'Urgent';
    }
  }
  
  String get description {
    switch (this) {
      case NoticePriority.low:
        return 'Low priority - informational';
      case NoticePriority.medium:
        return 'Medium priority - important';
      case NoticePriority.high:
        return 'High priority - very important';
      case NoticePriority.urgent:
        return 'Urgent priority - immediate attention';
    }
  }
  
  String get emoji {
    switch (this) {
      case NoticePriority.low:
        return '🟢';
      case NoticePriority.medium:
        return '🟡';
      case NoticePriority.high:
        return '🟠';
      case NoticePriority.urgent:
        return '🔴';
    }
  }
}

extension NoticeAudienceTypeExtension on NoticeAudienceType {
  String get displayName {
    switch (this) {
      case NoticeAudienceType.all:
        return 'All Users';
      case NoticeAudienceType.hostel:
        return 'Hostel';
      case NoticeAudienceType.wing:
        return 'Wing';
      case NoticeAudienceType.room:
        return 'Room';
      case NoticeAudienceType.role:
        return 'Role';
      case NoticeAudienceType.individual:
        return 'Individual';
    }
  }
  
  String get description {
    switch (this) {
      case NoticeAudienceType.all:
        return 'Send to all users in the system';
      case NoticeAudienceType.hostel:
        return 'Send to all users in specific hostels';
      case NoticeAudienceType.wing:
        return 'Send to all users in specific wings';
      case NoticeAudienceType.room:
        return 'Send to all users in specific rooms';
      case NoticeAudienceType.role:
        return 'Send to users with specific roles';
      case NoticeAudienceType.individual:
        return 'Send to specific individual users';
    }
  }
}

extension NoticeExtension on Notice {
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
  
  bool get isActive => isActive && !isExpired;
  
  Duration? get timeUntilExpiry {
    if (expiresAt == null) return null;
    final now = DateTime.now();
    if (now.isAfter(expiresAt!)) return Duration.zero;
    return expiresAt!.difference(now);
  }
  
  String get priorityDisplayName => priority.displayName;
  String get typeDisplayName => type.displayName;
  String get audienceDisplayName => audience.type.displayName;
}

extension NoticeInboxItemExtension on NoticeInboxItem {
  bool get hasAttachments => notice.attachments?.isNotEmpty ?? false;
  bool get hasImage => notice.imageUrl != null && notice.imageUrl!.isNotEmpty;
  
  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(notice.createdAt);
    
    if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

extension PushNotificationExtension on PushNotification {
  bool get isDelivered => status == PushNotificationStatus.delivered;
  bool get isFailed => status == PushNotificationStatus.failed;
  bool get isPending => status == PushNotificationStatus.pending;
  
  Duration? get deliveryTime {
    if (sentAt == null || deliveredAt == null) return null;
    return deliveredAt!.difference(sentAt!);
  }
}

extension OfflineQueueItemExtension on OfflineQueueItem {
  bool get canRetry => retryCount < 3 && status != OfflineQueueStatus.completed;
  bool get shouldRetry {
    if (!canRetry) return false;
    if (lastRetryAt == null) return true;
    final now = DateTime.now();
    final timeSinceLastRetry = now.difference(lastRetryAt!);
    return timeSinceLastRetry.inMinutes >= 5; // Retry every 5 minutes
  }
}
