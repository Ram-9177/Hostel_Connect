// lib/core/providers/notice_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notice_models.dart';
import '../services/notice_service.dart';
import '../state/load_state.dart';

// Service Provider
final noticeServiceProvider = Provider((ref) => NoticeService(ref.read(noticeApiServiceProvider)));

// Notice Providers
final noticesProvider = StateNotifierProvider.family<NoticesNotifier, LoadStateData<List<Notice>>, String>((ref, userId) {
  return NoticesNotifier(ref, userId);
});

final noticeProvider = StateNotifierProvider.family<NoticeNotifier, LoadStateData<Notice>, String>((ref, noticeId) {
  return NoticeNotifier(ref, noticeId);
});

final noticeInboxProvider = StateNotifierProvider.family<NoticeInboxNotifier, LoadStateData<List<NoticeInboxItem>>, String>((ref, userId) {
  return NoticeInboxNotifier(ref, userId);
});

final unreadNoticesProvider = StateNotifierProvider.family<UnreadNoticesNotifier, LoadStateData<List<NoticeInboxItem>>, String>((ref, userId) {
  return UnreadNoticesNotifier(ref, userId);
});

final unreadCountProvider = StateNotifierProvider.family<UnreadCountNotifier, LoadStateData<int>, String>((ref, userId) {
  return UnreadCountNotifier(ref, userId);
});

final recentNoticesProvider = StateNotifierProvider.family<RecentNoticesNotifier, LoadStateData<List<Notice>>, String>((ref, userId) {
  return RecentNoticesNotifier(ref, userId);
});

// Notice Templates Provider
final noticeTemplatesProvider = StateNotifierProvider<NoticeTemplatesNotifier, LoadStateData<List<NoticeTemplate>>>((ref) {
  return NoticeTemplatesNotifier(ref);
});

// Notice Analytics Provider
final noticeAnalyticsProvider = StateNotifierProvider<NoticeAnalyticsNotifier, LoadStateData<NoticeAnalytics>>((ref) {
  return NoticeAnalyticsNotifier(ref);
});

// Push Notification Providers
final pushNotificationsProvider = StateNotifierProvider.family<PushNotificationsNotifier, LoadStateData<List<PushNotification>>, String>((ref, noticeId) {
  return PushNotificationsNotifier(ref, noticeId);
});

final deviceTokensProvider = StateNotifierProvider.family<DeviceTokensNotifier, LoadStateData<List<DeviceToken>>, String>((ref, userId) {
  return DeviceTokensNotifier(ref, userId);
});

// Offline Queue Provider
final offlineQueueProvider = StateNotifierProvider.family<OfflineQueueNotifier, LoadStateData<List<OfflineQueueItem>>, String>((ref, userId) {
  return OfflineQueueNotifier(ref, userId);
});

// Notifier Classes

class NoticesNotifier extends StateNotifier<LoadStateData<List<Notice>>> {
  final Ref _ref;
  final String userId;
  List<Notice> _cachedNotices = [];

  NoticesNotifier(this._ref, this.userId) : super(LoadStateData()) {
    loadNotices();
  }

  Future<void> loadNotices({DateTime? from, DateTime? to, NoticeType? type, NoticePriority? priority}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getNotices(from: from, to: to, type: type, priority: priority);

      if (result.state == LoadState.success) {
        _cachedNotices = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedNotices);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedNotices);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedNotices);
    }
  }

  Future<void> createNotice(NoticeCreationRequest request) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.createNotice(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedNotices.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedNotices);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateNotice(String noticeId, NoticeUpdateRequest request) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.updateNotice(noticeId, request);

      if (result.state == LoadState.success && result.data != null) {
        final index = _cachedNotices.indexWhere((n) => n.id == noticeId);
        if (index != -1) {
          _cachedNotices[index] = result.data!;
          state = LoadStateData(state: LoadState.success, data: _cachedNotices);
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteNotice(String noticeId) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.deleteNotice(noticeId);

      if (result.state == LoadState.success) {
        _cachedNotices.removeWhere((n) => n.id == noticeId);
        state = LoadStateData(state: LoadState.success, data: _cachedNotices);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedNotices = [];
    state = LoadStateData();
  }
}

class NoticeNotifier extends StateNotifier<LoadStateData<Notice>> {
  final Ref _ref;
  final String noticeId;
  Notice? _cachedNotice;

  NoticeNotifier(this._ref, this.noticeId) : super(LoadStateData()) {
    loadNotice();
  }

  Future<void> loadNotice() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getNotice(noticeId);

      if (result.state == LoadState.success) {
        _cachedNotice = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedNotice);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedNotice);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedNotice);
    }
  }

  Future<void> markAsRead(String userId) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.markNoticeAsRead(noticeId, userId);

      if (result.state == LoadState.success && _cachedNotice != null) {
        // Update local cache to reflect read status
        // This would typically be handled by the inbox provider
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedNotice = null;
    state = LoadStateData();
  }
}

