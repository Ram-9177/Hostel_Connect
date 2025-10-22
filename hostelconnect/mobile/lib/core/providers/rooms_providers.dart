// lib/core/providers/rooms_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/hostel_api_service.dart';
import '../api/room_api_service.dart';
import '../services/room_allocation_service.dart';
import '../config/environment.dart';
import '../state/load_state.dart';
import '../models/room_models.dart';

// Hostels provider
final hostelsProvider = StateNotifierProvider<HostelsNotifier, LoadState<List<Hostel>>>((ref) {
  return HostelsNotifier(ref);
});

// Single hostel provider
final hostelProvider = StateNotifierProvider.family<HostelNotifier, LoadState<Hostel>, String>((ref, hostelId) {
  return HostelNotifier(ref, hostelId);
});

// Blocks provider
final blocksProvider = StateNotifierProvider.family<BlocksNotifier, LoadState<List<Block>>, String>((ref, hostelId) {
  return BlocksNotifier(ref, hostelId);
});

// Rooms provider
final roomsProvider = StateNotifierProvider.family<RoomsNotifier, LoadState<List<Room>>, String>((ref, blockId) {
  return RoomsNotifier(ref, blockId);
});

// Room allocation provider
final roomAllocationProvider = StateNotifierProvider<RoomAllocationNotifier, LoadState<RoomAllocation>>((ref) {
  return RoomAllocationNotifier(ref);
});

// Room map provider
final roomMapProvider = StateNotifierProvider<RoomMapNotifier, LoadState<RoomMap>>((ref) {
  return RoomMapNotifier(ref);
});

// New Room Allocation Service Providers
final roomAllocationServiceProvider = Provider((ref) => RoomAllocationService(ref.read(roomApiServiceProvider)));

// Blocks provider using new service
final blocksProviderV2 = StateNotifierProvider.family<BlocksNotifierV2, LoadStateData<List<Block>>, String>((ref, hostelId) {
  return BlocksNotifierV2(ref, hostelId);
});

// Floors provider
final floorsProvider = StateNotifierProvider.family<FloorsNotifier, LoadStateData<List<Floor>>, String>((ref, blockId) {
  return FloorsNotifier(ref, blockId);
});

// Rooms provider
final roomsProviderV2 = StateNotifierProvider.family<RoomsNotifierV2, LoadStateData<List<Room>>, String>((ref, floorId) {
  return RoomsNotifierV2(ref, floorId);
});

// Beds provider
final bedsProvider = StateNotifierProvider.family<BedsNotifier, LoadStateData<List<Bed>>, String>((ref, roomId) {
  return BedsNotifier(ref, roomId);
});

// Students provider
final studentsProvider = StateNotifierProvider.family<StudentsNotifier, LoadStateData<List<Student>>, String>((ref, hostelId) {
  return StudentsNotifier(ref, hostelId);
});

// Room Map provider
final roomMapProviderV2 = StateNotifierProvider.family<RoomMapNotifierV2, LoadStateData<List<RoomMapData>>, String>((ref, hostelId) {
  return RoomMapNotifierV2(ref, hostelId);
});

// Allocation History provider
final allocationHistoryProvider = StateNotifierProvider.family<AllocationHistoryNotifier, LoadStateData<List<AllocationHistory>>, String>((ref, hostelId) {
  return AllocationHistoryNotifier(ref, hostelId);
});

// Student Room provider
final studentRoomProvider = StateNotifierProvider.family<StudentRoomNotifier, LoadStateData<Room>, String>((ref, studentId) {
  return StudentRoomNotifier(ref, studentId);
});

// Student Bed provider
final studentBedProvider = StateNotifierProvider.family<StudentBedNotifier, LoadStateData<Bed>, String>((ref, studentId) {
  return StudentBedNotifier(ref, studentId);
});

// Data models
class Hostel {
  final String id;
  final String name;
  final String address;
  final int capacity;
  final int currentOccupancy;
  final String status; // 'active', 'inactive', 'maintenance'
  final List<String> amenities;
  final Map<String, dynamic> contactInfo;

