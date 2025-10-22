// lib/core/services/gatepass_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gatepass_models.dart';
import '../api/gatepass_api_service.dart';
import '../state/load_state.dart';

final gatepassServiceProvider = Provider((ref) => GatePassService(ref.read(gatepassApiServiceProvider)));

class GatePassService {
  final GatePassApiService _apiService;

  GatePassService(this._apiService);

  // Gate Pass CRUD Operations
  Future<LoadStateData<GatePass>> createGatePassRequest(GatePassRequest request) async {
    try {
      final gatePass = await _apiService.createGatePassRequest(request);
      return LoadStateData(state: LoadState.success, data: gatePass);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<GatePass>> getGatePass(String gatePassId) async {
    try {
      final gatePass = await _apiService.getGatePass(gatePassId);
      return LoadStateData(state: LoadState.success, data: gatePass);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> getGatePasses(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final gatePasses = await _apiService.getGatePasses(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: gatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> getStudentGatePasses(String studentId, {DateTime? from, DateTime? to}) async {
    try {
      final gatePasses = await _apiService.getStudentGatePasses(studentId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: gatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<GatePass>> updateGatePass(String gatePassId, Map<String, dynamic> updates) async {
    try {
      final gatePass = await _apiService.updateGatePass(gatePassId, updates);
      return LoadStateData(state: LoadState.success, data: gatePass);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> cancelGatePass(String gatePassId, String reason) async {
    try {
      await _apiService.cancelGatePass(gatePassId, reason);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Gate Pass Approval
  Future<LoadStateData<GatePass>> approveGatePass(GatePassApprovalRequest request) async {
    try {
      final gatePass = await _apiService.approveGatePass(request);
      return LoadStateData(state: LoadState.success, data: gatePass);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<GatePass>> rejectGatePass(String gatePassId, String reason) async {
    try {
      final gatePass = await _apiService.rejectGatePass(gatePassId, reason);
      return LoadStateData(state: LoadState.success, data: gatePass);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> getPendingApprovals(String hostelId) async {
    try {
      final gatePasses = await _apiService.getPendingApprovals(hostelId);
      return LoadStateData(state: LoadState.success, data: gatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // QR Code Management
  Future<LoadStateData<GatePass>> generateQRCode(QRGenerationRequest request) async {
    try {
      final gatePass = await _apiService.generateQRCode(request);
      return LoadStateData(state: LoadState.success, data: gatePass);
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

  Future<LoadStateData<GatePass>> getGatePassByQR(String qrCode) async {
    try {
      final gatePass = await _apiService.getGatePassByQR(qrCode);
      return LoadStateData(state: LoadState.success, data: gatePass);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Ad Integration
  Future<LoadStateData<AdIntegration>> startAd(String gatePassId, String adType) async {
    try {
      final adIntegration = await _apiService.startAd(gatePassId, adType);
      return LoadStateData(state: LoadState.success, data: adIntegration);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AdIntegration>> completeAd(String gatePassId, String adId) async {
    try {
      final adIntegration = await _apiService.completeAd(gatePassId, adId);
      return LoadStateData(state: LoadState.success, data: adIntegration);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<bool>> checkAdCompletion(String gatePassId) async {
    try {
      final isCompleted = await _apiService.checkAdCompletion(gatePassId);
      return LoadStateData(state: LoadState.success, data: isCompleted);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<GatePass>> emergencyBypassAd(EmergencyBypassRequest request) async {
    try {
      final gatePass = await _apiService.emergencyBypassAd(request);
      return LoadStateData(state: LoadState.success, data: gatePass);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Gate Scan Events
  Future<LoadStateData<GateScanEvent>> recordGateScan(GateScanEvent scanEvent) async {
    try {
      final recordedEvent = await _apiService.recordGateScan(scanEvent);
      return LoadStateData(state: LoadState.success, data: recordedEvent);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GateScanEvent>>> getGateScanHistory(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final scanHistory = await _apiService.getGateScanHistory(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: scanHistory);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GateScanEvent>>> getStudentScanHistory(String studentId, {DateTime? from, DateTime? to}) async {
    try {
      final scanHistory = await _apiService.getStudentScanHistory(studentId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: scanHistory);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GateScanEvent>>> getRecentScans(String hostelId, {int limit = 50}) async {
    try {
      final recentScans = await _apiService.getRecentScans(hostelId, limit: limit);
      return LoadStateData(state: LoadState.success, data: recentScans);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Gate Pass Statistics
  Future<LoadStateData<GatePassStatistics>> getGatePassStatistics(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final statistics = await _apiService.getGatePassStatistics(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: statistics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<GatePassDashboardData>> getDashboardData(String hostelId) async {
    try {
      final dashboardData = await _apiService.getDashboardData(hostelId);
      return LoadStateData(state: LoadState.success, data: dashboardData);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Gate Pass History
  Future<LoadStateData<List<GatePassHistory>>> getGatePassHistory(String gatePassId) async {
    try {
      final history = await _apiService.getGatePassHistory(gatePassId);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePassHistory>>> getHostelGatePassHistory(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final history = await _apiService.getHostelGatePassHistory(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Emergency Operations
  Future<LoadStateData<List<GatePass>>> getEmergencyBypasses(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final emergencyBypasses = await _apiService.getEmergencyBypasses(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: emergencyBypasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getEmergencyBypassStatistics(String hostelId) async {
    try {
      final statistics = await _apiService.getEmergencyBypassStatistics(hostelId);
      return LoadStateData(state: LoadState.success, data: statistics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Bulk Operations
  Future<LoadStateData<List<GatePass>>> bulkApproveGatePasses(List<String> gatePassIds, String approvedBy) async {
    try {
      final approvedGatePasses = await _apiService.bulkApproveGatePasses(gatePassIds, approvedBy);
      return LoadStateData(state: LoadState.success, data: approvedGatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> bulkRejectGatePasses(List<String> gatePassIds, String reason, String rejectedBy) async {
    try {
      final rejectedGatePasses = await _apiService.bulkRejectGatePasses(gatePassIds, reason, rejectedBy);
      return LoadStateData(state: LoadState.success, data: rejectedGatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Notifications
  Future<LoadStateData<void>> sendGatePassNotification(String gatePassId, String message, List<String> targetRoles) async {
    try {
      await _apiService.sendGatePassNotification(gatePassId, message, targetRoles);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> sendOverdueNotification(String hostelId) async {
    try {
      await _apiService.sendOverdueNotification(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Export/Import
  Future<LoadStateData<String>> exportGatePassData(String hostelId, String format, {DateTime? from, DateTime? to}) async {
    try {
      final exportUrl = await _apiService.exportGatePassData(hostelId, format, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: exportUrl);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> importGatePassData(String hostelId, List<Map<String, dynamic>> data) async {
    try {
      final gatePasses = await _apiService.importGatePassData(hostelId, data);
      return LoadStateData(state: LoadState.success, data: gatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Real-time Updates
  Future<LoadStateData<void>> subscribeToGatePassUpdates(String hostelId) async {
    try {
      await _apiService.subscribeToGatePassUpdates(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> unsubscribeFromGatePassUpdates(String hostelId) async {
    try {
      await _apiService.unsubscribeFromGatePassUpdates(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Gate Pass Templates
  Future<LoadStateData<List<Map<String, dynamic>>>> getGatePassTemplates() async {
    try {
      final templates = await _apiService.getGatePassTemplates();
      return LoadStateData(state: LoadState.success, data: templates);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> createGatePassTemplate(Map<String, dynamic> template) async {
    try {
      final createdTemplate = await _apiService.createGatePassTemplate(template);
      return LoadStateData(state: LoadState.success, data: createdTemplate);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Analytics and Reporting
  Future<LoadStateData<Map<String, dynamic>>> getGatePassAnalytics(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final analytics = await _apiService.getGatePassAnalytics(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Map<String, dynamic>>>> getGatePassTrends(String hostelId, {int days = 30}) async {
    try {
      final trends = await _apiService.getGatePassTrends(hostelId, days: days);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getAdAnalytics(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final analytics = await _apiService.getAdAnalytics(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Validation and Checks
  Future<LoadStateData<bool>> checkGatePassEligibility(String studentId) async {
    try {
      final isEligible = await _apiService.checkGatePassEligibility(studentId);
      return LoadStateData(state: LoadState.success, data: isEligible);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> validateGatePassRequest(GatePassRequest request) async {
    try {
      final validation = await _apiService.validateGatePassRequest(request);
      return LoadStateData(state: LoadState.success, data: validation);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<String>>> getGatePassViolations(String studentId) async {
    try {
      final violations = await _apiService.getGatePassViolations(studentId);
      return LoadStateData(state: LoadState.success, data: violations);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Utility Methods
  Future<LoadStateData<List<GatePass>>> getActiveGatePasses(String hostelId) async {
    try {
      final allGatePasses = await _apiService.getGatePasses(hostelId);
      final activeGatePasses = allGatePasses.where((gp) => gp.isActive).toList();
      return LoadStateData(state: LoadState.success, data: activeGatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> getOverdueGatePasses(String hostelId) async {
    try {
      final allGatePasses = await _apiService.getGatePasses(hostelId);
      final overdueGatePasses = allGatePasses.where((gp) => gp.isOverdueNow).toList();
      return LoadStateData(state: LoadState.success, data: overdueGatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> getGatePassesByType(String hostelId, GatePassType type) async {
    try {
      final allGatePasses = await _apiService.getGatePasses(hostelId);
      final filteredGatePasses = allGatePasses.where((gp) => gp.type == type).toList();
      return LoadStateData(state: LoadState.success, data: filteredGatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePass>>> getGatePassesByStatus(String hostelId, GatePassStatus status) async {
    try {
      final allGatePasses = await _apiService.getGatePasses(hostelId);
      final filteredGatePasses = allGatePasses.where((gp) => gp.status == status).toList();
      return LoadStateData(state: LoadState.success, data: filteredGatePasses);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }
}
