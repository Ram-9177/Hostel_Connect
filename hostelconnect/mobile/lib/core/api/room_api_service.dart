// lib/core/api/room_api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../models/room_models.dart';
import '../models/student.dart';
import '../models/allocation_history.dart';
import '../providers/dio_provider.dart';

final roomApiServiceProvider = Provider((ref) => RoomApiService(ref.read(dioProvider)));

class RoomApiService {
  final Dio _dio;

  RoomApiService(this._dio);

  // Admin CRUD Operations - Blocks
  Future<Block> createBlock(String hostelId, String name, int floors, String description) async {
    final response = await _dio.post('/hostels/$hostelId/blocks', data: {
      'name': name,
      'floors': floors,
      'description': description,
    });
    return Block.fromJson(response.data);
  }

  Future<List<Block>> getBlocks(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/blocks');
    return (response.data as List).map((json) => Block.fromJson(json)).toList();
  }

  Future<Block> updateBlock(String blockId, Map<String, dynamic> data) async {
    final response = await _dio.put('/hostels/blocks/$blockId', data: data);
    return Block.fromJson(response.data);
  }

  Future<void> deleteBlock(String blockId) async {
    await _dio.delete('/hostels/blocks/$blockId');
  }

  // Admin CRUD Operations - Floors
  Future<Floor> createFloor(String blockId, int floorNumber, String name, String description) async {
    final response = await _dio.post('/hostels/blocks/$blockId/floors', data: {
      'floorNumber': floorNumber,
      'name': name,
      'description': description,
    });
    return Floor.fromJson(response.data);
  }

  Future<List<Floor>> getFloors(String blockId) async {
    final response = await _dio.get('/hostels/blocks/$blockId/floors');
    return (response.data as List).map((json) => Floor.fromJson(json)).toList();
  }

  Future<Floor> updateFloor(String floorId, Map<String, dynamic> data) async {
    final response = await _dio.put('/hostels/floors/$floorId', data: data);
    return Floor.fromJson(response.data);
  }

  Future<void> deleteFloor(String floorId) async {
    await _dio.delete('/hostels/floors/$floorId');
  }

  // Admin CRUD Operations - Rooms
  Future<Room> createRoom(
    String floorId,
    String roomNumber,
    RoomType roomType,
    int capacity,
    String description,
  ) async {
    final response = await _dio.post('/hostels/blocks/floors/$floorId/rooms', data: {
      'roomNumber': roomNumber,
      'roomType': roomType.name,
      'capacity': capacity,
      'description': description,
    });
    return Room.fromJson(response.data);
  }

  Future<List<Room>> getRooms(String floorId) async {
    final response = await _dio.get('/hostels/blocks/floors/$floorId/rooms');
    return (response.data as List).map((json) => Room.fromJson(json)).toList();
  }

  Future<List<Room>> getHostelRooms(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/rooms');
    return (response.data as List).map((json) => Room.fromJson(json)).toList();
  }

  Future<Room> updateRoom(String roomId, Map<String, dynamic> data) async {
    final response = await _dio.put('/hostels/rooms/$roomId', data: data);
    return Room.fromJson(response.data);
  }

  Future<void> deleteRoom(String roomId) async {
    await _dio.delete('/hostels/rooms/$roomId');
  }

  // Admin CRUD Operations - Beds
  Future<Bed> createBed(String roomId, String bedNumber, BedType bedType) async {
    final response = await _dio.post('/hostels/rooms/$roomId/beds', data: {
      'bedNumber': bedNumber,
      'bedType': bedType.name,
    });
    return Bed.fromJson(response.data);
  }

  Future<List<Bed>> getBeds(String roomId) async {
    final response = await _dio.get('/hostels/rooms/$roomId/beds');
    return (response.data as List).map((json) => Bed.fromJson(json)).toList();
  }

  Future<Bed> updateBed(String bedId, Map<String, dynamic> data) async {
    final response = await _dio.put('/hostels/beds/$bedId', data: data);
    return Bed.fromJson(response.data);
  }

  Future<void> deleteBed(String bedId) async {
    await _dio.delete('/hostels/beds/$bedId');
  }

