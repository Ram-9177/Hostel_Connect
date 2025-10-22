// lib/core/providers/gatepass_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gatepass_models.dart';
import '../services/gatepass_service.dart';
import '../state/load_state.dart';

// Service Provider
final gatepassServiceProvider = Provider((ref) => GatePassService(ref.read(gatepassApiServiceProvider)));

// Gate Pass Providers
final gatepassesProvider = StateNotifierProvider.family<GatePassesNotifier, LoadStateData<List<GatePass>>, String>((ref, hostelId) {
  return GatePassesNotifier(ref, hostelId);
});

final gatepassProvider = StateNotifierProvider.family<GatePassNotifier, LoadStateData<GatePass>, String>((ref, gatePassId) {
  return GatePassNotifier(ref, gatePassId);
});

final studentGatePassesProvider = StateNotifierProvider.family<StudentGatePassesNotifier, LoadStateData<List<GatePass>>, String>((ref, studentId) {
  return StudentGatePassesNotifier(ref, studentId);
});

final pendingApprovalsProvider = StateNotifierProvider.family<PendingApprovalsNotifier, LoadStateData<List<GatePass>>, String>((ref, hostelId) {
  return PendingApprovalsNotifier(ref, hostelId);
});

final activeGatePassesProvider = StateNotifierProvider.family<ActiveGatePassesNotifier, LoadStateData<List<GatePass>>, String>((ref, hostelId) {
  return ActiveGatePassesNotifier(ref, hostelId);
});

final overdueGatePassesProvider = StateNotifierProvider.family<OverdueGatePassesNotifier, LoadStateData<List<GatePass>>, String>((ref, hostelId) {
  return OverdueGatePassesNotifier(ref, hostelId);
});

// Gate Scan Event Providers
final gateScanHistoryProvider = StateNotifierProvider.family<GateScanHistoryNotifier, LoadStateData<List<GateScanEvent>>, String>((ref, hostelId) {
  return GateScanHistoryNotifier(ref, hostelId);
});

final studentScanHistoryProvider = StateNotifierProvider.family<StudentScanHistoryNotifier, LoadStateData<List<GateScanEvent>>, String>((ref, studentId) {
  return StudentScanHistoryNotifier(ref, studentId);
});

final recentScansProvider = StateNotifierProvider.family<RecentScansNotifier, LoadStateData<List<GateScanEvent>>, String>((ref, hostelId) {
  return RecentScansNotifier(ref, hostelId);
});

// Statistics and Dashboard Providers
final gatepassStatisticsProvider = StateNotifierProvider.family<GatePassStatisticsNotifier, LoadStateData<GatePassStatistics>, String>((ref, hostelId) {
  return GatePassStatisticsNotifier(ref, hostelId);
});

final gatepassDashboardProvider = StateNotifierProvider.family<GatePassDashboardNotifier, LoadStateData<GatePassDashboardData>, String>((ref, hostelId) {
  return GatePassDashboardNotifier(ref, hostelId);
});

// Ad Integration Providers
final adIntegrationProvider = StateNotifierProvider.family<AdIntegrationNotifier, LoadStateData<AdIntegration>, String>((ref, gatePassId) {
  return AdIntegrationNotifier(ref, gatePassId);
});

// Emergency Bypass Providers
final emergencyBypassesProvider = StateNotifierProvider.family<EmergencyBypassesNotifier, LoadStateData<List<GatePass>>, String>((ref, hostelId) {
  return EmergencyBypassesNotifier(ref, hostelId);
});

final emergencyBypassStatsProvider = StateNotifierProvider.family<EmergencyBypassStatsNotifier, LoadStateData<Map<String, dynamic>>, String>((ref, hostelId) {
  return EmergencyBypassStatsNotifier(ref, hostelId);
});

// History Providers
final gatepassHistoryProvider = StateNotifierProvider.family<GatePassHistoryNotifier, LoadStateData<List<GatePassHistory>>, String>((ref, gatePassId) {
  return GatePassHistoryNotifier(ref, gatePassId);
});

final hostelGatePassHistoryProvider = StateNotifierProvider.family<HostelGatePassHistoryNotifier, LoadStateData<List<GatePassHistory>>, String>((ref, hostelId) {
  return HostelGatePassHistoryNotifier(ref, hostelId);
});

