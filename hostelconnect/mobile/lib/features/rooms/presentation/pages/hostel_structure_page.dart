// lib/features/rooms/presentation/pages/hostel_structure_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_service.dart';
import '../../../../core/guards/role_guard.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart' as ui;
import '../../data/rooms_service.dart';
import '../../domain/entities/room_entities.dart';

class HostelStructurePage extends ConsumerStatefulWidget {
  const HostelStructurePage({super.key});

  @override
  ConsumerState<HostelStructurePage> createState() => _HostelStructurePageState();
}

class _HostelStructurePageState extends ConsumerState<HostelStructurePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _roomsService = RoomsService(RoomsRepository());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['super_admin'],
      child: Scaffold(
        backgroundColor: IOSGradeTheme.background,
        appBar: AppBar(
          title: Text(IOSGradeTheme.getTeluguLabel('room_allotment')),
          backgroundColor: IOSGradeTheme.surface,
          elevation: 0,
          leading: const ui.BackButton(),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Blocks', icon: Icon(Icons.business_outlined)),
              Tab(text: 'Floors', icon: Icon(Icons.layers_outlined)),
              Tab(text: 'Rooms', icon: Icon(Icons.room_outlined)),
              Tab(text: 'Beds', icon: Icon(Icons.bed_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildBlocksTab(),
            _buildFloorsTab(),
            _buildRoomsTab(),
            _buildBedsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateDialog(),
          backgroundColor: IOSGradeTheme.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBlocksTab() {
    return FutureBuilder<List<Block>>(
      future: _roomsService.getBlocks('hostel_1'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final blocks = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
          itemCount: blocks.length,
          itemBuilder: (context, index) {
            final block = blocks[index];
            return IOSGradeCard(
              child: ListTile(
                leading: Container(
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
                title: Text(
                  block.name,
                  style: IOSGradeTheme.headline,
                ),
                subtitle: Text(
                  '${block.floors} floors',
                  style: IOSGradeTheme.callout.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onSelected: (value) => _handleBlockAction(value, block),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFloorsTab() {
    return FutureBuilder<List<Floor>>(
      future: _roomsService.getFloors('block_1'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final floors = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
          itemCount: floors.length,
          itemBuilder: (context, index) {
            final floor = floors[index];
            return IOSGradeCard(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
                  decoration: BoxDecoration(
                    color: IOSGradeTheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                  ),
                  child: const Icon(
                    Icons.layers_outlined,
                    color: IOSGradeTheme.secondary,
                  ),
                ),
                title: Text(
                  floor.name,
                  style: IOSGradeTheme.headline,
                ),
                subtitle: Text(
                  'Floor ${floor.floorNumber}',
                  style: IOSGradeTheme.callout.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onSelected: (value) => _handleFloorAction(value, floor),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRoomsTab() {
    return FutureBuilder<List<Room>>(
      future: _roomsService.getRooms('hostel_1'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final rooms = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            final room = rooms[index];
            return IOSGradeCard(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
                  decoration: BoxDecoration(
                    color: _getRoomStatusColor(room.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                  ),
                  child: Icon(
                    Icons.room_outlined,
                    color: _getRoomStatusColor(room.status),
                  ),
                ),
                title: Text(
                  'Room ${room.roomNumber}',
                  style: IOSGradeTheme.headline,
                ),
                subtitle: Text(
                  '${room.currentOccupancy}/${room.capacity} occupied',
                  style: IOSGradeTheme.callout.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: IOSGradeTheme.spacing2,
                        vertical: IOSGradeTheme.spacing1,
                      ),
                      decoration: BoxDecoration(
                        color: _getRoomStatusColor(room.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                      ),
                      child: Text(
                        room.status.toString().split('.').last.replaceAll('_', ' ').toUpperCase(),
                        style: IOSGradeTheme.caption1.copyWith(
                          color: _getRoomStatusColor(room.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                      onSelected: (value) => _handleRoomAction(value, room),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBedsTab() {
    return FutureBuilder<List<Bed>>(
      future: _roomsService.getBeds('room_1'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final beds = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
          itemCount: beds.length,
          itemBuilder: (context, index) {
            final bed = beds[index];
            return IOSGradeCard(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
                  decoration: BoxDecoration(
                    color: _getBedStatusColor(bed.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                  ),
                  child: Icon(
                    Icons.bed_outlined,
                    color: _getBedStatusColor(bed.status),
                  ),
                ),
                title: Text(
                  'Bed ${bed.bedNumber}',
                  style: IOSGradeTheme.headline,
                ),
                subtitle: Text(
                  bed.studentId != null ? 'Occupied by ${bed.studentId}' : 'Vacant',
                  style: IOSGradeTheme.callout.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: IOSGradeTheme.spacing2,
                        vertical: IOSGradeTheme.spacing1,
                      ),
                      decoration: BoxDecoration(
                        color: _getBedStatusColor(bed.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                      ),
                      child: Text(
                        bed.status.toString().split('.').last.toUpperCase(),
                        style: IOSGradeTheme.caption1.copyWith(
                          color: _getBedStatusColor(bed.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                      onSelected: (value) => _handleBedAction(value, bed),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getRoomStatusColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.vacant:
        return IOSGradeTheme.success;
      case RoomStatus.partiallyOccupied:
        return IOSGradeTheme.warning;
      case RoomStatus.fullyOccupied:
        return IOSGradeTheme.info;
      case RoomStatus.blocked:
        return IOSGradeTheme.error;
    }
  }

  Color _getBedStatusColor(BedStatus status) {
    switch (status) {
      case BedStatus.vacant:
        return IOSGradeTheme.success;
      case BedStatus.occupied:
        return IOSGradeTheme.info;
      case BedStatus.blocked:
        return IOSGradeTheme.error;
      case BedStatus.reserved:
        return IOSGradeTheme.warning;
    }
  }

  void _showCreateDialog() {
    final currentTab = _tabController.index;
    
    switch (currentTab) {
      case 0:
        _showCreateBlockDialog();
        break;
      case 1:
        _showCreateFloorDialog();
        break;
      case 2:
        _showCreateRoomDialog();
        break;
      case 3:
        _showCreateBedDialog();
        break;
    }
  }

  void _showCreateBlockDialog() {
    final nameController = TextEditingController();
    final floorsController = TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Block'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Block Name',
                hintText: 'e.g., Block A',
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing4),
            TextField(
              controller: floorsController,
              decoration: const InputDecoration(
                labelText: 'Number of Floors',
                hintText: 'e.g., 3',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _roomsService.createBlock(
                name: nameController.text,
                hostelId: 'hostel_1',
                floors: int.tryParse(floorsController.text) ?? 1,
              );
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showCreateFloorDialog() {
    final nameController = TextEditingController();
    final floorNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Floor'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Floor Name',
                hintText: 'e.g., Ground Floor',
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing4),
            TextField(
              controller: floorNumberController,
              decoration: const InputDecoration(
                labelText: 'Floor Number',
                hintText: 'e.g., 1',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _roomsService.createFloor(
                blockId: 'block_1',
                floorNumber: int.tryParse(floorNumberController.text) ?? 1,
                name: nameController.text,
              );
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showCreateRoomDialog() {
    final roomNumberController = TextEditingController();
    final capacityController = TextEditingController(text: '2');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Room'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: roomNumberController,
              decoration: const InputDecoration(
                labelText: 'Room Number',
                hintText: 'e.g., 101',
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing4),
            TextField(
              controller: capacityController,
              decoration: const InputDecoration(
                labelText: 'Capacity',
                hintText: 'e.g., 2',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _roomsService.createRoom(
                roomNumber: roomNumberController.text,
                blockId: 'block_1',
                floorId: 'floor_1',
                hostelId: 'hostel_1',
                capacity: int.tryParse(capacityController.text) ?? 2,
              );
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showCreateBedDialog() {
    final bedNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Bed'),
        content: TextField(
          controller: bedNumberController,
          decoration: const InputDecoration(
            labelText: 'Bed Number',
            hintText: 'e.g., A or 1',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _roomsService.createBed(
                roomId: 'room_1',
                bedNumber: bedNumberController.text,
              );
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _handleBlockAction(String action, Block block) {
    switch (action) {
      case 'edit':
        // TODO: Implement edit
        break;
      case 'delete':
        _showDeleteConfirmation('block', block.name, () async {
          await _roomsService.deleteBlock(block.id);
          setState(() {});
        });
        break;
    }
  }

  void _handleFloorAction(String action, Floor floor) {
    switch (action) {
      case 'edit':
        // TODO: Implement edit
        break;
      case 'delete':
        _showDeleteConfirmation('floor', floor.name, () async {
          await _roomsService.deleteFloor(floor.id);
          setState(() {});
        });
        break;
    }
  }

  void _handleRoomAction(String action, Room room) {
    switch (action) {
      case 'edit':
        // TODO: Implement edit
        break;
      case 'delete':
        _showDeleteConfirmation('room', room.roomNumber, () async {
          await _roomsService.deleteRoom(room.id);
          setState(() {});
        });
        break;
    }
  }

  void _handleBedAction(String action, Bed bed) {
    switch (action) {
      case 'edit':
        // TODO: Implement edit
        break;
      case 'delete':
        _showDeleteConfirmation('bed', bed.bedNumber, () async {
          await _roomsService.deleteBed(bed.id);
          setState(() {});
        });
        break;
    }
  }

  void _showDeleteConfirmation(String type, String name, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Confirmation'),
        content: Text('Are you sure you want to delete this $type "$name"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: IOSGradeTheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