class NoticeInboxNotifier extends StateNotifier<LoadStateData<List<NoticeInboxItem>>> {
  final Ref _ref;
  final String userId;
  List<NoticeInboxItem> _cachedInboxItems = [];

  NoticeInboxNotifier(this._ref, this.userId) : super(LoadStateData()) {
    loadInbox();
  }

  Future<void> loadInbox({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getNoticeInbox(userId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedInboxItems = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedInboxItems);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedInboxItems);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedInboxItems);
    }
  }

  Future<void> markAsRead(String noticeId) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.markNoticeAsRead(noticeId, userId);

      if (result.state == LoadState.success) {
        // Update local cache
        final index = _cachedInboxItems.indexWhere((item) => item.notice.id == noticeId);
        if (index != -1) {
          _cachedInboxItems[index] = _cachedInboxItems[index].copyWith(
            isRead: true,
            readAt: DateTime.now(),
          );
          state = LoadStateData(state: LoadState.success, data: _cachedInboxItems);
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> markAsUnread(String noticeId) async {
    try {
      // Update local cache
      final index = _cachedInboxItems.indexWhere((item) => item.notice.id == noticeId);
      if (index != -1) {
        _cachedInboxItems[index] = _cachedInboxItems[index].copyWith(
          isRead: false,
          readAt: null,
        );
        state = LoadStateData(state: LoadState.success, data: _cachedInboxItems);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> bulkMarkAsRead(List<String> noticeIds) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.bulkMarkAsRead(userId, noticeIds);

      if (result.state == LoadState.success) {
        // Update local cache
        for (final noticeId in noticeIds) {
          final index = _cachedInboxItems.indexWhere((item) => item.notice.id == noticeId);
          if (index != -1) {
            _cachedInboxItems[index] = _cachedInboxItems[index].copyWith(
              isRead: true,
              readAt: DateTime.now(),
            );
          }
        }
        state = LoadStateData(state: LoadState.success, data: _cachedInboxItems);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedInboxItems = [];
    state = LoadStateData();
  }
}

class UnreadNoticesNotifier extends StateNotifier<LoadStateData<List<NoticeInboxItem>>> {
  final Ref _ref;
  final String userId;
  List<NoticeInboxItem> _cachedUnreadNotices = [];

  UnreadNoticesNotifier(this._ref, this.userId) : super(LoadStateData()) {
    loadUnreadNotices();
  }

  Future<void> loadUnreadNotices() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getUnreadNotices(userId);

      if (result.state == LoadState.success) {
        _cachedUnreadNotices = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedUnreadNotices);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedUnreadNotices);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedUnreadNotices);
    }
  }

  void clearCache() {
    _cachedUnreadNotices = [];
    state = LoadStateData();
  }
}

class UnreadCountNotifier extends StateNotifier<LoadStateData<int>> {
  final Ref _ref;
  final String userId;
  int _cachedCount = 0;

  UnreadCountNotifier(this._ref, this.userId) : super(LoadStateData()) {
    loadUnreadCount();
  }

  Future<void> loadUnreadCount() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getUnreadCount(userId);

      if (result.state == LoadState.success) {
        _cachedCount = result.data ?? 0;
        state = LoadStateData(state: LoadState.success, data: _cachedCount);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedCount);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedCount);
    }
  }

  void incrementCount() {
    _cachedCount++;
    state = LoadStateData(state: LoadState.success, data: _cachedCount);
  }

  void decrementCount() {
    if (_cachedCount > 0) {
      _cachedCount--;
      state = LoadStateData(state: LoadState.success, data: _cachedCount);
    }
  }

  void clearCache() {
    _cachedCount = 0;
    state = LoadStateData();
  }
}

