// lib/core/models/policy_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'policy_models.freezed.dart';
part 'policy_models.g.dart';

/// Main Policy model containing all hostel policies
@freezed
class HostelPolicy with _$HostelPolicy {
  const factory HostelPolicy({
    required String id,
    required String hostelId,
    required String name,
    required PolicyType type,
    required Map<String, dynamic> configuration,
    required bool isActive,
    required DateTime effectiveFrom,
    DateTime? effectiveUntil,
    required String createdBy,
    required String createdByName,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
    List<String>? applicableRoles,
    Map<String, dynamic>? metadata,
  }) = _HostelPolicy;

  factory HostelPolicy.fromJson(Map<String, dynamic> json) => _$HostelPolicyFromJson(json);
}

/// Curfew Policy Configuration
@freezed
class CurfewPolicy with _$CurfewPolicy {
  const factory CurfewPolicy({
    required TimeOfDay weekdaysCurfew,
    required TimeOfDay weekendsCurfew,
    required int graceMinutes,
    required bool allowLateEntry,
    required List<String> exemptRoles,
    required String timezone,
    required Map<String, dynamic> penalties,
  }) = _CurfewPolicy;

  factory CurfewPolicy.fromJson(Map<String, dynamic> json) => _$CurfewPolicyFromJson(json);
}

/// Attendance Policy Configuration
@freezed
class AttendancePolicy with _$AttendancePolicy {
  const factory AttendancePolicy({
    required int graceMinutes,
    required int minimumAttendancePercentage,
    required List<AttendanceRule> rules,
    required Map<String, dynamic> consequences,
    required bool allowManualEntry,
    required bool requireReasonForAbsence,
  }) = _AttendancePolicy;

  factory AttendancePolicy.fromJson(Map<String, dynamic> json) => _$AttendancePolicyFromJson(json);
}

/// Meal Policy Configuration
@freezed
class MealPolicy with _$MealPolicy {
  const factory MealPolicy({
    required TimeOfDay breakfastCutoff,
    required TimeOfDay lunchCutoff,
    required TimeOfDay dinnerCutoff,
    required int forecastBufferPercentage,
    required int advanceBookingDays,
    required bool allowLateBooking,
    required Map<String, dynamic> dietaryRestrictions,
    required Map<String, dynamic> mealTimings,
  }) = _MealPolicy;

  factory MealPolicy.fromJson(Map<String, dynamic> json) => _$MealPolicyFromJson(json);
}

/// Room Policy Configuration
@freezed
class RoomPolicy with _$RoomPolicy {
  const factory RoomPolicy({
    required GenderPolicy genderPolicy,
    required List<WingRule> wingRules,
    required int maxRoomCapacity,
    required bool allowRoomSwapping,
    required int swapCooldownDays,
    required Map<String, dynamic> maintenanceRules,
    required Map<String, dynamic> visitorRules,
  }) = _RoomPolicy;

  factory RoomPolicy.fromJson(Map<String, dynamic> json) => _$RoomPolicyFromJson(json);
}

/// Policy Types
enum PolicyType {
  @JsonValue('curfew')
  curfew,
  @JsonValue('attendance')
  attendance,
  @JsonValue('meal')
  meal,
  @JsonValue('room')
  room,
  @JsonValue('visitor')
  visitor,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('general')
  general,
}

/// Gender Policy for Rooms
enum GenderPolicy {
  @JsonValue('same_gender')
  sameGender,
  @JsonValue('mixed_gender')
  mixedGender,
  @JsonValue('separate_wings')
  separateWings,
}

/// Time of Day model
@freezed
class TimeOfDay with _$TimeOfDay {
  const factory TimeOfDay({
    required int hour,
    required int minute,
  }) = _TimeOfDay;

  factory TimeOfDay.fromJson(Map<String, dynamic> json) => _$TimeOfDayFromJson(json);

  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  factory TimeOfDay.fromString(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}

/// Attendance Rule
@freezed
class AttendanceRule with _$AttendanceRule {
  const factory AttendanceRule({
    required String name,
    required String description,
    required int graceMinutes,
    required bool isMandatory,
    required List<String> applicableDays,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) = _AttendanceRule;

  factory AttendanceRule.fromJson(Map<String, dynamic> json) => _$AttendanceRuleFromJson(json);
}

/// Wing Rule for Room Management
@freezed
class WingRule with _$WingRule {
  const factory WingRule({
    required String wingName,
    required GenderPolicy genderPolicy,
    required List<String> allowedRoles,
    required Map<String, dynamic> restrictions,
    required bool isActive,
  }) = _WingRule;

