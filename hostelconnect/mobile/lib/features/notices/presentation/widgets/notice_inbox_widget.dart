// lib/features/notices/presentation/widgets/notice_inbox_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/notice_models.dart';
import '../../../../core/providers/notice_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import 'notice_detail_widget.dart';

class NoticeInboxWidget extends ConsumerStatefulWidget {
  final String userId;
  final VoidCallback? onNoticeRead;

  const NoticeInboxWidget({
    super.key,
    required this.userId,
    this.onNoticeRead,
  });

  @override
  ConsumerState<NoticeInboxWidget> createState() => _NoticeInboxWidgetState();
}

class _NoticeInboxWidgetState extends ConsumerState<NoticeInboxWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  NoticeType? _filterType;
  NoticePriority? _filterPriority;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _markAsRead(NoticeInboxItem item) async {
    if (item.isRead) return;

    try {
      final noticeService = ref.read(noticeServiceProvider);
      final result = await noticeService.markNoticeAsRead(item.notice.id, widget.userId);

      if (result.state == LoadState.success) {
        // Update local state
        ref.read(noticeInboxProvider(widget.userId).notifier).markAsRead(item.notice.id);
        ref.read(unreadCountProvider(widget.userId).notifier).decrementCount();
        
        Toast.showSuccess(context, 'Notice marked as read');
        widget.onNoticeRead?.call();
      } else {
        Toast.showError(context, result.error ?? 'Failed to mark as read');
      }
    } catch (e) {
      Toast.showError(context, 'Error marking notice as read: $e');
    }
  }

  Future<void> _markAsUnread(NoticeInboxItem item) async {
    if (!item.isRead) return;

    try {
      // Update local state
      ref.read(noticeInboxProvider(widget.userId).notifier).markAsUnread(item.notice.id);
      ref.read(unreadCountProvider(widget.userId).notifier).incrementCount();
      
      Toast.showSuccess(context, 'Notice marked as unread');
    } catch (e) {
      Toast.showError(context, 'Error marking notice as unread: $e');
    }
  }

  Future<void> _bulkMarkAsRead(List<NoticeInboxItem> items) async {
    final unreadItems = items.where((item) => !item.isRead).toList();
    if (unreadItems.isEmpty) return;

    try {
      final noticeIds = unreadItems.map((item) => item.notice.id).toList();
      final noticeService = ref.read(noticeServiceProvider);
      final result = await noticeService.bulkMarkAsRead(widget.userId, noticeIds);

      if (result.state == LoadState.success) {
        // Update local state
        ref.read(noticeInboxProvider(widget.userId).notifier).bulkMarkAsRead(noticeIds);
        ref.read(unreadCountProvider(widget.userId).notifier).clearCache();
        
        Toast.showSuccess(context, '${unreadItems.length} notices marked as read');
        widget.onNoticeRead?.call();
      } else {
        Toast.showError(context, result.error ?? 'Failed to mark notices as read');
      }
    } catch (e) {
      Toast.showError(context, 'Error marking notices as read: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final inboxData = ref.watch(noticeInboxProvider(widget.userId));
    final unreadCount = ref.watch(unreadCountProvider(widget.userId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Notice Inbox'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(noticeInboxProvider(widget.userId));
              ref.invalidate(unreadCountProvider(widget.userId));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'All',
              icon: const Icon(Icons.inbox),
            ),
            Tab(
              text: 'Unread',
              icon: Stack(
                children: [
                  const Icon(Icons.mark_email_unread),
                  if (unreadCount.data != null && unreadCount.data! > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: IOSGradeTheme.error,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${unreadCount.data}',
                          style: IOSGradeTheme.caption1.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Tab(
              text: 'Read',
              icon: const Icon(Icons.mark_email_read),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInboxTab(inboxData.data ?? [], 'all'),
          _buildInboxTab(inboxData.data?.where((item) => !item.isRead).toList() ?? [], 'unread'),
          _buildInboxTab(inboxData.data?.where((item) => item.isRead).toList() ?? [], 'read'),
        ],
      ),
    );
  }

  Widget _buildInboxTab(List<NoticeInboxItem> items, String tabType) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tabType == 'unread' ? Icons.mark_email_unread : Icons.inbox,
              color: IOSGradeTheme.textSecondary,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              tabType == 'unread' 
                  ? 'No unread notices'
                  : tabType == 'read'
                      ? 'No read notices'
                      : 'No notices',
              style: IOSGradeTheme.titleMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(noticeInboxProvider(widget.userId));
        ref.invalidate(unreadCountProvider(widget.userId));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildNoticeCard(item),
          );
        },
      ),
    );
  }

  Widget _buildNoticeCard(NoticeInboxItem item) {
    final notice = item.notice;
    
    return IOSGradeCard(
      child: InkWell(
        onTap: () async {
          // Mark as read if not already read
          if (!item.isRead) {
            await _markAsRead(item);
          }
          
          // Navigate to detail
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoticeDetailWidget(
                notice: notice,
                isRead: item.isRead,
                onMarkAsRead: () => _markAsRead(item),
                onMarkAsUnread: () => _markAsUnread(item),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  // Type Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTypeColor(notice.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notice.type.emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Title and Priority
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notice.title,
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: item.isRead 
                                ? IOSGradeTheme.textSecondary
                                : IOSGradeTheme.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(notice.priority).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _getPriorityColor(notice.priority),
                                ),
                              ),
                              child: Text(
                                notice.priority.displayName,
                                style: IOSGradeTheme.caption1.copyWith(
                                  color: _getPriorityColor(notice.priority),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              notice.type.displayName,
                              style: IOSGradeTheme.caption1.copyWith(
                                color: IOSGradeTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Read Status
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.isRead 
                          ? IOSGradeTheme.success.withOpacity(0.1)
                          : IOSGradeTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      item.isRead ? Icons.mark_email_read : Icons.mark_email_unread,
                      color: item.isRead ? IOSGradeTheme.success : IOSGradeTheme.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Content Preview
              Text(
                notice.content,
                style: IOSGradeTheme.bodyMedium.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 12),
              
              // Footer
              Row(
                children: [
                  // Author and Time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'By ${notice.createdByName}',
                          style: IOSGradeTheme.bodySmall.copyWith(
                            color: IOSGradeTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          item.timeAgo,
                          style: IOSGradeTheme.caption1.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Actions
                  Row(
                    children: [
                      if (!item.isRead)
                        IconButton(
                          icon: const Icon(Icons.mark_email_read),
                          onPressed: () => _markAsRead(item),
                          tooltip: 'Mark as Read',
                        ),
                      if (item.isRead)
                        IconButton(
                          icon: const Icon(Icons.mark_email_unread),
                          onPressed: () => _markAsUnread(item),
                          tooltip: 'Mark as Unread',
                        ),
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoticeDetailWidget(
                                notice: notice,
                                isRead: item.isRead,
                                onMarkAsRead: () => _markAsRead(item),
                                onMarkAsUnread: () => _markAsUnread(item),
                              ),
                            ),
                          );
                        },
                        tooltip: 'View Details',
                      ),
                    ],
                  ),
                ],
              ),
              
              // Delivery Status
              if (item.isDelivered || item.isFailed) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      item.isDelivered ? Icons.check_circle : Icons.error,
                      color: item.isDelivered ? IOSGradeTheme.success : IOSGradeTheme.error,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.isDelivered 
                          ? 'Delivered'
                          : 'Failed: ${item.failureReason ?? 'Unknown error'}',
                      style: IOSGradeTheme.caption1.copyWith(
                        color: item.isDelivered ? IOSGradeTheme.success : IOSGradeTheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Notices'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search query',
                hintText: 'Enter search terms',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<NoticeType?>(
              decoration: const InputDecoration(
                labelText: 'Filter by type',
                prefixIcon: Icon(Icons.category),
              ),
              value: _filterType,
              items: [
                const DropdownMenuItem<NoticeType?>(
                  value: null,
                  child: Text('All Types'),
                ),
                ...NoticeType.values.map((type) => DropdownMenuItem<NoticeType?>(
                  value: type,
                  child: Text(type.displayName),
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<NoticePriority?>(
              decoration: const InputDecoration(
                labelText: 'Filter by priority',
                prefixIcon: Icon(Icons.priority_high),
              ),
              value: _filterPriority,
              items: [
                const DropdownMenuItem<NoticePriority?>(
                  value: null,
                  child: Text('All Priorities'),
                ),
                ...NoticePriority.values.map((priority) => DropdownMenuItem<NoticePriority?>(
                  value: priority,
                  child: Text(priority.displayName),
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _filterPriority = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _filterType = null;
                _filterPriority = null;
              });
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(NoticeType type) {
    switch (type) {
      case NoticeType.general:
        return Colors.blue;
      case NoticeType.emergency:
        return Colors.red;
      case NoticeType.maintenance:
        return Colors.orange;
      case NoticeType.event:
        return Colors.green;
      case NoticeType.policy:
        return Colors.purple;
      case NoticeType.reminder:
        return Colors.amber;
      case NoticeType.announcement:
        return Colors.indigo;
    }
  }

  Color _getPriorityColor(NoticePriority priority) {
    switch (priority) {
      case NoticePriority.low:
        return Colors.green;
      case NoticePriority.medium:
        return Colors.orange;
      case NoticePriority.high:
        return Colors.red;
      case NoticePriority.urgent:
        return Colors.purple;
    }
  }
}
