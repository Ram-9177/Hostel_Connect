// lib/core/providers/policy_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/policy_models.dart';
import '../services/policy_service.dart';
import '../state/load_state.dart';

// Policy Service Provider
final policyServiceProvider = Provider((ref) => PolicyService(ref.read(policyApiServiceProvider)));

// Hostel Policies Provider
final hostelPoliciesProvider = StateNotifierProvider.family<HostelPoliciesNotifier, LoadStateData<List<HostelPolicy>>, String>((ref, hostelId) {
  return HostelPoliciesNotifier(ref, hostelId);
});

// Single Policy Provider
final policyProvider = StateNotifierProvider.family<PolicyNotifier, LoadStateData<HostelPolicy>, String>((ref, policyId) {
  return PolicyNotifier(ref, policyId);
});

// Policy Templates Provider
final policyTemplatesProvider = StateNotifierProvider<PolicyTemplatesNotifier, LoadStateData<List<PolicyTemplate>>>((ref) {
  return PolicyTemplatesNotifier(ref);
});

// Policy History Provider
final policyHistoryProvider = StateNotifierProvider.family<PolicyHistoryNotifier, LoadStateData<List<PolicyChangeHistory>>, String>((ref, hostelId) {
  return PolicyHistoryNotifier(ref, hostelId);
});

// Policy Statistics Provider
final policyStatisticsProvider = StateNotifierProvider.family<PolicyStatisticsNotifier, LoadStateData<PolicyStatistics>, String>((ref, policyId) {
  return PolicyStatisticsNotifier(ref, policyId);
});

// Student Policy Summary Provider
final studentPolicySummaryProvider = StateNotifierProvider.family<StudentPolicySummaryNotifier, LoadStateData<PolicySummary>, String>((ref, hostelId) {
  return StudentPolicySummaryNotifier(ref, hostelId);
});

// Warden Policies Provider (Read-only)
final wardenPoliciesProvider = StateNotifierProvider.family<WardenPoliciesNotifier, LoadStateData<List<HostelPolicy>>, String>((ref, hostelId) {
  return WardenPoliciesNotifier(ref, hostelId);
});

// Specific Policy Type Providers
final curfewPolicyProvider = StateNotifierProvider.family<CurfewPolicyNotifier, LoadStateData<CurfewPolicy>, String>((ref, hostelId) {
  return CurfewPolicyNotifier(ref, hostelId);
});

final attendancePolicyProvider = StateNotifierProvider.family<AttendancePolicyNotifier, LoadStateData<AttendancePolicy>, String>((ref, hostelId) {
  return AttendancePolicyNotifier(ref, hostelId);
});

final mealPolicyProvider = StateNotifierProvider.family<MealPolicyNotifier, LoadStateData<MealPolicy>, String>((ref, hostelId) {
  return MealPolicyNotifier(ref, hostelId);
});

final roomPolicyProvider = StateNotifierProvider.family<RoomPolicyNotifier, LoadStateData<RoomPolicy>, String>((ref, hostelId) {
  return RoomPolicyNotifier(ref, hostelId);
});

// Policy Compliance Provider
final policyComplianceProvider = StateNotifierProvider.family<PolicyComplianceNotifier, LoadStateData<Map<String, dynamic>>, String>((ref, hostelId) {
  return PolicyComplianceNotifier(ref, hostelId);
});

// Policy Violations Provider
final policyViolationsProvider = StateNotifierProvider.family<PolicyViolationsNotifier, LoadStateData<List<Map<String, dynamic>>>, String>((ref, hostelId) {
  return PolicyViolationsNotifier(ref, hostelId);
});

// Notifier Classes

class HostelPoliciesNotifier extends StateNotifier<LoadStateData<List<HostelPolicy>>> {
  final Ref _ref;
  final String hostelId;
  List<HostelPolicy> _cachedPolicies = [];

  HostelPoliciesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadPolicies();
  }

  Future<void> loadPolicies() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getPolicies(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedPolicies = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedPolicies);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicies);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicies);
    }
  }

  Future<void> createPolicy(HostelPolicy policy) async {
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.createPolicy(hostelId, policy);
      
      if (result.state == LoadState.success) {
        _cachedPolicies.add(result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedPolicies);
      } else {
        Toast.showError('Failed to create policy: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error creating policy: $e');
    }
  }

  Future<void> updatePolicy(String policyId, Map<String, dynamic> updates) async {
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.updatePolicy(policyId, updates);
      
      if (result.state == LoadState.success) {
        final index = _cachedPolicies.indexWhere((p) => p.id == policyId);
        if (index != -1) {
          _cachedPolicies[index] = result.data!;
          state = LoadStateData(state: LoadState.success, data: _cachedPolicies);
        }
      } else {
        Toast.showError('Failed to update policy: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error updating policy: $e');
    }
  }

  Future<void> deletePolicy(String policyId) async {
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.deletePolicy(policyId);
      
      if (result.state == LoadState.success) {
        _cachedPolicies.removeWhere((p) => p.id == policyId);
        state = LoadStateData(state: LoadState.success, data: _cachedPolicies);
      } else {
        Toast.showError('Failed to delete policy: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error deleting policy: $e');
    }
  }

  Future<void> togglePolicyStatus(String policyId) async {
    try {
      final policy = _cachedPolicies.firstWhere((p) => p.id == policyId);
      final policyService = _ref.read(policyServiceProvider);
      
      final result = policy.isActive 
          ? await policyService.deactivatePolicy(policyId)
          : await policyService.activatePolicy(policyId);
      
      if (result.state == LoadState.success) {
        final index = _cachedPolicies.indexWhere((p) => p.id == policyId);
        if (index != -1) {
          _cachedPolicies[index] = _cachedPolicies[index].copyWith(isActive: !policy.isActive);
          state = LoadStateData(state: LoadState.success, data: _cachedPolicies);
        }
      } else {
        Toast.showError('Failed to toggle policy status: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error toggling policy status: $e');
    }
  }

  void clearCache() {
    _cachedPolicies = [];
    state = LoadStateData();
  }
}

class PolicyNotifier extends StateNotifier<LoadStateData<HostelPolicy>> {
  final Ref _ref;
  final String policyId;
  HostelPolicy? _cachedPolicy;

  PolicyNotifier(this._ref, this.policyId) : super(LoadStateData()) {
    loadPolicy();
  }

  Future<void> loadPolicy() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getPolicy(policyId);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicy);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicy);
    }
  }

  void clearCache() {
    _cachedPolicy = null;
    state = LoadStateData();
  }
}

class PolicyTemplatesNotifier extends StateNotifier<LoadStateData<List<PolicyTemplate>>> {
  final Ref _ref;
  List<PolicyTemplate> _cachedTemplates = [];

  PolicyTemplatesNotifier(this._ref) : super(LoadStateData()) {
    loadTemplates();
  }

  Future<void> loadTemplates() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getPolicyTemplates();
      
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

class PolicyHistoryNotifier extends StateNotifier<LoadStateData<List<PolicyChangeHistory>>> {
  final Ref _ref;
  final String hostelId;
  List<PolicyChangeHistory> _cachedHistory = [];

  PolicyHistoryNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getHostelPolicyHistory(hostelId);
      
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

class PolicyStatisticsNotifier extends StateNotifier<LoadStateData<PolicyStatistics>> {
  final Ref _ref;
  final String policyId;
  PolicyStatistics? _cachedStatistics;

  PolicyStatisticsNotifier(this._ref, this.policyId) : super(LoadStateData()) {
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getPolicyStatistics(policyId);
      
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

class StudentPolicySummaryNotifier extends StateNotifier<LoadStateData<PolicySummary>> {
  final Ref _ref;
  final String hostelId;
  PolicySummary? _cachedSummary;

  StudentPolicySummaryNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadSummary();
  }

  Future<void> loadSummary() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getStudentPolicySummary(hostelId);
      
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

class WardenPoliciesNotifier extends StateNotifier<LoadStateData<List<HostelPolicy>>> {
  final Ref _ref;
  final String hostelId;
  List<HostelPolicy> _cachedPolicies = [];

  WardenPoliciesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadPolicies();
  }

  Future<void> loadPolicies() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getWardenPolicies(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedPolicies = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedPolicies);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicies);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicies);
    }
  }

  void clearCache() {
    _cachedPolicies = [];
    state = LoadStateData();
  }
}