  const Hostel({
    required this.id,
    required this.name,
    required this.address,
    required this.capacity,
    required this.currentOccupancy,
    required this.status,
    required this.amenities,
    required this.contactInfo,
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      capacity: json['capacity'] ?? 0,
      currentOccupancy: json['currentOccupancy'] ?? 0,
      status: json['status'] ?? 'active',
      amenities: List<String>.from(json['amenities'] ?? []),
      contactInfo: Map<String, dynamic>.from(json['contactInfo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'capacity': capacity,
      'currentOccupancy': currentOccupancy,
      'status': status,
      'amenities': amenities,
      'contactInfo': contactInfo,
    };
  }

  bool get isActive => status == 'active';
  bool get isFull => currentOccupancy >= capacity;
  double get occupancyPercentage => capacity > 0 ? (currentOccupancy / capacity) * 100 : 0;
  int get availableSlots => capacity - currentOccupancy;
}

class Block {
  final String id;
  final String name;
  final String hostelId;
  final int floors;
  final int totalRooms;
  final int occupiedRooms;
  final String status; // 'active', 'inactive', 'maintenance'
  final List<String> amenities;

  const Block({
    required this.id,
    required this.name,
    required this.hostelId,
    required this.floors,
    required this.totalRooms,
    required this.occupiedRooms,
    required this.status,
    required this.amenities,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      hostelId: json['hostelId']?.toString() ?? '',
      floors: json['floors'] ?? 0,
      totalRooms: json['totalRooms'] ?? 0,
      occupiedRooms: json['occupiedRooms'] ?? 0,
      status: json['status'] ?? 'active',
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hostelId': hostelId,
      'floors': floors,
      'totalRooms': totalRooms,
      'occupiedRooms': occupiedRooms,
      'status': status,
      'amenities': amenities,
    };
  }

  bool get isActive => status == 'active';
  bool get isFull => occupiedRooms >= totalRooms;
  double get occupancyPercentage => totalRooms > 0 ? (occupiedRooms / totalRooms) * 100 : 0;
  int get availableRooms => totalRooms - occupiedRooms;
}

class Room {
  final String id;
  final String roomNumber;
  final String blockId;
  final int floor;
  final int capacity;
  final int currentOccupancy;
  final String status; // 'available', 'occupied', 'maintenance', 'reserved'
  final List<String> amenities;
  final List<Student> occupants;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.blockId,
    required this.floor,
    required this.capacity,
    required this.currentOccupancy,
    required this.status,
    required this.amenities,
    required this.occupants,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id']?.toString() ?? '',
      roomNumber: json['roomNumber'] ?? '',
      blockId: json['blockId']?.toString() ?? '',
      floor: json['floor'] ?? 0,
      capacity: json['capacity'] ?? 0,
      currentOccupancy: json['currentOccupancy'] ?? 0,
      status: json['status'] ?? 'available',
      amenities: List<String>.from(json['amenities'] ?? []),
      occupants: (json['occupants'] as List<dynamic>?)
          ?.map((item) => Student.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'blockId': blockId,
      'floor': floor,
      'capacity': capacity,
      'currentOccupancy': currentOccupancy,
      'status': status,
      'amenities': amenities,
      'occupants': occupants.map((occupant) => occupant.toJson()).toList(),
    };
  }

  bool get isAvailable => status == 'available' && currentOccupancy < capacity;
  bool get isFull => currentOccupancy >= capacity;
  bool get isOccupied => status == 'occupied';
  bool get isMaintenance => status == 'maintenance';
  double get occupancyPercentage => capacity > 0 ? (currentOccupancy / capacity) * 100 : 0;
  int get availableBeds => capacity - currentOccupancy;
}

class Student {
  final String id;
  final String name;
  final String email;
  final String course;
  final String year;
  final String contactNumber;

  const Student({
    required this.id,
    required this.name,
    required this.email,
    required this.course,
    required this.year,
    required this.contactNumber,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      course: json['course'] ?? '',
      year: json['year'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'course': course,
      'year': year,
      'contactNumber': contactNumber,
    };
  }
}

class RoomAllocation {
  final String id;
  final String studentId;
  final String roomId;
  final DateTime allocatedAt;
  final String status; // 'active', 'transferred', 'vacated'
  final String? transferredTo;
  final DateTime? vacatedAt;

  const RoomAllocation({
    required this.id,
    required this.studentId,
    required this.roomId,
    required this.allocatedAt,
    required this.status,
    this.transferredTo,
    this.vacatedAt,
  });

