// lib/core/api/policy_api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../models/policy_models.dart';

final policyApiServiceProvider = Provider((ref) => PolicyApiService(ref.read(dioProvider)));

class PolicyApiService {
  final Dio _dio;

  PolicyApiService(this._dio);

  // Policy CRUD Operations
  Future<HostelPolicy> createPolicy(String hostelId, HostelPolicy policy) async {
    final response = await _dio.post('/hostels/$hostelId/policies', data: policy.toJson());
    return HostelPolicy.fromJson(response.data);
  }

  Future<List<HostelPolicy>> getPolicies(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies');
    return (response.data as List).map((json) => HostelPolicy.fromJson(json)).toList();
  }

  Future<HostelPolicy> getPolicy(String policyId) async {
    final response = await _dio.get('/policies/$policyId');
    return HostelPolicy.fromJson(response.data);
  }

  Future<HostelPolicy> updatePolicy(String policyId, Map<String, dynamic> updates) async {
    final response = await _dio.put('/policies/$policyId', data: updates);
    return HostelPolicy.fromJson(response.data);
  }

  Future<void> deletePolicy(String policyId) async {
    await _dio.delete('/policies/$policyId');
  }

  Future<void> activatePolicy(String policyId) async {
    await _dio.patch('/policies/$policyId/activate');
  }

  Future<void> deactivatePolicy(String policyId) async {
    await _dio.patch('/policies/$policyId/deactivate');
  }

  // Policy Templates
  Future<List<PolicyTemplate>> getPolicyTemplates() async {
    final response = await _dio.get('/policies/templates');
    return (response.data as List).map((json) => PolicyTemplate.fromJson(json)).toList();
  }

  Future<HostelPolicy> createPolicyFromTemplate(String hostelId, String templateId, Map<String, dynamic>? customizations) async {
    final response = await _dio.post('/hostels/$hostelId/policies/from-template', data: {
      'templateId': templateId,
      'customizations': customizations,
    });
    return HostelPolicy.fromJson(response.data);
  }

  // Policy Validation
  Future<PolicyValidationResult> validatePolicy(Map<String, dynamic> policyData) async {
    final response = await _dio.post('/policies/validate', data: policyData);
    return PolicyValidationResult.fromJson(response.data);
  }

  // Policy History
  Future<List<PolicyChangeHistory>> getPolicyHistory(String policyId) async {
    final response = await _dio.get('/policies/$policyId/history');
    return (response.data as List).map((json) => PolicyChangeHistory.fromJson(json)).toList();
  }

  Future<List<PolicyChangeHistory>> getHostelPolicyHistory(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/history');
    return (response.data as List).map((json) => PolicyChangeHistory.fromJson(json)).toList();
  }

  // Policy Statistics
  Future<PolicyStatistics> getPolicyStatistics(String policyId) async {
    final response = await _dio.get('/policies/$policyId/statistics');
    return PolicyStatistics.fromJson(response.data);
  }

  // Student Policy Summary
  Future<PolicySummary> getStudentPolicySummary(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/summary');
    return PolicySummary.fromJson(response.data);
  }

  // Warden Read-only Policy Access
  Future<List<HostelPolicy>> getWardenPolicies(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/warden');
    return (response.data as List).map((json) => HostelPolicy.fromJson(json)).toList();
  }

  // Specific Policy Types
  Future<CurfewPolicy> getCurfewPolicy(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/curfew');
    return CurfewPolicy.fromJson(response.data);
  }

  Future<AttendancePolicy> getAttendancePolicy(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/attendance');
    return AttendancePolicy.fromJson(response.data);
  }

  Future<MealPolicy> getMealPolicy(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/meal');
    return MealPolicy.fromJson(response.data);
  }

  Future<RoomPolicy> getRoomPolicy(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/room');
    return RoomPolicy.fromJson(response.data);
  }

  // Policy Updates
  Future<CurfewPolicy> updateCurfewPolicy(String hostelId, CurfewPolicy policy) async {
    final response = await _dio.put('/hostels/$hostelId/policies/curfew', data: policy.toJson());
    return CurfewPolicy.fromJson(response.data);
  }

  Future<AttendancePolicy> updateAttendancePolicy(String hostelId, AttendancePolicy policy) async {
    final response = await _dio.put('/hostels/$hostelId/policies/attendance', data: policy.toJson());
    return AttendancePolicy.fromJson(response.data);
  }

  Future<MealPolicy> updateMealPolicy(String hostelId, MealPolicy policy) async {
    final response = await _dio.put('/hostels/$hostelId/policies/meal', data: policy.toJson());
    return MealPolicy.fromJson(response.data);
  }

  Future<RoomPolicy> updateRoomPolicy(String hostelId, RoomPolicy policy) async {
    final response = await _dio.put('/hostels/$hostelId/policies/room', data: policy.toJson());
    return RoomPolicy.fromJson(response.data);
  }

  // Policy Bulk Operations
  Future<List<HostelPolicy>> bulkUpdatePolicies(String hostelId, List<Map<String, dynamic>> updates) async {
    final response = await _dio.put('/hostels/$hostelId/policies/bulk', data: {'updates': updates});
    return (response.data as List).map((json) => HostelPolicy.fromJson(json)).toList();
  }

  Future<void> bulkActivatePolicies(String hostelId, List<String> policyIds) async {
    await _dio.patch('/hostels/$hostelId/policies/bulk-activate', data: {'policyIds': policyIds});
  }

  Future<void> bulkDeactivatePolicies(String hostelId, List<String> policyIds) async {
    await _dio.patch('/hostels/$hostelId/policies/bulk-deactivate', data: {'policyIds': policyIds});
  }

  // Policy Export/Import
  Future<String> exportPolicies(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/export');
    return response.data['exportData'];
  }

  Future<List<HostelPolicy>> importPolicies(String hostelId, String importData) async {
    final response = await _dio.post('/hostels/$hostelId/policies/import', data: {'importData': importData});
    return (response.data as List).map((json) => HostelPolicy.fromJson(json)).toList();
  }

  // Policy Notifications
  Future<void> notifyPolicyChange(String policyId, List<String> targetRoles) async {
    await _dio.post('/policies/$policyId/notify', data: {'targetRoles': targetRoles});
  }

  Future<void> schedulePolicyActivation(String policyId, DateTime activationTime) async {
    await _dio.post('/policies/$policyId/schedule', data: {'activationTime': activationTime.toIso8601String()});
  }

  // Policy Compliance
  Future<Map<String, dynamic>> getPolicyCompliance(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/policies/compliance');
    return response.data;
  }

  Future<List<Map<String, dynamic>>> getPolicyViolations(String hostelId, {DateTime? from, DateTime? to}) async {
    final response = await _dio.get('/hostels/$hostelId/policies/violations', queryParameters: {
      if (from != null) 'from': from.toIso8601String(),
      if (to != null) 'to': to.toIso8601String(),
    });
    return List<Map<String, dynamic>>.from(response.data);
  }
}
