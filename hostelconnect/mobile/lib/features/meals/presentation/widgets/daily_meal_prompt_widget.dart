// lib/features/meals/presentation/widgets/daily_meal_prompt_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/meal_models.dart';
import '../../../../core/providers/meal_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import '../../../../core/cache/local_cache_service.dart';

class DailyMealPromptWidget extends ConsumerStatefulWidget {
  final String studentId;
  final String hostelId;
  final DateTime date;
  final VoidCallback? onIntentsSubmitted;

  const DailyMealPromptWidget({
    super.key,
    required this.studentId,
    required this.hostelId,
    required this.date,
    this.onIntentsSubmitted,
  });

  @override
  ConsumerState<DailyMealPromptWidget> createState() => _DailyMealPromptWidgetState();
}

class _DailyMealPromptWidgetState extends ConsumerState<DailyMealPromptWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  Map<MealType, bool> _mealIntents = {};
  bool _isSubmitting = false;
  bool _hasSubmittedToday = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadExistingIntents();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
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

  Future<void> _loadExistingIntents() async {
    final intentMap = ref.read(todayMealIntentMapProvider(widget.studentId));
    if (intentMap.state == LoadState.success && intentMap.data != null) {
      setState(() {
        _mealIntents = Map.from(intentMap.data!);
        _hasSubmittedToday = _mealIntents.isNotEmpty;
      });
    }
  }

  Future<void> _submitMealIntent(MealType mealType, bool willEat) async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final request = MealIntentRequest(
        studentId: widget.studentId,
        hostelId: widget.hostelId,
        date: widget.date,
        mealType: mealType,
        willEat: willEat,
      );

      final mealService = ref.read(mealServiceProvider);
      final result = await mealService.submitMealIntent(request);

      if (result.state == LoadState.success) {
        setState(() {
          _mealIntents[mealType] = willEat;
          _hasSubmittedToday = true;
        });
        try {
          final cache = ref.read(localCacheServiceProvider);
          final toCache = <String, bool>{};
          for (final entry in _mealIntents.entries) {
            toCache[entry.key.name] = entry.value;
          }
          await cache.cacheData('daily_meal_preference', toCache);
        } catch (_) {}
        
        Toast.showSuccess(context, '${mealType.displayName} intent submitted');
        widget.onIntentsSubmitted?.call();
      } else {
        Toast.showError(context, result.error ?? 'Failed to submit intent');
      }
    } catch (e) {
      Toast.showError(context, 'Error submitting intent: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _submitBulkIntents(Map<MealType, bool> intents) async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final request = BulkMealIntentRequest(
        studentId: widget.studentId,
        hostelId: widget.hostelId,
        date: widget.date,
        intents: intents,
      );

      final mealService = ref.read(mealServiceProvider);
      final result = await mealService.submitBulkMealIntents(request);

      if (result.state == LoadState.success) {
        setState(() {
          _mealIntents = Map.from(intents);
          _hasSubmittedToday = true;
        });
        try {
          final cache = ref.read(localCacheServiceProvider);
          final toCache = <String, bool>{};
          for (final entry in _mealIntents.entries) {
            toCache[entry.key.name] = entry.value;
          }
          await cache.cacheData('daily_meal_preference', toCache);
        } catch (_) {}
        
        Toast.showSuccess(context, 'All meal intents submitted');
        widget.onIntentsSubmitted?.call();
      } else {
        Toast.showError(context, result.error ?? 'Failed to submit intents');
      }
    } catch (e) {
      Toast.showError(context, 'Error submitting intents: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _submitAllYes() async {
    final allYesIntents = <MealType, bool>{};
    for (final mealType in MealType.values) {
      allYesIntents[mealType] = true;
    }
    await _submitBulkIntents(allYesIntents);
  }

  Future<void> _submitAllNo() async {
    final allNoIntents = <MealType, bool>{};
    for (final mealType in MealType.values) {
      allNoIntents[mealType] = false;
    }
    await _submitBulkIntents(allNoIntents);
  }

  Future<void> _copyYesterdayIntents() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final mealService = ref.read(mealServiceProvider);
      final result = await mealService.copyYesterdayIntents(
        widget.studentId,
        widget.hostelId,
        widget.date,
      );

      if (result.state == LoadState.success && result.data != null) {
        final yesterdayIntents = <MealType, bool>{};
        for (final intent in result.data!) {
          yesterdayIntents[intent.mealType] = intent.willEat;
        }
        
        setState(() {
          _mealIntents = yesterdayIntents;
          _hasSubmittedToday = true;
        });
        
        Toast.showSuccess(context, 'Yesterday\'s intents copied');
        widget.onIntentsSubmitted?.call();
      } else {
        Toast.showError(context, result.error ?? 'Failed to copy yesterday\'s intents');
      }
    } catch (e) {
      Toast.showError(context, 'Error copying yesterday\'s intents: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _applyLunchSameAsYesterday() async {
    if (_isSubmitting) return;
    setState(() {
      _isSubmitting = true;
    });
    try {
      final mealService = ref.read(mealServiceProvider);
      final result = await mealService.copyYesterdayIntents(
        widget.studentId,
        widget.hostelId,
        widget.date,
      );

      if (result.state == LoadState.success && result.data != null) {
        final lunchIntent = result.data!
            .firstWhere(
              (i) => i.mealType == MealType.lunch,
              orElse: () => MealIntent(
                studentId: widget.studentId,
                hostelId: widget.hostelId,
                date: widget.date,
                mealType: MealType.lunch,
                willEat: false,
              ),
            )
            .willEat;
        await _submitMealIntent(MealType.lunch, lunchIntent);
      } else {
        Toast.showError(context, result.error ?? 'No lunch intent found for yesterday');
      }
    } catch (e) {
      Toast.showError(context, 'Error applying lunch: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _applyLunchSameAsDaily() async {
    if (_isSubmitting) return;
    setState(() {
      _isSubmitting = true;
    });
    try {
      final cache = ref.read(localCacheServiceProvider);
      final cached = await cache.getCachedData<Map<String, dynamic>>('daily_meal_preference');
      if (cached != null && cached.containsKey('lunch')) {
        final willEat = cached['lunch'] == true;
        await _submitMealIntent(MealType.lunch, willEat);
      } else {
        Toast.showError(context, 'No daily lunch preference set');
      }
    } catch (e) {
      Toast.showError(context, 'Error applying daily lunch: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSubmitIntents = ref.watch(canSubmitIntentsProvider(widget.hostelId));
    final cutoffStatus = ref.watch(cutoffStatusProvider(widget.hostelId));

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: IOSGradeTheme.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today\'s Meal Intent',
                              style: IOSGradeTheme.titleLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatDate(widget.date),
                              style: IOSGradeTheme.bodyMedium.copyWith(
                                color: IOSGradeTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_hasSubmittedToday)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: IOSGradeTheme.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: IOSGradeTheme.success,
                            ),
                          ),
                          child: Text(
                            'Submitted',
                            style: IOSGradeTheme.caption1.copyWith(
                              color: IOSGradeTheme.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Cutoff Warning
                  if (cutoffStatus.data != null && cutoffStatus.data!.values.any((passed) => passed))
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: IOSGradeTheme.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: IOSGradeTheme.warning.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: IOSGradeTheme.warning,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Cutoff time (8:00 PM IST) has passed for some meals',
                              style: IOSGradeTheme.bodySmall.copyWith(
                                color: IOSGradeTheme.warning,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  if (cutoffStatus.data != null && cutoffStatus.data!.values.any((passed) => passed))
                    const SizedBox(height: 16),
                  
                  // Quick Actions
                  if (!_hasSubmittedToday) ...[
                    Text(
                      'Quick Actions',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: IOSGradeButton(
                            text: 'All Yes',
                            onPressed: _isSubmitting ? null : _submitAllYes,
                            icon: Icons.check_circle,
                            backgroundColor: IOSGradeTheme.success,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: IOSGradeButton(
                            text: 'All No',
                            onPressed: _isSubmitting ? null : _submitAllNo,
                            icon: Icons.cancel,
                            backgroundColor: IOSGradeTheme.error,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: IOSGradeButton(
                            text: 'Same as Yesterday',
                            onPressed: _isSubmitting ? null : _copyYesterdayIntents,
                            icon: Icons.copy,
                            backgroundColor: IOSGradeTheme.info,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                  
                  // Individual Meal Intents
                  Text(
                    'Meal Preferences',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  ...MealType.values.map((mealType) {
                    final canSubmit = canSubmitIntents.data?[mealType] ?? true;
                    final isSubmitted = _mealIntents.containsKey(mealType);
                    final willEat = _mealIntents[mealType] ?? false;
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: _buildMealIntentCard(
                        mealType,
                        canSubmit,
                        isSubmitted,
                        willEat,
                      ),
                    );
                  }).toList(),
                  
                  const SizedBox(height: 20),
                  
                  // Submit Button
                  if (!_hasSubmittedToday)
                    SizedBox(
                      width: double.infinity,
                      child: IOSGradeButton(
                        text: _isSubmitting ? 'Submitting...' : 'Submit Meal Intents',
                        onPressed: _isSubmitting ? null : () {
                          if (_mealIntents.isNotEmpty) {
                            _submitBulkIntents(_mealIntents);
                          } else {
                            Toast.showError(context, 'Please select at least one meal preference');
                          }
                        },
                        icon: Icons.send,
                        backgroundColor: IOSGradeTheme.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  
                  if (_hasSubmittedToday)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: IOSGradeTheme.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: IOSGradeTheme.success.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: IOSGradeTheme.success,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your meal intents have been submitted for today',
                              style: IOSGradeTheme.bodyMedium.copyWith(
                                color: IOSGradeTheme.success,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealIntentCard(
    MealType mealType,
    bool canSubmit,
    bool isSubmitted,
    bool willEat,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: canSubmit ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSubmitted 
              ? (willEat ? IOSGradeTheme.success : IOSGradeTheme.error)
              : IOSGradeTheme.border,
          width: isSubmitted ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Meal Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getMealTypeColor(mealType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              mealType.emoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Meal Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealType.displayName,
                  style: IOSGradeTheme.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  mealType.description,
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
                if (!canSubmit)
                  Text(
                    'Cutoff passed',
                    style: IOSGradeTheme.caption1.copyWith(
                      color: IOSGradeTheme.warning,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          
          // Action Buttons
          if (canSubmit && !isSubmitted) ...[
            Row(
              children: [
                _buildIntentButton(
                  'Yes',
                  true,
                  IOSGradeTheme.success,
                  () => _submitMealIntent(mealType, true),
                ),
                const SizedBox(width: 8),
                _buildIntentButton(
                  'No',
                  false,
                  IOSGradeTheme.error,
                  () => _submitMealIntent(mealType, false),
                ),
              ],
            ),
            if (mealType == MealType.lunch) ...[
              const SizedBox(width: 12),
              Row(
                children: [
                  _buildIntentButton(
                    'Same as Yesterday',
                    willEat,
                    IOSGradeTheme.info,
                    _applyLunchSameAsYesterday,
                  ),
                  const SizedBox(width: 8),
                  _buildIntentButton(
                    'Same as Daily',
                    willEat,
                    IOSGradeTheme.primary,
                    _applyLunchSameAsDaily,
                  ),
                ],
              ),
            ],
          ] else if (isSubmitted) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: willEat 
                    ? IOSGradeTheme.success.withOpacity(0.1)
                    : IOSGradeTheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: willEat ? IOSGradeTheme.success : IOSGradeTheme.error,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    willEat ? Icons.check_circle : Icons.cancel,
                    color: willEat ? IOSGradeTheme.success : IOSGradeTheme.error,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    willEat ? 'Will Eat' : 'Won\'t Eat',
                    style: IOSGradeTheme.caption1.copyWith(
                      color: willEat ? IOSGradeTheme.success : IOSGradeTheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: IOSGradeTheme.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: IOSGradeTheme.warning,
                ),
              ),
              child: Text(
                'Cutoff Passed',
                style: IOSGradeTheme.caption1.copyWith(
                  color: IOSGradeTheme.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIntentButton(String text, bool willEat, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: _isSubmitting ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: _isSubmitting ? Colors.grey[300] : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isSubmitting ? Colors.grey : color,
          ),
        ),
        child: Text(
          text,
          style: IOSGradeTheme.bodySmall.copyWith(
            color: _isSubmitting ? Colors.grey : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Color _getMealTypeColor(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Colors.orange;
      case MealType.lunch:
        return Colors.blue;
      case MealType.snacks:
        return Colors.purple;
      case MealType.dinner:
        return Colors.green;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return 'Today';
    }
    
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.day == yesterday.day && date.month == yesterday.month && date.year == yesterday.year) {
      return 'Yesterday';
    }
    
    return '${date.day}/${date.month}/${date.year}';
  }
}
