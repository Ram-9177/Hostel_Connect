// lib/features/notices/presentation/pages/broadcast_notice_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_service.dart';
import '../../../../core/guards/role_guard.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart' as ui;
import '../../data/notices_repository.dart';
import '../../domain/entities/notice_entities.dart';

class BroadcastNoticePage extends ConsumerStatefulWidget {
  const BroadcastNoticePage({super.key});

  @override
  ConsumerState<BroadcastNoticePage> createState() => _BroadcastNoticePageState();
}

class _BroadcastNoticePageState extends ConsumerState<BroadcastNoticePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _noticesRepository = NoticesRepository();
  
  NoticeTarget _selectedTarget = NoticeTarget.all;
  NoticeType _selectedType = NoticeType.general;
  int _selectedPriority = 1;
  DateTime? _expiryDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['warden_head', 'super_admin'],
      child: Scaffold(
        backgroundColor: IOSGradeTheme.background,
        appBar: AppBar(
          title: const Text('Broadcast Notice'),
          backgroundColor: IOSGradeTheme.surface,
          elevation: 0,
          leading: const ui.BackButton(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNoticeForm(),
                const SizedBox(height: IOSGradeTheme.spacing6),
                _buildTargetSelection(),
                const SizedBox(height: IOSGradeTheme.spacing6),
                _buildTypeAndPriority(),
                const SizedBox(height: IOSGradeTheme.spacing6),
                _buildExpiryDate(),
                const SizedBox(height: IOSGradeTheme.spacing8),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeForm() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notice Details',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Notice Title',
              hintText: 'Enter notice title',
              prefixIcon: Icon(Icons.title_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              if (value.length < 5) {
                return 'Title must be at least 5 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          TextFormField(
            controller: _contentController,
            decoration: const InputDecoration(
              labelText: 'Notice Content',
              hintText: 'Enter notice content',
              prefixIcon: Icon(Icons.description_outlined),
            ),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter content';
              }
              if (value.length < 10) {
                return 'Content must be at least 10 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTargetSelection() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Target Audience',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Wrap(
            spacing: IOSGradeTheme.spacing2,
            runSpacing: IOSGradeTheme.spacing2,
            children: NoticeTarget.values.map((target) {
              final isSelected = _selectedTarget == target;
              return FilterChip(
                label: Text(_getTargetLabel(target)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedTarget = target;
                  });
                },
                selectedColor: IOSGradeTheme.primary.withOpacity(0.1),
                checkmarkColor: IOSGradeTheme.primary,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeAndPriority() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type & Priority',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notice Type',
                      style: IOSGradeTheme.callout.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: IOSGradeTheme.spacing2),
                    DropdownButtonFormField<NoticeType>(
                      value: _selectedType,
                      decoration: const InputDecoration(
                        hintText: 'Select type',
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      items: NoticeType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(_getTypeLabel(type)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Priority',
                      style: IOSGradeTheme.callout.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: IOSGradeTheme.spacing2),
                    DropdownButtonFormField<int>(
                      value: _selectedPriority,
                      decoration: const InputDecoration(
                        hintText: 'Select priority',
                        prefixIcon: Icon(Icons.priority_high_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('Low')),
                        DropdownMenuItem(value: 2, child: Text('Medium')),
                        DropdownMenuItem(value: 3, child: Text('High')),
                        DropdownMenuItem(value: 4, child: Text('Urgent')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryDate() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expiry Date (Optional)',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          InkWell(
            onTap: _selectExpiryDate,
            child: Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
              decoration: BoxDecoration(
                border: Border.all(color: IOSGradeTheme.border),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: IOSGradeTheme.textSecondary,
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing3),
                  Expanded(
                    child: Text(
                      _expiryDate != null
                          ? 'Expires on ${_formatDate(_expiryDate!)}'
                          : 'Select expiry date (optional)',
                      style: IOSGradeTheme.callout.copyWith(
                        color: _expiryDate != null
                            ? IOSGradeTheme.textPrimary
                            : IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ),
                  if (_expiryDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _expiryDate = null;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitNotice,
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Broadcast Notice',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  String _getTargetLabel(NoticeTarget target) {
    switch (target) {
      case NoticeTarget.all:
        return 'All Students';
      case NoticeTarget.hostel:
        return 'This Hostel';
      case NoticeTarget.wing:
        return 'Specific Wing';
      case NoticeTarget.room:
        return 'Specific Room';
      case NoticeTarget.role:
        return 'Specific Role';
    }
  }

  String _getTypeLabel(NoticeType type) {
    switch (type) {
      case NoticeType.general:
        return 'General';
      case NoticeType.urgent:
        return 'Urgent';
      case NoticeType.maintenance:
        return 'Maintenance';
      case NoticeType.event:
        return 'Event';
      case NoticeType.policy:
        return 'Policy';
      case NoticeType.emergency:
        return 'Emergency';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectExpiryDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _expiryDate = date;
      });
    }
  }

  Future<void> _submitNotice() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authState = ref.read(AuthService.authStateProvider);
      final user = authState.user;
      
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final notice = Notice(
        id: 'notice_${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text,
        content: _contentController.text,
        type: _selectedType.toString(),
        target: _selectedTarget,
        hostelId: user.hostelId,
        createdBy: user.id,
        createdAt: DateTime.now(),
        expiresAt: _expiryDate,
        isActive: true,
        priority: _selectedPriority,
      );

      await _noticesRepository.createNotice(notice);

      // Send push notification
      final deviceTokens = await _noticesRepository.getDeviceTokensForNotice(notice);
      if (deviceTokens.isNotEmpty) {
        await _noticesRepository.sendPushNotification(
          title: notice.title,
          body: notice.content,
          tokens: deviceTokens.map((dt) => dt.token).toList(),
          data: {
            'noticeId': notice.id,
            'type': notice.type,
            'priority': notice.priority.toString(),
          },
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notice broadcasted successfully!'),
          backgroundColor: IOSGradeTheme.success,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Clear form
      _titleController.clear();
      _contentController.clear();
      setState(() {
        _selectedTarget = NoticeTarget.all;
        _selectedType = NoticeType.general;
        _selectedPriority = 1;
        _expiryDate = null;
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error broadcasting notice: ${e.toString()}'),
          backgroundColor: IOSGradeTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