// Analytics Providers
final gatepassAnalyticsProvider = StateNotifierProvider.family<GatePassAnalyticsNotifier, LoadStateData<Map<String, dynamic>>, String>((ref, hostelId) {
  return GatePassAnalyticsNotifier(ref, hostelId);
});

final gatepassTrendsProvider = StateNotifierProvider.family<GatePassTrendsNotifier, LoadStateData<List<Map<String, dynamic>>>, String>((ref, hostelId) {
  return GatePassTrendsNotifier(ref, hostelId);
});

final adAnalyticsProvider = StateNotifierProvider.family<AdAnalyticsNotifier, LoadStateData<Map<String, dynamic>>, String>((ref, hostelId) {
  return AdAnalyticsNotifier(ref, hostelId);
});

// Templates Provider
final gatepassTemplatesProvider = StateNotifierProvider<GatePassTemplatesNotifier, LoadStateData<List<Map<String, dynamic>>>>((ref) {
  return GatePassTemplatesNotifier(ref);
});

// Notifier Classes

class GatePassesNotifier extends StateNotifier<LoadStateData<List<GatePass>>> {
  final Ref _ref;
  final String hostelId;
  List<GatePass> _cachedGatePasses = [];

  GatePassesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadGatePasses();
  }

  Future<void> loadGatePasses({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGatePasses(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedGatePasses = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedGatePasses);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedGatePasses);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedGatePasses);
    }
  }

  Future<void> createGatePassRequest(GatePassRequest request) async {
    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.createGatePassRequest(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedGatePasses.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedGatePasses);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedGatePasses = [];
    state = LoadStateData();
  }
}

class GatePassNotifier extends StateNotifier<LoadStateData<GatePass>> {
  final Ref _ref;
  final String gatePassId;
  GatePass? _cachedGatePass;

  GatePassNotifier(this._ref, this.gatePassId) : super(LoadStateData()) {
    loadGatePass();
  }

  Future<void> loadGatePass() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGatePass(gatePassId);

      if (result.state == LoadState.success) {
        _cachedGatePass = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedGatePass);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedGatePass);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedGatePass);
    }
  }

  Future<void> updateGatePass(Map<String, dynamic> updates) async {
    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.updateGatePass(gatePassId, updates);

      if (result.state == LoadState.success && result.data != null) {
        _cachedGatePass = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedGatePass);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> approveGatePass(GatePassApprovalRequest request) async {
    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.approveGatePass(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedGatePass = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedGatePass);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> rejectGatePass(String reason) async {
    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.rejectGatePass(gatePassId, reason);

      if (result.state == LoadState.success && result.data != null) {
        _cachedGatePass = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedGatePass);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedGatePass = null;
    state = LoadStateData();
  }
}

class StudentGatePassesNotifier extends StateNotifier<LoadStateData<List<GatePass>>> {
  final Ref _ref;
  final String studentId;
  List<GatePass> _cachedGatePasses = [];

  StudentGatePassesNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadStudentGatePasses();
  }

  Future<void> loadStudentGatePasses({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getStudentGatePasses(studentId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedGatePasses = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedGatePasses);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedGatePasses);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedGatePasses);
    }
  }

  void clearCache() {
    _cachedGatePasses = [];
    state = LoadStateData();
  }
}

class PendingApprovalsNotifier extends StateNotifier<LoadStateData<List<GatePass>>> {
  final Ref _ref;
  final String hostelId;
  List<GatePass> _cachedPendingApprovals = [];

  PendingApprovalsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadPendingApprovals();
  }

  Future<void> loadPendingApprovals() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getPendingApprovals(hostelId);

      if (result.state == LoadState.success) {
        _cachedPendingApprovals = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedPendingApprovals);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPendingApprovals);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPendingApprovals);
    }
  }

  void clearCache() {
    _cachedPendingApprovals = [];
    state = LoadStateData();
  }
}

class ActiveGatePassesNotifier extends StateNotifier<LoadStateData<List<GatePass>>> {
  final Ref _ref;
  final String hostelId;
  List<GatePass> _cachedActiveGatePasses = [];

  ActiveGatePassesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadActiveGatePasses();
  }

  Future<void> loadActiveGatePasses() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getActiveGatePasses(hostelId);

      if (result.state == LoadState.success) {
        _cachedActiveGatePasses = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedActiveGatePasses);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedActiveGatePasses);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedActiveGatePasses);
    }
  }

  void clearCache() {
    _cachedActiveGatePasses = [];
    state = LoadStateData();
  }
}

