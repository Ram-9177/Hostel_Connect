// lib/features/rooms/data/rooms_repository.dart
import 'dart:convert';
import '../domain/entities/room_entities.dart';

class RoomsRepository {
  // Mock data for demonstration
  static final List<Block> _blocks = [
    Block(
      id: 'block_1',
      name: 'Block A',
      hostelId: 'hostel_1',
      floors: 3,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Block(
      id: 'block_2',
      name: 'Block B',
      hostelId: 'hostel_1',
      floors: 2,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<Floor> _floors = [
    Floor(
      id: 'floor_1',
      blockId: 'block_1',
      floorNumber: 1,
      name: 'Ground Floor',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Floor(
      id: 'floor_2',
      blockId: 'block_1',
      floorNumber: 2,
      name: 'First Floor',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Floor(
      id: 'floor_3',
      blockId: 'block_1',
      floorNumber: 3,
      name: 'Second Floor',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<Room> _rooms = [
    Room(
      id: 'room_1',
      roomNumber: '101',
      blockId: 'block_1',
      floorId: 'floor_1',
      hostelId: 'hostel_1',
      capacity: 2,
      currentOccupancy: 1,
      status: RoomStatus.partiallyOccupied,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Room(
      id: 'room_2',
      roomNumber: '102',
      blockId: 'block_1',
      floorId: 'floor_1',
      hostelId: 'hostel_1',
      capacity: 2,
      currentOccupancy: 2,
      status: RoomStatus.fullyOccupied,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Room(
      id: 'room_3',
      roomNumber: '201',
      blockId: 'block_1',
      floorId: 'floor_2',
      hostelId: 'hostel_1',
      capacity: 2,
      currentOccupancy: 0,
      status: RoomStatus.vacant,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<Bed> _beds = [
    Bed(
      id: 'bed_1',
      roomId: 'room_1',
      bedNumber: 'A',
      status: BedStatus.occupied,
      studentId: 'student_1',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Bed(
      id: 'bed_2',
      roomId: 'room_1',
      bedNumber: 'B',
      status: BedStatus.vacant,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Bed(
      id: 'bed_3',
      roomId: 'room_2',
      bedNumber: 'A',
      status: BedStatus.occupied,
      studentId: 'student_2',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Bed(
      id: 'bed_4',
      roomId: 'room_2',
      bedNumber: 'B',
      status: BedStatus.occupied,
      studentId: 'student_3',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Bed(
      id: 'bed_5',
      roomId: 'room_3',
      bedNumber: 'A',
      status: BedStatus.vacant,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Bed(
      id: 'bed_6',
      roomId: 'room_3',
      bedNumber: 'B',
      status: BedStatus.vacant,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<RoomAllocation> _allocations = [
    RoomAllocation(
      id: 'alloc_1',
      studentId: 'student_1',
      roomId: 'room_1',
      bedId: 'bed_1',
      allocatedBy: 'warden_1',
      reason: 'Initial allocation',
      allocatedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    RoomAllocation(
      id: 'alloc_2',
      studentId: 'student_2',
      roomId: 'room_2',
      bedId: 'bed_3',
      allocatedBy: 'warden_1',
      reason: 'Initial allocation',
      allocatedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    RoomAllocation(
      id: 'alloc_3',
      studentId: 'student_3',
      roomId: 'room_2',
      bedId: 'bed_4',
      allocatedBy: 'warden_1',
      reason: 'Initial allocation',
      allocatedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];

  // Block operations
  Future<List<Block>> getBlocks(String hostelId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _blocks.where((block) => block.hostelId == hostelId).toList();
  }

  Future<Block> createBlock(Block block) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _blocks.add(block);
    return block;
  }

  Future<Block> updateBlock(Block block) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _blocks.indexWhere((b) => b.id == block.id);
    if (index != -1) {
      _blocks[index] = block;
    }
    return block;
  }

  Future<void> deleteBlock(String blockId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _blocks.removeWhere((block) => block.id == blockId);
  }

  // Floor operations
  Future<List<Floor>> getFloors(String blockId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _floors.where((floor) => floor.blockId == blockId).toList();
  }

  Future<Floor> createFloor(Floor floor) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _floors.add(floor);
    return floor;
  }

  Future<Floor> updateFloor(Floor floor) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _floors.indexWhere((f) => f.id == floor.id);
    if (index != -1) {
      _floors[index] = floor;
    }
    return floor;
  }

  Future<void> deleteFloor(String floorId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _floors.removeWhere((floor) => floor.id == floorId);
  }

  // Room operations
  Future<List<Room>> getRooms(String hostelId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _rooms.where((room) => room.hostelId == hostelId).toList();
  }

  Future<List<Room>> getRoomsByFloor(String floorId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _rooms.where((room) => room.floorId == floorId).toList();
  }

  Future<Room> createRoom(Room room) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _rooms.add(room);
    return room;
  }

  Future<Room> updateRoom(Room room) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _rooms.indexWhere((r) => r.id == room.id);
    if (index != -1) {
      _rooms[index] = room;
    }
    return room;
  }

  Future<void> deleteRoom(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _rooms.removeWhere((room) => room.id == roomId);
  }

  // Bed operations
  Future<List<Bed>> getBeds(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _beds.where((bed) => bed.roomId == roomId).toList();
  }

  Future<Bed> createBed(Bed bed) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _beds.add(bed);
    return bed;
  }

  Future<Bed> updateBed(Bed bed) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _beds.indexWhere((b) => b.id == bed.id);
    if (index != -1) {
      _beds[index] = bed;
    }
    return bed;
  }

  Future<void> deleteBed(String bedId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _beds.removeWhere((bed) => bed.id == bedId);
  }

  // Allocation operations
  Future<RoomAllocation> allocateBed({
    required String studentId,
    required String roomId,
    required String bedId,
    required String allocatedBy,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final allocation = RoomAllocation(
      id: 'alloc_${DateTime.now().millisecondsSinceEpoch}',
      studentId: studentId,
      roomId: roomId,
      bedId: bedId,
      allocatedBy: allocatedBy,
      reason: reason,
      allocatedAt: DateTime.now(),
    );
    
    _allocations.add(allocation);
    
    // Update bed status
    final bedIndex = _beds.indexWhere((bed) => bed.id == bedId);
    if (bedIndex != -1) {
      _beds[bedIndex] = Bed(
        id: _beds[bedIndex].id,
        roomId: _beds[bedIndex].roomId,
        bedNumber: _beds[bedIndex].bedNumber,
        status: BedStatus.occupied,
        studentId: studentId,
        isActive: _beds[bedIndex].isActive,
        createdAt: _beds[bedIndex].createdAt,
        updatedAt: DateTime.now(),
      );
    }
    
    // Update room occupancy
    _updateRoomOccupancy(roomId);
    
    return allocation;
  }

  Future<RoomAllocation> transferStudent({
    required String studentId,
    required String fromRoomId,
    required String toRoomId,
    required String toBedId,
    required String transferredBy,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Vacate current bed
    await vacateBed(studentId: studentId, vacatedBy: transferredBy, reason: 'Transfer');
    
    // Allocate new bed
    return await allocateBed(
      studentId: studentId,
      roomId: toRoomId,
      bedId: toBedId,
      allocatedBy: transferredBy,
      reason: reason,
    );
  }

  Future<void> swapStudents({
    required String student1Id,
    required String student2Id,
    required String swappedBy,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Get current allocations
    final alloc1 = _allocations.firstWhere((a) => a.studentId == student1Id && a.isActive);
    final alloc2 = _allocations.firstWhere((a) => a.studentId == student2Id && a.isActive);
    
    // Vacate both beds
    await vacateBed(studentId: student1Id, vacatedBy: swappedBy, reason: 'Swap');
    await vacateBed(studentId: student2Id, vacatedBy: swappedBy, reason: 'Swap');
    
    // Allocate swapped beds
    await allocateBed(
      studentId: student1Id,
      roomId: alloc2.roomId,
      bedId: alloc2.bedId,
      allocatedBy: swappedBy,
      reason: reason,
    );
    
    await allocateBed(
      studentId: student2Id,
      roomId: alloc1.roomId,
      bedId: alloc1.bedId,
      allocatedBy: swappedBy,
      reason: reason,
    );
  }

  Future<void> vacateBed({
    required String studentId,
    required String vacatedBy,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final allocationIndex = _allocations.indexWhere((a) => a.studentId == studentId && a.isActive);
    if (allocationIndex != -1) {
      final allocation = _allocations[allocationIndex];
      _allocations[allocationIndex] = RoomAllocation(
        id: allocation.id,
        studentId: allocation.studentId,
        roomId: allocation.roomId,
        bedId: allocation.bedId,
        allocatedBy: allocation.allocatedBy,
        reason: allocation.reason,
        allocatedAt: allocation.allocatedAt,
        vacatedAt: DateTime.now(),
        vacatedBy: vacatedBy,
        vacateReason: reason,
      );
      
      // Update bed status
      final bedIndex = _beds.indexWhere((bed) => bed.id == allocation.bedId);
      if (bedIndex != -1) {
        _beds[bedIndex] = Bed(
          id: _beds[bedIndex].id,
          roomId: _beds[bedIndex].roomId,
          bedNumber: _beds[bedIndex].bedNumber,
          status: BedStatus.vacant,
          studentId: null,
          isActive: _beds[bedIndex].isActive,
          createdAt: _beds[bedIndex].createdAt,
          updatedAt: DateTime.now(),
        );
      }
      
      // Update room occupancy
      _updateRoomOccupancy(allocation.roomId);
    }
  }

  Future<List<RoomAllocation>> getAllocationHistory(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _allocations.where((a) => a.studentId == studentId).toList();
  }

  Future<RoomAllocation?> getCurrentAllocation(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _allocations.firstWhere((a) => a.studentId == studentId && a.isActive);
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getRoomMap(String hostelId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final rooms = await getRooms(hostelId);
    final blocks = await getBlocks(hostelId);
    final floors = <Floor>[];
    
    for (final block in blocks) {
      floors.addAll(await getFloors(block.id));
    }
    
    return {
      'blocks': blocks.map((b) => b.toJson()).toList(),
      'floors': floors.map((f) => f.toJson()).toList(),
      'rooms': rooms.map((r) => r.toJson()).toList(),
      'beds': _beds.map((b) => b.toJson()).toList(),
    };
  }

  void _updateRoomOccupancy(String roomId) {
    final roomIndex = _rooms.indexWhere((room) => room.id == roomId);
    if (roomIndex != -1) {
      final room = _rooms[roomIndex];
      final occupiedBeds = _beds.where((bed) => bed.roomId == roomId && bed.isOccupied).length;
      
      RoomStatus status;
      if (occupiedBeds == 0) {
        status = RoomStatus.vacant;
      } else if (occupiedBeds < room.capacity) {
        status = RoomStatus.partiallyOccupied;
      } else {
        status = RoomStatus.fullyOccupied;
      }
      
      _rooms[roomIndex] = Room(
        id: room.id,
        roomNumber: room.roomNumber,
        blockId: room.blockId,
        floorId: room.floorId,
        hostelId: room.hostelId,
        capacity: room.capacity,
        currentOccupancy: occupiedBeds,
        status: status,
        isActive: room.isActive,
        createdAt: room.createdAt,
        updatedAt: DateTime.now(),
      );
    }
  }
}