  factory RoomAllocation.fromJson(Map<String, dynamic> json) {
    return RoomAllocation(
      id: json['id']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      roomId: json['roomId']?.toString() ?? '',
      allocatedAt: DateTime.tryParse(json['allocatedAt'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'active',
      transferredTo: json['transferredTo'],
      vacatedAt: json['vacatedAt'] != null ? DateTime.tryParse(json['vacatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'roomId': roomId,
      'allocatedAt': allocatedAt.toIso8601String(),
      'status': status,
      'transferredTo': transferredTo,
      'vacatedAt': vacatedAt?.toIso8601String(),
    };
  }

  bool get isActive => status == 'active';
  bool get isTransferred => status == 'transferred';
  bool get isVacated => status == 'vacated';
}

class RoomMap {
  final String hostelId;
  final Map<String, List<Room>> roomsByFloor;
  final Map<String, Block> blocks;
  final List<String> availableRooms;
  final List<String> occupiedRooms;

  const RoomMap({
    required this.hostelId,
    required this.roomsByFloor,
    required this.blocks,
    required this.availableRooms,
    required this.occupiedRooms,
  });

  factory RoomMap.fromJson(Map<String, dynamic> json) {
    final roomsByFloor = <String, List<Room>>{};
    final roomsData = json['roomsByFloor'] as Map<String, dynamic>? ?? {};
    
    for (final entry in roomsData.entries) {
      final rooms = (entry.value as List<dynamic>?)
          ?.map((item) => Room.fromJson(item))
          .toList() ?? [];
      roomsByFloor[entry.key] = rooms;
    }
    
    final blocks = <String, Block>{};
    final blocksData = json['blocks'] as Map<String, dynamic>? ?? {};
    
    for (final entry in blocksData.entries) {
      blocks[entry.key] = Block.fromJson(entry.value);
    }
    
    return RoomMap(
      hostelId: json['hostelId']?.toString() ?? '',
      roomsByFloor: roomsByFloor,
      blocks: blocks,
      availableRooms: List<String>.from(json['availableRooms'] ?? []),
      occupiedRooms: List<String>.from(json['occupiedRooms'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hostelId': hostelId,
      'roomsByFloor': roomsByFloor.map((key, value) => MapEntry(key, value.map((room) => room.toJson()).toList())),
      'blocks': blocks.map((key, value) => MapEntry(key, value.toJson())),
      'availableRooms': availableRooms,
      'occupiedRooms': occupiedRooms,
    };
  }
}

// Notifiers
class HostelsNotifier extends StateNotifier<LoadState<List<Hostel>>> {
  final Ref _ref;
  List<Hostel> _cachedHostels = [];

  HostelsNotifier(this._ref) : super(const LoadState.idle()) {
    loadHostels();
  }

  Future<void> loadHostels() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      if (Environment.enableMockData) {
        // Mock data
        await Future.delayed(const Duration(seconds: 1));
        
        final hostels = [
          Hostel(
            id: '1',
            name: 'Boys Hostel A',
            address: 'Campus North',
            capacity: 200,
            currentOccupancy: 150,
            status: 'active',
            amenities: ['WiFi', 'Laundry', 'Gym'],
            contactInfo: {'phone': '+91 9876543210', 'email': 'boyshostel@university.edu'},
          ),
          Hostel(
            id: '2',
            name: 'Girls Hostel B',
            address: 'Campus South',
            capacity: 150,
            currentOccupancy: 120,
            status: 'active',
            amenities: ['WiFi', 'Laundry', 'Library'],
            contactInfo: {'phone': '+91 9876543211', 'email': 'girlshostel@university.edu'},
          ),
        ];
        
        _cachedHostels = hostels;
        state = LoadState.success(hostels);
      } else {
        final hostelApiService = _ref.read(hostelApiServiceProvider);
        final hostelsData = await hostelApiService.getHostels();
        final hostels = hostelsData.map((json) => Hostel.fromJson(json)).toList();
        
        _cachedHostels = hostels;
        state = LoadState.success(hostels);
      }
    } catch (e) {
      state = LoadState.error('Failed to load hostels: ${e.toString()}', previousData: _cachedHostels);
    }
  }

  void clearCache() {
    _cachedHostels = [];
    state = const LoadState.idle();
  }
}

class HostelNotifier extends StateNotifier<LoadState<Hostel>> {
  final Ref _ref;
  final String hostelId;
  Hostel? _cachedHostel;

  HostelNotifier(this._ref, this.hostelId) : super(const LoadState.idle()) {
    loadHostel();
  }

  Future<void> loadHostel() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      if (Environment.enableMockData) {
        // Mock data
        await Future.delayed(const Duration(milliseconds: 500));
        
        final hostel = Hostel(
          id: hostelId,
          name: 'Sample Hostel',
          address: 'Sample Address',
          capacity: 100,
          currentOccupancy: 75,
          status: 'active',
          amenities: ['WiFi', 'Laundry'],
          contactInfo: {'phone': '+91 9876543210'},
        );
        
        _cachedHostel = hostel;
        state = LoadState.success(hostel);
      } else {
        final hostelApiService = _ref.read(hostelApiServiceProvider);
        final hostelData = await hostelApiService.getHostel(hostelId);
        final hostel = Hostel.fromJson(hostelData);
        
        _cachedHostel = hostel;
        state = LoadState.success(hostel);
      }
    } catch (e) {
      state = LoadState.error('Failed to load hostel: ${e.toString()}', previousData: _cachedHostel);
    }
  }

  void clearCache() {
    _cachedHostel = null;
    state = const LoadState.idle();
  }
}

class BlocksNotifier extends StateNotifier<LoadState<List<Block>>> {
  final Ref _ref;
  final String hostelId;
  List<Block> _cachedBlocks = [];

  BlocksNotifier(this._ref, this.hostelId) : super(const LoadState.idle()) {
    loadBlocks();
  }

  Future<void> loadBlocks() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      if (Environment.enableMockData) {
        // Mock data
        await Future.delayed(const Duration(milliseconds: 500));
        
        final blocks = [
          Block(
            id: '1',
            name: 'Block A',
            hostelId: hostelId,
            floors: 3,
            totalRooms: 30,
            occupiedRooms: 25,
            status: 'active',
            amenities: ['WiFi', 'Laundry'],
          ),
          Block(
            id: '2',
            name: 'Block B',
            hostelId: hostelId,
            floors: 2,
            totalRooms: 20,
            occupiedRooms: 18,
            status: 'active',
            amenities: ['WiFi'],
          ),
        ];
        
        _cachedBlocks = blocks;
        state = LoadState.success(blocks);
      } else {
        final hostelApiService = _ref.read(hostelApiServiceProvider);
        final blocksData = await hostelApiService.getBlocks(hostelId);
        final blocks = blocksData.map((json) => Block.fromJson(json)).toList();
        
        _cachedBlocks = blocks;
        state = LoadState.success(blocks);
      }
    } catch (e) {
      state = LoadState.error('Failed to load blocks: ${e.toString()}', previousData: _cachedBlocks);
    }
  }

