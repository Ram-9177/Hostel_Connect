// lib/features/notices/data/notices_repository.dart
import 'dart:convert';
import '../domain/entities/notice_entities.dart';

class NoticesRepository {
  // Mock data for demonstration
  static final List<Notice> _notices = [
    Notice(
      id: 'notice_1',
      title: 'Hostel Meeting Tomorrow',
      content: 'Monthly hostel meeting will be held tomorrow at 6:00 PM in the common hall. All students are requested to attend.',
      type: 'general',
      target: NoticeTarget.all,
      hostelId: 'hostel_1',
      createdBy: 'warden_1',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      expiresAt: DateTime.now().add(const Duration(days: 1)),
      isActive: true,
      priority: 2,
    ),
    Notice(
      id: 'notice_2',
      title: 'Water Supply Maintenance',
      content: 'Water supply will be temporarily suspended from 9:00 AM to 12:00 PM tomorrow for maintenance work.',
      type: 'maintenance',
      target: NoticeTarget.hostel,
      hostelId: 'hostel_1',
      createdBy: 'warden_1',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      expiresAt: DateTime.now().add(const Duration(days: 1)),
      isActive: true,
      priority: 3,
    ),
    Notice(
      id: 'notice_3',
      title: 'Cultural Festival Registration',
      content: 'Registration for the annual cultural festival is now open. Last date for registration is this Friday.',
      type: 'event',
      target: NoticeTarget.all,
      hostelId: 'hostel_1',
      createdBy: 'warden_head_1',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      expiresAt: DateTime.now().add(const Duration(days: 3)),
      isActive: true,
      priority: 2,
    ),
    Notice(
      id: 'notice_4',
      title: 'Emergency Contact Update',
      content: 'Please update your emergency contact information in the hostel office by this week.',
      type: 'urgent',
      target: NoticeTarget.all,
      hostelId: 'hostel_1',
      createdBy: 'super_admin_1',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      expiresAt: DateTime.now().add(const Duration(days: 7)),
      isActive: true,
      priority: 3,
    ),
  ];

  static final List<NoticeRead> _noticeReads = [
    NoticeRead(
      id: 'read_1',
      noticeId: 'notice_1',
      userId: 'student_1',
      readAt: DateTime.now().subtract(const Duration(minutes: 30)),
      deviceId: 'device_1',
    ),
  ];

  static final List<DeviceToken> _deviceTokens = [
    DeviceToken(
      id: 'device_1',
      userId: 'student_1',
      token: 'mock_fcm_token_student_1',
      platform: 'android',
      deviceId: 'device_1',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
    ),
    DeviceToken(
      id: 'device_2',
      userId: 'student_2',
      token: 'mock_fcm_token_student_2',
      platform: 'android',
      deviceId: 'device_2',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
    ),
  ];

  // Notice operations
  Future<List<Notice>> getNotices({
    String? userId,
    String? hostelId,
    String? role,
    bool unreadOnly = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    List<Notice> filteredNotices = _notices.where((notice) {
      if (!notice.isActive || notice.isExpired) return false;
      
      // Filter by target
      switch (notice.target) {
        case NoticeTarget.all:
          return true;
        case NoticeTarget.hostel:
          return notice.hostelId == hostelId;
        case NoticeTarget.role:
          return notice.role == role;
        case NoticeTarget.wing:
        case NoticeTarget.room:
          // For demo, assume all students are in the same wing/room
          return true;
      }
    }).toList();

    // Sort by priority and creation date
    filteredNotices.sort((a, b) {
      if (a.priority != b.priority) {
        return b.priority.compareTo(a.priority); // Higher priority first
      }
      return b.createdAt.compareTo(a.createdAt); // Newer first
    });

    if (unreadOnly && userId != null) {
      final readNoticeIds = _noticeReads
          .where((read) => read.userId == userId)
          .map((read) => read.noticeId)
          .toSet();
      
      filteredNotices = filteredNotices
          .where((notice) => !readNoticeIds.contains(notice.id))
          .toList();
    }

    return filteredNotices;
  }

  Future<Notice> createNotice(Notice notice) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _notices.add(notice);
    return notice;
  }

