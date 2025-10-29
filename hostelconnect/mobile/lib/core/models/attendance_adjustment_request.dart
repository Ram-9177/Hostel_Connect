// lib/core/models/attendance_adjustment_request.dart

/// Request model for adjusting/correcting attendance records
class AttendanceAdjustmentRequest {
  final String attendanceId;
  final String studentId;
  final String sessionId;
  final String reason;
  final String adjustmentType; // 'MARK_PRESENT', 'MARK_ABSENT', 'CORRECTION', 'OVERRIDE'
  final String adjustedBy;
  final DateTime? originalTimestamp;
  final DateTime? newTimestamp;
  final Map<String, dynamic>? metadata;

  const AttendanceAdjustmentRequest({
    required this.attendanceId,
    required this.studentId,
    required this.sessionId,
    required this.reason,
    required this.adjustmentType,
    required this.adjustedBy,
    this.originalTimestamp,
    this.newTimestamp,
    this.metadata,
  });

  /// Convert to JSON for API submission
  Map<String, dynamic> toJson() => {
    'attendanceId': attendanceId,
    'studentId': studentId,
    'sessionId': sessionId,
    'reason': reason,
    'adjustmentType': adjustmentType,
    'adjustedBy': adjustedBy,
    if (originalTimestamp != null) 'originalTimestamp': originalTimestamp!.toIso8601String(),
    if (newTimestamp != null) 'newTimestamp': newTimestamp!.toIso8601String(),
    if (metadata != null) 'metadata': metadata,
  };

  /// Create from JSON response
  factory AttendanceAdjustmentRequest.fromJson(Map<String, dynamic> json) {
    return AttendanceAdjustmentRequest(
      attendanceId: json['attendanceId'] as String,
      studentId: json['studentId'] as String,
      sessionId: json['sessionId'] as String,
      reason: json['reason'] as String,
      adjustmentType: json['adjustmentType'] as String,
      adjustedBy: json['adjustedBy'] as String,
      originalTimestamp: json['originalTimestamp'] != null
          ? DateTime.parse(json['originalTimestamp'] as String)
          : null,
      newTimestamp: json['newTimestamp'] != null
          ? DateTime.parse(json['newTimestamp'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Create a copy with modified fields
  AttendanceAdjustmentRequest copyWith({
    String? attendanceId,
    String? studentId,
    String? sessionId,
    String? reason,
    String? adjustmentType,
    String? adjustedBy,
    DateTime? originalTimestamp,
    DateTime? newTimestamp,
    Map<String, dynamic>? metadata,
  }) {
    return AttendanceAdjustmentRequest(
      attendanceId: attendanceId ?? this.attendanceId,
      studentId: studentId ?? this.studentId,
      sessionId: sessionId ?? this.sessionId,
      reason: reason ?? this.reason,
      adjustmentType: adjustmentType ?? this.adjustmentType,
      adjustedBy: adjustedBy ?? this.adjustedBy,
      originalTimestamp: originalTimestamp ?? this.originalTimestamp,
      newTimestamp: newTimestamp ?? this.newTimestamp,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Adjustment type enum
enum AttendanceAdjustmentType {
  markPresent('MARK_PRESENT'),
  markAbsent('MARK_ABSENT'),
  correction('CORRECTION'),
  override('OVERRIDE');

  final String value;
  const AttendanceAdjustmentType(this.value);

  static AttendanceAdjustmentType fromString(String value) {
    return AttendanceAdjustmentType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AttendanceAdjustmentType.correction,
    );
  }
}
