// lib/core/models/gate_pass_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gate_pass_models.freezed.dart';
part 'gate_pass_models.g.dart';

enum GatePassStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('APPROVED')
  approved,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('OVERDUE')
  overdue,
  @JsonValue('CANCELLED')
  cancelled,
}

enum GatePassDirection {
  @JsonValue('OUT')
  out,
  @JsonValue('IN')
  _in, // 'in' is a reserved keyword, using _in
}

@freezed
class GatePass with _$GatePass {
  const factory GatePass({
    required String id,
    required String studentId,
    required String reason,
    required DateTime requestedAt,
    required DateTime departureTime,
    required DateTime expectedReturnTime,
    DateTime? actualReturnTime,
    @Default(GatePassStatus.pending) GatePassStatus status,
    String? approvedBy,
    String? rejectedBy,
    String? remarks,
    DateTime? createdAt,
    DateTime? updatedAt,
    Student? student, // Optional: to embed student details
  }) = _GatePass;

  factory GatePass.fromJson(Map<String, dynamic> json) => _$GatePassFromJson(json);
}

@freezed
class GatePassRequest with _$GatePassRequest {
  const factory GatePassRequest({
    required String studentId,
    required String reason,
    required DateTime departureTime,
    required DateTime expectedReturnTime,
  }) = _GatePassRequest;

  factory GatePassRequest.fromJson(Map<String, dynamic> json) => _$GatePassRequestFromJson(json);
}

@freezed
class GatePassQRTokenPayload with _$GatePassQRTokenPayload {
  const factory GatePassQRTokenPayload({
    required String gatePassId,
    required String userId, // User who generated the QR (e.g., student)
    required DateTime issuedAt,
    required DateTime expiresAt,
    required String nonce, // For replay protection
  }) = _GatePassQRTokenPayload;

  factory GatePassQRTokenPayload.fromJson(Map<String, dynamic> json) => _$GatePassQRTokenPayloadFromJson(json);
}

@freezed
class GateScanResult with _$GateScanResult {
  const factory GateScanResult({
    required bool ok,
    required GatePassDirection direction,
    required Student student,
    required GatePass gatePass,
    @Default([]) List<String> warnings, // e.g., "EXPIRED", "ALREADY_USED", "OUT_OF_WINDOW"
    String? message,
  }) = _GateScanResult;

  factory GateScanResult.fromJson(Map<String, dynamic> json) => _$GateScanResultFromJson(json);
}

// Student model for gate pass context
@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String rollNumber,
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    String? roomId,
    String? bedId,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
}