// lib/features/rooms/data/rooms_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/room_entities.dart';
import 'rooms_repository.dart';

// Repository provider
final roomsRepositoryProvider = Provider<RoomsRepository>((ref) {
  return RoomsRepository();
});

// Service provider
final roomsServiceProvider = Provider<RoomsService>((ref) {
  final repository = ref.watch(roomsRepositoryProvider);
  return RoomsService(repository);
});

class RoomsService {
  final RoomsRepository _repository;

  RoomsService(this._repository);

  // Block operations
  Future<List<Block>> getBlocks(String hostelId) async {
    return await _repository.getBlocks(hostelId);
  }

  Future<Block> createBlock({
    required String name,
    required String hostelId,
    required int floors,
  }) async {
    final block = Block(
      id: 'block_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      hostelId: hostelId,
      floors: floors,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await _repository.createBlock(block);
  }

  Future<Block> updateBlock(Block block) async {
    return await _repository.updateBlock(block);
  }

  Future<void> deleteBlock(String blockId) async {
    return await _repository.deleteBlock(blockId);
  }

  // Floor operations
  Future<List<Floor>> getFloors(String blockId) async {
    return await _repository.getFloors(blockId);
  }

  Future<Floor> createFloor({
    required String blockId,
    required int floorNumber,
    required String name,
  }) async {
    final floor = Floor(
      id: 'floor_${DateTime.now().millisecondsSinceEpoch}',
      blockId: blockId,
      floorNumber: floorNumber,
      name: name,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await _repository.createFloor(floor);
  }

  Future<Floor> updateFloor(Floor floor) async {
    return await _repository.updateFloor(floor);
  }

  Future<void> deleteFloor(String floorId) async {
    return await _repository.deleteFloor(floorId);
  }

  // Room operations
  Future<List<Room>> getRooms(String hostelId) async {
    return await _repository.getRooms(hostelId);
  }

  Future<List<Room>> getRoomsByFloor(String floorId) async {
    return await _repository.getRoomsByFloor(floorId);
  }

  Future<Room> createRoom({
    required String roomNumber,
    required String blockId,
    required String floorId,
    required String hostelId,
    required int capacity,
  }) async {
    final room = Room(
      id: 'room_${DateTime.now().millisecondsSinceEpoch}',
      roomNumber: roomNumber,
      blockId: blockId,
      floorId: floorId,
      hostelId: hostelId,
      capacity: capacity,
      currentOccupancy: 0,
      status: RoomStatus.vacant,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await _repository.createRoom(room);
  }

  Future<Room> updateRoom(Room room) async {
    return await _repository.updateRoom(room);
  }

  Future<void> deleteRoom(String roomId) async {
    return await _repository.deleteRoom(roomId);
  }

  // Bed operations
  Future<List<Bed>> getBeds(String roomId) async {
    return await _repository.getBeds(roomId);
  }

  Future<Bed> createBed({
    required String roomId,
    required String bedNumber,
  }) async {
    final bed = Bed(
      id: 'bed_${DateTime.now().millisecondsSinceEpoch}',
      roomId: roomId,
      bedNumber: bedNumber,
      status: BedStatus.vacant,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await _repository.createBed(bed);
  }

  Future<Bed> updateBed(Bed bed) async {
    return await _repository.updateBed(bed);
  }

  Future<void> deleteBed(String bedId) async {
    return await _repository.deleteBed(bedId);
  }

  // Allocation operations
  Future<RoomAllocation> allocateBed({
    required String studentId,
    required String roomId,
    required String bedId,
    required String allocatedBy,
    required String reason,
  }) async {
    return await _repository.allocateBed(
      studentId: studentId,
      roomId: roomId,
      bedId: bedId,
      allocatedBy: allocatedBy,
      reason: reason,
    );
  }

  Future<RoomAllocation> transferStudent({
    required String studentId,
    required String fromRoomId,
    required String toRoomId,
    required String toBedId,
    required String transferredBy,
    required String reason,
  }) async {
    return await _repository.transferStudent(
      studentId: studentId,
      fromRoomId: fromRoomId,
      toRoomId: toRoomId,
      toBedId: toBedId,
      transferredBy: transferredBy,
      reason: reason,
    );
  }

  Future<void> swapStudents({
    required String student1Id,
    required String student2Id,
    required String swappedBy,
    required String reason,
  }) async {
    return await _repository.swapStudents(
      student1Id: student1Id,
      student2Id: student2Id,
      swappedBy: swappedBy,
      reason: reason,
    );
  }

  Future<void> vacateBed({
    required String studentId,
    required String vacatedBy,
    required String reason,
  }) async {
    return await _repository.vacateBed(
      studentId: studentId,
      vacatedBy: vacatedBy,
      reason: reason,
    );
  }

  Future<List<RoomAllocation>> getAllocationHistory(String studentId) async {
    return await _repository.getAllocationHistory(studentId);
  }

  Future<RoomAllocation?> getCurrentAllocation(String studentId) async {
    return await _repository.getCurrentAllocation(studentId);
  }

  Future<Map<String, dynamic>> getRoomMap(String hostelId) async {
    return await _repository.getRoomMap(hostelId);
  }

  // Utility methods
  Future<List<Room>> getAvailableRooms(String hostelId) async {
    final rooms = await getRooms(hostelId);
    return rooms.where((room) => room.isVacant || room.isPartiallyOccupied).toList();
  }

  Future<List<Bed>> getAvailableBeds(String roomId) async {
    final beds = await getBeds(roomId);
    return beds.where((bed) => bed.isVacant).toList();
  }

  Future<Map<String, dynamic>> getRoomOccupancyStats(String hostelId) async {
    final rooms = await getRooms(hostelId);
    final totalRooms = rooms.length;
    final vacantRooms = rooms.where((r) => r.isVacant).length;
    final partiallyOccupiedRooms = rooms.where((r) => r.isPartiallyOccupied).length;
    final fullyOccupiedRooms = rooms.where((r) => r.isFullyOccupied).length;
    final blockedRooms = rooms.where((r) => r.isBlocked).length;

    return {
      'totalRooms': totalRooms,
      'vacantRooms': vacantRooms,
      'partiallyOccupiedRooms': partiallyOccupiedRooms,
      'fullyOccupiedRooms': fullyOccupiedRooms,
      'blockedRooms': blockedRooms,
      'occupancyRate': totalRooms > 0 ? ((fullyOccupiedRooms + partiallyOccupiedRooms) / totalRooms * 100).round() : 0,
    };
  }
}
