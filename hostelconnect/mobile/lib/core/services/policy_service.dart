// lib/core/services/policy_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/policy_models.dart';
import '../api/policy_api_service.dart';
import '../state/load_state.dart';

final policyServiceProvider = Provider((ref) => PolicyService(ref.read(policyApiServiceProvider)));

class PolicyService {
  final PolicyApiService _apiService;

  PolicyService(this._apiService);

  // Policy CRUD Operations
  Future<LoadStateData<HostelPolicy>> createPolicy(String hostelId, HostelPolicy policy) async {
    try {
      final createdPolicy = await _apiService.createPolicy(hostelId, policy);
      return LoadStateData(state: LoadState.success, data: createdPolicy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<HostelPolicy>>> getPolicies(String hostelId) async {
    try {
      final policies = await _apiService.getPolicies(hostelId);
      return LoadStateData(state: LoadState.success, data: policies);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<HostelPolicy>> getPolicy(String policyId) async {
    try {
      final policy = await _apiService.getPolicy(policyId);
      return LoadStateData(state: LoadState.success, data: policy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<HostelPolicy>> updatePolicy(String policyId, Map<String, dynamic> updates) async {
    try {
      final updatedPolicy = await _apiService.updatePolicy(policyId, updates);
      return LoadStateData(state: LoadState.success, data: updatedPolicy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deletePolicy(String policyId) async {
    try {
      await _apiService.deletePolicy(policyId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> activatePolicy(String policyId) async {
    try {
      await _apiService.activatePolicy(policyId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deactivatePolicy(String policyId) async {
    try {
      await _apiService.deactivatePolicy(policyId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Templates
  Future<LoadStateData<List<PolicyTemplate>>> getPolicyTemplates() async {
    try {
      final templates = await _apiService.getPolicyTemplates();
      return LoadStateData(state: LoadState.success, data: templates);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<HostelPolicy>> createPolicyFromTemplate(
    String hostelId,
    String templateId,
    Map<String, dynamic>? customizations,
  ) async {
    try {
      final policy = await _apiService.createPolicyFromTemplate(hostelId, templateId, customizations);
      return LoadStateData(state: LoadState.success, data: policy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Validation
  Future<LoadStateData<PolicyValidationResult>> validatePolicy(Map<String, dynamic> policyData) async {
    try {
      final result = await _apiService.validatePolicy(policyData);
      return LoadStateData(state: LoadState.success, data: result);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy History
  Future<LoadStateData<List<PolicyChangeHistory>>> getPolicyHistory(String policyId) async {
    try {
      final history = await _apiService.getPolicyHistory(policyId);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<PolicyChangeHistory>>> getHostelPolicyHistory(String hostelId) async {
    try {
      final history = await _apiService.getHostelPolicyHistory(hostelId);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Statistics
  Future<LoadStateData<PolicyStatistics>> getPolicyStatistics(String policyId) async {
    try {
      final statistics = await _apiService.getPolicyStatistics(policyId);
      return LoadStateData(state: LoadState.success, data: statistics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Student Policy Summary
  Future<LoadStateData<PolicySummary>> getStudentPolicySummary(String hostelId) async {
    try {
      final summary = await _apiService.getStudentPolicySummary(hostelId);
      return LoadStateData(state: LoadState.success, data: summary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Warden Read-only Policy Access
  Future<LoadStateData<List<HostelPolicy>>> getWardenPolicies(String hostelId) async {
    try {
      final policies = await _apiService.getWardenPolicies(hostelId);
      return LoadStateData(state: LoadState.success, data: policies);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Specific Policy Types
  Future<LoadStateData<CurfewPolicy>> getCurfewPolicy(String hostelId) async {
    try {
      final policy = await _apiService.getCurfewPolicy(hostelId);
      return LoadStateData(state: LoadState.success, data: policy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendancePolicy>> getAttendancePolicy(String hostelId) async {
    try {
      final policy = await _apiService.getAttendancePolicy(hostelId);
      return LoadStateData(state: LoadState.success, data: policy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealPolicy>> getMealPolicy(String hostelId) async {
    try {
      final policy = await _apiService.getMealPolicy(hostelId);
      return LoadStateData(state: LoadState.success, data: policy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<RoomPolicy>> getRoomPolicy(String hostelId) async {
    try {
      final policy = await _apiService.getRoomPolicy(hostelId);
      return LoadStateData(state: LoadState.success, data: policy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Updates
  Future<LoadStateData<CurfewPolicy>> updateCurfewPolicy(String hostelId, CurfewPolicy policy) async {
    try {
      final updatedPolicy = await _apiService.updateCurfewPolicy(hostelId, policy);
      return LoadStateData(state: LoadState.success, data: updatedPolicy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AttendancePolicy>> updateAttendancePolicy(String hostelId, AttendancePolicy policy) async {
    try {
      final updatedPolicy = await _apiService.updateAttendancePolicy(hostelId, policy);
      return LoadStateData(state: LoadState.success, data: updatedPolicy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealPolicy>> updateMealPolicy(String hostelId, MealPolicy policy) async {
    try {
      final updatedPolicy = await _apiService.updateMealPolicy(hostelId, policy);
      return LoadStateData(state: LoadState.success, data: updatedPolicy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<RoomPolicy>> updateRoomPolicy(String hostelId, RoomPolicy policy) async {
    try {
      final updatedPolicy = await _apiService.updateRoomPolicy(hostelId, policy);
      return LoadStateData(state: LoadState.success, data: updatedPolicy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Bulk Operations
  Future<LoadStateData<List<HostelPolicy>>> bulkUpdatePolicies(
    String hostelId,
    List<Map<String, dynamic>> updates,
  ) async {
    try {
      final policies = await _apiService.bulkUpdatePolicies(hostelId, updates);
      return LoadStateData(state: LoadState.success, data: policies);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> bulkActivatePolicies(String hostelId, List<String> policyIds) async {
    try {
      await _apiService.bulkActivatePolicies(hostelId, policyIds);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> bulkDeactivatePolicies(String hostelId, List<String> policyIds) async {
    try {
      await _apiService.bulkDeactivatePolicies(hostelId, policyIds);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Export/Import
  Future<LoadStateData<String>> exportPolicies(String hostelId) async {
    try {
      final exportData = await _apiService.exportPolicies(hostelId);
      return LoadStateData(state: LoadState.success, data: exportData);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<HostelPolicy>>> importPolicies(String hostelId, String importData) async {
    try {
      final policies = await _apiService.importPolicies(hostelId, importData);
      return LoadStateData(state: LoadState.success, data: policies);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Notifications
  Future<LoadStateData<void>> notifyPolicyChange(String policyId, List<String> targetRoles) async {
    try {
      await _apiService.notifyPolicyChange(policyId, targetRoles);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> schedulePolicyActivation(String policyId, DateTime activationTime) async {
    try {
      await _apiService.schedulePolicyActivation(policyId, activationTime);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Policy Compliance
  Future<LoadStateData<Map<String, dynamic>>> getPolicyCompliance(String hostelId) async {
    try {
      final compliance = await _apiService.getPolicyCompliance(hostelId);
      return LoadStateData(state: LoadState.success, data: compliance);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Map<String, dynamic>>>> getPolicyViolations(
    String hostelId, {
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final violations = await _apiService.getPolicyViolations(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: violations);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Utility Methods
  Future<LoadStateData<List<HostelPolicy>>> getActivePolicies(String hostelId) async {
    try {
      final allPolicies = await _apiService.getPolicies(hostelId);
      final activePolicies = allPolicies.where((policy) => policy.isActive).toList();
      return LoadStateData(state: LoadState.success, data: activePolicies);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<HostelPolicy>>> getPoliciesByType(String hostelId, PolicyType type) async {
    try {
      final allPolicies = await _apiService.getPolicies(hostelId);
      final filteredPolicies = allPolicies.where((policy) => policy.type == type).toList();
      return LoadStateData(state: LoadState.success, data: filteredPolicies);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<PolicyType, HostelPolicy>>> getPoliciesByTypeMap(String hostelId) async {
    try {
      final allPolicies = await _apiService.getPolicies(hostelId);
      final activePolicies = allPolicies.where((policy) => policy.isActive).toList();
      
      final Map<PolicyType, HostelPolicy> policyMap = {};
      for (final policy in activePolicies) {
        policyMap[policy.type] = policy;
      }
      
      return LoadStateData(state: LoadState.success, data: policyMap);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }
}
