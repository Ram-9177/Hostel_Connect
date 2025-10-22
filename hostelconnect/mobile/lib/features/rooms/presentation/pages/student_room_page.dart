// lib/features/rooms/presentation/pages/student_room_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_service.dart';
import '../../../../core/guards/role_guard.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart' as ui;
import '../../data/rooms_service.dart';
import '../../domain/entities/room_entities.dart';

class StudentRoomPage extends ConsumerStatefulWidget {
  const StudentRoomPage({super.key});

  @override
  ConsumerState<StudentRoomPage> createState() => _StudentRoomPageState();
}

class _StudentRoomPageState extends ConsumerState<StudentRoomPage> {
  final _roomsService = RoomsService(RoomsRepository());
  RoomAllocation? _currentAllocation;
  Room? _room;
  List<Bed> _beds = [];
  List<Student> _roommates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentRoomData();
  }

  Future<void> _loadStudentRoomData() async {
    try {
      final authState = ref.read(AuthService.authStateProvider);
      final studentId = authState.user?.id ?? 'student_1';
      
      final allocation = await _roomsService.getCurrentAllocation(studentId);
      if (allocation != null) {
        setState(() {
          _currentAllocation = allocation;
        });
        
        // Load room details
        final rooms = await _roomsService.getRooms('hostel_1');
        final room = rooms.firstWhere((r) => r.id == allocation.roomId);
        
        // Load bed details
        final beds = await _roomsService.getBeds(allocation.roomId);
        
        setState(() {
          _room = room;
          _beds = beds;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading room data: ${e.toString()}'),
          backgroundColor: IOSGradeTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['student'],
      child: Scaffold(
        backgroundColor: IOSGradeTheme.background,
        appBar: AppBar(
          title: const Text('My Room'),
          backgroundColor: IOSGradeTheme.surface,
          elevation: 0,
          leading: const ui.BackButton(),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _currentAllocation == null
                ? _buildNoRoomAssigned()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRoomInfo(),
                        const SizedBox(height: IOSGradeTheme.spacing6),
                        _buildBedInfo(),
                        const SizedBox(height: IOSGradeTheme.spacing6),
                        _buildRoommates(),
                        const SizedBox(height: IOSGradeTheme.spacing6),
                        _buildRoomRules(),
                        const SizedBox(height: IOSGradeTheme.spacing6),
                        _buildFloorMap(),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildNoRoomAssigned() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
              decoration: BoxDecoration(
                color: IOSGradeTheme.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusXLarge),
              ),
              child: const Icon(
                Icons.home_outlined,
                size: 64,
                color: IOSGradeTheme.warning,
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing6),
            Text(
              'No Room Assigned',
              style: IOSGradeTheme.title1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing3),
            Text(
              'You haven\'t been assigned to a room yet. Please contact your warden for room allocation.',
              style: IOSGradeTheme.body.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: IOSGradeTheme.spacing6),
            ElevatedButton(
              onPressed: () => _contactWarden(),
              child: const Text('Contact Warden'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomInfo() {
    if (_room == null) return const SizedBox.shrink();

    return IOSGradeCard(
      backgroundColor: IOSGradeTheme.primary.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.room_outlined,
                  color: IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room ${_room!.roomNumber}',
                      style: IOSGradeTheme.title1.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Block A • Ground Floor',
                      style: IOSGradeTheme.callout.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Capacity',
                  '${_room!.capacity} beds',
                  Icons.people_outline,
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  'Occupancy',
                  '${_room!.currentOccupancy}/${_room!.capacity}',
                  Icons.person_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
            decoration: BoxDecoration(
              color: _getRoomStatusColor(_room!.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Row(
              children: [
                Icon(
                  _getRoomStatusIcon(_room!.status),
                  color: _getRoomStatusColor(_room!.status),
                  size: 20,
                ),
                const SizedBox(width: IOSGradeTheme.spacing2),
                Text(
                  'Status: ${_room!.status.toString().split('.').last.replaceAll('_', ' ').toUpperCase()}',
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _getRoomStatusColor(_room!.status),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBedInfo() {
    final myBed = _beds.firstWhere(
      (bed) => bed.id == _currentAllocation!.bedId,
      orElse: () => Bed(
        id: '',
        roomId: '',
        bedNumber: 'N/A',
        status: BedStatus.vacant,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Bed Assignment',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.bed_outlined,
                  color: IOSGradeTheme.success,
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bed ${myBed.bedNumber}',
                      style: IOSGradeTheme.headline.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Allocated on ${_formatDate(_currentAllocation!.allocatedAt)}',
                      style: IOSGradeTheme.callout.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: IOSGradeTheme.spacing2,
                  vertical: IOSGradeTheme.spacing1,
                ),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: Text(
                  'OCCUPIED',
                  style: IOSGradeTheme.caption1.copyWith(
                    color: IOSGradeTheme.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoommates() {
    final roommateBeds = _beds.where((bed) => bed.isOccupied && bed.id != _currentAllocation!.bedId).toList();

    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Roommates',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          if (roommateBeds.isEmpty)
            Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
              decoration: BoxDecoration(
                color: IOSGradeTheme.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: IOSGradeTheme.info,
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing2),
                  Text(
                    'You are the only occupant in this room',
                    style: IOSGradeTheme.callout.copyWith(
                      color: IOSGradeTheme.info,
                    ),
                  ),
                ],
              ),
            )
          else
            ...roommateBeds.map((bed) => _buildRoommateCard(bed)),
        ],
      ),
    );
  }

  Widget _buildRoommateCard(Bed bed) {
    return Container(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing2),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
        border: Border.all(color: IOSGradeTheme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
            decoration: BoxDecoration(
              color: IOSGradeTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: const Icon(
              Icons.person_outline,
              color: IOSGradeTheme.primary,
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student ${bed.studentId}',
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Bed ${bed.bedNumber}',
                  style: IOSGradeTheme.footnote.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomRules() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hostel Rules',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          _buildRuleItem('Curfew Time', '10:00 PM - 6:00 AM'),
          _buildRuleItem('Visitors', 'No visitors allowed in rooms'),
          _buildRuleItem('Noise', 'Maintain silence after 10:00 PM'),
          _buildRuleItem('Cleanliness', 'Keep room clean and tidy'),
          _buildRuleItem('Electrical', 'No unauthorized electrical appliances'),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: IOSGradeTheme.spacing2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: IOSGradeTheme.spacing1),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: IOSGradeTheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: IOSGradeTheme.footnote.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloorMap() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Floor Map',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
            decoration: BoxDecoration(
              color: IOSGradeTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Column(
              children: [
                Text(
                  'Room Layout',
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: IOSGradeTheme.spacing3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _beds.map((bed) => _buildBedInMap(bed)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBedInMap(Bed bed) {
    final isMyBed = bed.id == _currentAllocation!.bedId;
    
    return Container(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
      decoration: BoxDecoration(
        color: isMyBed 
            ? IOSGradeTheme.primary.withOpacity(0.1)
            : bed.isOccupied 
                ? IOSGradeTheme.info.withOpacity(0.1)
                : IOSGradeTheme.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
        border: Border.all(
          color: isMyBed 
              ? IOSGradeTheme.primary
              : bed.isOccupied 
                  ? IOSGradeTheme.info
                  : IOSGradeTheme.success,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isMyBed ? Icons.person : bed.isOccupied ? Icons.person_outline : Icons.bed,
            color: isMyBed 
                ? IOSGradeTheme.primary
                : bed.isOccupied 
                    ? IOSGradeTheme.info
                    : IOSGradeTheme.success,
            size: 20,
          ),
          const SizedBox(height: IOSGradeTheme.spacing1),
          Text(
            bed.bedNumber,
            style: IOSGradeTheme.caption1.copyWith(
              fontWeight: FontWeight.w600,
              color: isMyBed 
                  ? IOSGradeTheme.primary
                  : bed.isOccupied 
                      ? IOSGradeTheme.info
                      : IOSGradeTheme.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: IOSGradeTheme.textSecondary, size: 20),
        const SizedBox(height: IOSGradeTheme.spacing1),
        Text(
          value,
          style: IOSGradeTheme.callout.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: IOSGradeTheme.caption1.copyWith(
            color: IOSGradeTheme.textSecondary,
          ),
        ),
      ],
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

  IconData _getRoomStatusIcon(RoomStatus status) {
    switch (status) {
      case RoomStatus.vacant:
        return Icons.check_circle_outline;
      case RoomStatus.partiallyOccupied:
        return Icons.warning_outlined;
      case RoomStatus.fullyOccupied:
        return Icons.person_outline;
      case RoomStatus.blocked:
        return Icons.block_outlined;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _contactWarden() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contact warden feature coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Mock Student class for roommates
class Student {
  final String id;
  final String name;

  const Student({required this.id, required this.name});
}
