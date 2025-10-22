// lib/core/models/allocation_history.dart
class AllocationHistory {
  final String id;
  final String studentId;
  final String roomId;
  final String bedNumber;
  final DateTime allocatedAt;
  final DateTime? deallocatedAt;
  final String? reason;
  final bool isActive;

  const AllocationHistory({
    required this.id,
    required this.studentId,
    required this.roomId,
    required this.bedNumber,
    required this.allocatedAt,
    this.deallocatedAt,
    this.reason,
    this.isActive = true,
  });

  factory AllocationHistory.fromJson(Map<String, dynamic> json) {
    return AllocationHistory(
      id: json['id']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      roomId: json['roomId']?.toString() ?? '',
      bedNumber: json['bedNumber']?.toString() ?? '',
      allocatedAt: DateTime.tryParse(json['allocatedAt'].toString()) ?? DateTime.now(),
      deallocatedAt: json['deallocatedAt'] != null ? DateTime.tryParse(json['deallocatedAt'].toString()) : null,
      reason: json['reason']?.toString(),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'roomId': roomId,
      'bedNumber': bedNumber,
      'allocatedAt': allocatedAt.toIso8601String(),
      'deallocatedAt': deallocatedAt?.toIso8601String(),
      'reason': reason,
      'isActive': isActive,
    };
  }
}
