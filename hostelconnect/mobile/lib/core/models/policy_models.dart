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
    required String category,
    required Map<String, dynamic> rules,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _HostelPolicy;

  factory HostelPolicy.fromJson(Map<String, dynamic> json) => _$HostelPolicyFromJson(json);
}

@freezed
class CurfewPolicy with _$CurfewPolicy {
  const factory CurfewPolicy({
    required String id,
    required String hostelId,
    required String curfewTime,
    required String gracePeriod,
    required List<String> exceptions,
    @Default(true) bool isActive,
  }) = _CurfewPolicy;

  factory CurfewPolicy.fromJson(Map<String, dynamic> json) => _$CurfewPolicyFromJson(json);
}

@freezed
class AttendancePolicy with _$AttendancePolicy {
  const factory AttendancePolicy({
    required String id,
    required String hostelId,
    required int requiredAttendance,
    required List<String> attendanceTypes,
    required Map<String, dynamic> penalties,
    @Default(true) bool isActive,
  }) = _AttendancePolicy;

  factory AttendancePolicy.fromJson(Map<String, dynamic> json) => _$AttendancePolicyFromJson(json);
}

@freezed
class MealPolicy with _$MealPolicy {
  const factory MealPolicy({
    required String id,
    required String hostelId,
    required Map<String, String> mealTimes,
    required int advanceBookingDays,
    required Map<String, dynamic> cancellationRules,
    @Default(true) bool isActive,
  }) = _MealPolicy;

  factory MealPolicy.fromJson(Map<String, dynamic> json) => _$MealPolicyFromJson(json);
}

@freezed
class RoomPolicy with _$RoomPolicy {
  const factory RoomPolicy({
    required String id,
    required String hostelId,
    required Map<String, dynamic> allocationRules,
    required Map<String, dynamic> maintenanceRules,
    required Map<String, dynamic> guestRules,
    @Default(true) bool isActive,
  }) = _RoomPolicy;

  factory RoomPolicy.fromJson(Map<String, dynamic> json) => _$RoomPolicyFromJson(json);
}