  factory WingRule.fromJson(Map<String, dynamic> json) => _$WingRuleFromJson(json);
}

/// Policy Summary for Students
@freezed
class PolicySummary with _$PolicySummary {
  const factory PolicySummary({
    required String hostelId,
    required List<PolicyRule> rules,
    required DateTime lastUpdated,
    required String version,
  }) = _PolicySummary;

  factory PolicySummary.fromJson(Map<String, dynamic> json) => _$PolicySummaryFromJson(json);
}

/// Simple Policy Rule for Student Display
@freezed
class PolicyRule with _$PolicyRule {
  const factory PolicyRule({
    required String title,
    required String description,
    required String category,
    required String icon,
    required bool isImportant,
  }) = _PolicyRule;

  factory PolicyRule.fromJson(Map<String, dynamic> json) => _$PolicyRuleFromJson(json);
}

/// Policy Change History
@freezed
class PolicyChangeHistory with _$PolicyChangeHistory {
  const factory PolicyChangeHistory({
    required String id,
    required String policyId,
    required PolicyChangeType changeType,
    required Map<String, dynamic> oldValue,
    required Map<String, dynamic> newValue,
    required String changedBy,
    required String changedByName,
    required DateTime changedAt,
    String? reason,
    Map<String, dynamic>? metadata,
  }) = _PolicyChangeHistory;

  factory PolicyChangeHistory.fromJson(Map<String, dynamic> json) => _$PolicyChangeHistoryFromJson(json);
}

/// Policy Change Types
enum PolicyChangeType {
  @JsonValue('created')
  created,
  @JsonValue('updated')
  updated,
  @JsonValue('activated')
  activated,
  @JsonValue('deactivated')
  deactivated,
  @JsonValue('deleted')
  deleted,
}

/// Policy Template for Quick Setup
@freezed
class PolicyTemplate with _$PolicyTemplate {
  const factory PolicyTemplate({
    required String id,
    required String name,
    required String description,
    required PolicyType type,
    required Map<String, dynamic> defaultConfiguration,
    required List<String> tags,
    required bool isPublic,
  }) = _PolicyTemplate;

  factory PolicyTemplate.fromJson(Map<String, dynamic> json) => _$PolicyTemplateFromJson(json);
}

/// Policy Validation Result
@freezed
class PolicyValidationResult with _$PolicyValidationResult {
  const factory PolicyValidationResult({
    required bool isValid,
    required List<String> errors,
    required List<String> warnings,
    Map<String, dynamic>? suggestions,
  }) = _PolicyValidationResult;

  factory PolicyValidationResult.fromJson(Map<String, dynamic> json) => _$PolicyValidationResultFromJson(json);
}

/// Policy Statistics
@freezed
class PolicyStatistics with _$PolicyStatistics {
  const factory PolicyStatistics({
    required String policyId,
    required int totalViolations,
    required int totalWarnings,
    required int totalPenalties,
    required Map<String, int> violationsByType,
    required Map<String, int> violationsByMonth,
    required DateTime lastViolation,
    required double complianceRate,
  }) = _PolicyStatistics;

  factory PolicyStatistics.fromJson(Map<String, dynamic> json) => _$PolicyStatisticsFromJson(json);
}

/// Extension methods for TimeOfDay
extension TimeOfDayExtension on TimeOfDay {
  String toDisplayString() {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }

  String to12HourFormat() {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$displayHour:$minuteStr $period';
  }

  DateTime toDateTimeToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  bool isAfter(TimeOfDay other) {
    if (hour > other.hour) return true;
    if (hour < other.hour) return false;
    return minute > other.minute;
  }

  bool isBefore(TimeOfDay other) {
    if (hour < other.hour) return true;
    if (hour > other.hour) return false;
    return minute < other.minute;
  }

  Duration difference(TimeOfDay other) {
    final thisMinutes = hour * 60 + minute;
    final otherMinutes = other.hour * 60 + other.minute;
    return Duration(minutes: thisMinutes - otherMinutes);
  }
}
