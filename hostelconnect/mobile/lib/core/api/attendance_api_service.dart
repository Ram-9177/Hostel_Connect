// lib/core/api/attendance_api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../models/attendance_models.dart';
import '../models/attendance_request.dart';
import '../models/attendance_session_request.dart';
import '../models/attendance_adjustment_request.dart';
import '../providers/dio_provider.dart';

final attendanceApiServiceProvider = Provider((ref) => AttendanceApiService(ref.read(dioProvider)));

class AttendanceApiService {
  final Dio _dio;

  AttendanceApiService(this._dio);

  // Create attendance session
  Future<AttendanceSession> createSession(AttendanceSessionRequest request) async {
    try {
      final response = await _dio.post('/attendance/sessions', data: request.toJson());
      return AttendanceSession.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create attendance session: ${e.message}');
    }
  }

  // Mark attendance for a student
  Future<AttendanceRecord> markAttendance(AttendanceRequest request) async {
    try {
      final response = await _dio.post('/attendance/mark', data: request.toJson());
      return AttendanceRecord.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to mark attendance: ${e.message}');
    }
  }

  // Get student's attendance summary
  Future<AttendanceSummary> getStudentAttendance(String studentId, {String? date, int? days}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (date != null) queryParams['date'] = date;
      if (days != null) queryParams['days'] = days;
      
      final response = await _dio.get('/students/$studentId/attendance', queryParameters: queryParams);
      return AttendanceSummary.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch student attendance: ${e.message}');
    }
  }

  // Get attendance statistics
  Future<AttendanceStats> getAttendanceStats({String? date}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (date != null) queryParams['date'] = date;
      
      final response = await _dio.get('/attendance/stats', queryParameters: queryParams);
      return AttendanceStats.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch attendance stats: ${e.message}');
    }
  }

  // Adjust attendance record
  Future<AttendanceRecord> adjustAttendance(String recordId, AttendanceAdjustmentRequest request) async {
    try {
      final response = await _dio.patch('/attendance/$recordId/adjust', data: request.toJson());
      return AttendanceRecord.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to adjust attendance: ${e.message}');
    }
  }

  // Get attendance records for a session
  Future<List<AttendanceRecord>> getSessionAttendance(String sessionId) async {
    try {
      final response = await _dio.get('/attendance/sessions/$sessionId/records');
      return (response.data as List).map((json) => AttendanceRecord.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch session attendance: ${e.message}');
    }
  }

  // Bulk mark attendance
  Future<List<AttendanceRecord>> bulkMarkAttendance(List<AttendanceRequest> requests) async {
    try {
      final response = await _dio.post('/attendance/bulk-mark', data: {
        'records': requests.map((r) => r.toJson()).toList()
      });
      return (response.data as List).map((json) => AttendanceRecord.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to bulk mark attendance: ${e.message}');
    }
  }
}