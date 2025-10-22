// lib/features/notices/presentation/widgets/notice_creation_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/notice_models.dart';
import '../../../../core/providers/notice_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class NoticeCreationWidget extends ConsumerStatefulWidget {
  final VoidCallback? onNoticeCreated;

  const NoticeCreationWidget({
    super.key,
    this.onNoticeCreated,
  });

  @override
  ConsumerState<NoticeCreationWidget> createState() => _NoticeCreationWidgetState();
}

class _NoticeCreationWidgetState extends ConsumerState<NoticeCreationWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  
  NoticeType _selectedType = NoticeType.general;
  NoticePriority _selectedPriority = NoticePriority.medium;
  NoticeAudienceType _selectedAudienceType = NoticeAudienceType.all;
  List<String> _selectedTargetIds = [];
  DateTime? _expiresAt;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    
    _slideController.forward();
    _fadeController.forward();
  }

  Future<void> _submitNotice() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedAudienceType != NoticeAudienceType.all && _selectedTargetIds.isEmpty) {
      Toast.showError(context, 'Please select target audience');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final audience = NoticeAudience(
        type: _selectedAudienceType,
        targetIds: _selectedTargetIds,
        targetDetails: _getTargetDetails(),
        description: _getAudienceDescription(),
      );

      final request = NoticeCreationRequest(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        priority: _selectedPriority,
        type: _selectedType,
        audience: audience,
        expiresAt: _expiresAt,
        metadata: {
          'created_via': 'mobile_app',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      final noticeService = ref.read(noticeServiceProvider);
      final result = await noticeService.createNotice(request);

      if (result.state == LoadState.success) {
        Toast.showSuccess(context, 'Notice created successfully');
        widget.onNoticeCreated?.call();
        
        // Clear form
        _titleController.clear();
        _contentController.clear();
        _selectedTargetIds.clear();
        _expiresAt = null;
        
        // Refresh notices
        ref.invalidate(noticesProvider('user_1')); // TODO: Get from auth context
      } else {
        Toast.showError(context, result.error ?? 'Failed to create notice');
      }
    } catch (e) {
      Toast.showError(context, 'Error creating notice: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Map<String, dynamic> _getTargetDetails() {
    switch (_selectedAudienceType) {
      case NoticeAudienceType.hostel:
        return {'hostel_ids': _selectedTargetIds};
      case NoticeAudienceType.wing:
        return {'wing_ids': _selectedTargetIds};
      case NoticeAudienceType.room:
        return {'room_ids': _selectedTargetIds};
      case NoticeAudienceType.role:
        return {'roles': _selectedTargetIds};
      case NoticeAudienceType.individual:
        return {'user_ids': _selectedTargetIds};
      case NoticeAudienceType.all:
        return {'all_users': true};
    }
  }

  String _getAudienceDescription() {
    switch (_selectedAudienceType) {
      case NoticeAudienceType.all:
        return 'All users in the system';
      case NoticeAudienceType.hostel:
        return 'Users in selected hostels';
      case NoticeAudienceType.wing:
        return 'Users in selected wings';
      case NoticeAudienceType.room:
        return 'Users in selected rooms';
      case NoticeAudienceType.role:
        return 'Users with selected roles';
      case NoticeAudienceType.individual:
        return 'Selected individual users';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: IOSGradeTheme.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Notice',
                                style: IOSGradeTheme.titleLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Send notification to selected audience',
                                style: IOSGradeTheme.bodyMedium.copyWith(
                                  color: IOSGradeTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Notice Type Selection
                    Text(
                      'Notice Type',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: IOSGradeTheme.border),
                      ),
                      child: Column(
                        children: NoticeType.values.map((type) {
                          return RadioListTile<NoticeType>(
                            title: Row(
                              children: [
                                Text(type.emoji),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(type.displayName),
                                      Text(
                                        type.description,
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: IOSGradeTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            value: type,
                            groupValue: _selectedType,
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                            activeColor: IOSGradeTheme.primary,
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Priority Selection
                    Text(
                      'Priority',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: IOSGradeTheme.border),
                      ),
                      child: Column(
                        children: NoticePriority.values.map((priority) {
                          return RadioListTile<NoticePriority>(
                            title: Row(
                              children: [
                                Text(priority.emoji),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(priority.displayName),
                                      Text(
                                        priority.description,
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: IOSGradeTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            value: priority,
                            groupValue: _selectedPriority,
                            onChanged: (value) {
                              setState(() {
                                _selectedPriority = value!;
                              });
                            },
                            activeColor: IOSGradeTheme.primary,
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Title
                    Text(
                      'Title',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    IOSGradeInputField(
                      controller: _titleController,
                      label: 'Notice Title',
                      hint: 'Enter notice title',
                      prefixIcon: Icons.title,
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
                    
                    const SizedBox(height: 20),
                    
                    // Content
                    Text(
                      'Content',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    IOSGradeInputField(
                      controller: _contentController,
                      label: 'Notice Content',
                      hint: 'Enter notice content',
                      prefixIcon: Icons.description,
                      maxLines: 4,
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
                    
                    const SizedBox(height: 20),
                    
                    // Audience Selection
                    Text(
                      'Audience',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: IOSGradeTheme.border),
                      ),
                      child: Column(
                        children: NoticeAudienceType.values.map((audienceType) {
                          return RadioListTile<NoticeAudienceType>(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(audienceType.displayName),
                                      Text(
                                        audienceType.description,
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: IOSGradeTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            value: audienceType,
                            groupValue: _selectedAudienceType,
                            onChanged: (value) {
                              setState(() {
                                _selectedAudienceType = value!;
                                _selectedTargetIds.clear();
                              });
                            },
                            activeColor: IOSGradeTheme.primary,
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Target Selection (if not all)
                    if (_selectedAudienceType != NoticeAudienceType.all) ...[
                      Text(
                        'Select Targets',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: IOSGradeTheme.border),
                        ),
                        child: Text(
                          'Target selection will be implemented based on audience type',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: IOSGradeTheme.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                    
                    // Expiration Date
                    Text(
                      'Expiration (Optional)',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 7)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() {
                            _expiresAt = date;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: IOSGradeTheme.border),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: IOSGradeTheme.textSecondary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _expiresAt != null 
                                    ? 'Expires: ${_expiresAt!.day}/${_expiresAt!.month}/${_expiresAt!.year}'
                                    : 'Select expiration date',
                                style: IOSGradeTheme.bodyMedium.copyWith(
                                  color: _expiresAt != null 
                                      ? IOSGradeTheme.textPrimary
                                      : IOSGradeTheme.textSecondary,
                                ),
                              ),
                            ),
                            if (_expiresAt != null)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _expiresAt = null;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: IOSGradeButton(
                        text: _isSubmitting ? 'Creating Notice...' : 'Create Notice',
                        onPressed: _isSubmitting ? null : _submitNotice,
                        icon: Icons.send,
                        backgroundColor: IOSGradeTheme.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