  void clearCache() {
    _cachedBlocks = [];
    state = const LoadState.idle();
  }
}

class RoomsNotifier extends StateNotifier<LoadState<List<Room>>> {
  final Ref _ref;
  final String blockId;
  List<Room> _cachedRooms = [];

  RoomsNotifier(this._ref, this.blockId) : super(const LoadState.idle()) {
    loadRooms();
  }

  Future<void> loadRooms() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      if (Environment.enableMockData) {
        // Mock data
        await Future.delayed(const Duration(milliseconds: 500));
        
        final rooms = [
          Room(
            id: '1',
            roomNumber: '101',
            blockId: blockId,
            floor: 1,
            capacity: 2,
            currentOccupancy: 1,
            status: 'available',
            amenities: ['WiFi', 'AC'],
            occupants: [
              Student(
                id: 'student_1',
                name: 'John Doe',
                email: 'john@university.edu',
                course: 'Computer Science',
                year: '3rd Year',
                contactNumber: '+91 9876543210',
              ),
            ],
          ),
          Room(
            id: '2',
            roomNumber: '102',
            blockId: blockId,
            floor: 1,
            capacity: 2,
            currentOccupancy: 2,
            status: 'occupied',
            amenities: ['WiFi'],
            occupants: [
              Student(
                id: 'student_2',
                name: 'Jane Smith',
                email: 'jane@university.edu',
                course: 'Electronics',
                year: '2nd Year',
                contactNumber: '+91 9876543211',
              ),
              Student(
                id: 'student_3',
                name: 'Bob Johnson',
                email: 'bob@university.edu',
                course: 'Mechanical',
                year: '4th Year',
                contactNumber: '+91 9876543212',
              ),
            ],
          ),
        ];
        
        _cachedRooms = rooms;
        state = LoadState.success(rooms);
      } else {
        final hostelApiService = _ref.read(hostelApiServiceProvider);
        final roomsData = await hostelApiService.getRoomsByBlock(blockId);
        final rooms = roomsData.map((json) => Room.fromJson(json)).toList();
        
        _cachedRooms = rooms;
        state = LoadState.success(rooms);
      }
    } catch (e) {
      state = LoadState.error('Failed to load rooms: ${e.toString()}', previousData: _cachedRooms);
    }
  }

