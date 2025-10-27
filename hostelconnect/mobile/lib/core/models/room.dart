// lib/core/models/room.dart
import 'package:json_annotation/json_annotation.dart';
import 'student.dart';

part 'room.g.dart';

enum RoomStatus {
  @JsonValue('AVAILABLE')
  available,
  @JsonValue('OCCUPIED')
  occupied,
  @JsonValue('MAINTENANCE')
  maintenance,
  @JsonValue('RESERVED')
  reserved,
}

enum RoomType {
  @JsonValue('SINGLE')
  single,
  @JsonValue('DOUBLE')
  double,
  @JsonValue('TRIPLE')
  triple,
  @JsonValue('QUAD')
  quad,
}

@JsonSerializable()
class Room {
  final String id;
  final String roomNumber;
  final RoomType roomType;
  final int capacity;
  final int currentOccupancy;
  final RoomStatus status;
  final String? description;
  final String hostelId;
  final List<Student> occupants;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.roomType,
    required this.capacity,
    required this.currentOccupancy,
    required this.status,
    this.description,
    required this.hostelId,
    required this.occupants,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);

  Room copyWith({
    String? id,
    String? roomNumber,
    RoomType? roomType,
    int? capacity,
    int? currentOccupancy,
    RoomStatus? status,
    String? description,
    String? hostelId,
    List<Student>? occupants,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Room(
      id: id ?? this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      roomType: roomType ?? this.roomType,
      capacity: capacity ?? this.capacity,
      currentOccupancy: currentOccupancy ?? this.currentOccupancy,
      status: status ?? this.status,
      description: description ?? this.description,
      hostelId: hostelId ?? this.hostelId,
      occupants: occupants ?? this.occupants,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isAvailable => status == RoomStatus.available && currentOccupancy < capacity;
  bool get isFull => currentOccupancy >= capacity;

  @override
  String toString() {
    return 'Room(id: $id, roomNumber: $roomNumber, type: $roomType, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Room && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
