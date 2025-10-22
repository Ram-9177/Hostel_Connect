// lib/core/models/policy_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'policy_models.freezed.dart';
part 'policy_models.g.dart';

@freezed
class HostelPolicy with _$HostelPolicy {
  const factory HostelPolicy({
    required String id,
    required String hostelId,
    required String name,
    required String description,
    required PolicyType type,
    required Map<String, dynamic> rules,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _HostelPolicy;

  factory HostelPolicy.fromJson(Map<String, dynamic> json) => _$HostelPolicyFromJson(json);
}

@freezed
class CurfewPolicy with _$CurfewPolicy {
  const factory CurfewPolicy({
    required String id,
    required String hostelId,
    required TimeOfDay curfewTime,
    required TimeOfDay wakeUpTime,
    required List<String> allowedDays,
    required bool isStrict,
    required String violationAction,
  }) = _CurfewPolicy;

  factory CurfewPolicy.fromJson(Map<String, dynamic> json) => _$CurfewPolicyFromJson(json);
}

@freezed
class AttendancePolicy with _$AttendancePolicy {
  const factory AttendancePolicy({
    required String id,
    required String hostelId,
    required double minimumAttendance,
    required List<String> exemptedDays,
    required String violationAction,
    required bool allowLateEntry,
    required Duration lateEntryGracePeriod,
  }) = _AttendancePolicy;

  factory AttendancePolicy.fromJson(Map<String, dynamic> json) => _$AttendancePolicyFromJson(json);
}

@freezed
class MealPolicy with _$MealPolicy {
  const factory MealPolicy({
    required String id,
    required String hostelId,
    required TimeOfDay breakfastTime,
    required TimeOfDay lunchTime,
    required TimeOfDay dinnerTime,
    required Duration mealWindow,
    required bool allowOptOut,
    required String optOutDeadline,
  }) = _MealPolicy;

  factory MealPolicy.fromJson(Map<String, dynamic> json) => _$MealPolicyFromJson(json);
}

@freezed
class RoomPolicy with _$RoomPolicy {
  const factory RoomPolicy({
    required String id,
    required String hostelId,
    required bool allowGuests,
    required int maxGuests,
    required Duration guestStayLimit,
    required bool allowRoomChange,
    required String roomChangeProcess,
  }) = _RoomPolicy;

  factory RoomPolicy.fromJson(Map<String, dynamic> json) => _$RoomPolicyFromJson(json);
}

enum PolicyType {
  @JsonValue('CURFEW')
  curfew,
  @JsonValue('ATTENDANCE')
  attendance,
  @JsonValue('MEAL')
  meal,
  @JsonValue('ROOM')
  room,
  @JsonValue('GENERAL')
  general,
}

class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  factory TimeOfDay.fromJson(Map<String, dynamic> json) => TimeOfDay(
    hour: json['hour'] as int,
    minute: json['minute'] as int,
  );

  Map<String, dynamic> toJson() => {
    'hour': hour,
    'minute': minute,
  };

  @override
  String toString() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}