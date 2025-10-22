// lib/core/models/room_models.dart
import 'package:flutter/foundation.dart';

/// Block model
@immutable
class Block {
  final String id;
  final String name;
  final String description;
  final List<Floor> floors;

  const Block({
    required this.id,
    required this.name,
    required this.description,
    required this.floors,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      floors: (json['floors'] as List?)
          ?.map((e) => Floor.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'floors': floors.map((e) => e.toJson()).toList(),
    };
  }
}

/// Floor model
@immutable
class Floor {
  final String id;
  final int floorNumber;
  final String name;
  final String description;
  final List<Room> rooms;

  const Floor({
    required this.id,
    required this.floorNumber,
    required this.name,
    required this.description,
    required this.rooms,
  });

  factory Floor.fromJson(Map<String, dynamic> json) {
    return Floor(
      id: json['id'] ?? '',
      floorNumber: json['floorNumber'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rooms: (json['rooms'] as List?)
          ?.map((e) => Room.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'floorNumber': floorNumber,
      'name': name,
      'description': description,
      'rooms': rooms.map((e) => e.toJson()).toList(),
    };
  }
}

/// Room model
@immutable
class Room {
  final String id;
  final String roomNumber;
  final String roomType;
  final int capacity;
  final int currentOccupancy;
  final String status;
  final List<Bed> beds;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.roomType,
    required this.capacity,
    required this.currentOccupancy,
    required this.status,
    required this.beds,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? '',
      roomNumber: json['roomNumber'] ?? '',
      roomType: json['roomType'] ?? '',
      capacity: json['capacity'] ?? 0,
      currentOccupancy: json['currentOccupancy'] ?? 0,
      status: json['status'] ?? '',
      beds: (json['beds'] as List?)
          ?.map((e) => Bed.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'roomType': roomType,
      'capacity': capacity,
      'currentOccupancy': currentOccupancy,
      'status': status,
      'beds': beds.map((e) => e.toJson()).toList(),
    };
  }
}

/// Bed model
@immutable
class Bed {
  final String id;
  final int bedNumber;
  final String bedType;
  final String status;
  final String? studentName;

  const Bed({
    required this.id,
    required this.bedNumber,
    required this.bedType,
    required this.status,
    this.studentName,
  });

  factory Bed.fromJson(Map<String, dynamic> json) {
    return Bed(
      id: json['id'] ?? '',
      bedNumber: json['bedNumber'] ?? 0,
      bedType: json['bedType'] ?? '',
      status: json['status'] ?? '',
      studentName: json['studentName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bedNumber': bedNumber,
      'bedType': bedType,
      'status': status,
      'studentName': studentName,
    };
  }
}