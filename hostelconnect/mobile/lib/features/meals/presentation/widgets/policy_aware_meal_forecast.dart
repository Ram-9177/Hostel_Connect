// lib/features/meals/presentation/widgets/policy_aware_meal_forecast.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/meal_policy_integration_service.dart';
import '../../../../core/models/policy_models.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';

class PolicyAwareMealForecast extends ConsumerStatefulWidget {
  final String hostelId;
  final String mealType;
  final int baseForecast;

  const PolicyAwareMealForecast({
    super.key,
    required this.hostelId,
    required this.mealType,
    required this.baseForecast,
  });

  @override
  ConsumerState<PolicyAwareMealForecast> createState() => _PolicyAwareMealForecastState();
}

class _PolicyAwareMealForecastState extends ConsumerState<PolicyAwareMealForecast> {
  Map<String, dynamic>? _mealTimingInfo;
  int? _forecastWithBuffer;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMealPolicyInfo();
  }

  Future<void> _loadMealPolicyInfo() async {
    setState(() => _isLoading = true);
    
    try {
      final mealPolicyService = ref.read(mealPolicyIntegrationServiceProvider);
      
      final timingInfo = await mealPolicyService.getMealTimingInfo(widget.hostelId);
      final forecastWithBuffer = await mealPolicyService.calculateMealForecast(
        widget.hostelId,
        widget.baseForecast,
        widget.mealType,
      );
      
      setState(() {
        _mealTimingInfo = timingInfo;
        _forecastWithBuffer = forecastWithBuffer;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: IOSGradeTheme.error),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Error loading meal policy: $_error',
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    color: IOSGradeTheme.error,
                  ),
                ),
              ),
              TextButton(
                onPressed: _loadMealPolicyInfo,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getMealIcon(widget.mealType),
                  color: _getMealColor(widget.mealType),
                ),
                const SizedBox(width: 12),
                Text(
                  '${widget.mealType.toUpperCase()} Forecast',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: IOSGradeTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Base Forecast
            _buildForecastRow(
              'Base Forecast',
              '${widget.baseForecast} meals',
              Icons.restaurant,
              IOSGradeTheme.textSecondary,
            ),
            
            // Buffer Applied
            if (_forecastWithBuffer != null && _forecastWithBuffer! > widget.baseForecast)
              _buildForecastRow(
                'Buffer Applied',
                '${_forecastWithBuffer! - widget.baseForecast} meals',
                Icons.trending_up,
                IOSGradeTheme.warning,
              ),
            
            // Final Forecast
            if (_forecastWithBuffer != null)
              _buildForecastRow(
                'Final Forecast',
                '${_forecastWithBuffer!} meals',
                Icons.check_circle,
                IOSGradeTheme.success,
              ),
            
            const SizedBox(height: 12),
            
            // Cutoff Information
            if (_mealTimingInfo != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                  border: Border.all(
                    color: IOSGradeTheme.info.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: IOSGradeTheme.info,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cutoff: ${_getCutoffTime(widget.mealType)}',
                        style: IOSGradeTheme.bodyMedium.copyWith(
                          color: IOSGradeTheme.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: IOSGradeTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getMealIcon(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Icons.wb_sunny;
      case 'lunch':
        return Icons.wb_sunny_outlined;
      case 'dinner':
        return Icons.nightlight_round;
      default:
        return Icons.restaurant;
    }
  }

  Color _getMealColor(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return IOSGradeTheme.warning;
      case 'lunch':
        return IOSGradeTheme.info;
      case 'dinner':
        return IOSGradeTheme.primary;
      default:
        return IOSGradeTheme.textSecondary;
    }
  }

  String _getCutoffTime(String mealType) {
    if (_mealTimingInfo == null) return 'Not available';
    
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return _mealTimingInfo!['breakfastCutoff'] ?? 'Not set';
      case 'lunch':
        return _mealTimingInfo!['lunchCutoff'] ?? 'Not set';
      case 'dinner':
        return _mealTimingInfo!['dinnerCutoff'] ?? 'Not set';
      default:
        return 'Not set';
    }
  }
}