  // Warden Allocation Operations
  Future<AllocationHistory> allocateBed(
    String studentId,
    String bedId,
    String reason,
    String performedBy,
  ) async {
    final response = await _dio.post('/hostels/rooms/allocate', data: {
      'studentId': studentId,
      'bedId': bedId,
      'reason': reason,
      'performedBy': performedBy,
    });
    return AllocationHistory.fromJson(response.data);
  }

  Future<AllocationHistory> transferStudent(
    String studentId,
    String fromBedId,
    String toBedId,
    String reason,
    String performedBy,
  ) async {
    final response = await _dio.post('/hostels/students/$studentId/transfer', data: {
      'fromBedId': fromBedId,
      'toBedId': toBedId,
      'reason': reason,
      'performedBy': performedBy,
    });
    return AllocationHistory.fromJson(response.data);
  }

  Future<List<AllocationHistory>> swapStudents(
    String student1Id,
    String student2Id,
    String reason,
    String performedBy,
  ) async {
    final response = await _dio.post('/hostels/students/swap', data: {
      'student1Id': student1Id,
      'student2Id': student2Id,
      'reason': reason,
      'performedBy': performedBy,
    });
    return (response.data as List).map((json) => AllocationHistory.fromJson(json)).toList();
  }

  Future<AllocationHistory> vacateBed(
    String studentId,
    String reason,
    String performedBy,
  ) async {
    final response = await _dio.post('/hostels/students/$studentId/vacate', data: {
      'reason': reason,
      'performedBy': performedBy,
    });
    return AllocationHistory.fromJson(response.data);
  }

  // Student Operations
  Future<Room> getStudentRoom(String studentId) async {
    final response = await _dio.get('/students/$studentId/room');
    return Room.fromJson(response.data);
  }

  Future<Bed> getStudentBed(String studentId) async {
    final response = await _dio.get('/students/$studentId/bed');
    return Bed.fromJson(response.data);
  }

  // Room Map Operations
  Future<List<RoomMapData>> getRoomMap(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/room-map');
    return (response.data as List).map((json) => RoomMapData.fromJson(json)).toList();
  }

  // Allocation History
  Future<List<AllocationHistory>> getAllocationHistory(String hostelId, {int? limit}) async {
    final response = await _dio.get('/hostels/$hostelId/allocation-history', queryParameters: {
      if (limit != null) 'limit': limit,
    });
    return (response.data as List).map((json) => AllocationHistory.fromJson(json)).toList();
  }

  // CSV Import/Export
  Future<List<Room>> importRoomsFromCSV(String csvData) async {
    final response = await _dio.post('/hostels/import/rooms', data: {'csvData': csvData});
    return (response.data as List).map((json) => Room.fromJson(json)).toList();
  }

  Future<String> exportRoomsToCSV(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/export/rooms');
    return response.data['csvData'];
  }

  Future<List<AllocationHistory>> importAllocationsFromCSV(String csvData) async {
    final response = await _dio.post('/hostels/import/allocations', data: {'csvData': csvData});
    return (response.data as List).map((json) => AllocationHistory.fromJson(json)).toList();
  }

  Future<String> exportAllocationsToCSV(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/export/allocations');
    return response.data['csvData'];
  }

  // Utility Methods
  Future<List<Student>> getUnassignedStudents(String hostelId) async {
    final response = await _dio.get('/students/unassigned', queryParameters: {'hostelId': hostelId});
    return (response.data as List).map((json) => Student.fromJson(json)).toList();
  }

  Future<List<Bed>> getAvailableBeds(String hostelId) async {
    final response = await _dio.get('/rooms/available', queryParameters: {'hostelId': hostelId});
    return (response.data as List).map((json) => Bed.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> getRoomStatistics(String hostelId) async {
    final response = await _dio.get('/hostels/$hostelId/analytics');
    return response.data;
  }

  // Legacy methods for backward compatibility
  Future<List<Map<String, dynamic>>> getAvailableRooms() async {
    final response = await _dio.get('/rooms/available');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> getRoom(String id) async {
    final response = await _dio.get('/rooms/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> allocateRoom(Map<String, dynamic> allocationData) async {
    final response = await _dio.post('/rooms/allocate', data: allocationData);
    return response.data;
  }
}