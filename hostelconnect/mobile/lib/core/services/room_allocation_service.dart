// lib/core/services/room_allocation_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/room_models.dart';
import '../api/room_api_service.dart';
import '../state/load_state.dart';

final roomAllocationServiceProvider = Provider((ref) => RoomAllocationService(ref.read(roomApiServiceProvider)));

class RoomAllocationService {
  final RoomApiService _apiService;

  RoomAllocationService(this._apiService);

  // Admin CRUD Operations
  Future<LoadStateData<Block>> createBlock(String hostelId, String name, int floors, String description) async {
    try {
      final block = await _apiService.createBlock(hostelId, name, floors, description);
      return LoadStateData(state: LoadState.success, data: block);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Block>>> getBlocks(String hostelId) async {
    try {
      final blocks = await _apiService.getBlocks(hostelId);
      return LoadStateData(state: LoadState.success, data: blocks);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Floor>> createFloor(String blockId, int floorNumber, String name, String description) async {
    try {
      final floor = await _apiService.createFloor(blockId, floorNumber, name, description);
      return LoadStateData(state: LoadState.success, data: floor);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Floor>>> getFloors(String blockId) async {
    try {
      final floors = await _apiService.getFloors(blockId);
      return LoadStateData(state: LoadState.success, data: floors);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Room>> createRoom(
    String floorId,
    String roomNumber,
    RoomType roomType,
    int capacity,
    String description,
  ) async {
    try {
      final room = await _apiService.createRoom(floorId, roomNumber, roomType, capacity, description);
      return LoadStateData(state: LoadState.success, data: room);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Room>>> getRooms(String floorId) async {
    try {
      final rooms = await _apiService.getRooms(floorId);
      return LoadStateData(state: LoadState.success, data: rooms);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Bed>> createBed(
    String roomId,
    String bedNumber,
    BedType bedType,
  ) async {
    try {
      final bed = await _apiService.createBed(roomId, bedNumber, bedType);
      return LoadStateData(state: LoadState.success, data: bed);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Bed>>> getBeds(String roomId) async {
    try {
      final beds = await _apiService.getBeds(roomId);
      return LoadStateData(state: LoadState.success, data: beds);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Warden Allocation Operations
  Future<LoadStateData<AllocationHistory>> allocateBed(
    String studentId,
    String bedId,
    String reason,
    String performedBy,
  ) async {
    try {
      final history = await _apiService.allocateBed(studentId, bedId, reason, performedBy);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AllocationHistory>> transferStudent(
    String studentId,
    String fromBedId,
    String toBedId,
    String reason,
    String performedBy,
  ) async {
    try {
      final history = await _apiService.transferStudent(studentId, fromBedId, toBedId, reason, performedBy);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AllocationHistory>>> swapStudents(
    String student1Id,
    String student2Id,
    String reason,
    String performedBy,
  ) async {
    try {
      final histories = await _apiService.swapStudents(student1Id, student2Id, reason, performedBy);
      return LoadStateData(state: LoadState.success, data: histories);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<AllocationHistory>> vacateBed(
    String studentId,
    String reason,
    String performedBy,
  ) async {
    try {
      final history = await _apiService.vacateBed(studentId, reason, performedBy);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Student Operations
  Future<LoadStateData<Room>> getStudentRoom(String studentId) async {
    try {
      final room = await _apiService.getStudentRoom(studentId);
      return LoadStateData(state: LoadState.success, data: room);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Bed>> getStudentBed(String studentId) async {
    try {
      final bed = await _apiService.getStudentBed(studentId);
      return LoadStateData(state: LoadState.success, data: bed);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Room Map Operations
  Future<LoadStateData<List<RoomMapData>>> getRoomMap(String hostelId) async {
    try {
      final roomMap = await _apiService.getRoomMap(hostelId);
      return LoadStateData(state: LoadState.success, data: roomMap);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Allocation History
  Future<LoadStateData<List<AllocationHistory>>> getAllocationHistory(String hostelId, {int? limit}) async {
    try {
      final history = await _apiService.getAllocationHistory(hostelId, limit: limit);
      return LoadStateData(state: LoadState.success, data: history);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // CSV Import/Export
  Future<LoadStateData<List<Room>>> importRoomsFromCSV(String csvData) async {
    try {
      final rooms = await _apiService.importRoomsFromCSV(csvData);
      return LoadStateData(state: LoadState.success, data: rooms);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<String>> exportRoomsToCSV(String hostelId) async {
    try {
      final csvData = await _apiService.exportRoomsToCSV(hostelId);
      return LoadStateData(state: LoadState.success, data: csvData);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AllocationHistory>>> importAllocationsFromCSV(String csvData) async {
    try {
      final allocations = await _apiService.importAllocationsFromCSV(csvData);
      return LoadStateData(state: LoadState.success, data: allocations);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<String>> exportAllocationsToCSV(String hostelId) async {
    try {
      final csvData = await _apiService.exportAllocationsToCSV(hostelId);
      return LoadStateData(state: LoadState.success, data: csvData);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Utility Methods
  Future<LoadStateData<List<Student>>> getUnassignedStudents(String hostelId) async {
    try {
      final students = await _apiService.getUnassignedStudents(hostelId);
      return LoadStateData(state: LoadState.success, data: students);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Bed>>> getAvailableBeds(String hostelId) async {
    try {
      final beds = await _apiService.getAvailableBeds(hostelId);
      return LoadStateData(state: LoadState.success, data: beds);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getRoomStatistics(String hostelId) async {
    try {
      final stats = await _apiService.getRoomStatistics(hostelId);
      return LoadStateData(state: LoadState.success, data: stats);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }
}
