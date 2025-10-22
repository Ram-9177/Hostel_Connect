// lib/core/models/attendance_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_models.freezed.dart';
part 'attendance_models.g.dart';

/// Attendance Session Model
@freezed
class AttendanceSession with _$AttendanceSession {
  const factory AttendanceSession({
    required String id,
    required String hostelId,
    required String createdBy,
    required String createdByName,
    required AttendanceMode mode,
    required DateTime startTime,
    DateTime? endTime,
    required SessionStatus status,
    required String title,
    String? description,
    required Map<String, dynamic> settings,
    required List<String> scannedStudents,
    required List<String> manualEntries,
    required int totalPresent,
    required int totalAbsent,
    required int totalLate,
    required int totalAdjusted,
    DateTime? gracePeriodEnd,
    Map<String, dynamic>? metadata,
  }) = _AttendanceSession;

  factory AttendanceSession.fromJson(Map<String, dynamic> json) => _$AttendanceSessionFromJson(json);
}

/// Attendance Entry Model
@freezed
class AttendanceEntry with _$AttendanceEntry {
  const factory AttendanceEntry({
    required String id,
    required String sessionId,
    required String studentId,
    required String studentName,
    required String studentRollNumber,
    required AttendanceStatus status,
    required DateTime timestamp,
    required EntryMethod method,
    String? reason,
    String? qrCode,
    String? nonce,
    bool? isLate,
    bool? isAdjusted,
    DateTime? adjustedAt,
    String? adjustedBy,
    Map<String, dynamic>? metadata,
  }) = _AttendanceEntry;

  factory AttendanceEntry.fromJson(Map<String, dynamic> json) => _$AttendanceEntryFromJson(json);
}

/// QR Code Data Model
@freezed
class AttendanceQRCode with _$AttendanceQRCode {
  const factory AttendanceQRCode({
    required String studentId,
    required String sessionId,
    required String nonce,
    required DateTime generatedAt,
    required DateTime expiresAt,
    required String signature,
  }) = _AttendanceQRCode;

  factory AttendanceQRCode.fromJson(Map<String, dynamic> json) => _$AttendanceQRCodeFromJson(json);
}

/// Attendance Summary Model
@freezed
class AttendanceSummary with _$AttendanceSummary {
  const factory AttendanceSummary({
    required String sessionId,
    required String sessionTitle,
    required DateTime sessionDate,
    required AttendanceMode mode,
    required int totalStudents,
    required int presentCount,
    required int absentCount,
    required int lateCount,
    required int adjustedCount,
    required double attendancePercentage,
    required List<AttendanceEntry> entries,
    required Map<String, dynamic> statistics,
    DateTime? lastUpdated,
  }) = _AttendanceSummary;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryFromJson(json);
}

/// Manual Entry Request Model
@freezed
class ManualEntryRequest with _$ManualEntryRequest {
  const factory ManualEntryRequest({
    required String sessionId,
    required String studentId,
    required String reason,
    required AttendanceStatus status,
    String? notes,
    DateTime? customTimestamp,
  }) = _ManualEntryRequest;

  factory ManualEntryRequest.fromJson(Map<String, dynamic> json) => _$ManualEntryRequestFromJson(json);
}

/// Session Settings Model
@freezed
class SessionSettings with _$SessionSettings {
  const factory SessionSettings({
    required int gracePeriodMinutes,
    required bool allowManualEntry,
    required bool allowLateEntry,
    required bool autoCloseAfterInactivity,
    required int inactivityTimeoutMinutes,
    required bool requireReasonForAbsence,
    required bool enableQRScanning,
    required bool enableManualMarking,
    required List<String> allowedRoles,
    Map<String, dynamic>? customSettings,
  }) = _SessionSettings;

  factory SessionSettings.fromJson(Map<String, dynamic> json) => _$SessionSettingsFromJson(json);
}

/// Attendance Statistics Model
@freezed
class AttendanceStatistics with _$AttendanceStatistics {
  const factory AttendanceStatistics({
    required String period,
    required DateTime startDate,
    required DateTime endDate,
    required int totalSessions,
    required int totalStudents,
    required double averageAttendance,
    required Map<String, int> statusCounts,
    required Map<String, double> dailyAttendance,
    required List<String> topAbsentees,
    required List<String> topAttendees,
    Map<String, dynamic>? trends,
  }) = _AttendanceStatistics;

  factory AttendanceStatistics.fromJson(Map<String, dynamic> json) => _$AttendanceStatisticsFromJson(json);
}

/// Enums

enum AttendanceMode {
  @JsonValue('kiosk')
  kiosk,
  @JsonValue('warden')
  warden,
  @JsonValue('hybrid')
  hybrid,
}

enum SessionStatus {
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('closed')
  closed,
  @JsonValue('cancelled')
  cancelled,
}

enum AttendanceStatus {
  @JsonValue('present')
  present,
  @JsonValue('absent')
  absent,
  @JsonValue('late')
  late,
  @JsonValue('excused')
  excused,
}

enum EntryMethod {
  @JsonValue('qr_scan')
  qrScan,
  @JsonValue('manual')
  manual,
  @JsonValue('auto')
  auto,
  @JsonValue('adjusted')
  adjusted,
}

