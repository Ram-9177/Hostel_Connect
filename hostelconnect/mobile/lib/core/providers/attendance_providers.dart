// lib/core/providers/attendance_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance_models.dart';
import '../services/attendance_service.dart';
import '../state/load_state.dart';

// Service Provider
final attendanceServiceProvider = Provider((ref) => AttendanceService(ref.read(attendanceApiServiceProvider)));

// Session Providers
final sessionsProvider = StateNotifierProvider.family<SessionsNotifier, LoadStateData<List<AttendanceSession>>, String>((ref, hostelId) {
  return SessionsNotifier(ref, hostelId);
});

final sessionProvider = StateNotifierProvider.family<SessionNotifier, LoadStateData<AttendanceSession>, String>((ref, sessionId) {
  return SessionNotifier(ref, sessionId);
});

final activeSessionsProvider = StateNotifierProvider.family<ActiveSessionsNotifier, LoadStateData<List<AttendanceSession>>, String>((ref, hostelId) {
  return ActiveSessionsNotifier(ref, hostelId);
});

// Session Entries Providers
final sessionEntriesProvider = StateNotifierProvider.family<SessionEntriesNotifier, LoadStateData<List<AttendanceEntry>>, String>((ref, sessionId) {
  return SessionEntriesNotifier(ref, sessionId);
});

// QR Code Providers
final qrCodesProvider = StateNotifierProvider.family<QRCodesNotifier, LoadStateData<List<AttendanceQRCode>>, String>((ref, sessionId) {
  return QRCodesNotifier(ref, sessionId);
});

// Summary Providers
final sessionSummaryProvider = StateNotifierProvider.family<SessionSummaryNotifier, LoadStateData<AttendanceSummary>, String>((ref, sessionId) {
  return SessionSummaryNotifier(ref, sessionId);
});

final attendanceStatisticsProvider = StateNotifierProvider.family<AttendanceStatisticsNotifier, LoadStateData<AttendanceStatistics>, String>((ref, hostelId) {
  return AttendanceStatisticsNotifier(ref, hostelId);
});

// Night Attendance Providers
final nightAttendanceProvider = StateNotifierProvider.family<NightAttendanceNotifier, LoadStateData<NightAttendanceCalculation>, String>((ref, hostelId) {
  return NightAttendanceNotifier(ref, hostelId);
});

final nightAttendanceHistoryProvider = StateNotifierProvider.family<NightAttendanceHistoryNotifier, LoadStateData<List<NightAttendanceCalculation>>, String>((ref, hostelId) {
  return NightAttendanceHistoryNotifier(ref, hostelId);
});

// Student Attendance Providers
final studentAttendanceProvider = StateNotifierProvider.family<StudentAttendanceNotifier, LoadStateData<List<AttendanceEntry>>, String>((ref, studentId) {
  return StudentAttendanceNotifier(ref, studentId);
});

final studentAttendanceSummaryProvider = StateNotifierProvider.family<StudentAttendanceSummaryNotifier, LoadStateData<Map<String, dynamic>>, String>((ref, studentId) {
  return StudentAttendanceSummaryNotifier(ref, studentId);
});

// Session Templates Providers
final sessionTemplatesProvider = StateNotifierProvider<SessionTemplatesNotifier, LoadStateData<List<SessionTemplate>>>((ref) {
  return SessionTemplatesNotifier(ref);
});

// Adjustment History Providers
final adjustmentHistoryProvider = StateNotifierProvider.family<AdjustmentHistoryNotifier, LoadStateData<List<AttendanceEntry>>, String>((ref, sessionId) {
  return AdjustmentHistoryNotifier(ref, sessionId);
});

// Duplicate Entries Providers
final duplicateEntriesProvider = StateNotifierProvider.family<DuplicateEntriesNotifier, LoadStateData<List<String>>, String>((ref, sessionId) {
  return DuplicateEntriesNotifier(ref, sessionId);
});

// Attendance Trends Providers
final attendanceTrendsProvider = StateNotifierProvider.family<AttendanceTrendsNotifier, LoadStateData<List<Map<String, dynamic>>>, String>((ref, hostelId) {
  return AttendanceTrendsNotifier(ref, hostelId);
});

// Notifier Classes

class SessionsNotifier extends StateNotifier<LoadStateData<List<AttendanceSession>>> {
  final Ref _ref;
  final String hostelId;
  List<AttendanceSession> _cachedSessions = [];

  SessionsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadSessions();
  }

  Future<void> loadSessions({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getSessions(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedSessions = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedSessions);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedSessions);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedSessions);
    }
  }

  Future<void> createSession(CreateSessionRequest request) async {
    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.createSession(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedSessions.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedSessions);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedSessions = [];
    state = LoadStateData();
  }
}

