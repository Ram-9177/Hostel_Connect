class AttendanceSessionRequest {
  final String sessionId;
  final DateTime startTime;
  final DateTime? endTime;
  
  AttendanceSessionRequest({
    required this.sessionId,
    required this.startTime,
    this.endTime,
  });
  
  Map<String, dynamic> toJson() => {
    'session_id': sessionId,
    'start_time': startTime.toIso8601String(),
    if (endTime != null) 'end_time': endTime!.toIso8601String(),
  };
  
  factory AttendanceSessionRequest.fromJson(Map<String, dynamic> json) {
    return AttendanceSessionRequest(
      sessionId: json['session_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] != null 
          ? DateTime.parse(json['end_time'] as String) 
          : null,
    );
  }
}