  Future<Notice> updateNotice(Notice notice) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _notices.indexWhere((n) => n.id == notice.id);
    if (index != -1) {
      _notices[index] = notice;
    }
    return notice;
  }

  Future<void> deleteNotice(String noticeId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _notices.removeWhere((notice) => notice.id == noticeId);
  }

  // Notice read operations
  Future<void> markNoticeAsRead(String noticeId, String userId, {String? deviceId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if already read
    final existingRead = _noticeReads.firstWhere(
      (read) => read.noticeId == noticeId && read.userId == userId,
      orElse: () => NoticeRead(
        id: '',
        noticeId: '',
        userId: '',
        readAt: DateTime.now(),
      ),
    );

    if (existingRead.id.isEmpty) {
      _noticeReads.add(NoticeRead(
        id: 'read_${DateTime.now().millisecondsSinceEpoch}',
        noticeId: noticeId,
        userId: userId,
        readAt: DateTime.now(),
        deviceId: deviceId,
      ));
    }
  }

  Future<List<NoticeRead>> getNoticeReads(String noticeId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _noticeReads.where((read) => read.noticeId == noticeId).toList();
  }

  Future<bool> isNoticeRead(String noticeId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _noticeReads.any((read) => read.noticeId == noticeId && read.userId == userId);
  }

  // Device token operations
  Future<DeviceToken> registerDeviceToken({
    required String userId,
    required String token,
    required String platform,
    String? deviceId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if token already exists
    final existingToken = _deviceTokens.firstWhere(
      (dt) => dt.userId == userId && dt.platform == platform,
      orElse: () => DeviceToken(
        id: '',
        userId: '',
        token: '',
        platform: '',
        isActive: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    if (existingToken.id.isNotEmpty) {
      // Update existing token
      final index = _deviceTokens.indexWhere((dt) => dt.id == existingToken.id);
      if (index != -1) {
        _deviceTokens[index] = DeviceToken(
          id: existingToken.id,
          userId: userId,
          token: token,
          platform: platform,
          deviceId: deviceId,
          isActive: true,
          createdAt: existingToken.createdAt,
          updatedAt: DateTime.now(),
        );
        return _deviceTokens[index];
      }
    }

    // Create new token
    final newToken = DeviceToken(
      id: 'device_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      token: token,
      platform: platform,
      deviceId: deviceId,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _deviceTokens.add(newToken);
    return newToken;
  }

  Future<void> unregisterDeviceToken(String userId, String platform) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _deviceTokens.removeWhere((dt) => dt.userId == userId && dt.platform == platform);
  }

  Future<List<DeviceToken>> getDeviceTokensForNotice(Notice notice) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    List<DeviceToken> targetTokens = [];
    
    switch (notice.target) {
      case NoticeTarget.all:
        targetTokens = _deviceTokens.where((dt) => dt.isActive).toList();
        break;
      case NoticeTarget.hostel:
        // For demo, assume all users are in the same hostel
        targetTokens = _deviceTokens.where((dt) => dt.isActive).toList();
        break;
      case NoticeTarget.role:
        // For demo, assume all users have the same role
        targetTokens = _deviceTokens.where((dt) => dt.isActive).toList();
        break;
      case NoticeTarget.wing:
      case NoticeTarget.room:
        // For demo, assume all users are in the same wing/room
        targetTokens = _deviceTokens.where((dt) => dt.isActive).toList();
        break;
    }
    
    return targetTokens;
  }

  // Push notification simulation
  Future<void> sendPushNotification({
    required String title,
    required String body,
    required List<String> tokens,
    Map<String, dynamic>? data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Simulate push notification
    print('📱 Push Notification Sent:');
    print('Title: $title');
    print('Body: $body');
    print('Tokens: ${tokens.length}');
    print('Data: $data');
    
    // In a real implementation, this would call FCM/APNs
  }

  // Offline queue operations
  static final List<Map<String, dynamic>> _offlineQueue = [];

  Future<void> queueOfflineAction(Map<String, dynamic> action) async {
    _offlineQueue.add({
      ...action,
      'queuedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getOfflineQueue() async {
    return List.from(_offlineQueue);
  }

  Future<void> clearOfflineQueue() async {
    _offlineQueue.clear();
  }

  Future<void> replayOfflineQueue() async {
    for (final action in _offlineQueue) {
      try {
        switch (action['type']) {
          case 'mark_notice_read':
            await markNoticeAsRead(
              action['noticeId'],
              action['userId'],
              deviceId: action['deviceId'],
            );
            break;
          case 'register_device':
            await registerDeviceToken(
              userId: action['userId'],
              token: action['token'],
              platform: action['platform'],
              deviceId: action['deviceId'],
            );
            break;
        }
      } catch (e) {
        print('Error replaying offline action: $e');
      }
    }
    
    await clearOfflineQueue();
  }
}