  void clearCache() {
    _cachedRooms = [];
    state = const LoadState.idle();
  }
}

class RoomAllocationNotifier extends StateNotifier<LoadState<RoomAllocation>> {
  final Ref _ref;

  RoomAllocationNotifier(this._ref) : super(const LoadState.idle());

  Future<void> allocateRoom(String studentId, String roomId) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      
      final allocation = RoomAllocation(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentId: studentId,
        roomId: roomId,
        allocatedAt: DateTime.now(),
        status: 'active',
      );
      
      state = LoadState.success(allocation);
    } catch (e) {
      state = LoadState.error('Failed to allocate room: ${e.toString()}');
    }
  }

  Future<void> transferRoom(String allocationId, String newRoomId) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      
      final allocation = RoomAllocation(
        id: allocationId,
        studentId: 'student_id',
        roomId: newRoomId,
        allocatedAt: DateTime.now(),
        status: 'transferred',
        transferredTo: newRoomId,
      );
      
      state = LoadState.success(allocation);
    } catch (e) {
      state = LoadState.error('Failed to transfer room: ${e.toString()}');
    }
  }

  Future<void> vacateRoom(String allocationId) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      
      final allocation = RoomAllocation(
        id: allocationId,
        studentId: 'student_id',
        roomId: 'room_id',
        allocatedAt: DateTime.now(),
        status: 'vacated',
        vacatedAt: DateTime.now(),
      );
      
      state = LoadState.success(allocation);
    } catch (e) {
      state = LoadState.error('Failed to vacate room: ${e.toString()}');
    }
  }

  void clearState() {
    state = const LoadState.idle();
  }
}

class RoomMapNotifier extends StateNotifier<LoadState<RoomMap>> {
  final Ref _ref;
  RoomMap? _cachedRoomMap;

  RoomMapNotifier(this._ref) : super(const LoadState.idle()) {
    loadRoomMap();
  }

  Future<void> loadRoomMap() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      if (Environment.enableMockData) {
        // Mock data
        await Future.delayed(const Duration(seconds: 1));
        
        final roomMap = RoomMap(
          hostelId: 'hostel_1',
          roomsByFloor: {},
          blocks: {},
          availableRooms: ['101', '102', '103'],
          occupiedRooms: ['201', '202', '203'],
        );
        
        _cachedRoomMap = roomMap;
        state = LoadState.success(roomMap);
      } else {
        final hostelApiService = _ref.read(hostelApiServiceProvider);
        final roomMapData = await hostelApiService.getRoomMap('hostel_1');
        final roomMap = RoomMap.fromJson(roomMapData);
        
        _cachedRoomMap = roomMap;
        state = LoadState.success(roomMap);
      }
    } catch (e) {
      state = LoadState.error('Failed to load room map: ${e.toString()}', previousData: _cachedRoomMap);
    }
  }

  void clearCache() {
    _cachedRoomMap = null;
    state = const LoadState.idle();
  }
}

// New Notifier Classes using RoomAllocationService

class BlocksNotifierV2 extends StateNotifier<LoadStateData<List<Block>>> {
  final Ref _ref;
  final String hostelId;
  List<Block> _cachedBlocks = [];

  BlocksNotifierV2(this._ref, this.hostelId) : super(LoadStateData()) {
    loadBlocks();
  }

  Future<void> loadBlocks() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getBlocks(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedBlocks = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedBlocks);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedBlocks);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedBlocks);
    }
  }

  void clearCache() {
    _cachedBlocks = [];
    state = LoadStateData();
  }
}

class FloorsNotifier extends StateNotifier<LoadStateData<List<Floor>>> {
  final Ref _ref;
  final String blockId;
  List<Floor> _cachedFloors = [];