class OverdueGatePassesNotifier extends StateNotifier<LoadStateData<List<GatePass>>> {
  final Ref _ref;
  final String hostelId;
  List<GatePass> _cachedOverdueGatePasses = [];

  OverdueGatePassesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadOverdueGatePasses();
  }

  Future<void> loadOverdueGatePasses() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getOverdueGatePasses(hostelId);

      if (result.state == LoadState.success) {
        _cachedOverdueGatePasses = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedOverdueGatePasses);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedOverdueGatePasses);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedOverdueGatePasses);
    }
  }

  void clearCache() {
    _cachedOverdueGatePasses = [];
    state = LoadStateData();
  }
}

class GateScanHistoryNotifier extends StateNotifier<LoadStateData<List<GateScanEvent>>> {
  final Ref _ref;
  final String hostelId;
  List<GateScanEvent> _cachedScanHistory = [];

  GateScanHistoryNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadScanHistory();
  }

  Future<void> loadScanHistory({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGateScanHistory(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedScanHistory = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedScanHistory);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedScanHistory);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedScanHistory);
    }
  }

  Future<void> recordGateScan(GateScanEvent scanEvent) async {
    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.recordGateScan(scanEvent);

      if (result.state == LoadState.success && result.data != null) {
        _cachedScanHistory.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedScanHistory);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedScanHistory = [];
    state = LoadStateData();
  }
}

class StudentScanHistoryNotifier extends StateNotifier<LoadStateData<List<GateScanEvent>>> {
  final Ref _ref;
  final String studentId;
  List<GateScanEvent> _cachedScanHistory = [];

  StudentScanHistoryNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadStudentScanHistory();
  }

  Future<void> loadStudentScanHistory({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getStudentScanHistory(studentId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedScanHistory = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedScanHistory);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedScanHistory);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedScanHistory);
    }
  }

  void clearCache() {
    _cachedScanHistory = [];
    state = LoadStateData();
  }
}

class RecentScansNotifier extends StateNotifier<LoadStateData<List<GateScanEvent>>> {
  final Ref _ref;
  final String hostelId;
  List<GateScanEvent> _cachedRecentScans = [];

  RecentScansNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadRecentScans();
  }

  Future<void> loadRecentScans({int limit = 50}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getRecentScans(hostelId, limit: limit);

      if (result.state == LoadState.success) {
        _cachedRecentScans = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedRecentScans);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedRecentScans);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedRecentScans);
    }
  }

  void clearCache() {
    _cachedRecentScans = [];
    state = LoadStateData();
  }
}

class GatePassStatisticsNotifier extends StateNotifier<LoadStateData<GatePassStatistics>> {
  final Ref _ref;
  final String hostelId;
  GatePassStatistics? _cachedStatistics;

  GatePassStatisticsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadStatistics();
  }

  Future<void> loadStatistics({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGatePassStatistics(hostelId, from: from, to: to);

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

class GatePassDashboardNotifier extends StateNotifier<LoadStateData<GatePassDashboardData>> {
  final Ref _ref;
  final String hostelId;
  GatePassDashboardData? _cachedDashboardData;

  GatePassDashboardNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getDashboardData(hostelId);

      if (result.state == LoadState.success) {
        _cachedDashboardData = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedDashboardData);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedDashboardData);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedDashboardData);
    }
  }

  void clearCache() {
    _cachedDashboardData = null;
    state = LoadStateData();
  }
}

class AdIntegrationNotifier extends StateNotifier<LoadStateData<AdIntegration>> {
  final Ref _ref;
  final String gatePassId;
  AdIntegration? _cachedAdIntegration;

  AdIntegrationNotifier(this._ref, this.gatePassId) : super(LoadStateData()) {
    loadAdIntegration();
  }

  Future<void> loadAdIntegration() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.checkAdCompletion(gatePassId);

