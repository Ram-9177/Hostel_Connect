import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../../core/network/api_service.dart';
import '../../core/storage/secure_storage.dart';
import '../../shared/theme/telugu_theme.dart';

// Notice model
class Notice {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  final List<String> targetAudience;
  final bool isRead;
  final String? imageUrl;

  const Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.targetAudience,
    this.isRead = false,
    this.imageUrl,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
      targetAudience: List<String>.from(json['targetAudience'] ?? []),
      isRead: json['isRead'] ?? false,
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
      'targetAudience': targetAudience,
      'isRead': isRead,
      'imageUrl': imageUrl,
    };
  }
}

// Notices state
class NoticesState {
  final List<Notice> notices;
  final bool isLoading;
  final String? error;
  final int unreadCount;

  const NoticesState({
    this.notices = const [],
    this.isLoading = false,
    this.error,
    this.unreadCount = 0,
  });

  NoticesState copyWith({
    List<Notice>? notices,
    bool? isLoading,
    String? error,
    int? unreadCount,
  }) {
    return NoticesState(
      notices: notices ?? this.notices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

// Notices notifier
class NoticesNotifier extends StateNotifier<NoticesState> {
  NoticesNotifier() : super(const NoticesState()) {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    // Request permission
    await FirebaseMessaging.instance.requestPermission();
    
    // Register device token
    await _registerDeviceToken();
    
    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Listen to background messages
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    
    // Load initial notices
    await loadNotices();
  }

  Future<void> _registerDeviceToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        final deviceInfo = DeviceInfoPlugin();
        String deviceId;
        
        if (Platform.isAndroid) {
          final androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id;
        } else if (Platform.isIOS) {
          final iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor ?? 'unknown';
        } else {
          deviceId = 'unknown';
        }

        await ApiService.registerDevice(
          deviceToken: token,
          deviceId: deviceId,
          platform: Platform.isAndroid ? 'android' : 'ios',
        );
        
        await SecureTokenStorage.storeDeviceId(deviceId);
      }
    } catch (e) {
      print('Failed to register device token: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Show in-app notification
    _showInAppNotification(message);
    
    // Reload notices
    loadNotices();
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    // Handle background message
    loadNotices();
  }

  void _showInAppNotification(RemoteMessage message) {
    // This would typically use a notification service
    // For now, we'll just reload the notices
    loadNotices();
  }

  Future<void> loadNotices() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await ApiService.getNotices();
      final noticesList = (response['notices'] as List)
          .map((json) => Notice.fromJson(json))
          .toList();
      
      final unreadCount = noticesList.where((notice) => !notice.isRead).length;
      
      state = state.copyWith(
        notices: noticesList,
        isLoading: false,
        unreadCount: unreadCount,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> markAsRead(String noticeId) async {
    try {
      await ApiService.markNoticeAsRead(noticeId);
      
      // Update local state
      final updatedNotices = state.notices.map((notice) {
        if (notice.id == noticeId) {
          return Notice(
            id: notice.id,
            title: notice.title,
            content: notice.content,
            author: notice.author,
            createdAt: notice.createdAt,
            targetAudience: notice.targetAudience,
            isRead: true,
            imageUrl: notice.imageUrl,
          );
        }
        return notice;
      }).toList();
      
      final unreadCount = updatedNotices.where((notice) => !notice.isRead).length;
      
      state = state.copyWith(
        notices: updatedNotices,
        unreadCount: unreadCount,
      );
    } catch (e) {
      print('Failed to mark notice as read: $e');
    }
  }

  Future<void> createNotice({
    required String title,
    required String content,
    required List<String> targetAudience,
    String? imageUrl,
  }) async {
    try {
      await ApiService.createNotice(
        title: title,
        content: content,
        targetAudience: targetAudience,
        imageUrl: imageUrl,
      );
      
      // Reload notices
      await loadNotices();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// Providers
final noticesProvider = StateNotifierProvider<NoticesNotifier, NoticesState>(
  (ref) => NoticesNotifier(),
);

// Notices page
class NoticesPage extends ConsumerWidget {
  const NoticesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticesState = ref.watch(noticesProvider);
    
    return Scaffold(
      backgroundColor: HTeluguTheme.background,
      appBar: AppBar(
        title: Text(HTeluguTheme.getTeluguLabel('notices', englishFallback: 'Notices')),
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: HTeluguTheme.onPrimary,
        actions: [
          if (noticesState.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: HTeluguTheme.error,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${noticesState.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: noticesState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : noticesState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: HTeluguTheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        noticesState.error!,
                        style: HTeluguTheme.bodyMedium.copyWith(
                          color: HTeluguTheme.error,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(noticesProvider.notifier).loadNotices(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : noticesState.notices.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_none,
                            size: 64,
                            color: HTeluguTheme.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No notices available',
                            style: HTeluguTheme.headlineSmall.copyWith(
                              color: HTeluguTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => ref.read(noticesProvider.notifier).loadNotices(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: noticesState.notices.length,
                        itemBuilder: (context, index) {
                          final notice = noticesState.notices[index];
                          return _NoticeCard(
                            notice: notice,
                            onTap: () => _showNoticeDetail(context, notice),
                            onMarkAsRead: () => ref.read(noticesProvider.notifier).markAsRead(notice.id),
                          );
                        },
                      ),
                    ),
    );
  }

  void _showNoticeDetail(BuildContext context, Notice notice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoticeDetailPage(notice: notice),
      ),
    );
  }
}

// Notice card widget
class _NoticeCard extends StatelessWidget {
  final Notice notice;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const _NoticeCard({
    required this.notice,
    required this.onTap,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (!notice.isRead) {
            onMarkAsRead();
          }
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      notice.title,
                      style: HTeluguTheme.headlineSmall.copyWith(
                        fontWeight: notice.isRead ? FontWeight.normal : FontWeight.bold,
                        color: notice.isRead ? HTeluguTheme.textSecondary : HTeluguTheme.textPrimary,
                      ),
                    ),
                  ),
                  if (!notice.isRead)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: HTeluguTheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notice.content,
                style: HTeluguTheme.bodyMedium.copyWith(
                  color: HTeluguTheme.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: HTeluguTheme.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    notice.author,
                    style: HTeluguTheme.bodySmall.copyWith(
                      color: HTeluguTheme.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(notice.createdAt),
                    style: HTeluguTheme.bodySmall.copyWith(
                      color: HTeluguTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// Notice detail page
class NoticeDetailPage extends StatelessWidget {
  final Notice notice;

  const NoticeDetailPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HTeluguTheme.background,
      appBar: AppBar(
        title: const Text('Notice Details'),
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: HTeluguTheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notice.title,
                  style: HTeluguTheme.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  notice.content,
                  style: HTeluguTheme.bodyMedium,
                ),
                if (notice.imageUrl != null) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      notice.imageUrl!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: HTeluguTheme.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'By ${notice.author}',
                      style: HTeluguTheme.bodySmall.copyWith(
                        color: HTeluguTheme.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatDate(notice.createdAt),
                      style: HTeluguTheme.bodySmall.copyWith(
                        color: HTeluguTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}