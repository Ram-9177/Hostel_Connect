// lib/features/rooms/presentation/pages/admin_room_management_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/room_models.dart';
import '../../../../core/services/room_allocation_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

class AdminRoomManagementPage extends ConsumerStatefulWidget {
  const AdminRoomManagementPage({super.key});

  @override
  ConsumerState<AdminRoomManagementPage> createState() => _AdminRoomManagementPageState();
}

class _AdminRoomManagementPageState extends ConsumerState<AdminRoomManagementPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1';
  
  // Data lists
  List<Block> _blocks = [];
  List<Floor> _floors = [];
  List<Room> _rooms = [];
  List<Bed> _beds = [];
  
  // Loading states
  bool _isLoadingBlocks = false;
  bool _isLoadingFloors = false;
  bool _isLoadingRooms = false;
  bool _isLoadingBeds = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    await _loadBlocks();
  }

  Future<void> _loadBlocks() async {
    setState(() => _isLoadingBlocks = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getBlocks(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _blocks = result.data ?? [];
          _isLoadingBlocks = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load blocks');
        setState(() => _isLoadingBlocks = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading blocks: $e');
      setState(() => _isLoadingBlocks = false);
    }
  }

  Future<void> _loadFloors(String blockId) async {
    setState(() => _isLoadingFloors = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getFloors(blockId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _floors = result.data ?? [];
          _isLoadingFloors = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load floors');
        setState(() => _isLoadingFloors = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading floors: $e');
      setState(() => _isLoadingFloors = false);
    }
  }

  Future<void> _loadRooms(String floorId) async {
    setState(() => _isLoadingRooms = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getRooms(floorId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _rooms = result.data ?? [];
          _isLoadingRooms = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load rooms');
        setState(() => _isLoadingRooms = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading rooms: $e');
      setState(() => _isLoadingRooms = false);
    }
  }

  Future<void> _loadBeds(String roomId) async {
    setState(() => _isLoadingBeds = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getBeds(roomId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _beds = result.data ?? [];
          _isLoadingBeds = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load beds');
        setState(() => _isLoadingBeds = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading beds: $e');
      setState(() => _isLoadingBeds = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Room Management'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Blocks', icon: Icon(Icons.business)),
            Tab(text: 'Floors', icon: Icon(Icons.layers)),
            Tab(text: 'Rooms', icon: Icon(Icons.room)),
            Tab(text: 'Beds', icon: Icon(Icons.bed)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showImportExportDialog,
            icon: const Icon(Icons.import_export),
          ),
        ],
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
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBlocksTab() {
    if (_isLoadingBlocks) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadBlocks,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _blocks.length,
        itemBuilder: (context, index) {
          final block = _blocks[index];
          return IOSGradeCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: IOSGradeTheme.primary.withOpacity(0.1),
                child: Text(
                  block.name.substring(0, 1),
                  style: const TextStyle(
                    color: IOSGradeTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(block.name),
              subtitle: Text('${block.floors} floors • ${block.description}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _editBlock(block),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _deleteBlock(block),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              onTap: () {
                _loadFloors(block.id);
                _tabController.animateTo(1);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloorsTab() {
    if (_isLoadingFloors) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () => _loadFloors(_blocks.isNotEmpty ? _blocks.first.id : ''),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _floors.length,
        itemBuilder: (context, index) {
          final floor = _floors[index];
          return IOSGradeCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: IOSGradeTheme.secondary.withOpacity(0.1),
                child: Text(
                  floor.floorNumber.toString(),
                  style: const TextStyle(
                    color: IOSGradeTheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(floor.name),
              subtitle: Text('Floor ${floor.floorNumber} • ${floor.description}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _editFloor(floor),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _deleteFloor(floor),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              onTap: () {
                _loadRooms(floor.id);
                _tabController.animateTo(2);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoomsTab() {
    if (_isLoadingRooms) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () => _loadRooms(_floors.isNotEmpty ? _floors.first.id : ''),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index];
          return IOSGradeCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getRoomStatusColor(room.status).withOpacity(0.1),
                child: Icon(
                  Icons.room,
                  color: _getRoomStatusColor(room.status),
                ),
              ),
              title: Text('Room ${room.roomNumber}'),
              subtitle: Text(
                '${room.currentOccupancy}/${room.capacity} • ${room.roomType.name}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _editRoom(room),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _deleteRoom(room),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              onTap: () {
                _loadBeds(room.id);
                _tabController.animateTo(3);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBedsTab() {
    if (_isLoadingBeds) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () => _loadBeds(_rooms.isNotEmpty ? _rooms.first.id : ''),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _beds.length,
        itemBuilder: (context, index) {
          final bed = _beds[index];
          return IOSGradeCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getBedStatusColor(bed.status).withOpacity(0.1),
                child: Icon(
                  Icons.bed,
                  color: _getBedStatusColor(bed.status),
                ),
              ),
              title: Text('Bed ${bed.bedNumber}'),
              subtitle: Text(
                bed.studentName ?? 'Available • ${bed.bedType.name}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _editBed(bed),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _deleteBed(bed),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _showCreateDialog,
      icon: const Icon(Icons.add),
      label: Text(_getCreateLabel()),
      backgroundColor: IOSGradeTheme.primary,
      foregroundColor: Colors.white,
    );
  }

  String _getCreateLabel() {
    switch (_tabController.index) {
      case 0:
        return 'Create Block';
      case 1:
        return 'Create Floor';
      case 2:
        return 'Create Room';
      case 3:
        return 'Create Bed';
      default:
        return 'Create';
    }
  }

  Color _getRoomStatusColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return IOSGradeTheme.success;
      case RoomStatus.occupied:
        return IOSGradeTheme.warning;
      case RoomStatus.maintenance:
        return IOSGradeTheme.error;
      case RoomStatus.reserved:
        return IOSGradeTheme.info;
    }
  }

  Color _getBedStatusColor(BedStatus status) {
    switch (status) {
      case BedStatus.available:
        return IOSGradeTheme.success;
      case BedStatus.occupied:
        return IOSGradeTheme.warning;
      case BedStatus.maintenance:
        return IOSGradeTheme.error;
      case BedStatus.reserved:
        return IOSGradeTheme.info;
    }
  }

  void _showCreateDialog() {
    switch (_tabController.index) {
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
    final floorsController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Block'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Block Name'),
            ),
            TextField(
              controller: floorsController,
              decoration: const InputDecoration(labelText: 'Number of Floors'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
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
              if (nameController.text.isNotEmpty && floorsController.text.isNotEmpty) {
                await _createBlock(
                  nameController.text,
                  int.parse(floorsController.text),
                  descriptionController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showCreateFloorDialog() {
    // Implementation for create floor dialog
    Toast.showInfo(context, 'Create Floor dialog - Implementation needed');
  }

  void _showCreateRoomDialog() {
    // Implementation for create room dialog
    Toast.showInfo(context, 'Create Room dialog - Implementation needed');
  }

  void _showCreateBedDialog() {
    // Implementation for create bed dialog
    Toast.showInfo(context, 'Create Bed dialog - Implementation needed');
  }

  Future<void> _createBlock(String name, int floors, String description) async {
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.createBlock(_selectedHostelId, name, floors, description);
      
      if (result.state == LoadState.success) {
        Toast.showSuccess(context, 'Block created successfully');
        _loadBlocks();
      } else {
        Toast.showError(context, result.error ?? 'Failed to create block');
      }
    } catch (e) {
      Toast.showError(context, 'Error creating block: $e');
    }
  }

  void _editBlock(Block block) {
    Toast.showInfo(context, 'Edit Block - Implementation needed');
  }

  void _deleteBlock(Block block) {
    Toast.showInfo(context, 'Delete Block - Implementation needed');
  }

  void _editFloor(Floor floor) {
    Toast.showInfo(context, 'Edit Floor - Implementation needed');
  }

  void _deleteFloor(Floor floor) {
    Toast.showInfo(context, 'Delete Floor - Implementation needed');
  }

  void _editRoom(Room room) {
    Toast.showInfo(context, 'Edit Room - Implementation needed');
  }

  void _deleteRoom(Room room) {
    Toast.showInfo(context, 'Delete Room - Implementation needed');
  }

  void _editBed(Bed bed) {
    Toast.showInfo(context, 'Edit Bed - Implementation needed');
  }

  void _deleteBed(Bed bed) {
    Toast.showInfo(context, 'Delete Bed - Implementation needed');
  }

  void _showImportExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import/Export'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Import Rooms from CSV'),
              onTap: _importRoomsFromCSV,
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Rooms to CSV'),
              onTap: _exportRoomsToCSV,
            ),
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Import Allocations from CSV'),
              onTap: _importAllocationsFromCSV,
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Allocations to CSV'),
              onTap: _exportAllocationsToCSV,
            ),
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

  Future<void> _importRoomsFromCSV() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null) {
        final file = result.files.first;
        final csvData = String.fromCharCodes(file.bytes!);
        
        final roomService = ref.read(roomAllocationServiceProvider);
        final importResult = await roomService.importRoomsFromCSV(csvData);
        
        if (importResult.state == LoadState.success) {
          Toast.showSuccess(context, 'Rooms imported successfully');
          _loadInitialData();
        } else {
          Toast.showError(context, importResult.error ?? 'Failed to import rooms');
        }
      }
    } catch (e) {
      Toast.showError(context, 'Error importing rooms: $e');
    }
  }

  Future<void> _exportRoomsToCSV() async {
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.exportRoomsToCSV(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        Toast.showSuccess(context, 'Rooms exported successfully');
        // In a real app, you would save the file to device storage
      } else {
        Toast.showError(context, result.error ?? 'Failed to export rooms');
      }
    } catch (e) {
      Toast.showError(context, 'Error exporting rooms: $e');
    }
  }

  Future<void> _importAllocationsFromCSV() async {
    Toast.showInfo(context, 'Import Allocations - Implementation needed');
  }

  Future<void> _exportAllocationsToCSV() async {
    Toast.showInfo(context, 'Export Allocations - Implementation needed');
  }
}
