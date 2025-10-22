// lib/core/api/gate_pass_api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../models/gate_pass_models.dart';

final gatePassApiServiceProvider = Provider((ref) => GatePassApiService(ref.read(dioProvider)));

class GatePassApiService {
  final Dio _dio;

  GatePassApiService(this._dio);

  // Student requests a new gate pass
  Future<GatePass> requestGatePass(GatePassRequest request) async {
    try {
      final response = await _dio.post('/gate-passes', data: request.toJson());
      return GatePass.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to request gate pass: ${e.message}');
    }
  }

  // Student gets their active/pending gate passes
  Future<List<GatePass>> getMyGatePasses(String studentId) async {
    try {
      final response = await _dio.get('/students/$studentId/gate-passes');
      return (response.data as List).map((json) => GatePass.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch my gate passes: ${e.message}');
    }
  }

  // Warden/Admin approves a gate pass
  Future<GatePass> approveGatePass(String gatePassId, String approvedBy) async {
    try {
      final response = await _dio.patch('/gate-passes/$gatePassId/approve', data: {'approvedBy': approvedBy});
      return GatePass.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to approve gate pass: ${e.message}');
    }
  }

  // Warden/Admin rejects a gate pass
  Future<GatePass> rejectGatePass(String gatePassId, String rejectedBy, String remarks) async {
    try {
      final response = await _dio.patch('/gate-passes/$gatePassId/reject', data: {'rejectedBy': rejectedBy, 'remarks': remarks});
      return GatePass.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to reject gate pass: ${e.message}');
    }
  }

  // Generate QR token for an approved gate pass
  Future<Map<String, dynamic>> generateGatePassQr(String gatePassId) async {
    try {
      final response = await _dio.get('/gate-passes/$gatePassId/qr');
      return response.data; // Should contain { token: "...", ttlSeconds: ... }
    } on DioException catch (e) {
      throw Exception('Failed to generate QR token: ${e.message}');
    }
  }

  // Scan QR token (kiosk/warden device)
  Future<GateScanResult> scanGatePassQr(String token, String deviceId) async {
    try {
      final response = await _dio.post('/gate/scan', data: {'token': token, 'deviceId': deviceId});
      return GateScanResult.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to scan QR token: ${e.message}');
    }
  }
}