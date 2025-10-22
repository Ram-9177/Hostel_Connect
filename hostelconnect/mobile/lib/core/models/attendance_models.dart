// lib/core/models/attendance_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_models.freezed.dart';
part 'attendance_models.g.dart';

enum AttendanceMode {
  @JsonValue('KIOSK')
  kiosk,
  @JsonValue('WARDEN')
  warden,
  @JsonValue('HYBRID')
  hybrid,
}

enum AttendanceStatus {
  @JsonValue('PRESENT')
  present,
  @JsonValue('ABSENT')
  absent,
  @JsonValue('LATE')
  late,
  @JsonValue('EXCUSED')
  excused,
  @JsonValue('ADJUSTED')
  adjusted,
}

enum AttendanceSession {
  @JsonValue('MORNING')
  morning,
  @JsonValue('EVENING')
  evening,
  @JsonValue('NIGHT')
  night,
}

@freezed
class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    required String id,
    required String studentId,
    required String sessionId,
    required AttendanceSession session,
    required DateTime date,
    required AttendanceStatus status,
    required DateTime recordedAt,
    String? recordedBy,
    String? reason,
    String? photoUrl,
    @Default(false) bool isAdjusted,
    DateTime? adjustedAt,
    String? adjustedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Student? student, // Optional: to embed student details
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) => _$AttendanceRecordFromJson(json);
}

@freezed
class AttendanceSession with _$AttendanceSession {
  const factory AttendanceSession({
    required String id,
    required AttendanceSession session,
    required DateTime date,
    required AttendanceMode mode,
    required DateTime startTime,
    required DateTime endTime,
    @Default(false) bool isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AttendanceSession;

  factory AttendanceSession.fromJson(Map<String, dynamic> json) => _$AttendanceSessionFromJson(json);
}

@freezed
class AttendanceSummary with _$AttendanceSummary {
  const factory AttendanceSummary({
    required String studentId,
    required DateTime date,
    required int totalSessions,
    required int presentCount,
    required int absentCount,
    required int lateCount,
    required int excusedCount,
    required double attendancePercentage,
    required List<AttendanceRecord> records,
  }) = _AttendanceSummary;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryFromJson(json);
}

@freezed
class AttendanceStats with _$AttendanceStats {
  const factory AttendanceStats({
    required DateTime date,
    required int totalStudents,
    required int presentStudents,
    required int absentStudents,
    required int lateStudents,
    required int excusedStudents,
    required double overallPercentage,
    required Map<AttendanceSession, int> sessionBreakdown,
  }) = _AttendanceStats;

  factory AttendanceStats.fromJson(Map<String, dynamic> json) => _$AttendanceStatsFromJson(json);
}

// Student model for attendance context
@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String rollNumber,
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    String? roomId,
    String? bedId,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
}