// Specific Policy Type Notifiers
class CurfewPolicyNotifier extends StateNotifier<LoadStateData<CurfewPolicy>> {
  final Ref _ref;
  final String hostelId;
  CurfewPolicy? _cachedPolicy;

  CurfewPolicyNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadPolicy();
  }

  Future<void> loadPolicy() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getCurfewPolicy(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicy);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicy);
    }
  }

  Future<void> updatePolicy(CurfewPolicy policy) async {
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.updateCurfewPolicy(hostelId, policy);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        Toast.showError('Failed to update curfew policy: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error updating curfew policy: $e');
    }
  }

  void clearCache() {
    _cachedPolicy = null;
    state = LoadStateData();
  }
}

class AttendancePolicyNotifier extends StateNotifier<LoadStateData<AttendancePolicy>> {
  final Ref _ref;
  final String hostelId;
  AttendancePolicy? _cachedPolicy;

  AttendancePolicyNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadPolicy();
  }

  Future<void> loadPolicy() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getAttendancePolicy(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicy);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicy);
    }
  }

  Future<void> updatePolicy(AttendancePolicy policy) async {
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.updateAttendancePolicy(hostelId, policy);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        Toast.showError('Failed to update attendance policy: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error updating attendance policy: $e');
    }
  }

  void clearCache() {
    _cachedPolicy = null;
    state = LoadStateData();
  }
}

class MealPolicyNotifier extends StateNotifier<LoadStateData<MealPolicy>> {
  final Ref _ref;
  final String hostelId;
  MealPolicy? _cachedPolicy;

  MealPolicyNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadPolicy();
  }

  Future<void> loadPolicy() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getMealPolicy(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicy);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicy);
    }
  }

  Future<void> updatePolicy(MealPolicy policy) async {
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.updateMealPolicy(hostelId, policy);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        Toast.showError('Failed to update meal policy: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error updating meal policy: $e');
    }
  }

  void clearCache() {
    _cachedPolicy = null;
    state = LoadStateData();
  }
}

class RoomPolicyNotifier extends StateNotifier<LoadStateData<RoomPolicy>> {
  final Ref _ref;
  final String hostelId;
  RoomPolicy? _cachedPolicy;

  RoomPolicyNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadPolicy();
  }

  Future<void> loadPolicy() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getRoomPolicy(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicy);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicy);
    }
  }

  Future<void> updatePolicy(RoomPolicy policy) async {
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.updateRoomPolicy(hostelId, policy);
      
      if (result.state == LoadState.success) {
        _cachedPolicy = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedPolicy);
      } else {
        Toast.showError('Failed to update room policy: ${result.error}');
      }
    } catch (e) {
      Toast.showError('Error updating room policy: $e');
    }
  }

  void clearCache() {
    _cachedPolicy = null;
    state = LoadStateData();
  }
}

class PolicyComplianceNotifier extends StateNotifier<LoadStateData<Map<String, dynamic>>> {
  final Ref _ref;
  final String hostelId;
  Map<String, dynamic> _cachedCompliance = {};

  PolicyComplianceNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadCompliance();
  }

  Future<void> loadCompliance() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getPolicyCompliance(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedCompliance = result.data ?? {};
        state = LoadStateData(state: LoadState.success, data: _cachedCompliance);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedCompliance);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedCompliance);
    }
  }

  void clearCache() {
    _cachedCompliance = {};
    state = LoadStateData();
  }
}

class PolicyViolationsNotifier extends StateNotifier<LoadStateData<List<Map<String, dynamic>>>> {
  final Ref _ref;
  final String hostelId;
  List<Map<String, dynamic>> _cachedViolations = [];

  PolicyViolationsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadViolations();
  }

  Future<void> loadViolations({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final policyService = _ref.read(policyServiceProvider);
      final result = await policyService.getPolicyViolations(hostelId, from: from, to: to);
      
      if (result.state == LoadState.success) {
        _cachedViolations = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedViolations);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedViolations);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedViolations);
    }
  }

  void clearCache() {
    _cachedViolations = [];
    state = LoadStateData();
  }
}