/// Session Creation Request
@freezed
class CreateSessionRequest with _$CreateSessionRequest {
  const factory CreateSessionRequest({
    required String hostelId,
    required AttendanceMode mode,
    required String title,
    String? description,
    required SessionSettings settings,
    DateTime? scheduledStartTime,
    Map<String, dynamic>? metadata,
  }) = _CreateSessionRequest;

  factory CreateSessionRequest.fromJson(Map<String, dynamic> json) => _$CreateSessionRequestFromJson(json);
}

/// QR Scan Request
@freezed
class QRScanRequest with _$QRScanRequest {
  const factory QRScanRequest({
    required String sessionId,
    required String qrCode,
    required String scannedBy,
    DateTime? timestamp,
  }) = _QRScanRequest;

  factory QRScanRequest.fromJson(Map<String, dynamic> json) => _$QRScanRequestFromJson(json);
}

/// Session Close Request
@freezed
class CloseSessionRequest with _$CloseSessionRequest {
  const factory CloseSessionRequest({
    required String sessionId,
    String? reason,
    bool? forceClose,
    Map<String, dynamic>? finalStatistics,
  }) = _CloseSessionRequest;

  factory CloseSessionRequest.fromJson(Map<String, dynamic> json) => _$CloseSessionRequestFromJson(json);
}

/// Attendance Adjustment Request
@freezed
class AttendanceAdjustmentRequest with _$AttendanceAdjustmentRequest {
  const factory AttendanceAdjustmentRequest({
    required String sessionId,
    required String studentId,
    required AttendanceStatus newStatus,
    required String reason,
    required String adjustedBy,
    DateTime? customTimestamp,
    Map<String, dynamic>? metadata,
  }) = _AttendanceAdjustmentRequest;

  factory AttendanceAdjustmentRequest.fromJson(Map<String, dynamic> json) => _$AttendanceAdjustmentRequestFromJson(json);
}

/// Night Attendance Calculation Model
@freezed
class NightAttendanceCalculation with _$NightAttendanceCalculation {
  const factory NightAttendanceCalculation({
    required String hostelId,
    required DateTime date,
    required int totalStudents,
    required int outpassCount,
    required int presentCount,
    required int absentCount,
    required double attendancePercentage,
    required List<String> outpassStudents,
    required List<String> presentStudents,
    required List<String> absentStudents,
    DateTime? calculatedAt,
  }) = _NightAttendanceCalculation;

  factory NightAttendanceCalculation.fromJson(Map<String, dynamic> json) => _$NightAttendanceCalculationFromJson(json);
}

/// Session Template Model
@freezed
class SessionTemplate with _$SessionTemplate {
  const factory SessionTemplate({
    required String id,
    required String name,
    required String description,
    required AttendanceMode mode,
    required SessionSettings settings,
    required List<String> tags,
    required bool isPublic,
    required String createdBy,
    DateTime? createdAt,
  }) = _SessionTemplate;

  factory SessionTemplate.fromJson(Map<String, dynamic> json) => _$SessionTemplateFromJson(json);
}

/// Attendance Report Model
@freezed
class AttendanceReport with _$AttendanceReport {
  const factory AttendanceReport({
    required String id,
    required String title,
    required String description,
    required ReportType type,
    required DateTime generatedAt,
    required String generatedBy,
    required Map<String, dynamic> data,
    required String format,
    String? downloadUrl,
    DateTime? expiresAt,
  }) = _AttendanceReport;

  factory AttendanceReport.fromJson(Map<String, dynamic> json) => _$AttendanceReportFromJson(json);
}

enum ReportType {
  @JsonValue('session')
  session,
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('student')
  student,
  @JsonValue('hostel')
  hostel,
}

/// Extension methods for convenience
extension AttendanceSessionExtension on AttendanceSession {
  bool get isActive => status == SessionStatus.active;
  bool get isClosed => status == SessionStatus.closed;
  bool get isPaused => status == SessionStatus.paused;
  
  Duration? get duration {
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    return null;
  }
  
  bool get isWithinGracePeriod {
    if (gracePeriodEnd == null) return false;
    return DateTime.now().isBefore(gracePeriodEnd!);
  }
  
  int get totalEntries => scannedStudents.length + manualEntries.length;
}

extension AttendanceEntryExtension on AttendanceEntry {
  bool get isScanned => method == EntryMethod.qrScan;
  bool get isManual => method == EntryMethod.manual;
  bool get isAdjusted => method == EntryMethod.adjusted;
  
  String get statusDisplayName {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.excused:
        return 'Excused';
    }
  }
}

extension AttendanceModeExtension on AttendanceMode {
  String get displayName {
    switch (this) {
      case AttendanceMode.kiosk:
        return 'Kiosk Mode';
      case AttendanceMode.warden:
        return 'Warden Mode';
      case AttendanceMode.hybrid:
        return 'Hybrid Mode';
    }
  }
  
  String get description {
    switch (this) {
      case AttendanceMode.kiosk:
        return 'Students scan QR codes independently';
      case AttendanceMode.warden:
        return 'Warden marks attendance manually';
      case AttendanceMode.hybrid:
        return 'Combination of QR scanning and manual entry';
    }
  }
}
