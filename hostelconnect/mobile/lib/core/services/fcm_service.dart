// lib/core/services/fcm_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notice_models.dart';
import '../api/notice_api_service.dart';
import '../cache/local_cache_service.dart';
import '../services/gatepass_service.dart';
import '../models/gatepass_models.dart';
import 'meal_notification_controller.dart';
import 'local_notification_service.dart';

final fcmServiceProvider = Provider((ref) => FCMService(
  ref,
  ref.read(noticeApiServiceProvider),
  ref.read(localCacheServiceProvider),
  ref.read(gatepassServiceProvider),
));

class FCMService {
  final Ref _ref;
  final NoticeApiService _apiService;
  final LocalCacheService _cacheService;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GatePassService _gatePassService;

  FCMService(this._ref, this._apiService, this._cacheService, this._gatePassService);

  // Device Token Registration
  Future<String?> getDeviceToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  Future<bool> registerDeviceToken(String userId) async {
    try {
      final fcmToken = await getDeviceToken();
      if (fcmToken == null) {
        debugPrint('Failed to get FCM token');
        return false;
      }

      final request = DeviceTokenRegistrationRequest(
        token: fcmToken,
        deviceType: defaultTargetPlatform.name,
        deviceId: await _getDeviceId(),
        appVersion: await _getAppVersion(),
        osVersion: await _getOsVersion(),
        fcmToken: fcmToken,
        metadata: {
          'platform': defaultTargetPlatform.name,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      final result = await _apiService.registerDeviceToken(userId, request);
      return result.state == LoadState.success;
    } catch (e) {
      debugPrint('Error registering device token: $e');
      return false;
    }
  }

  Future<void> unregisterDeviceToken(String userId) async {
    try {
      await _apiService.unregisterDeviceToken(userId);
    } catch (e) {
      debugPrint('Error unregistering device token: $e');
    }
  }

  // Push Notification Handling
  Future<void> initializePushNotifications() async {
    try {
      // Request permission
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('Push notification permission: ${settings.authorizationStatus}');

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle background messages
      FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

      // Handle notification tap when app is terminated
      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleTerminatedMessage(initialMessage);
      }

      // Initialize local notifications (for actionable buttons)
      await _ref.read(localNotificationServiceProvider).initialize();
    } catch (e) {
      debugPrint('Error initializing push notifications: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Received foreground message: ${message.messageId}');
    
    // Show local notification or update UI
    _processNotification(message);
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    debugPrint('Received background message: ${message.messageId}');
    
    // Navigate to notice or update UI
    _processNotification(message);
  }

  void _handleTerminatedMessage(RemoteMessage message) {
    debugPrint('Received terminated message: ${message.messageId}');
    
    // Navigate to notice or update UI
    _processNotification(message);
  }

  void _processNotification(RemoteMessage message) async {
    try {
      final data = message.data;

      // Skip meal notifications if student is OUT
      final category = data['category'] ?? data['type'] ?? '';
      final mealType = (data['mealType'] ?? data['meal_type'] ?? '').toString().toLowerCase();
      if (category.toString().toLowerCase() == 'meal' ||
          category.toString().toLowerCase() == 'meals' ||
          mealType.isNotEmpty) {
        final userId = await _getCurrentUserId();
        if (userId.isNotEmpty) {
          final isOut = await _isStudentCurrentlyOut(userId);
          if (isOut) {
            debugPrint('Skipping meal notification as student is OUT');
            return;
          }
          final normalized = (mealType.isNotEmpty ? mealType : category.toString()).toLowerCase();
          if (normalized == 'lunch' || normalized == 'dinner') {
            // In-app prompt
            _ref.read(mealNotificationControllerProvider).notify(
              MealNotificationEvent(mealType: normalized, date: DateTime.now()),
            );
            // System notification with actions
            await _ref.read(localNotificationServiceProvider).showMealNotification(
              mealType: normalized,
              title: normalized == 'lunch' ? 'Lunch is being served' : 'Dinner time',
              body: 'Will you eat ${normalized == 'lunch' ? 'lunch' : 'dinner'} today?',
            );
          }
        }
      }

      final noticeId = data['notice_id'];
      if (noticeId != null) {
        await _storeNotificationForOfflineProcessing(noticeId);
        await _updateLocalNoticeCache(noticeId);
      }
    } catch (e) {
      debugPrint('Error processing notification: $e');
    }
  }

  Future<bool> _isStudentCurrentlyOut(String studentId) async {
    try {
      final result = await _gatePassService.getStudentGatePasses(studentId);
      if (result.state == LoadState.success && result.data != null) {
        for (final gp in result.data!) {
          final active = gp.status == GatePassStatus.active || gp.status == GatePassStatus.overdue;
          final notReturned = gp.actualReturnTime == null;
          if (active && notReturned) return true;
        }
      }
    } catch (e) {
      debugPrint('Failed to determine student out status: $e');
    }
    return false;
  }

  // Offline Queue Management
  Future<void> _storeNotificationForOfflineProcessing(String noticeId) async {
    try {
      final queueItem = OfflineQueueItem(
        id: 'queue_${DateTime.now().millisecondsSinceEpoch}',
        actionType: OfflineActionType.markDelivered,
        noticeId: noticeId,
        userId: await _getCurrentUserId(),
        createdAt: DateTime.now(),
        payload: {
          'notice_id': noticeId,
          'delivered_at': DateTime.now().toIso8601String(),
        },
        retryCount: 0,
        status: OfflineQueueStatus.pending,
      );

      await _cacheService.storeOfflineQueueItem(queueItem);
    } catch (e) {
      debugPrint('Error storing offline queue item: $e');
    }
  }

  Future<void> _updateLocalNoticeCache(String noticeId) async {
    try {
      // Update local cache to mark notice as delivered
      await _cacheService.updateNoticeDeliveryStatus(noticeId, true);
    } catch (e) {
      debugPrint('Error updating local notice cache: $e');
    }
  }

  // Offline Queue Processing
  Future<void> processOfflineQueue() async {
    try {
      final queueItems = await _cacheService.getOfflineQueueItems();
      
      for (final item in queueItems) {
        if (item.shouldRetry) {
          await _processQueueItem(item);
        }
      }
    } catch (e) {
      debugPrint('Error processing offline queue: $e');
    }
  }

  Future<void> _processQueueItem(OfflineQueueItem item) async {
    try {
      // Update status to processing
      await _cacheService.updateOfflineQueueItemStatus(item.id, OfflineQueueStatus.processing);

      bool success = false;
      
      switch (item.actionType) {
        case OfflineActionType.markRead:
          success = await _markNoticeAsRead(item.noticeId, item.userId);
          break;
        case OfflineActionType.markDelivered:
          success = await _markNoticeAsDelivered(item.noticeId, item.userId);
          break;
        case OfflineActionType.syncDeviceToken:
          success = await registerDeviceToken(item.userId);
          break;
      }

      if (success) {
        await _cacheService.updateOfflineQueueItemStatus(item.id, OfflineQueueStatus.completed);
      } else {
        await _cacheService.updateOfflineQueueItemStatus(item.id, OfflineQueueStatus.failed);
        await _cacheService.incrementOfflineQueueItemRetryCount(item.id);
      }
    } catch (e) {
      debugPrint('Error processing queue item: $e');
      await _cacheService.updateOfflineQueueItemStatus(item.id, OfflineQueueStatus.failed);
    }
  }

  Future<bool> _markNoticeAsRead(String noticeId, String userId) async {
    try {
      final result = await _apiService.markNoticeAsRead(noticeId, userId);
      return result.state == LoadState.success;
    } catch (e) {
      debugPrint('Error marking notice as read: $e');
      return false;
    }
  }

  Future<bool> _markNoticeAsDelivered(String noticeId, String userId) async {
    try {
      final result = await _apiService.markNoticeAsDelivered(noticeId, userId);
      return result.state == LoadState.success;
    } catch (e) {
      debugPrint('Error marking notice as delivered: $e');
      return false;
    }
  }

  // Read Receipt Management
  Future<void> markNoticeAsRead(String noticeId, String userId) async {
    try {
      // Try to mark as read online first
      final result = await _apiService.markNoticeAsRead(noticeId, userId);
      
      if (result.state != LoadState.success) {
        // If online fails, queue for offline processing
        await _queueReadReceipt(noticeId, userId);
      }
    } catch (e) {
      debugPrint('Error marking notice as read: $e');
      // Queue for offline processing
      await _queueReadReceipt(noticeId, userId);
    }
  }

  Future<void> _queueReadReceipt(String noticeId, String userId) async {
    try {
      final queueItem = OfflineQueueItem(
        id: 'read_${DateTime.now().millisecondsSinceEpoch}',
        actionType: OfflineActionType.markRead,
        noticeId: noticeId,
        userId: userId,
        createdAt: DateTime.now(),
        payload: {
          'notice_id': noticeId,
          'read_at': DateTime.now().toIso8601String(),
        },
        retryCount: 0,
        status: OfflineQueueStatus.pending,
      );

      await _cacheService.storeOfflineQueueItem(queueItem);
    } catch (e) {
      debugPrint('Error queuing read receipt: $e');
    }
  }

  // Utility Methods
  Future<String> _getDeviceId() async {
    // TODO: Implement device ID retrieval
    return 'device_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String> _getAppVersion() async {
    // TODO: Implement app version retrieval
    return '1.0.0';
  }

  Future<String> _getOsVersion() async {
    // TODO: Implement OS version retrieval
    return 'Unknown';
  }

  Future<String> _getCurrentUserId() async {
    // TODO: Get current user ID from auth context
    return 'user_1';
  }

  // Notification Settings
  Future<void> updateNotificationSettings({
    bool? enablePush,
    bool? enableSound,
    bool? enableVibration,
    bool? enableBadge,
  }) async {
    try {
      // Update local settings
      await _cacheService.updateNotificationSettings({
        'enable_push': enablePush,
        'enable_sound': enableSound,
        'enable_vibration': enableVibration,
        'enable_badge': enableBadge,
      });

      // Update server settings
      await _apiService.updateNotificationSettings({
        'enable_push': enablePush,
        'enable_sound': enableSound,
        'enable_vibration': enableVibration,
        'enable_badge': enableBadge,
      });
    } catch (e) {
      debugPrint('Error updating notification settings: $e');
    }
  }

  Future<Map<String, dynamic>> getNotificationSettings() async {
    try {
      return await _cacheService.getNotificationSettings();
    } catch (e) {
      debugPrint('Error getting notification settings: $e');
      return {
        'enable_push': true,
        'enable_sound': true,
        'enable_vibration': true,
        'enable_badge': true,
      };
    }
  }

  // Cleanup
  Future<void> cleanup() async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (e) {
      debugPrint('Error cleaning up FCM: $e');
    }
  }
}
