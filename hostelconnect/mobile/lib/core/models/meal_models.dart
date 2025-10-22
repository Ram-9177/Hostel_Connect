// lib/core/models/meal_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_models.freezed.dart';
part 'meal_models.g.dart';

/// Meal Intent Model
@freezed
class MealIntent with _$MealIntent {
  const factory MealIntent({
    required String id,
    required String studentId,
    required String studentName,
    required String studentRollNumber,
    required String hostelId,
    required DateTime date,
    required MealType mealType,
    required bool willEat,
    required DateTime submittedAt,
    String? reason,
    String? notes,
    bool? isOverride,
    String? overriddenBy,
    DateTime? overriddenAt,
    Map<String, dynamic>? metadata,
  }) = _MealIntent;

  factory MealIntent.fromJson(Map<String, dynamic> json) => _$MealIntentFromJson(json);
}

/// Meal Forecast Model
@freezed
class MealForecast with _$MealForecast {
  const factory MealForecast({
    required String id,
    required String hostelId,
    required DateTime date,
    required MealType mealType,
    required int totalStudents,
    required int confirmedCount,
    required int bufferCount,
    required int overrideCount,
    required int finalCount,
    required double bufferPercentage,
    required DateTime calculatedAt,
    required String calculatedBy,
    List<MealOverride>? overrides,
    Map<String, dynamic>? metadata,
  }) = _MealForecast;

  factory MealForecast.fromJson(Map<String, dynamic> json) => _$MealForecastFromJson(json);
}

/// Meal Override Model
@freezed
class MealOverride with _$MealOverride {
  const factory MealOverride({
    required String id,
    required String hostelId,
    required DateTime date,
    required MealType mealType,
    required int additionalCount,
    required String reason,
    required String overriddenBy,
    required String overriddenByName,
    required DateTime overriddenAt,
    String? notes,
    Map<String, dynamic>? metadata,
  }) = _MealOverride;

  factory MealOverride.fromJson(Map<String, dynamic> json) => _$MealOverrideFromJson(json);
}

/// Meal Policy Model
@freezed
class MealPolicy with _$MealPolicy {
  const factory MealPolicy({
    required String id,
    required String hostelId,
    required MealType mealType,
    required TimeOfDay cutoffTime,
    required double bufferPercentage,
    required bool isActive,
    required DateTime createdAt,
    required String createdBy,
    DateTime? updatedAt,
    String? updatedBy,
    Map<String, dynamic>? metadata,
  }) = _MealPolicy;

  factory MealPolicy.fromJson(Map<String, dynamic> json) => _$MealPolicyFromJson(json);
}

/// Chef Board Model
@freezed
class ChefBoard with _$ChefBoard {
  const factory ChefBoard({
    required String id,
    required String hostelId,
    required DateTime date,
    required List<MealForecast> forecasts,
    required Map<MealType, int> lockedCounts,
    required Map<MealType, int> actualCounts,
    required DateTime lockedAt,
    required String lockedBy,
    required bool isLocked,
    List<String>? exportUrls,
    Map<String, dynamic>? metadata,
  }) = _ChefBoard;

  factory ChefBoard.fromJson(Map<String, dynamic> json) => _$ChefBoardFromJson(json);
}

/// Daily Meal Summary Model
@freezed
class DailyMealSummary with _$DailyMealSummary {
  const factory DailyMealSummary({
    required String hostelId,
    required DateTime date,
    required Map<MealType, int> intentCounts,
    required Map<MealType, int> forecastCounts,
    required Map<MealType, int> overrideCounts,
    required Map<MealType, bool> cutoffPassed,
    required Map<MealType, TimeOfDay> cutoffTimes,
    required int totalStudents,
    required DateTime lastUpdated,
  }) = _DailyMealSummary;

  factory DailyMealSummary.fromJson(Map<String, dynamic> json) => _$DailyMealSummaryFromJson(json);
}