class RecentNoticesNotifier extends StateNotifier<LoadStateData<List<Notice>>> {
  final Ref _ref;
  final String userId;
  List<Notice> _cachedRecentNotices = [];

  RecentNoticesNotifier(this._ref, this.userId) : super(LoadStateData()) {
    loadRecentNotices();
  }

  Future<void> loadRecentNotices({int limit = 10}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getRecentNotices(userId, limit: limit);

      if (result.state == LoadState.success) {
        _cachedRecentNotices = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedRecentNotices);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedRecentNotices);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedRecentNotices);
    }
  }

  void clearCache() {
    _cachedRecentNotices = [];
    state = LoadStateData();
  }
}

class NoticeTemplatesNotifier extends StateNotifier<LoadStateData<List<NoticeTemplate>>> {
  final Ref _ref;
  List<NoticeTemplate> _cachedTemplates = [];

  NoticeTemplatesNotifier(this._ref) : super(LoadStateData()) {
    loadTemplates();
  }

  Future<void> loadTemplates() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getNoticeTemplates();

      if (result.state == LoadState.success) {
        _cachedTemplates = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedTemplates);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTemplates);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTemplates);
    }
  }

  Future<void> createTemplate(NoticeTemplate template) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.createNoticeTemplate(template);

      if (result.state == LoadState.success && result.data != null) {
        _cachedTemplates.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedTemplates);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedTemplates = [];
    state = LoadStateData();
  }
}

class NoticeAnalyticsNotifier extends StateNotifier<LoadStateData<NoticeAnalytics>> {
  final Ref _ref;
  NoticeAnalytics? _cachedAnalytics;

  NoticeAnalyticsNotifier(this._ref) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getNoticeAnalytics(from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class PushNotificationsNotifier extends StateNotifier<LoadStateData<List<PushNotification>>> {
  final Ref _ref;
  final String noticeId;
  List<PushNotification> _cachedPushNotifications = [];

  PushNotificationsNotifier(this._ref, this.noticeId) : super(LoadStateData()) {
    loadPushNotifications();
  }

  Future<void> loadPushNotifications() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getPushNotifications(noticeId);

      if (result.state == LoadState.success) {
        _cachedPushNotifications = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedPushNotifications);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPushNotifications);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPushNotifications);
    }
  }

  Future<void> sendPushNotification() async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.sendPushNotification(noticeId);

      if (result.state == LoadState.success && result.data != null) {
        _cachedPushNotifications.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedPushNotifications);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedPushNotifications = [];
    state = LoadStateData();
  }
}

class DeviceTokensNotifier extends StateNotifier<LoadStateData<List<DeviceToken>>> {
  final Ref _ref;
  final String userId;
  List<DeviceToken> _cachedDeviceTokens = [];

  DeviceTokensNotifier(this._ref, this.userId) : super(LoadStateData()) {
    loadDeviceTokens();
  }

  Future<void> loadDeviceTokens() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getUserDeviceTokens(userId);

      if (result.state == LoadState.success) {
        _cachedDeviceTokens = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedDeviceTokens);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedDeviceTokens);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedDeviceTokens);
    }
  }

  Future<void> registerDeviceToken(DeviceTokenRegistrationRequest request) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.registerDeviceToken(userId, request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedDeviceTokens.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedDeviceTokens);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedDeviceTokens = [];
    state = LoadStateData();
  }
}

class OfflineQueueNotifier extends StateNotifier<LoadStateData<List<OfflineQueueItem>>> {
  final Ref _ref;
  final String userId;
  List<OfflineQueueItem> _cachedQueueItems = [];

  OfflineQueueNotifier(this._ref, this.userId) : super(LoadStateData()) {
    loadOfflineQueue();
  }

  Future<void> loadOfflineQueue() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.getOfflineQueueItems(userId);

      if (result.state == LoadState.success) {
        _cachedQueueItems = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedQueueItems);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedQueueItems);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedQueueItems);
    }
  }

  Future<void> processQueueItem(String itemId) async {
    try {
      final noticeService = _ref.read(noticeServiceProvider);
      final result = await noticeService.processOfflineQueueItem(itemId);

      if (result.state == LoadState.success) {
        // Remove processed item from cache
        _cachedQueueItems.removeWhere((item) => item.id == itemId);
        state = LoadStateData(state: LoadState.success, data: _cachedQueueItems);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedQueueItems = [];
    state = LoadStateData();
  }
}
