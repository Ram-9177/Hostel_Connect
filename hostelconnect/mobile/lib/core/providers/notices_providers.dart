// lib/core/providers/notices_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/notices_api_service.dart';
import '../config/environment.dart';
import 'load_state.dart';

// Notices list provider with pagination
final noticesProvider = StateNotifierProvider<NoticesNotifier, PaginationState<Notice>>((ref) {
  return NoticesNotifier(ref);
});

// Single notice provider
final noticeProvider = StateNotifierProvider.family<NoticeNotifier, LoadState<Notice>, String>((ref, noticeId) {
  return NoticeNotifier(ref, noticeId);
});

// Create notice provider
final createNoticeProvider = StateNotifierProvider<CreateNoticeNotifier, LoadState<Notice>>((ref) {
  return CreateNoticeNotifier(ref);
});

// Notice data model
class Notice {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final List<String> targetRoles;
  final bool isRead;
  final String priority; // 'low', 'medium', 'high', 'urgent'

  const Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    this.expiresAt,
    required this.targetRoles,
    required this.isRead,
    required this.priority,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      author: json['author'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      expiresAt: json['expiresAt'] != null ? DateTime.tryParse(json['expiresAt']) : null,
      targetRoles: List<String>.from(json['targetRoles'] ?? []),
      isRead: json['isRead'] ?? false,
      priority: json['priority'] ?? 'medium',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'targetRoles': targetRoles,
      'isRead': isRead,
      'priority': priority,
    };
  }

  Notice copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    DateTime? createdAt,
    DateTime? expiresAt,
    List<String>? targetRoles,
    bool? isRead,
    String? priority,
  }) {
    return Notice(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      targetRoles: targetRoles ?? this.targetRoles,
      isRead: isRead ?? this.isRead,
      priority: priority ?? this.priority,
    );
  }
}

// Notifiers
class NoticesNotifier extends StateNotifier<PaginationState<Notice>> {
  final Ref _ref;
  List<Notice> _cachedNotices = [];

  NoticesNotifier(this._ref) : super(const PaginationState()) {
    loadNotices();
  }

  Future<void> loadNotices({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;
    
    if (refresh) {
      state = state.copyWith(
        items: [],
        currentPage: 1,
        loadState: const LoadState.loading(),
      );
    } else {
      state = state.copyWith(loadState: const LoadState.loading());
    }
    
    try {
      final noticesApiService = _ref.read(noticesApiServiceProvider);
      List<Map<String, dynamic>> noticesData;
      
      if (Environment.enableMockData) {
        // Mock data
        await Future.delayed(const Duration(seconds: 1));
        noticesData = [
          {
            'id': '1',
            'title': 'Hostel Maintenance Notice',
            'content': 'Water supply will be interrupted from 2 PM to 4 PM today.',
            'author': 'Maintenance Team',
            'createdAt': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
            'targetRoles': ['student'],
            'isRead': false,
            'priority': 'high',
          },
          {
            'id': '2',
            'title': 'Mess Menu Update',
            'content': 'New menu items have been added to the mess.',
            'author': 'Mess Committee',
            'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
            'targetRoles': ['student'],
            'isRead': true,
            'priority': 'medium',
          },
        ];
      } else {
        noticesData = await noticesApiService.getNotices();
      }
      
      final notices = noticesData.map((json) => Notice.fromJson(json)).toList();
      
      if (refresh) {
        _cachedNotices = notices;
        state = state.copyWith(
          items: notices,
          loadState: LoadState.success(notices),
          hasMore: notices.length >= state.pageSize,
        );
      } else {
        final updatedItems = [...state.items, ...notices];
        _cachedNotices = updatedItems;
        state = state.copyWith(
          items: updatedItems,
          loadState: LoadState.success(updatedItems),
          hasMore: notices.length >= state.pageSize,
          currentPage: state.currentPage + 1,
        );
      }
    } catch (e) {
      state = state.copyWith(
        loadState: LoadState.error('Failed to load notices: ${e.toString()}', previousData: _cachedNotices),
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.canLoadMore) return;
    await loadNotices();
  }

  Future<void> refresh() async {
    await loadNotices(refresh: true);
  }

  Future<void> markAsRead(String noticeId) async {
    final updatedItems = state.items.map((notice) {
      if (notice.id == noticeId) {
        return notice.copyWith(isRead: true);
      }
      return notice;
    }).toList();
    
    state = state.copyWith(items: updatedItems);
    _cachedNotices = updatedItems;
    
    // TODO: Call API to mark as read
  }

  void clearCache() {
    _cachedNotices = [];
    state = const PaginationState();
  }
}

class NoticeNotifier extends StateNotifier<LoadState<Notice>> {
  final Ref _ref;
  final String noticeId;
  Notice? _cachedNotice;

  NoticeNotifier(this._ref, this.noticeId) : super(const LoadState.idle()) {
    loadNotice();
  }

  Future<void> loadNotice() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // TODO: Implement single notice API
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock data for now
      final notice = Notice(
        id: noticeId,
        title: 'Sample Notice',
        content: 'This is a sample notice content.',
        author: 'Admin',
        createdAt: DateTime.now(),
        targetRoles: ['student'],
        isRead: false,
        priority: 'medium',
      );
      
      _cachedNotice = notice;
      state = LoadState.success(notice);
    } catch (e) {
      state = LoadState.error('Failed to load notice: ${e.toString()}', previousData: _cachedNotice);
    }
  }

  Future<void> markAsRead() async {
    if (state.data != null) {
      final updatedNotice = state.data!.copyWith(isRead: true);
      _cachedNotice = updatedNotice;
      state = LoadState.success(updatedNotice);
      
      // TODO: Call API to mark as read
    }
  }

  void clearCache() {
    _cachedNotice = null;
    state = const LoadState.idle();
  }
}

class CreateNoticeNotifier extends StateNotifier<LoadState<Notice>> {
  final Ref _ref;

  CreateNoticeNotifier(this._ref) : super(const LoadState.idle());

  Future<void> createNotice({
    required String title,
    required String content,
    required List<String> targetRoles,
    String priority = 'medium',
    DateTime? expiresAt,
  }) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      final noticesApiService = _ref.read(noticesApiServiceProvider);
      
      final noticeData = {
        'title': title,
        'content': content,
        'targetRoles': targetRoles,
        'priority': priority,
        'expiresAt': expiresAt?.toIso8601String(),
      };
      
      if (Environment.enableMockData) {
        await Future.delayed(const Duration(seconds: 1));
        
        final notice = Notice(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          content: content,
          author: 'Current User', // TODO: Get from auth
          createdAt: DateTime.now(),
          expiresAt: expiresAt,
          targetRoles: targetRoles,
          isRead: false,
          priority: priority,
        );
        
        state = LoadState.success(notice);
      } else {
        final response = await noticesApiService.createNotice(noticeData);
        final notice = Notice.fromJson(response);
        state = LoadState.success(notice);
      }
      
      // Refresh notices list
      _ref.read(noticesProvider.notifier).refresh();
    } catch (e) {
      state = LoadState.error('Failed to create notice: ${e.toString()}');
    }
  }

  void clearState() {
    state = const LoadState.idle();
  }
}
