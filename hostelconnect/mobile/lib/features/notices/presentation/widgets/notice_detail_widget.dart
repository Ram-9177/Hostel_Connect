// lib/features/notices/presentation/widgets/notice_detail_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/notice_models.dart';
import '../../../../core/providers/notice_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class NoticeDetailWidget extends ConsumerStatefulWidget {
  final Notice notice;
  final bool isRead;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onMarkAsUnread;

  const NoticeDetailWidget({
    super.key,
    required this.notice,
    required this.isRead,
    this.onMarkAsRead,
    this.onMarkAsUnread,
  });

  @override
  ConsumerState<NoticeDetailWidget> createState() => _NoticeDetailWidgetState();
}

class _NoticeDetailWidgetState extends ConsumerState<NoticeDetailWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isMarkingAsRead = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    
    // Auto-mark as read if not already read
    if (!widget.isRead) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onMarkAsRead?.call();
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    
    _fadeController.forward();
  }

  Future<void> _markAsRead() async {
    if (widget.isRead || _isMarkingAsRead) return;

    setState(() {
      _isMarkingAsRead = true;
    });

    try {
      widget.onMarkAsRead?.call();
      Toast.showSuccess(context, 'Notice marked as read');
    } catch (e) {
      Toast.showError(context, 'Error marking notice as read: $e');
    } finally {
      setState(() {
        _isMarkingAsRead = false;
      });
    }
  }

  Future<void> _markAsUnread() async {
    if (!widget.isRead) return;

    try {
      widget.onMarkAsUnread?.call();
      Toast.showSuccess(context, 'Notice marked as unread');
    } catch (e) {
      Toast.showError(context, 'Error marking notice as unread: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final notice = widget.notice;
    final stats = ref.watch(noticeAnalyticsProvider);

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: Text(notice.title),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          if (!widget.isRead)
            IconButton(
              icon: _isMarkingAsRead 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.mark_email_read),
              onPressed: _isMarkingAsRead ? null : _markAsRead,
              tooltip: 'Mark as Read',
            ),
          if (widget.isRead)
            IconButton(
              icon: const Icon(Icons.mark_email_unread),
              onPressed: _markAsUnread,
              tooltip: 'Mark as Unread',
            ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
              Toast.showInfo(context, 'Share functionality not implemented');
            },
            tooltip: 'Share',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notice Header Card
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type and Priority
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _getTypeColor(notice.type).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              notice.type.emoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notice.title,
                                  style: IOSGradeTheme.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(notice.priority).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: _getPriorityColor(notice.priority),
                                        ),
                                      ),
                                      child: Text(
                                        notice.priority.displayName,
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: _getPriorityColor(notice.priority),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getTypeColor(notice.type).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: _getTypeColor(notice.type),
                                        ),
                                      ),
                                      child: Text(
                                        notice.type.displayName,
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: _getTypeColor(notice.type),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Content
                      Text(
                        notice.content,
                        style: IOSGradeTheme.bodyLarge.copyWith(
                          height: 1.6,
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Metadata
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            _buildMetadataRow('Author', notice.createdByName),
                            _buildMetadataRow('Created', _formatDateTime(notice.createdAt)),
                            _buildMetadataRow('Audience', notice.audienceDisplayName),
                            if (notice.expiresAt != null)
                              _buildMetadataRow('Expires', _formatDateTime(notice.expiresAt!)),
                            if (notice.isExpired)
                              _buildMetadataRow('Status', 'Expired', isWarning: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Read Status Card
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        widget.isRead ? Icons.mark_email_read : Icons.mark_email_unread,
                        color: widget.isRead ? IOSGradeTheme.success : IOSGradeTheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isRead ? 'Read' : 'Unread',
                              style: IOSGradeTheme.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: widget.isRead ? IOSGradeTheme.success : IOSGradeTheme.primary,
                              ),
                            ),
                            Text(
                              widget.isRead 
                                  ? 'You have read this notice'
                                  : 'This notice is unread',
                              style: IOSGradeTheme.bodyMedium.copyWith(
                                color: IOSGradeTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!widget.isRead)
                        IOSGradeButton(
                          text: 'Mark as Read',
                          onPressed: _isMarkingAsRead ? null : _markAsRead,
                          icon: Icons.mark_email_read,
                          backgroundColor: IOSGradeTheme.success,
                          foregroundColor: Colors.white,
                        ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Audience Details Card
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: IOSGradeTheme.primary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Audience',
                            style: IOSGradeTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        notice.audience.description,
                        style: IOSGradeTheme.bodyMedium,
                      ),
                      if (notice.audience.targetIds.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Target IDs: ${notice.audience.targetIds.join(', ')}',
                          style: IOSGradeTheme.bodySmall.copyWith(
                            color: IOSGradeTheme.textSecondary,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Notice Stats Card (if available)
              if (notice.stats != null)
                IOSGradeCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.analytics,
                              color: IOSGradeTheme.info,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Statistics',
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
                                'Sent',
                                notice.stats!.totalSent.toString(),
                                Icons.send,
                                IOSGradeTheme.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildStatCard(
                                'Delivered',
                                notice.stats!.totalDelivered.toString(),
                                Icons.check_circle,
                                IOSGradeTheme.success,
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
                                notice.stats!.totalRead.toString(),
                                Icons.mark_email_read,
                                IOSGradeTheme.info,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildStatCard(
                                'Failed',
                                notice.stats!.totalFailed.toString(),
                                Icons.error,
                                IOSGradeTheme.error,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Progress Bars
                        _buildProgressBar(
                          'Delivery Rate',
                          notice.stats!.deliveryRate,
                          IOSGradeTheme.success,
                        ),
                        const SizedBox(height: 8),
                        _buildProgressBar(
                          'Read Rate',
                          notice.stats!.readRate,
                          IOSGradeTheme.info,
                        ),
                      ],
                    ),
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Actions Card
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Actions',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: IOSGradeButton(
                              text: widget.isRead ? 'Mark as Unread' : 'Mark as Read',
                              onPressed: widget.isRead ? _markAsUnread : _markAsRead,
                              icon: widget.isRead ? Icons.mark_email_unread : Icons.mark_email_read,
                              backgroundColor: widget.isRead ? IOSGradeTheme.warning : IOSGradeTheme.success,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: IOSGradeButton(
                              text: 'Share',
                              onPressed: () {
                                // TODO: Implement share functionality
                                Toast.showInfo(context, 'Share functionality not implemented');
                              },
                              icon: Icons.share,
                              backgroundColor: IOSGradeTheme.info,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataRow(String label, String value, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: isWarning ? IOSGradeTheme.warning : IOSGradeTheme.textPrimary,
                fontWeight: isWarning ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
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

  Widget _buildProgressBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: IOSGradeTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(value * 100).toStringAsFixed(1)}%',
              style: IOSGradeTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    
    if (diff.inDays > 0) {
      return '${diff.inDays}d ago (${dateTime.day}/${dateTime.month}/${dateTime.year})';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
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
