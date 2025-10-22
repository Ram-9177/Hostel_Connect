// lib/features/notices/presentation/pages/notices_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/notice_models.dart';
import '../../../../core/providers/notice_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../widgets/notice_creation_widget.dart';
import '../widgets/notice_inbox_widget.dart';

class NoticesPage extends ConsumerStatefulWidget {
  const NoticesPage({super.key});

  @override
  ConsumerState<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends ConsumerState<NoticesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedUserId = 'user_1'; // TODO: Get from auth context

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = ref.watch(unreadCountProvider(_selectedUserId));
    final recentNotices = ref.watch(recentNoticesProvider(_selectedUserId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Notices'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          // Unread count badge
          if (unreadCount.data != null && unreadCount.data! > 0)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: IOSGradeTheme.error,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${unreadCount.data}',
                style: IOSGradeTheme.caption1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(noticeInboxProvider(_selectedUserId));
              ref.invalidate(unreadCountProvider(_selectedUserId));
              ref.invalidate(recentNoticesProvider(_selectedUserId));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Inbox', icon: Icon(Icons.inbox)),
            Tab(text: 'Create', icon: Icon(Icons.add)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NoticeInboxWidget(
            userId: _selectedUserId,
            onNoticeRead: () {
              ref.invalidate(unreadCountProvider(_selectedUserId));
            },
          ),
          _buildCreateTab(),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Quick Stats
          _buildQuickStatsCard(),
          
          // Notice Creation Widget
          NoticeCreationWidget(
            onNoticeCreated: () {
              ref.invalidate(noticesProvider(_selectedUserId));
              ref.invalidate(recentNoticesProvider(_selectedUserId));
            },
          ),
          
          // Recent Notices
          _buildRecentNoticesCard(),
        ],
      ),
    );
  }

  Widget _buildQuickStatsCard() {
    final unreadCount = ref.watch(unreadCountProvider(_selectedUserId));
    final inboxData = ref.watch(noticeInboxProvider(_selectedUserId));

    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.dashboard,
                    color: IOSGradeTheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Notice Statistics',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total',
                      '${inboxData.data?.length ?? 0}',
                      Icons.inbox,
                      IOSGradeTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      'Unread',
                      '${unreadCount.data ?? 0}',
                      Icons.mark_email_unread,
                      IOSGradeTheme.error,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Read',
                      '${(inboxData.data?.where((item) => item.isRead).length ?? 0)}',
                      Icons.mark_email_read,
                      IOSGradeTheme.success,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      'Delivered',
                      '${inboxData.data?.where((item) => item.isDelivered).length ?? 0}',
                      Icons.check_circle,
                      IOSGradeTheme.info,
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

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: IOSGradeTheme.caption1.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentNoticesCard() {
    final recentNotices = ref.watch(recentNoticesProvider(_selectedUserId));

    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: IOSGradeTheme.textSecondary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Recent Notices',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              if (recentNotices.state == LoadState.loading)
                const Center(child: CircularProgressIndicator())
              else if (recentNotices.state == LoadState.error)
                Center(
                  child: Text(
                    'Failed to load recent notices',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.error,
                    ),
                  ),
                )
              else if (recentNotices.data?.isEmpty ?? true)
                Center(
                  child: Text(
                    'No recent notices',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                )
              else
                ...recentNotices.data!.take(5).map((notice) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          notice.type.emoji,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notice.title,
                                style: IOSGradeTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _formatTimeAgo(notice.createdAt),
                                style: IOSGradeTheme.caption1.copyWith(
                                  color: IOSGradeTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(notice.priority).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
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
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    
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