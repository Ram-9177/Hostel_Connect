// lib/features/rooms/domain/entities/room_entities.dart
class Block {
  final String id;
  final String name;
  final String hostelId;
  final int floors;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Block({
    required this.id,
    required this.name,
    required this.hostelId,
    required this.floors,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'],
      name: json['name'],
      hostelId: json['hostelId'],
      floors: json['floors'] ?? 1,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hostelId': hostelId,
      'floors': floors,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Floor {
  final String id;
  final String blockId;
  final int floorNumber;
  final String name;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Floor({
    required this.id,
    required this.blockId,
    required this.floorNumber,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Floor.fromJson(Map<String, dynamic> json) {
    return Floor(
      id: json['id'],
      blockId: json['blockId'],
      floorNumber: json['floorNumber'],
      name: json['name'],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'blockId': blockId,
      'floorNumber': floorNumber,
      'name': name,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Room {
  final String id;
  final String roomNumber;
  final String blockId;
  final String floorId;
  final String hostelId;
  final int capacity;
  final int currentOccupancy;
  final RoomStatus status;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.blockId,
    required this.floorId,
    required this.hostelId,
    required this.capacity,
    required this.currentOccupancy,
    required this.status,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomNumber: json['roomNumber'],
      blockId: json['blockId'],
      floorId: json['floorId'],
      hostelId: json['hostelId'],
      capacity: json['capacity'] ?? 2,
      currentOccupancy: json['currentOccupancy'] ?? 0,
      status: RoomStatus.fromString(json['status'] ?? 'vacant'),
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'blockId': blockId,
      'floorId': floorId,
      'hostelId': hostelId,
      'capacity': capacity,
      'currentOccupancy': currentOccupancy,
      'status': status.toString(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isVacant => currentOccupancy == 0;
  bool get isPartiallyOccupied => currentOccupancy > 0 && currentOccupancy < capacity;
  bool get isFullyOccupied => currentOccupancy >= capacity;
  bool get isBlocked => status == RoomStatus.blocked;
}

class Bed {
  final String id;
  final String roomId;
  final String bedNumber;
  final BedStatus status;
  final String? studentId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Bed({
    required this.id,
    required this.roomId,
    required this.bedNumber,
    required this.status,
    this.studentId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bed.fromJson(Map<String, dynamic> json) {
    return Bed(
      id: json['id'],
      roomId: json['roomId'],
      bedNumber: json['bedNumber'],
      status: BedStatus.fromString(json['status'] ?? 'vacant'),
      studentId: json['studentId'],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'bedNumber': bedNumber,
      'status': status.toString(),
      'studentId': studentId,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isVacant => status == BedStatus.vacant;
  bool get isOccupied => status == BedStatus.occupied;
  bool get isBlocked => status == BedStatus.blocked;
  bool get isReserved => status == BedStatus.reserved;
}

class RoomAllocation {
  final String id;
  final String studentId;
  final String roomId;
  final String bedId;
  final String allocatedBy;
  final String reason;
  final DateTime allocatedAt;
  final DateTime? vacatedAt;
  final String? vacatedBy;
  final String? vacateReason;

  const RoomAllocation({
    required this.id,
    required this.studentId,
    required this.roomId,
    required this.bedId,
    required this.allocatedBy,
    required this.reason,
    required this.allocatedAt,
    this.vacatedAt,
    this.vacatedBy,
    this.vacateReason,
  });

  factory RoomAllocation.fromJson(Map<String, dynamic> json) {
    return RoomAllocation(
      id: json['id'],
      studentId: json['studentId'],
      roomId: json['roomId'],
      bedId: json['bedId'],
      allocatedBy: json['allocatedBy'],
      reason: json['reason'],
      allocatedAt: DateTime.parse(json['allocatedAt']),
      vacatedAt: json['vacatedAt'] != null ? DateTime.parse(json['vacatedAt']) : null,
      vacatedBy: json['vacatedBy'],
      vacateReason: json['vacateReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'roomId': roomId,
      'bedId': bedId,
      'allocatedBy': allocatedBy,
      'reason': reason,
      'allocatedAt': allocatedAt.toIso8601String(),
      'vacatedAt': vacatedAt?.toIso8601String(),
      'vacatedBy': vacatedBy,
      'vacateReason': vacateReason,
    };
  }

  bool get isActive => vacatedAt == null;
}

// Enums
enum RoomStatus {
  vacant,
  partiallyOccupied,
  fullyOccupied,
  blocked;

  static RoomStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'vacant':
        return RoomStatus.vacant;
      case 'partially_occupied':
        return RoomStatus.partiallyOccupied;
      case 'fully_occupied':
        return RoomStatus.fullyOccupied;
      case 'blocked':
        return RoomStatus.blocked;
      default:
        return RoomStatus.vacant;
    }
  }

  @override
  String toString() {
    switch (this) {
      case RoomStatus.vacant:
        return 'vacant';
      case RoomStatus.partiallyOccupied:
        return 'partially_occupied';
      case RoomStatus.fullyOccupied:
        return 'fully_occupied';
      case RoomStatus.blocked:
        return 'blocked';
    }
  }
}

enum BedStatus {
  vacant,
  occupied,
  blocked,
  reserved;

  static BedStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'vacant':
        return BedStatus.vacant;
      case 'occupied':
        return BedStatus.occupied;
      case 'blocked':
        return BedStatus.blocked;
      case 'reserved':
        return BedStatus.reserved;
      default:
        return BedStatus.vacant;
    }
  }

  @override
  String toString() {
    switch (this) {
      case BedStatus.vacant:
        return 'vacant';
      case BedStatus.occupied:
        return 'occupied';
      case BedStatus.blocked:
        return 'blocked';
      case BedStatus.reserved:
        return 'reserved';
    }
  }
}

enum AllocationAction {
  allocate,
  transfer,
  swap,
  vacate;

  @override
  String toString() {
    switch (this) {
      case AllocationAction.allocate:
        return 'allocate';
      case AllocationAction.transfer:
        return 'transfer';
      case AllocationAction.swap:
        return 'swap';
      case AllocationAction.vacate:
        return 'vacate';
    }
  }
}