/// Meal Intent Request Model
@freezed
class MealIntentRequest with _$MealIntentRequest {
  const factory MealIntentRequest({
    required String studentId,
    required String hostelId,
    required DateTime date,
    required MealType mealType,
    required bool willEat,
    String? reason,
    String? notes,
  }) = _MealIntentRequest;

  factory MealIntentRequest.fromJson(Map<String, dynamic> json) => _$MealIntentRequestFromJson(json);
}

/// Bulk Meal Intent Request Model
@freezed
class BulkMealIntentRequest with _$BulkMealIntentRequest {
  const factory BulkMealIntentRequest({
    required String studentId,
    required String hostelId,
    required DateTime date,
    required Map<MealType, bool> intents,
    String? reason,
    String? notes,
  }) = _BulkMealIntentRequest;

  factory BulkMealIntentRequest.fromJson(Map<String, dynamic> json) => _$BulkMealIntentRequestFromJson(json);
}

/// Meal Override Request Model
@freezed
class MealOverrideRequest with _$MealOverrideRequest {
  const factory MealOverrideRequest({
    required String hostelId,
    required DateTime date,
    required MealType mealType,
    required int additionalCount,
    required String reason,
    String? notes,
    required String overriddenBy,
  }) = _MealOverrideRequest;

  factory MealOverrideRequest.fromJson(Map<String, dynamic> json) => _$MealOverrideRequestFromJson(json);
}

/// Meal Statistics Model
@freezed
class MealStatistics with _$MealStatistics {
  const factory MealStatistics({
    required String period,
    required DateTime startDate,
    required DateTime endDate,
    required int totalIntents,
    required int totalForecasts,
    required int totalOverrides,
    required double averageAttendance,
    required Map<MealType, int> mealTypeCounts,
    required Map<MealType, double> mealTypePercentages,
    required List<String> topReasons,
    required Map<String, int> dailyAttendance,
    Map<String, dynamic>? trends,
  }) = _MealStatistics;

  factory MealStatistics.fromJson(Map<String, dynamic> json) => _$MealStatisticsFromJson(json);
}

/// Meal Dashboard Data Model
@freezed
class MealDashboardData with _$MealDashboardData {
  const factory MealDashboardData({
    required String hostelId,
    required DateTime date,
    required Map<MealType, int> todayIntents,
    required Map<MealType, int> todayForecasts,
    required Map<MealType, int> todayOverrides,
    required Map<MealType, bool> cutoffStatus,
    required int totalStudents,
    required int studentsWithIntents,
    required List<MealIntent> recentIntents,
    required List<MealOverride> recentOverrides,
    required Map<String, dynamic> hourlyStats,
  }) = _MealDashboardData;

  factory MealDashboardData.fromJson(Map<String, dynamic> json) => _$MealDashboardDataFromJson(json);
}

/// Meal Export Request Model
@freezed
class MealExportRequest with _$MealExportRequest {
  const factory MealExportRequest({
    required String hostelId,
    required DateTime date,
    required String format,
    required List<MealType> mealTypes,
    bool? includeForecasts,
    bool? includeOverrides,
    bool? includeIntents,
  }) = _MealExportRequest;

  factory MealExportRequest.fromJson(Map<String, dynamic> json) => _$MealExportRequestFromJson(json);
}

/// Meal Template Model
@freezed
class MealTemplate with _$MealTemplate {
  const factory MealTemplate({
    required String id,
    required String name,
    required String description,
    required Map<MealType, bool> defaultIntents,
    required List<String> tags,
    required bool isPublic,
    required String createdBy,
    DateTime? createdAt,
  }) = _MealTemplate;

  factory MealTemplate.fromJson(Map<String, dynamic> json) => _$MealTemplateFromJson(json);
}

/// Enums

enum MealType {
  @JsonValue('breakfast')
  breakfast,
  @JsonValue('lunch')
  lunch,
  @JsonValue('snacks')
  snacks,
  @JsonValue('dinner')
  dinner,
}

enum MealStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('overridden')
  overridden,
  @JsonValue('locked')
  locked,
}

enum ExportFormat {
  @JsonValue('csv')
  csv,
  @JsonValue('excel')
  excel,
  @JsonValue('pdf')
  pdf,
}

