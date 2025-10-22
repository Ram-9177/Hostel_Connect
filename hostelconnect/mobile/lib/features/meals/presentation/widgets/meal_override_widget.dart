// lib/features/meals/presentation/widgets/meal_override_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/meal_models.dart';
import '../../../../core/providers/meal_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class MealOverrideWidget extends ConsumerStatefulWidget {
  final String hostelId;
  final DateTime date;
  final VoidCallback? onOverrideAdded;

  const MealOverrideWidget({
    super.key,
    required this.hostelId,
    required this.date,
    this.onOverrideAdded,
  });

  @override
  ConsumerState<MealOverrideWidget> createState() => _MealOverrideWidgetState();
}

class _MealOverrideWidgetState extends ConsumerState<MealOverrideWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _notesController = TextEditingController();
  
  MealType _selectedMealType = MealType.breakfast;
  int _additionalCount = 0;
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
    _reasonController.dispose();
    _notesController.dispose();
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

  Future<void> _submitOverride() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_additionalCount <= 0) {
      Toast.showError(context, 'Additional count must be greater than 0');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final request = MealOverrideRequest(
        hostelId: widget.hostelId,
        date: widget.date,
        mealType: _selectedMealType,
        additionalCount: _additionalCount,
        reason: _reasonController.text.trim(),
        notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
        overriddenBy: 'warden_head', // TODO: Get from auth context
      );

      final mealService = ref.read(mealServiceProvider);
      final result = await mealService.addMealOverride(request);

      if (result.state == LoadState.success) {
        Toast.showSuccess(context, 'Meal override added successfully');
        widget.onOverrideAdded?.call();
        
        // Clear form
        _reasonController.clear();
        _notesController.clear();
        _additionalCount = 0;
        
        // Refresh forecasts
        ref.invalidate(todayMealForecastsProvider(widget.hostelId));
      } else {
        Toast.showError(context, result.error ?? 'Failed to add override');
      }
    } catch (e) {
      Toast.showError(context, 'Error adding override: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final forecasts = ref.watch(todayMealForecastsProvider(widget.hostelId));
    final overrides = ref.watch(todayMealOverridesProvider(widget.hostelId));

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
                          Icons.edit,
                          color: IOSGradeTheme.warning,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Meal Override',
                                style: IOSGradeTheme.titleLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Add additional meals for ${_formatDate(widget.date)}',
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
                    
                    // Meal Type Selection
                    Text(
                      'Select Meal Type',
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
                        children: MealType.values.map((mealType) {
                          final forecast = forecasts.data?.firstWhere(
                            (f) => f.mealType == mealType,
                            orElse: () => MealForecast(
                              id: '',
                              hostelId: widget.hostelId,
                              date: widget.date,
                              mealType: mealType,
                              totalStudents: 0,
                              confirmedCount: 0,
                              bufferCount: 0,
                              overrideCount: 0,
                              finalCount: 0,
                              bufferPercentage: 0.0,
                              calculatedAt: DateTime.now(),
                              calculatedBy: '',
                            ),
                          );
                          
                          return RadioListTile<MealType>(
                            title: Row(
                              children: [
                                Text(mealType.emoji),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(mealType.displayName),
                                      Text(
                                        'Current: ${forecast.finalCount} meals',
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: IOSGradeTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            value: mealType,
                            groupValue: _selectedMealType,
                            onChanged: (value) {
                              setState(() {
                                _selectedMealType = value!;
                              });
                            },
                            activeColor: IOSGradeTheme.primary,
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Additional Count
                    Text(
                      'Additional Count',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    IOSGradeInputField(
                      initialValue: _additionalCount.toString(),
                      label: 'Number of additional meals',
                      hint: 'Enter number of additional meals',
                      prefixIcon: Icons.add_circle,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter additional count';
                        }
                        final count = int.tryParse(value);
                        if (count == null || count <= 0) {
                          return 'Please enter a valid positive number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _additionalCount = int.tryParse(value) ?? 0;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Reason
                    Text(
                      'Reason for Override',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    IOSGradeInputField(
                      controller: _reasonController,
                      label: 'Reason',
                      hint: 'Enter reason for meal override',
                      prefixIcon: Icons.info_outline,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a reason';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Notes
                    Text(
                      'Additional Notes (Optional)',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    IOSGradeInputField(
                      controller: _notesController,
                      label: 'Notes',
                      hint: 'Any additional information',
                      prefixIcon: Icons.note_outlined,
                      maxLines: 2,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Current Overrides
                    if (overrides.data?.isNotEmpty == true) ...[
                      Text(
                        'Current Overrides',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      ...overrides.data!.map((override) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Container(
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
                                  Icons.edit,
                                  color: IOSGradeTheme.warning,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${override.mealType.displayName}: +${override.additionalCount} meals',
                                        style: IOSGradeTheme.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        override.reason,
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: IOSGradeTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  _formatTime(override.overriddenAt),
                                  style: IOSGradeTheme.caption1.copyWith(
                                    color: IOSGradeTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      
                      const SizedBox(height: 20),
                    ],
                    
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: IOSGradeButton(
                        text: _isSubmitting ? 'Adding Override...' : 'Add Override',
                        onPressed: _isSubmitting ? null : _submitOverride,
                        icon: Icons.add,
                        backgroundColor: IOSGradeTheme.warning,
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return 'Today';
    }
    
    final tomorrow = now.add(const Duration(days: 1));
    if (date.day == tomorrow.day && date.month == tomorrow.month && date.year == tomorrow.year) {
      return 'Tomorrow';
    }
    
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
