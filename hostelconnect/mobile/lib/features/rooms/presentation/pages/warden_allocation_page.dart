// lib/features/rooms/presentation/pages/warden_allocation_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/room_models.dart';
import '../../../../core/services/room_allocation_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class WardenAllocationPage extends ConsumerStatefulWidget {
  const WardenAllocationPage({super.key});

  @override
  ConsumerState<WardenAllocationPage> createState() => _WardenAllocationPageState();
}

class _WardenAllocationPageState extends ConsumerState<WardenAllocationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1';
  
  // Data
  List<Student> _unassignedStudents = [];
  List<Bed> _availableBeds = [];
  List<RoomMapData> _roomMap = [];
  List<AllocationHistory> _allocationHistory = [];
  
  // Loading states
  bool _isLoadingStudents = false;
  bool _isLoadingBeds = false;
  bool _isLoadingRoomMap = false;
  bool _isLoadingHistory = false;

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
    await Future.wait([
      _loadUnassignedStudents(),
      _loadAvailableBeds(),
      _loadRoomMap(),
      _loadAllocationHistory(),
    ]);
  }

  Future<void> _loadUnassignedStudents() async {
    setState(() => _isLoadingStudents = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getUnassignedStudents(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _unassignedStudents = result.data ?? [];
          _isLoadingStudents = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load students');
        setState(() => _isLoadingStudents = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading students: $e');
      setState(() => _isLoadingStudents = false);
    }
  }

  Future<void> _loadAvailableBeds() async {
    setState(() => _isLoadingBeds = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getAvailableBeds(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _availableBeds = result.data ?? [];
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

  Future<void> _loadRoomMap() async {
    setState(() => _isLoadingRoomMap = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getRoomMap(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _roomMap = result.data ?? [];
          _isLoadingRoomMap = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load room map');
        setState(() => _isLoadingRoomMap = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading room map: $e');
      setState(() => _isLoadingRoomMap = false);
    }
  }

  Future<void> _loadAllocationHistory() async {
    setState(() => _isLoadingHistory = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.getAllocationHistory(_selectedHostelId, limit: 50);
      
      if (result.state == LoadState.success) {
        setState(() {
          _allocationHistory = result.data ?? [];
          _isLoadingHistory = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load history');
        setState(() => _isLoadingHistory = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading history: $e');
      setState(() => _isLoadingHistory = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Room Allocation'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Allocate', icon: Icon(Icons.person_add)),
            Tab(text: 'Transfer', icon: Icon(Icons.swap_horiz)),
            Tab(text: 'Swap', icon: Icon(Icons.swap_vert)),
            Tab(text: 'Map', icon: Icon(Icons.map)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _loadInitialData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllocateTab(),
          _buildTransferTab(),
          _buildSwapTab(),
          _buildRoomMapTab(),
        ],
      ),
    );
  }

  Widget _buildAllocateTab() {
    if (_isLoadingStudents || _isLoadingBeds) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () => Future.wait([_loadUnassignedStudents(), _loadAvailableBeds()]),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Unassigned Students Section
          Text(
            'Unassigned Students (${_unassignedStudents.length})',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._unassignedStudents.map((student) => _buildStudentCard(student)),
          
          const SizedBox(height: 24),
          
          // Available Beds Section
          Text(
            'Available Beds (${_availableBeds.length})',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._availableBeds.map((bed) => _buildBedCard(bed)),
        ],
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: IOSGradeTheme.primary.withOpacity(0.1),
          child: Text(
            student.name.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: IOSGradeTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(student.name),
        subtitle: Text('${student.studentId} • ${student.email}'),
        trailing: ElevatedButton(
          onPressed: () => _showAllocateDialog(student),
          child: const Text('Allocate'),
        ),
      ),
    );
  }

  Widget _buildBedCard(Bed bed) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: IOSGradeTheme.success.withOpacity(0.1),
          child: const Icon(
            Icons.bed,
            color: IOSGradeTheme.success,
          ),
        ),
        title: Text('Bed ${bed.bedNumber}'),
        subtitle: Text('Room ${bed.roomId} • ${bed.bedType.name}'),
        trailing: Text(
          'Available',
          style: TextStyle(
            color: IOSGradeTheme.success,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTransferTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.swap_horiz,
            size: 64,
            color: IOSGradeTheme.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Transfer Student',
            style: IOSGradeTheme.titleLarge.copyWith(
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a student to transfer to a different bed',
            style: IOSGradeTheme.bodyLarge.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _showTransferDialog,
            child: const Text('Start Transfer'),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.swap_vert,
            size: 64,
            color: IOSGradeTheme.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Swap Students',
            style: IOSGradeTheme.titleLarge.copyWith(
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Swap two students between their current beds',
            style: IOSGradeTheme.bodyLarge.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _showSwapDialog,
            child: const Text('Start Swap'),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomMapTab() {
    if (_isLoadingRoomMap) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadRoomMap,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room Map',
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: IOSGradeTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            
            // Legend
            _buildLegend(),
            const SizedBox(height: 16),
            
            // Room Map Grid
            _buildRoomMapGrid(),
            
            const SizedBox(height: 24),
            
            // Allocation History
            Text(
              'Recent Allocations',
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: IOSGradeTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ..._allocationHistory.take(10).map((history) => _buildHistoryItem(history)),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Legend',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildLegendItem('Available', IOSGradeTheme.success),
              const SizedBox(width: 16),
              _buildLegendItem('Occupied', IOSGradeTheme.warning),
              const SizedBox(width: 16),
              _buildLegendItem('Maintenance', IOSGradeTheme.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: IOSGradeTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildRoomMapGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _roomMap.length,
      itemBuilder: (context, index) {
        final room = _roomMap[index];
        return _buildRoomMapItem(room);
      },
    );
  }

  Widget _buildRoomMapItem(RoomMapData room) {
    return GestureDetector(
      onTap: () => _showRoomDetails(room),
      child: Container(
        decoration: BoxDecoration(
          color: _getRoomMapColor(room.status),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: IOSGradeTheme.border,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              room.roomNumber,
              style: IOSGradeTheme.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '${room.currentOccupancy}/${room.capacity}',
              style: IOSGradeTheme.footnote.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(AllocationHistory history) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getActionColor(history.action).withOpacity(0.1),
          child: Icon(
            _getActionIcon(history.action),
            color: _getActionColor(history.action),
            size: 20,
          ),
        ),
        title: Text(history.studentName),
        subtitle: Text(
          '${_getActionText(history.action)} • ${_formatDate(history.createdAt)}',
        ),
        trailing: Text(
          history.performedByName,
          style: IOSGradeTheme.footnote.copyWith(
            color: IOSGradeTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  Color _getRoomMapColor(RoomStatus status) {
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

  Color _getActionColor(AllocationAction action) {
    switch (action) {
      case AllocationAction.allocate:
        return IOSGradeTheme.success;
      case AllocationAction.transfer:
        return IOSGradeTheme.info;
      case AllocationAction.swap:
        return IOSGradeTheme.secondary;
      case AllocationAction.vacate:
        return IOSGradeTheme.error;
      case AllocationAction.reserve:
        return IOSGradeTheme.warning;
      case AllocationAction.unreserve:
        return IOSGradeTheme.textSecondary;
    }
  }

  IconData _getActionIcon(AllocationAction action) {
    switch (action) {
      case AllocationAction.allocate:
        return Icons.person_add;
      case AllocationAction.transfer:
        return Icons.swap_horiz;
      case AllocationAction.swap:
        return Icons.swap_vert;
      case AllocationAction.vacate:
        return Icons.person_remove;
      case AllocationAction.reserve:
        return Icons.bookmark;
      case AllocationAction.unreserve:
        return Icons.bookmark_remove;
    }
  }

  String _getActionText(AllocationAction action) {
    switch (action) {
      case AllocationAction.allocate:
        return 'Allocated';
      case AllocationAction.transfer:
        return 'Transferred';
      case AllocationAction.swap:
        return 'Swapped';
      case AllocationAction.vacate:
        return 'Vacated';
      case AllocationAction.reserve:
        return 'Reserved';
      case AllocationAction.unreserve:
        return 'Unreserved';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showAllocateDialog(Student student) {
    final reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Allocate ${student.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select a bed for ${student.name}:'),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _availableBeds.length,
                itemBuilder: (context, index) {
                  final bed = _availableBeds[index];
                  return ListTile(
                    leading: const Icon(Icons.bed),
                    title: Text('Bed ${bed.bedNumber}'),
                    subtitle: Text('Room ${bed.roomId}'),
                    onTap: () async {
                      Navigator.pop(context);
                      await _allocateBed(student, bed, reasonController.text);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (optional)',
                hintText: 'Enter reason for allocation',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _allocateBed(Student student, Bed bed, String reason) async {
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      final result = await roomService.allocateBed(
        student.id,
        bed.id,
        reason.isEmpty ? 'Initial allocation' : reason,
        'warden_user_id', // In real app, get from auth service
      );
      
      if (result.state == LoadState.success) {
        Toast.showSuccess(context, '${student.name} allocated to Bed ${bed.bedNumber}');
        _loadInitialData();
      } else {
        Toast.showError(context, result.error ?? 'Failed to allocate bed');
      }
    } catch (e) {
      Toast.showError(context, 'Error allocating bed: $e');
    }
  }

  void _showTransferDialog() {
    Toast.showInfo(context, 'Transfer dialog - Implementation needed');
  }

  void _showSwapDialog() {
    Toast.showInfo(context, 'Swap dialog - Implementation needed');
  }

  void _showRoomDetails(RoomMapData room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Room ${room.roomNumber}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${room.status.name}'),
            Text('Capacity: ${room.currentOccupancy}/${room.capacity}'),
            const SizedBox(height: 16),
            Text('Beds:', style: IOSGradeTheme.titleMedium),
            ...room.beds.map((bed) => ListTile(
              leading: Icon(
                Icons.bed,
                color: bed.status == BedStatus.occupied 
                    ? IOSGradeTheme.warning 
                    : IOSGradeTheme.success,
              ),
              title: Text('Bed ${bed.bedNumber}'),
              subtitle: Text(bed.studentName ?? 'Available'),
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
