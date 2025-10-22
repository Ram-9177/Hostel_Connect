// lib/features/attendance/domain/entities/attendance_entities.dart
class AttendanceSession {
  final String id;
  final String hostelId;
  final String createdBy;
  final AttendanceType type;
  final DateTime startTime;
  final DateTime? endTime;
  final AttendanceStatus status;
  final String? description;
  final Map<String, dynamic>? settings;

  const AttendanceSession({
    required this.id,
    required this.hostelId,
    required this.createdBy,
    required this.type,
    required this.startTime,
    this.endTime,
    required this.status,
    this.description,
    this.settings,
  });

  factory AttendanceSession.fromJson(Map<String, dynamic> json) {
    return AttendanceSession(
      id: json['id'],
      hostelId: json['hostelId'],
      createdBy: json['createdBy'],
      type: AttendanceType.fromString(json['type']),
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      status: AttendanceStatus.fromString(json['status']),
      description: json['description'],
      settings: json['settings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hostelId': hostelId,
      'createdBy': createdBy,
      'type': type.toString(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'status': status.toString(),
      'description': description,
      'settings': settings,
    };
  }

  bool get isActive => status == AttendanceStatus.active;
  bool get isCompleted => status == AttendanceStatus.completed;
  bool get isCancelled => status == AttendanceStatus.cancelled;
}

class AttendanceRecord {
  final String id;
  final String sessionId;
  final String studentId;
  final DateTime timestamp;
  final AttendanceMethod method;
  final String? scannedBy;
  final String? reason;
  final bool isLate;
  final bool isAdjusted;
  final Map<String, dynamic>? metadata;

  const AttendanceRecord({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.timestamp,
    required this.method,
    this.scannedBy,
    this.reason,
    required this.isLate,
    required this.isAdjusted,
    this.metadata,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      sessionId: json['sessionId'],
      studentId: json['studentId'],
      timestamp: DateTime.parse(json['timestamp']),
      method: AttendanceMethod.fromString(json['method']),
      scannedBy: json['scannedBy'],
      reason: json['reason'],
      isLate: json['isLate'] ?? false,
      isAdjusted: json['isAdjusted'] ?? false,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sessionId': sessionId,
      'studentId': studentId,
      'timestamp': timestamp.toIso8601String(),
      'method': method.toString(),
      'scannedBy': scannedBy,
      'reason': reason,
      'isLate': isLate,
      'isAdjusted': isAdjusted,
      'metadata': metadata,
    };
  }
}

class AttendanceSummary {
  final String sessionId;
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int adjustedCount;
  final double attendancePercentage;
  final DateTime lastUpdated;

  const AttendanceSummary({
    required this.sessionId,
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.adjustedCount,
    required this.attendancePercentage,
    required this.lastUpdated,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSummary(
      sessionId: json['sessionId'],
      totalStudents: json['totalStudents'],
      presentCount: json['presentCount'],
      absentCount: json['absentCount'],
      lateCount: json['lateCount'],
      adjustedCount: json['adjustedCount'],
      attendancePercentage: json['attendancePercentage'].toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'totalStudents': totalStudents,
      'presentCount': presentCount,
      'absentCount': absentCount,
      'lateCount': lateCount,
      'adjustedCount': adjustedCount,
      'attendancePercentage': attendancePercentage,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

enum AttendanceType {
  morning,
  evening,
  night,
  custom;

  static AttendanceType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'morning':
        return AttendanceType.morning;
      case 'evening':
        return AttendanceType.evening;
      case 'night':
        return AttendanceType.night;
      case 'custom':
        return AttendanceType.custom;
      default:
        return AttendanceType.custom;
    }
  }

  @override
  String toString() {
    switch (this) {
      case AttendanceType.morning:
        return 'morning';
      case AttendanceType.evening:
        return 'evening';
      case AttendanceType.night:
        return 'night';
      case AttendanceType.custom:
        return 'custom';
    }
  }
}

enum AttendanceStatus {
  active,
  completed,
  cancelled;

  static AttendanceStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AttendanceStatus.active;
      case 'completed':
        return AttendanceStatus.completed;
      case 'cancelled':
        return AttendanceStatus.cancelled;
      default:
        return AttendanceStatus.active;
    }
  }

  @override
  String toString() {
    switch (this) {
      case AttendanceStatus.active:
        return 'active';
      case AttendanceStatus.completed:
        return 'completed';
      case AttendanceStatus.cancelled:
        return 'cancelled';
    }
  }
}

enum AttendanceMethod {
  kiosk,
  warden,
  manual,
  qr;

  static AttendanceMethod fromString(String method) {
    switch (method.toLowerCase()) {
      case 'kiosk':
        return AttendanceMethod.kiosk;
      case 'warden':
        return AttendanceMethod.warden;
      case 'manual':
        return AttendanceMethod.manual;
      case 'qr':
        return AttendanceMethod.qr;
      default:
        return AttendanceMethod.manual;
    }
  }

  @override
  String toString() {
    switch (this) {
      case AttendanceMethod.kiosk:
        return 'kiosk';
      case AttendanceMethod.warden:
        return 'warden';
      case AttendanceMethod.manual:
        return 'manual';
      case AttendanceMethod.qr:
        return 'qr';
    }
  }
}
