// lib/core/models/attendance_request.dart
import 'package:freezed_annotation/freezed_annotation.dart';

/// Request model for marking student attendance
class AttendanceRequest {
  final String studentId;
  final String sessionId;
  final DateTime timestamp;
  final String method; // 'SCAN', 'MANUAL', 'KIOSK', 'WARDEN'
  final String? deviceId;
  final String? location;
  final Map<String, dynamic>? metadata;

  const AttendanceRequest({
    required this.studentId,
    required this.sessionId,
    required this.timestamp,
    required this.method,
    this.deviceId,
    this.location,
    this.metadata,
  });

  /// Convert to JSON for API submission
  Map<String, dynamic> toJson() => {
    'studentId': studentId,
    'sessionId': sessionId,
    'timestamp': timestamp.toIso8601String(),
    'method': method,
    if (deviceId != null) 'deviceId': deviceId,
    if (location != null) 'location': location,
    if (metadata != null) 'metadata': metadata,
  };

  /// Create from JSON response
  factory AttendanceRequest.fromJson(Map<String, dynamic> json) {
    return AttendanceRequest(
      studentId: json['studentId'] as String,
      sessionId: json['sessionId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      method: json['method'] as String,
      deviceId: json['deviceId'] as String?,
      location: json['location'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Create a copy with modified fields
  AttendanceRequest copyWith({
    String? studentId,
    String? sessionId,
    DateTime? timestamp,
    String? method,
    String? deviceId,
    String? location,
    Map<String, dynamic>? metadata,
  }) {
    return AttendanceRequest(
      studentId: studentId ?? this.studentId,
      sessionId: sessionId ?? this.sessionId,
      timestamp: timestamp ?? this.timestamp,
      method: method ?? this.method,
      deviceId: deviceId ?? this.deviceId,
      location: location ?? this.location,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Attendance method enum
enum AttendanceMethod {
  scan('SCAN'),
  manual('MANUAL'),
  kiosk('KIOSK'),
  warden('WARDEN');

  final String value;
  const AttendanceMethod(this.value);

  static AttendanceMethod fromString(String value) {
    return AttendanceMethod.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AttendanceMethod.manual,
    );
  }
}