  FloorsNotifier(this._ref, this.blockId) : super(LoadStateData()) {
    loadFloors();
  }

  Future<void> loadFloors() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getFloors(blockId);
      
      if (result.state == LoadState.success) {
        _cachedFloors = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedFloors);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedFloors);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedFloors);
    }
  }

  void clearCache() {
    _cachedFloors = [];
    state = LoadStateData();
  }
}

class RoomsNotifierV2 extends StateNotifier<LoadStateData<List<Room>>> {
  final Ref _ref;
  final String floorId;
  List<Room> _cachedRooms = [];

  RoomsNotifierV2(this._ref, this.floorId) : super(LoadStateData()) {
    loadRooms();
  }

  Future<void> loadRooms() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getRooms(floorId);
      
      if (result.state == LoadState.success) {
        _cachedRooms = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedRooms);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedRooms);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedRooms);
    }
  }

  void clearCache() {
    _cachedRooms = [];
    state = LoadStateData();
  }
}

class BedsNotifier extends StateNotifier<LoadStateData<List<Bed>>> {
  final Ref _ref;
  final String roomId;
  List<Bed> _cachedBeds = [];

  BedsNotifier(this._ref, this.roomId) : super(LoadStateData()) {
    loadBeds();
  }

  Future<void> loadBeds() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getBeds(roomId);
      
      if (result.state == LoadState.success) {
        _cachedBeds = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedBeds);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedBeds);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedBeds);
    }
  }

  void clearCache() {
    _cachedBeds = [];
    state = LoadStateData();
  }
}

class StudentsNotifier extends StateNotifier<LoadStateData<List<Student>>> {
  final Ref _ref;
  final String hostelId;
  List<Student> _cachedStudents = [];

  StudentsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadStudents();
  }

  Future<void> loadStudents() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getUnassignedStudents(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedStudents = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedStudents);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedStudents);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedStudents);
    }
  }

  void clearCache() {
    _cachedStudents = [];
    state = LoadStateData();
  }
}

class RoomMapNotifierV2 extends StateNotifier<LoadStateData<List<RoomMapData>>> {
  final Ref _ref;
  final String hostelId;
  List<RoomMapData> _cachedRoomMap = [];

  RoomMapNotifierV2(this._ref, this.hostelId) : super(LoadStateData()) {
    loadRoomMap();
  }

  Future<void> loadRoomMap() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getRoomMap(hostelId);
      
      if (result.state == LoadState.success) {
        _cachedRoomMap = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedRoomMap);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedRoomMap);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedRoomMap);
    }
  }

  void clearCache() {
    _cachedRoomMap = [];
    state = LoadStateData();
  }
}

class AllocationHistoryNotifier extends StateNotifier<LoadStateData<List<AllocationHistory>>> {
  final Ref _ref;
  final String hostelId;
  List<AllocationHistory> _cachedHistory = [];

  AllocationHistoryNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getAllocationHistory(hostelId, limit: 50);
      
      if (result.state == LoadState.success) {
        _cachedHistory = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedHistory);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedHistory);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedHistory);
    }
  }

  void clearCache() {
    _cachedHistory = [];
    state = LoadStateData();
  }
}

class StudentRoomNotifier extends StateNotifier<LoadStateData<Room>> {
  final Ref _ref;
  final String studentId;
  Room? _cachedRoom;

  StudentRoomNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadRoom();
  }

  Future<void> loadRoom() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getStudentRoom(studentId);
      
      if (result.state == LoadState.success) {
        _cachedRoom = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedRoom);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedRoom);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedRoom);
    }
  }

  void clearCache() {
    _cachedRoom = null;
    state = LoadStateData();
  }
}

class StudentBedNotifier extends StateNotifier<LoadStateData<Bed>> {
  final Ref _ref;
  final String studentId;
  Bed? _cachedBed;

  StudentBedNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadBed();
  }

  Future<void> loadBed() async {
    if (state.state == LoadState.loading) return;
    
    state = state.copyWith(state: LoadState.loading);
    
    try {
      final roomService = _ref.read(roomAllocationServiceProvider);
      final result = await roomService.getStudentBed(studentId);
      
      if (result.state == LoadState.success) {
        _cachedBed = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedBed);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedBed);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedBed);
    }
  }

  void clearCache() {
    _cachedBed = null;
    state = LoadStateData();
  }
}
