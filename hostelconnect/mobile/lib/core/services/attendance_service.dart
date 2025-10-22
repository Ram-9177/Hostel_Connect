// lib/core/services/attendance_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance_models.dart';
import '../api/attendance_api_service.dart';
import '../state/load_state.dart';

final attendanceServiceProvider = Provider((ref) => AttendanceService(ref.read(attendanceApiServiceProvider)));

class AttendanceService {
  final AttendanceApiService _apiService;

  AttendanceService(this._apiService);

  // Session Management
  Future<LoadStateData<AttendanceSession>> createSession(CreateSessionRequest request) async {
    try {
      final session = await _apiService.createSession(request);
      return LoadStateData(state: LoadState.success, data: session);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendanceSession>> getSession(String sessionId) async {
    try {
      final session = await _apiService.getSession(sessionId);
      return LoadStateData(state: LoadState.success, data: session);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceSession>>> getSessions(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final sessions = await _apiService.getSessions(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: sessions);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendanceSession>> updateSession(String sessionId, Map<String, dynamic> updates) async {
    try {
      final session = await _apiService.updateSession(sessionId, updates);
      return LoadStateData(state: LoadState.success, data: session);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendanceSession>> closeSession(CloseSessionRequest request) async {
    try {
      final session = await _apiService.closeSession(request);
      return LoadStateData(state: LoadState.success, data: session);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> cancelSession(String sessionId, String reason) async {
    try {
      await _apiService.cancelSession(sessionId, reason);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> pauseSession(String sessionId) async {
    try {
      await _apiService.pauseSession(sessionId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> resumeSession(String sessionId) async {
    try {
      await _apiService.resumeSession(sessionId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // QR Code Management
  Future<LoadStateData<AttendanceQRCode>> generateQRCode(String sessionId, String studentId) async {
    try {
      final qrCode = await _apiService.generateQRCode(sessionId, studentId);
      return LoadStateData(state: LoadState.success, data: qrCode);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceQRCode>>> generateBulkQRCodes(String sessionId, List<String> studentIds) async {
    try {
      final qrCodes = await _apiService.generateBulkQRCodes(sessionId, studentIds);
      return LoadStateData(state: LoadState.success, data: qrCodes);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendanceEntry>> scanQRCode(QRScanRequest request) async {
    try {
      final entry = await _apiService.scanQRCode(request);
      return LoadStateData(state: LoadState.success, data: entry);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<bool>> validateQRCode(String qrCode) async {
    try {
      final isValid = await _apiService.validateQRCode(qrCode);
      return LoadStateData(state: LoadState.success, data: isValid);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Manual Entry
  Future<LoadStateData<AttendanceEntry>> addManualEntry(ManualEntryRequest request) async {
    try {
      final entry = await _apiService.addManualEntry(request);
      return LoadStateData(state: LoadState.success, data: entry);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceEntry>>> getSessionEntries(String sessionId) async {
    try {
      final entries = await _apiService.getSessionEntries(sessionId);
      return LoadStateData(state: LoadState.success, data: entries);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendanceEntry>> updateEntry(String entryId, Map<String, dynamic> updates) async {
    try {
      final entry = await _apiService.updateEntry(entryId, updates);
      return LoadStateData(state: LoadState.success, data: entry);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deleteEntry(String entryId) async {
    try {
      await _apiService.deleteEntry(entryId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Attendance Adjustments
  Future<LoadStateData<AttendanceEntry>> adjustAttendance(AttendanceAdjustmentRequest request) async {
    try {
      final entry = await _apiService.adjustAttendance(request);
      return LoadStateData(state: LoadState.success, data: entry);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceEntry>>> getAdjustmentHistory(String sessionId) async {
    try {
      final adjustments = await _apiService.getAdjustmentHistory(sessionId);
      return LoadStateData(state: LoadState.success, data: adjustments);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Grace Period Management
  Future<LoadStateData<void>> extendGracePeriod(String sessionId, int additionalMinutes) async {
    try {
      await _apiService.extendGracePeriod(sessionId, additionalMinutes);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceEntry>>> processLateEntries(String sessionId) async {
    try {
      final entries = await _apiService.processLateEntries(sessionId);
      return LoadStateData(state: LoadState.success, data: entries);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Night Attendance Calculation
  Future<LoadStateData<NightAttendanceCalculation>> calculateNightAttendance(String hostelId, DateTime date) async {
    try {
      final calculation = await _apiService.calculateNightAttendance(hostelId, date);
      return LoadStateData(state: LoadState.success, data: calculation);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<NightAttendanceCalculation>>> getNightAttendanceHistory(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final history = await _apiService.getNightAttendanceHistory(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Summary and Reports
  Future<LoadStateData<AttendanceSummary>> getSessionSummary(String sessionId) async {
    try {
      final summary = await _apiService.getSessionSummary(sessionId);
      return LoadStateData(state: LoadState.success, data: summary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendanceStatistics>> getAttendanceStatistics(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final statistics = await _apiService.getAttendanceStatistics(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: statistics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendanceReport>> generateReport(String hostelId, ReportType type, {DateTime? from, DateTime? to}) async {
    try {
      final report = await _apiService.generateReport(hostelId, type, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: report);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Session Templates
  Future<LoadStateData<List<SessionTemplate>>> getSessionTemplates() async {
    try {
      final templates = await _apiService.getSessionTemplates();
      return LoadStateData(state: LoadState.success, data: templates);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<SessionTemplate>> createSessionTemplate(SessionTemplate template) async {
    try {
      final createdTemplate = await _apiService.createSessionTemplate(template);
      return LoadStateData(state: LoadState.success, data: createdTemplate);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Student-specific attendance
  Future<LoadStateData<List<AttendanceEntry>>> getStudentAttendance(String studentId, {DateTime? from, DateTime? to}) async {
    try {
      final entries = await _apiService.getStudentAttendance(studentId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: entries);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getStudentAttendanceSummary(String studentId, {DateTime? from, DateTime? to}) async {
    try {
      final summary = await _apiService.getStudentAttendanceSummary(studentId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: summary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Duplicate Prevention
  Future<LoadStateData<bool>> checkDuplicateEntry(String sessionId, String studentId) async {
    try {
      final isDuplicate = await _apiService.checkDuplicateEntry(sessionId, studentId);
      return LoadStateData(state: LoadState.success, data: isDuplicate);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<String>>> getDuplicateEntries(String sessionId) async {
    try {
      final duplicates = await _apiService.getDuplicateEntries(sessionId);
      return LoadStateData(state: LoadState.success, data: duplicates);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Session Analytics
  Future<LoadStateData<Map<String, dynamic>>> getSessionAnalytics(String sessionId) async {
    try {
      final analytics = await _apiService.getSessionAnalytics(sessionId);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Map<String, dynamic>>>> getAttendanceTrends(String hostelId, {int days = 30}) async {
    try {
      final trends = await _apiService.getAttendanceTrends(hostelId, days: days);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Bulk Operations
  Future<LoadStateData<List<AttendanceEntry>>> bulkMarkAttendance(String sessionId, List<Map<String, dynamic>> entries) async {
    try {
      final markedEntries = await _apiService.bulkMarkAttendance(sessionId, entries);
      return LoadStateData(state: LoadState.success, data: markedEntries);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> bulkAdjustAttendance(String sessionId, List<AttendanceAdjustmentRequest> adjustments) async {
    try {
      await _apiService.bulkAdjustAttendance(sessionId, adjustments);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Export/Import
  Future<LoadStateData<String>> exportSessionData(String sessionId, String format) async {
    try {
      final exportUrl = await _apiService.exportSessionData(sessionId, format);
      return LoadStateData(state: LoadState.success, data: exportUrl);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceEntry>>> importSessionData(String sessionId, List<Map<String, dynamic>> data) async {
    try {
      final entries = await _apiService.importSessionData(sessionId, data);
      return LoadStateData(state: LoadState.success, data: entries);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Utility Methods
  Future<LoadStateData<List<AttendanceSession>>> getActiveSessions(String hostelId) async {
    try {
      final allSessions = await _apiService.getSessions(hostelId);
      final activeSessions = allSessions.where((session) => session.isActive).toList();
      return LoadStateData(state: LoadState.success, data: activeSessions);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceSession>>> getSessionsByMode(String hostelId, AttendanceMode mode) async {
    try {
      final allSessions = await _apiService.getSessions(hostelId);
      final filteredSessions = allSessions.where((session) => session.mode == mode).toList();
      return LoadStateData(state: LoadState.success, data: filteredSessions);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getSessionStatistics(String sessionId) async {
    try {
      final analytics = await _apiService.getSessionAnalytics(sessionId);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }
}
