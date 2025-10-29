// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceRecordImpl _$$AttendanceRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRecordImpl(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      sessionId: json['sessionId'] as String,
      session: $enumDecode(_$AttendanceSessionTypeEnumMap, json['session']),
      date: DateTime.parse(json['date'] as String),
      status: $enumDecode(_$AttendanceStatusEnumMap, json['status']),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      recordedBy: json['recordedBy'] as String?,
      reason: json['reason'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isAdjusted: json['isAdjusted'] as bool? ?? false,
      adjustedAt: json['adjustedAt'] == null
          ? null
          : DateTime.parse(json['adjustedAt'] as String),
      adjustedBy: json['adjustedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      student: json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AttendanceRecordImplToJson(
        _$AttendanceRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'sessionId': instance.sessionId,
      'session': _$AttendanceSessionTypeEnumMap[instance.session]!,
      'date': instance.date.toIso8601String(),
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'recordedBy': instance.recordedBy,
      'reason': instance.reason,
      'photoUrl': instance.photoUrl,
      'isAdjusted': instance.isAdjusted,
      'adjustedAt': instance.adjustedAt?.toIso8601String(),
      'adjustedBy': instance.adjustedBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'student': instance.student,
    };

const _$AttendanceSessionTypeEnumMap = {
  AttendanceSessionType.morning: 'MORNING',
  AttendanceSessionType.evening: 'EVENING',
  AttendanceSessionType.night: 'NIGHT',
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.present: 'PRESENT',
  AttendanceStatus.absent: 'ABSENT',
  AttendanceStatus.late: 'LATE',
  AttendanceStatus.excused: 'EXCUSED',
  AttendanceStatus.adjusted: 'ADJUSTED',
};

_$AttendanceSessionImpl _$$AttendanceSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceSessionImpl(
      id: json['id'] as String,
      session: $enumDecode(_$AttendanceSessionTypeEnumMap, json['session']),
      date: DateTime.parse(json['date'] as String),
      mode: $enumDecode(_$AttendanceModeEnumMap, json['mode']),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isActive: json['isActive'] as bool? ?? false,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AttendanceSessionImplToJson(
        _$AttendanceSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'session': _$AttendanceSessionTypeEnumMap[instance.session]!,
      'date': instance.date.toIso8601String(),
      'mode': _$AttendanceModeEnumMap[instance.mode]!,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'isActive': instance.isActive,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$AttendanceModeEnumMap = {
  AttendanceMode.kiosk: 'KIOSK',
  AttendanceMode.warden: 'WARDEN',
  AttendanceMode.hybrid: 'HYBRID',
};

_$AttendanceSummaryImpl _$$AttendanceSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceSummaryImpl(
      studentId: json['studentId'] as String,
      date: DateTime.parse(json['date'] as String),
      totalSessions: (json['totalSessions'] as num).toInt(),
      presentCount: (json['presentCount'] as num).toInt(),
      absentCount: (json['absentCount'] as num).toInt(),
      lateCount: (json['lateCount'] as num).toInt(),
      excusedCount: (json['excusedCount'] as num).toInt(),
      attendancePercentage: (json['attendancePercentage'] as num).toDouble(),
      records: (json['records'] as List<dynamic>)
          .map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AttendanceSummaryImplToJson(
        _$AttendanceSummaryImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'date': instance.date.toIso8601String(),
      'totalSessions': instance.totalSessions,
      'presentCount': instance.presentCount,
      'absentCount': instance.absentCount,
      'lateCount': instance.lateCount,
      'excusedCount': instance.excusedCount,
      'attendancePercentage': instance.attendancePercentage,
      'records': instance.records,
    };

_$AttendanceStatsImpl _$$AttendanceStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceStatsImpl(
      date: DateTime.parse(json['date'] as String),
      totalStudents: (json['totalStudents'] as num).toInt(),
      presentStudents: (json['presentStudents'] as num).toInt(),
      absentStudents: (json['absentStudents'] as num).toInt(),
      lateStudents: (json['lateStudents'] as num).toInt(),
      excusedStudents: (json['excusedStudents'] as num).toInt(),
      overallPercentage: (json['overallPercentage'] as num).toDouble(),
      sessionBreakdown: (json['sessionBreakdown'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$AttendanceSessionTypeEnumMap, k), (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$$AttendanceStatsImplToJson(
        _$AttendanceStatsImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'totalStudents': instance.totalStudents,
      'presentStudents': instance.presentStudents,
      'absentStudents': instance.absentStudents,
      'lateStudents': instance.lateStudents,
      'excusedStudents': instance.excusedStudents,
      'overallPercentage': instance.overallPercentage,
      'sessionBreakdown': instance.sessionBreakdown
          .map((k, e) => MapEntry(_$AttendanceSessionTypeEnumMap[k]!, e)),
    };

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['id'] as String,
      rollNumber: json['rollNumber'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      roomId: json['roomId'] as String?,
      bedId: json['bedId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rollNumber': instance.rollNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'roomId': instance.roomId,
      'bedId': instance.bedId,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
