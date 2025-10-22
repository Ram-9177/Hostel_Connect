// lib/core/services/notice_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notice_models.dart';
import '../api/notice_api_service.dart';
import '../state/load_state.dart';

final noticeServiceProvider = Provider((ref) => NoticeService(ref.read(noticeApiServiceProvider)));

class NoticeService {
  final NoticeApiService _apiService;

  NoticeService(this._apiService);

  // Notice CRUD Operations
  Future<LoadStateData<Notice>> createNotice(NoticeCreationRequest request) async {
    try {
      final notice = await _apiService.createNotice(request);
      return LoadStateData(state: LoadState.success, data: notice);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Notice>> getNotice(String noticeId) async {
    try {
      final notice = await _apiService.getNotice(noticeId);
      return LoadStateData(state: LoadState.success, data: notice);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Notice>>> getNotices({DateTime? from, DateTime? to, NoticeType? type, NoticePriority? priority}) async {
    try {
      final notices = await _apiService.getNotices(from: from, to: to, type: type, priority: priority);
      return LoadStateData(state: LoadState.success, data: notices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Notice>>> getUserNotices(String userId, {DateTime? from, DateTime? to}) async {
    try {
      final notices = await _apiService.getUserNotices(userId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: notices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Notice>> updateNotice(String noticeId, NoticeUpdateRequest request) async {
    try {
      final notice = await _apiService.updateNotice(noticeId, request);
      return LoadStateData(state: LoadState.success, data: notice);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deleteNotice(String noticeId) async {
    try {
      await _apiService.deleteNotice(noticeId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> activateNotice(String noticeId) async {
    try {
      await _apiService.activateNotice(noticeId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deactivateNotice(String noticeId) async {
    try {
      await _apiService.deactivateNotice(noticeId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Notice Inbox Operations
  Future<LoadStateData<List<NoticeInboxItem>>> getNoticeInbox(String userId, {DateTime? from, DateTime? to}) async {
    try {
      final inboxItems = await _apiService.getNoticeInbox(userId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: inboxItems);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<NoticeInboxItem>>> getUnreadNotices(String userId) async {
    try {
      final unreadNotices = await _apiService.getUnreadNotices(userId);
      return LoadStateData(state: LoadState.success, data: unreadNotices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<int>> getUnreadCount(String userId) async {
    try {
      final count = await _apiService.getUnreadCount(userId);
      return LoadStateData(state: LoadState.success, data: count);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Read Receipt Operations
  Future<LoadStateData<NoticeReadReceipt>> markNoticeAsRead(String noticeId, String userId) async {
    try {
      final readReceipt = await _apiService.markNoticeAsRead(noticeId, userId);
      return LoadStateData(state: LoadState.success, data: readReceipt);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> markNoticeAsDelivered(String noticeId, String userId) async {
    try {
      await _apiService.markNoticeAsDelivered(noticeId, userId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<NoticeReadReceipt>>> getNoticeReadReceipts(String noticeId) async {
    try {
      final readReceipts = await _apiService.getNoticeReadReceipts(noticeId);
      return LoadStateData(state: LoadState.success, data: readReceipts);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Device Token Management
  Future<LoadStateData<DeviceToken>> registerDeviceToken(String userId, DeviceTokenRegistrationRequest request) async {
    try {
      final deviceToken = await _apiService.registerDeviceToken(userId, request);
      return LoadStateData(state: LoadState.success, data: deviceToken);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> unregisterDeviceToken(String userId) async {
    try {
      await _apiService.unregisterDeviceToken(userId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<DeviceToken>>> getUserDeviceTokens(String userId) async {
    try {
      final deviceTokens = await _apiService.getUserDeviceTokens(userId);
      return LoadStateData(state: LoadState.success, data: deviceTokens);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Push Notification Operations
  Future<LoadStateData<PushNotification>> sendPushNotification(String noticeId) async {
    try {
      final pushNotification = await _apiService.sendPushNotification(noticeId);
      return LoadStateData(state: LoadState.success, data: pushNotification);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<PushNotification>>> getPushNotifications(String noticeId) async {
    try {
      final pushNotifications = await _apiService.getPushNotifications(noticeId);
      return LoadStateData(state: LoadState.success, data: pushNotifications);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<PushNotification>> getPushNotification(String pushId) async {
    try {
      final pushNotification = await _apiService.getPushNotification(pushId);
      return LoadStateData(state: LoadState.success, data: pushNotification);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> retryPushNotification(String pushId) async {
    try {
      await _apiService.retryPushNotification(pushId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> cancelPushNotification(String pushId) async {
    try {
      await _apiService.cancelPushNotification(pushId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Notice Templates
  Future<LoadStateData<List<NoticeTemplate>>> getNoticeTemplates() async {
    try {
      final templates = await _apiService.getNoticeTemplates();
      return LoadStateData(state: LoadState.success, data: templates);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<NoticeTemplate>> createNoticeTemplate(NoticeTemplate template) async {
    try {
      final createdTemplate = await _apiService.createNoticeTemplate(template);
      return LoadStateData(state: LoadState.success, data: createdTemplate);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<NoticeTemplate>> updateNoticeTemplate(String templateId, Map<String, dynamic> updates) async {
    try {
      final updatedTemplate = await _apiService.updateNoticeTemplate(templateId, updates);
      return LoadStateData(state: LoadState.success, data: updatedTemplate);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deleteNoticeTemplate(String templateId) async {
    try {
      await _apiService.deleteNoticeTemplate(templateId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Notice>> createNoticeFromTemplate(String templateId, Map<String, dynamic> customizations) async {
    try {
      final notice = await _apiService.createNoticeFromTemplate(templateId, customizations);
      return LoadStateData(state: LoadState.success, data: notice);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Notice Analytics
  Future<LoadStateData<NoticeAnalytics>> getNoticeAnalytics({DateTime? from, DateTime? to}) async {
    try {
      final analytics = await _apiService.getNoticeAnalytics(from: from, to: to);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<NoticeStats>> getNoticeStats(String noticeId) async {
    try {
      final stats = await _apiService.getNoticeStats(noticeId);
      return LoadStateData(state: LoadState.success, data: stats);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Map<String, dynamic>>>> getNoticeTrends({int days = 30}) async {
    try {
      final trends = await _apiService.getNoticeTrends(days: days);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Audience Management
  Future<LoadStateData<List<String>>> getAudienceTargets(NoticeAudienceType audienceType, {String? filter}) async {
    try {
      final targets = await _apiService.getAudienceTargets(audienceType, filter: filter);
      return LoadStateData(state: LoadState.success, data: targets);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getAudienceDetails(NoticeAudienceType audienceType, List<String> targetIds) async {
    try {
      final details = await _apiService.getAudienceDetails(audienceType, targetIds);
      return LoadStateData(state: LoadState.success, data: details);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Bulk Operations
  Future<LoadStateData<List<Notice>>> bulkCreateNotices(List<NoticeCreationRequest> requests) async {
    try {
      final notices = await _apiService.bulkCreateNotices(requests);
      return LoadStateData(state: LoadState.success, data: notices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> bulkDeleteNotices(List<String> noticeIds) async {
    try {
      await _apiService.bulkDeleteNotices(noticeIds);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> bulkMarkAsRead(String userId, List<String> noticeIds) async {
    try {
      await _apiService.bulkMarkAsRead(userId, noticeIds);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> bulkMarkAsUnread(String userId, List<String> noticeIds) async {
    try {
      await _apiService.bulkMarkAsUnread(userId, noticeIds);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Search and Filter
  Future<LoadStateData<List<Notice>>> searchNotices(String query, {NoticeType? type, NoticePriority? priority}) async {
    try {
      final notices = await _apiService.searchNotices(query, type: type, priority: priority);
      return LoadStateData(state: LoadState.success, data: notices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Notice>>> getNoticesByAudience(NoticeAudienceType audienceType, String targetId) async {
    try {
      final notices = await _apiService.getNoticesByAudience(audienceType, targetId);
      return LoadStateData(state: LoadState.success, data: notices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Export and Import
  Future<LoadStateData<String>> exportNotices(String format, {DateTime? from, DateTime? to}) async {
    try {
      final exportUrl = await _apiService.exportNotices(format, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: exportUrl);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Notice>>> importNotices(List<Map<String, dynamic>> data) async {
    try {
      final notices = await _apiService.importNotices(data);
      return LoadStateData(state: LoadState.success, data: notices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Notification Settings
  Future<LoadStateData<void>> updateNotificationSettings(Map<String, dynamic> settings) async {
    try {
      await _apiService.updateNotificationSettings(settings);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getNotificationSettings() async {
    try {
      final settings = await _apiService.getNotificationSettings();
      return LoadStateData(state: LoadState.success, data: settings);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Offline Queue Management
  Future<LoadStateData<List<OfflineQueueItem>>> getOfflineQueueItems(String userId) async {
    try {
      final queueItems = await _apiService.getOfflineQueueItems(userId);
      return LoadStateData(state: LoadState.success, data: queueItems);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> processOfflineQueueItem(String itemId) async {
    try {
      await _apiService.processOfflineQueueItem(itemId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> clearOfflineQueue(String userId) async {
    try {
      await _apiService.clearOfflineQueue(userId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Real-time Updates
  Future<LoadStateData<void>> subscribeToNotices(String userId) async {
    try {
      await _apiService.subscribeToNotices(userId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> unsubscribeFromNotices(String userId) async {
    try {
      await _apiService.unsubscribeFromNotices(userId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Validation
  Future<LoadStateData<bool>> validateNoticeAudience(NoticeAudience audience) async {
    try {
      final isValid = await _apiService.validateNoticeAudience(audience);
      return LoadStateData(state: LoadState.success, data: isValid);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getNoticePreview(NoticeCreationRequest request) async {
    try {
      final preview = await _apiService.getNoticePreview(request);
      return LoadStateData(state: LoadState.success, data: preview);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Emergency Notices
  Future<LoadStateData<Notice>> createEmergencyNotice(NoticeCreationRequest request) async {
    try {
      final notice = await _apiService.createEmergencyNotice(request);
      return LoadStateData(state: LoadState.success, data: notice);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Notice>>> getActiveEmergencyNotices() async {
    try {
      final emergencyNotices = await _apiService.getActiveEmergencyNotices();
      return LoadStateData(state: LoadState.success, data: emergencyNotices);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> acknowledgeEmergencyNotice(String noticeId, String userId) async {
    try {
      await _apiService.acknowledgeEmergencyNotice(noticeId, userId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Utility Methods
  Future<LoadStateData<List<Notice>>> getRecentNotices(String userId, {int limit = 10}) async {
    try {
      final notices = await _apiService.getUserNotices(userId);
      if (notices.isNotEmpty) {
        final recentNotices = notices.take(limit).toList();
        return LoadStateData(state: LoadState.success, data: recentNotices);
      }
      return LoadStateData(state: LoadState.success, data: []);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Notice>>> getNoticesByType(NoticeType type, {int limit = 20}) async {
    try {
      final notices = await _apiService.getNotices(type: type);
      if (notices.isNotEmpty) {
        final filteredNotices = notices.take(limit).toList();
        return LoadStateData(state: LoadState.success, data: filteredNotices);
      }
      return LoadStateData(state: LoadState.success, data: []);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Notice>>> getNoticesByPriority(NoticePriority priority, {int limit = 20}) async {
    try {
      final notices = await _apiService.getNotices(priority: priority);
      if (notices.isNotEmpty) {
        final filteredNotices = notices.take(limit).toList();
        return LoadStateData(state: LoadState.success, data: filteredNotices);
      }
      return LoadStateData(state: LoadState.success, data: []);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }
}
