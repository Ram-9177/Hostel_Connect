// lib/core/models/bed.dart
import 'package:json_annotation/json_annotation.dart';
import 'student.dart';

part 'bed.g.dart';

enum BedStatus {
  @JsonValue('AVAILABLE')
  available,
  @JsonValue('OCCUPIED')
  occupied,
  @JsonValue('MAINTENANCE')
  maintenance,
  @JsonValue('RESERVED')
  reserved,
}

enum BedType {
  @JsonValue('SINGLE')
  single,
  @JsonValue('BUNK_TOP')
  bunkTop,
  @JsonValue('BUNK_BOTTOM')
  bunkBottom,
}

@JsonSerializable()
class Bed {
  final String id;
  final String bedNumber;
  final BedType bedType;
  final BedStatus status;
  final String roomId;
  final Student? occupant;
  final DateTime? allocatedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Bed({
    required this.id,
    required this.bedNumber,
    required this.bedType,
    required this.status,
    required this.roomId,
    this.occupant,
    this.allocatedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bed.fromJson(Map<String, dynamic> json) => _$BedFromJson(json);
  Map<String, dynamic> toJson() => _$BedToJson(this);

  Bed copyWith({
    String? id,
    String? bedNumber,
    BedType? bedType,
    BedStatus? status,
    String? roomId,
    Student? occupant,
    DateTime? allocatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Bed(
      id: id ?? this.id,
      bedNumber: bedNumber ?? this.bedNumber,
      bedType: bedType ?? this.bedType,
      status: status ?? this.status,
      roomId: roomId ?? this.roomId,
      occupant: occupant ?? this.occupant,
      allocatedAt: allocatedAt ?? this.allocatedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isAvailable => status == BedStatus.available && occupant == null;
  bool get isOccupied => status == BedStatus.occupied && occupant != null;

  @override
  String toString() {
    return 'Bed(id: $id, bedNumber: $bedNumber, type: $bedType, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Bed && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
