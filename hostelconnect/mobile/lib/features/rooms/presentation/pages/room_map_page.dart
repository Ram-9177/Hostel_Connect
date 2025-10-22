// lib/features/rooms/presentation/pages/room_map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_service.dart';
import '../../../../core/guards/role_guard.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart' as ui;
import '../../data/rooms_service.dart';
import '../../domain/entities/room_entities.dart';

class RoomMapPage extends ConsumerStatefulWidget {
  const RoomMapPage({super.key});

  @override
  ConsumerState<RoomMapPage> createState() => _RoomMapPageState();
}

class _RoomMapPageState extends ConsumerState<RoomMapPage> {
  final _roomsService = RoomsService(RoomsRepository());
  Map<String, dynamic>? _roomMapData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoomMap();
  }

  Future<void> _loadRoomMap() async {
    try {
      final data = await _roomsService.getRoomMap('hostel_1');
      setState(() {
        _roomMapData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading room map: ${e.toString()}'),
          backgroundColor: IOSGradeTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['warden', 'super_admin'],
      child: Scaffold(
        backgroundColor: IOSGradeTheme.background,
        appBar: AppBar(
          title: Text(IOSGradeTheme.getTeluguLabel('room_map')),
          backgroundColor: IOSGradeTheme.surface,
          elevation: 0,
          leading: const ui.BackButton(),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadRoomMap,
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _roomMapData == null
                ? const Center(child: Text('No room data available'))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOccupancyStats(),
                        const SizedBox(height: IOSGradeTheme.spacing6),
                        _buildRoomMap(),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildOccupancyStats() {
    final rooms = (_roomMapData!['rooms'] as List)
        .map((r) => Room.fromJson(r))
        .toList();

    final totalRooms = rooms.length;
    final vacantRooms = rooms.where((r) => r.isVacant).length;
    final partiallyOccupiedRooms = rooms.where((r) => r.isPartiallyOccupied).length;
    final fullyOccupiedRooms = rooms.where((r) => r.isFullyOccupied).length;
    final occupancyRate = totalRooms > 0 ? ((fullyOccupiedRooms + partiallyOccupiedRooms) / totalRooms * 100).round() : 0;

    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Occupancy Overview',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Rooms',
                  totalRooms.toString(),
                  Icons.room_outlined,
                  IOSGradeTheme.info,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Vacant',
                  vacantRooms.toString(),
                  Icons.check_circle_outline,
                  IOSGradeTheme.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Partially Occupied',
                  partiallyOccupiedRooms.toString(),
                  Icons.warning_outlined,
                  IOSGradeTheme.warning,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Fully Occupied',
                  fullyOccupiedRooms.toString(),
                  Icons.person_outline,
                  IOSGradeTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
            decoration: BoxDecoration(
              color: IOSGradeTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Occupancy Rate',
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$occupancyRate%',
                  style: IOSGradeTheme.title2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: IOSGradeTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: IOSGradeTheme.spacing2),
          Text(
            value,
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            style: IOSGradeTheme.caption1.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRoomMap() {
    final blocks = (_roomMapData!['blocks'] as List)
        .map((b) => Block.fromJson(b))
        .toList();
    final floors = (_roomMapData!['floors'] as List)
        .map((f) => Floor.fromJson(f))
        .toList();
    final rooms = (_roomMapData!['rooms'] as List)
        .map((r) => Room.fromJson(r))
        .toList();
    final beds = (_roomMapData!['beds'] as List)
        .map((b) => Bed.fromJson(b))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Room Map',
          style: IOSGradeTheme.title2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing4),
        ...blocks.map((block) => _buildBlockMap(block, floors, rooms, beds)),
      ],
    );
  }

  Widget _buildBlockMap(Block block, List<Floor> floors, List<Room> rooms, List<Bed> beds) {
    final blockFloors = floors.where((f) => f.blockId == block.id).toList();
    
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.business_outlined,
                  color: IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing3),
              Text(
                block.name,
                style: IOSGradeTheme.headline.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          ...blockFloors.map((floor) => _buildFloorMap(floor, rooms, beds)),
        ],
      ),
    );
  }

  Widget _buildFloorMap(Floor floor, List<Room> rooms, List<Bed> beds) {
    final floorRooms = rooms.where((r) => r.floorId == floor.id).toList();
    
    return Container(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing4),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
        border: Border.all(color: IOSGradeTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            floor.name,
            style: IOSGradeTheme.callout.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          Wrap(
            spacing: IOSGradeTheme.spacing2,
            runSpacing: IOSGradeTheme.spacing2,
            children: floorRooms.map((room) => _buildRoomCard(room, beds)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(Room room, List<Bed> beds) {
    final roomBeds = beds.where((b) => b.roomId == room.id).toList();
    final occupiedBeds = roomBeds.where((b) => b.isOccupied).length;
    
    Color roomColor;
    IconData roomIcon;
    
    if (room.isVacant) {
      roomColor = IOSGradeTheme.success;
      roomIcon = Icons.check_circle_outline;
    } else if (room.isPartiallyOccupied) {
      roomColor = IOSGradeTheme.warning;
      roomIcon = Icons.warning_outlined;
    } else if (room.isFullyOccupied) {
      roomColor = IOSGradeTheme.info;
      roomIcon = Icons.person_outline;
    } else {
      roomColor = IOSGradeTheme.error;
      roomIcon = Icons.block_outlined;
    }

    return GestureDetector(
      onTap: () => _showRoomDetails(room, roomBeds),
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
        decoration: BoxDecoration(
          color: roomColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
          border: Border.all(color: roomColor.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(roomIcon, color: roomColor, size: 20),
            const SizedBox(height: IOSGradeTheme.spacing1),
            Text(
              room.roomNumber,
              style: IOSGradeTheme.caption1.copyWith(
                fontWeight: FontWeight.w600,
                color: roomColor,
              ),
            ),
            Text(
              '$occupiedBeds/${room.capacity}',
              style: IOSGradeTheme.caption2.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoomDetails(Room room, List<Bed> beds) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Room ${room.roomNumber}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Capacity: ${room.capacity}'),
            Text('Occupied: ${room.currentOccupancy}'),
            Text('Status: ${room.status.toString().split('.').last.replaceAll('_', ' ').toUpperCase()}'),
            const SizedBox(height: IOSGradeTheme.spacing3),
            Text(
              'Beds:',
              style: IOSGradeTheme.callout.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing2),
            ...beds.map((bed) => Padding(
              padding: const EdgeInsets.symmetric(vertical: IOSGradeTheme.spacing1),
              child: Row(
                children: [
                  Icon(
                    bed.isOccupied ? Icons.person : Icons.bed,
                    size: 16,
                    color: bed.isOccupied ? IOSGradeTheme.info : IOSGradeTheme.success,
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing2),
                  Text('Bed ${bed.bedNumber}'),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: IOSGradeTheme.spacing1,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: bed.isOccupied 
                          ? IOSGradeTheme.info.withOpacity(0.1)
                          : IOSGradeTheme.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      bed.isOccupied ? 'OCCUPIED' : 'VACANT',
                      style: IOSGradeTheme.caption2.copyWith(
                        color: bed.isOccupied ? IOSGradeTheme.info : IOSGradeTheme.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