      if (result.state == LoadState.success) {
        // Create mock AdIntegration based on completion status
        _cachedAdIntegration = AdIntegration(
          adId: 'ad_$gatePassId',
          adType: 'interstitial',
          durationSeconds: 20,
          isCompleted: result.data ?? false,
          completedAt: result.data == true ? DateTime.now() : null,
        );
        state = LoadStateData(state: LoadState.success, data: _cachedAdIntegration);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAdIntegration);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAdIntegration);
    }
  }

  Future<void> startAd(String adType) async {
    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.startAd(gatePassId, adType);

      if (result.state == LoadState.success && result.data != null) {
        _cachedAdIntegration = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAdIntegration);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> completeAd(String adId) async {
    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.completeAd(gatePassId, adId);

      if (result.state == LoadState.success && result.data != null) {
        _cachedAdIntegration = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAdIntegration);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedAdIntegration = null;
    state = LoadStateData();
  }
}

class EmergencyBypassesNotifier extends StateNotifier<LoadStateData<List<GatePass>>> {
  final Ref _ref;
  final String hostelId;
  List<GatePass> _cachedEmergencyBypasses = [];

  EmergencyBypassesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadEmergencyBypasses();
  }

  Future<void> loadEmergencyBypasses({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getEmergencyBypasses(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedEmergencyBypasses = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedEmergencyBypasses);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedEmergencyBypasses);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedEmergencyBypasses);
    }
  }

  void clearCache() {
    _cachedEmergencyBypasses = [];
    state = LoadStateData();
  }
}

class EmergencyBypassStatsNotifier extends StateNotifier<LoadStateData<Map<String, dynamic>>> {
  final Ref _ref;
  final String hostelId;
  Map<String, dynamic>? _cachedStats;

  EmergencyBypassStatsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadEmergencyBypassStats();
  }

  Future<void> loadEmergencyBypassStats() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getEmergencyBypassStatistics(hostelId);

      if (result.state == LoadState.success) {
        _cachedStats = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedStats);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedStats);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedStats);
    }
  }

  void clearCache() {
    _cachedStats = null;
    state = LoadStateData();
  }
}

class GatePassHistoryNotifier extends StateNotifier<LoadStateData<List<GatePassHistory>>> {
  final Ref _ref;
  final String gatePassId;
  List<GatePassHistory> _cachedHistory = [];

  GatePassHistoryNotifier(this._ref, this.gatePassId) : super(LoadStateData()) {
    loadGatePassHistory();
  }

  Future<void> loadGatePassHistory() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGatePassHistory(gatePassId);

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

class HostelGatePassHistoryNotifier extends StateNotifier<LoadStateData<List<GatePassHistory>>> {
  final Ref _ref;
  final String hostelId;
  List<GatePassHistory> _cachedHistory = [];

  HostelGatePassHistoryNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadHostelGatePassHistory();
  }

  Future<void> loadHostelGatePassHistory({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getHostelGatePassHistory(hostelId, from: from, to: to);

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

class GatePassAnalyticsNotifier extends StateNotifier<LoadStateData<Map<String, dynamic>>> {
  final Ref _ref;
  final String hostelId;
  Map<String, dynamic>? _cachedAnalytics;

  GatePassAnalyticsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGatePassAnalytics(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class GatePassTrendsNotifier extends StateNotifier<LoadStateData<List<Map<String, dynamic>>>> {
  final Ref _ref;
  final String hostelId;
  List<Map<String, dynamic>> _cachedTrends = [];

  GatePassTrendsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadTrends();
  }

  Future<void> loadTrends({int days = 30}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGatePassTrends(hostelId, days: days);

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

class AdAnalyticsNotifier extends StateNotifier<LoadStateData<Map<String, dynamic>>> {
  final Ref _ref;
  final String hostelId;
  Map<String, dynamic>? _cachedAdAnalytics;

  AdAnalyticsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadAdAnalytics();
  }

  Future<void> loadAdAnalytics({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getAdAnalytics(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedAdAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAdAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAdAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAdAnalytics);
    }
  }

  void clearCache() {
    _cachedAdAnalytics = null;
    state = LoadStateData();
  }
}

class GatePassTemplatesNotifier extends StateNotifier<LoadStateData<List<Map<String, dynamic>>>> {
  final Ref _ref;
  List<Map<String, dynamic>> _cachedTemplates = [];

  GatePassTemplatesNotifier(this._ref) : super(LoadStateData()) {
    loadTemplates();
  }

  Future<void> loadTemplates() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final gatepassService = _ref.read(gatepassServiceProvider);
      final result = await gatepassService.getGatePassTemplates();

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