/// Extension methods for convenience
extension MealTypeExtension on MealType {
  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.snacks:
        return 'Snacks';
      case MealType.dinner:
        return 'Dinner';
    }
  }
  
  String get description {
    switch (this) {
      case MealType.breakfast:
        return 'Morning meal (7:00 AM - 9:00 AM)';
      case MealType.lunch:
        return 'Midday meal (12:00 PM - 2:00 PM)';
      case MealType.snacks:
        return 'Evening snacks (4:00 PM - 6:00 PM)';
      case MealType.dinner:
        return 'Evening meal (7:00 PM - 9:00 PM)';
    }
  }
  
  String get emoji {
    switch (this) {
      case MealType.breakfast:
        return '🌅';
      case MealType.lunch:
        return '☀️';
      case MealType.snacks:
        return '🍪';
      case MealType.dinner:
        return '🌙';
    }
  }
  
  TimeOfDay get defaultCutoffTime {
    switch (this) {
      case MealType.breakfast:
        return const TimeOfDay(hour: 20, minute: 0); // Previous day 8 PM
      case MealType.lunch:
        return const TimeOfDay(hour: 20, minute: 0); // Previous day 8 PM
      case MealType.snacks:
        return const TimeOfDay(hour: 20, minute: 0); // Previous day 8 PM
      case MealType.dinner:
        return const TimeOfDay(hour: 20, minute: 0); // Same day 8 PM
    }
  }
}

extension MealIntentExtension on MealIntent {
  bool get isOverride => isOverride == true;
  bool get isSubmittedToday => submittedAt.day == DateTime.now().day;
  
  String get statusDisplayName {
    if (isOverride == true) return 'Overridden';
    return willEat ? 'Will Eat' : 'Won\'t Eat';
  }
}

extension MealForecastExtension on MealForecast {
  double get attendancePercentage {
    if (totalStudents == 0) return 0.0;
    return (finalCount / totalStudents) * 100;
  }
  
  bool get isOverCapacity {
    return finalCount > totalStudents;
  }
  
  int get excessCount {
    return finalCount > totalStudents ? finalCount - totalStudents : 0;
  }
}

extension ChefBoardExtension on ChefBoard {
  bool get isLockedForDate {
    return isLocked && lockedAt.day == DateTime.now().day;
  }
  
  Map<MealType, int> get totalForecastCounts {
    final Map<MealType, int> totals = {};
    for (final forecast in forecasts) {
      totals[forecast.mealType] = forecast.finalCount;
    }
    return totals;
  }
  
  int get totalMealsForecast {
    return forecasts.fold(0, (sum, forecast) => sum + forecast.finalCount);
  }
}

extension DailyMealSummaryExtension on DailyMealSummary {
  bool get isCutoffPassed {
    final now = DateTime.now();
    return cutoffPassed.values.any((passed) => passed) || 
           now.hour >= 20; // 8 PM IST cutoff
  }
  
  Map<MealType, bool> get canSubmitIntents {
    final Map<MealType, bool> canSubmit = {};
    for (final mealType in MealType.values) {
      canSubmit[mealType] = !cutoffPassed[mealType] ?? true;
    }
    return canSubmit;
  }
  
  int get totalIntentsToday {
    return intentCounts.values.fold(0, (sum, count) => sum + count);
  }
  
  int get totalForecastsToday {
    return forecastCounts.values.fold(0, (sum, count) => sum + count);
  }
}

/// Time of Day extension for JSON serialization
extension TimeOfDayExtension on TimeOfDay {
  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }
  
  static TimeOfDay fromJson(Map<String, dynamic> json) {
    return TimeOfDay(
      hour: json['hour'] ?? 0,
      minute: json['minute'] ?? 0,
    );
  }
  
  String get displayString {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }
  
  bool get isAfterCutoff {
    final now = DateTime.now();
    final cutoffDateTime = DateTime(now.year, now.month, now.day, hour, minute);
    return now.isAfter(cutoffDateTime);
  }
}