class SessionNotifier extends StateNotifier<LoadStateData<AttendanceSession>> {
  final Ref _ref;
  final String sessionId;
  AttendanceSession? _cachedSession;

  SessionNotifier(this._ref, this.sessionId) : super(LoadStateData()) {
    loadSession();
  }

  Future<void> loadSession() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getSession(sessionId);

      if (result.state == LoadState.success) {
        _cachedSession = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedSession);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedSession);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedSession);
    }
  }

  Future<void> updateSession(Map<String, dynamic> updates) async {
    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.updateSession(sessionId, updates);

      if (result.state == LoadState.success && result.data != null) {
        _cachedSession = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedSession);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> closeSession(CloseSessionRequest request) async {
    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.closeSession(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedSession = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedSession);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedSession = null;
    state = LoadStateData();
  }
}

class ActiveSessionsNotifier extends StateNotifier<LoadStateData<List<AttendanceSession>>> {
  final Ref _ref;
  final String hostelId;
  List<AttendanceSession> _cachedActiveSessions = [];

  ActiveSessionsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadActiveSessions();
  }

  Future<void> loadActiveSessions() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getActiveSessions(hostelId);

      if (result.state == LoadState.success) {
        _cachedActiveSessions = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedActiveSessions);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedActiveSessions);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedActiveSessions);
    }
  }

  void clearCache() {
    _cachedActiveSessions = [];
    state = LoadStateData();
  }
}

class SessionEntriesNotifier extends StateNotifier<LoadStateData<List<AttendanceEntry>>> {
  final Ref _ref;
  final String sessionId;
  List<AttendanceEntry> _cachedEntries = [];

  SessionEntriesNotifier(this._ref, this.sessionId) : super(LoadStateData()) {
    loadEntries();
  }

  Future<void> loadEntries() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getSessionEntries(sessionId);

      if (result.state == LoadState.success) {
        _cachedEntries = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedEntries);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedEntries);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedEntries);
    }
  }

  Future<void> addManualEntry(ManualEntryRequest request) async {
    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.addManualEntry(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedEntries.add(result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedEntries);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> scanQRCode(QRScanRequest request) async {
    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.scanQRCode(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedEntries.add(result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedEntries);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedEntries = [];
    state = LoadStateData();
  }
}

class QRCodesNotifier extends StateNotifier<LoadStateData<List<AttendanceQRCode>>> {
  final Ref _ref;
  final String sessionId;
  List<AttendanceQRCode> _cachedQRCodes = [];

  QRCodesNotifier(this._ref, this.sessionId) : super(LoadStateData()) {
    loadQRCodes();
  }

  Future<void> loadQRCodes() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.generateBulkQRCodes(sessionId, []);

      if (result.state == LoadState.success) {
        _cachedQRCodes = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedQRCodes);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedQRCodes);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedQRCodes);
    }
  }

  Future<void> generateQRCode(String studentId) async {
    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.generateQRCode(sessionId, studentId);

      if (result.state == LoadState.success && result.data != null) {
        _cachedQRCodes.add(result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedQRCodes);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedQRCodes = [];
    state = LoadStateData();
  }
}

class SessionSummaryNotifier extends StateNotifier<LoadStateData<AttendanceSummary>> {
  final Ref _ref;
  final String sessionId;
  AttendanceSummary? _cachedSummary;

  SessionSummaryNotifier(this._ref, this.sessionId) : super(LoadStateData()) {
    loadSummary();
  }

  Future<void> loadSummary() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getSessionSummary(sessionId);

      if (result.state == LoadState.success) {
        _cachedSummary = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedSummary);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedSummary);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedSummary);
    }
  }

  void clearCache() {
    _cachedSummary = null;
    state = LoadStateData();
  }
}

class AttendanceStatisticsNotifier extends StateNotifier<LoadStateData<AttendanceStatistics>> {
  final Ref _ref;
  final String hostelId;
  AttendanceStatistics? _cachedStatistics;

  AttendanceStatisticsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadStatistics();
  }

  Future<void> loadStatistics({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getAttendanceStatistics(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedStatistics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedStatistics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedStatistics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedStatistics);
    }
  }

  void clearCache() {
    _cachedStatistics = null;
    state = LoadStateData();
  }
}

class NightAttendanceNotifier extends StateNotifier<LoadStateData<NightAttendanceCalculation>> {
  final Ref _ref;
  final String hostelId;
  NightAttendanceCalculation? _cachedCalculation;

  NightAttendanceNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadNightAttendance();
  }

  Future<void> loadNightAttendance({DateTime? date}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.calculateNightAttendance(hostelId, date ?? DateTime.now());

      if (result.state == LoadState.success) {
        _cachedCalculation = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedCalculation);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedCalculation);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedCalculation);
    }
  }

  void clearCache() {
    _cachedCalculation = null;
    state = LoadStateData();
  }
}

class NightAttendanceHistoryNotifier extends StateNotifier<LoadStateData<List<NightAttendanceCalculation>>> {
  final Ref _ref;
  final String hostelId;
  List<NightAttendanceCalculation> _cachedHistory = [];

  NightAttendanceHistoryNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadHistory();
  }

  Future<void> loadHistory({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getNightAttendanceHistory(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedHistory = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedHistory);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedHistory);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedHistory);
    }
  }

  void clearCache() {
    _cachedHistory = [];
    state = LoadStateData();
  }
}

class StudentAttendanceNotifier extends StateNotifier<LoadStateData<List<AttendanceEntry>>> {
  final Ref _ref;
  final String studentId;
  List<AttendanceEntry> _cachedEntries = [];

  StudentAttendanceNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadAttendance();
  }

  Future<void> loadAttendance({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getStudentAttendance(studentId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedEntries = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedEntries);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedEntries);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedEntries);
    }
  }

  void clearCache() {
    _cachedEntries = [];
    state = LoadStateData();
  }
}

class StudentAttendanceSummaryNotifier extends StateNotifier<LoadStateData<Map<String, dynamic>>> {
  final Ref _ref;
  final String studentId;
  Map<String, dynamic>? _cachedSummary;

  StudentAttendanceSummaryNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadSummary();
  }

  Future<void> loadSummary({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getStudentAttendanceSummary(studentId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedSummary = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedSummary);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedSummary);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedSummary);
    }
  }

  void clearCache() {
    _cachedSummary = null;
    state = LoadStateData();
  }
}

class SessionTemplatesNotifier extends StateNotifier<LoadStateData<List<SessionTemplate>>> {
  final Ref _ref;
  List<SessionTemplate> _cachedTemplates = [];

  SessionTemplatesNotifier(this._ref) : super(LoadStateData()) {
    loadTemplates();
  }

  Future<void> loadTemplates() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getSessionTemplates();

      if (result.state == LoadState.success) {
        _cachedTemplates = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedTemplates);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTemplates);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTemplates);
    }
  }

  void clearCache() {
    _cachedTemplates = [];
    state = LoadStateData();
  }
}

class AdjustmentHistoryNotifier extends StateNotifier<LoadStateData<List<AttendanceEntry>>> {
  final Ref _ref;
  final String sessionId;
  List<AttendanceEntry> _cachedAdjustments = [];

  AdjustmentHistoryNotifier(this._ref, this.sessionId) : super(LoadStateData()) {
    loadAdjustments();
  }

  Future<void> loadAdjustments() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getAdjustmentHistory(sessionId);

      if (result.state == LoadState.success) {
        _cachedAdjustments = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedAdjustments);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAdjustments);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAdjustments);
    }
  }

  void clearCache() {
    _cachedAdjustments = [];
    state = LoadStateData();
  }
}

class DuplicateEntriesNotifier extends StateNotifier<LoadStateData<List<String>>> {
  final Ref _ref;
  final String sessionId;
  List<String> _cachedDuplicates = [];

  DuplicateEntriesNotifier(this._ref, this.sessionId) : super(LoadStateData()) {
    loadDuplicates();
  }

  Future<void> loadDuplicates() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getDuplicateEntries(sessionId);

      if (result.state == LoadState.success) {
        _cachedDuplicates = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedDuplicates);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedDuplicates);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedDuplicates);
    }
  }

  void clearCache() {
    _cachedDuplicates = [];
    state = LoadStateData();
  }
}

class AttendanceTrendsNotifier extends StateNotifier<LoadStateData<List<Map<String, dynamic>>>> {
  final Ref _ref;
  final String hostelId;
  List<Map<String, dynamic>> _cachedTrends = [];

  AttendanceTrendsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadTrends();
  }

  Future<void> loadTrends({int days = 30}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final attendanceService = _ref.read(attendanceServiceProvider);
      final result = await attendanceService.getAttendanceTrends(hostelId, days: days);

      if (result.state == LoadState.success) {
        _cachedTrends = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedTrends);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTrends);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTrends);
    }
  }

  void clearCache() {
    _cachedTrends = [];
    state = LoadStateData();
  }
}