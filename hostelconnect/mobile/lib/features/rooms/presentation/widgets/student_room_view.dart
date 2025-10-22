// lib/features/rooms/presentation/widgets/student_room_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/room_models.dart';
import '../../../../core/services/room_allocation_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class StudentRoomView extends ConsumerStatefulWidget {
  final String studentId;
  final bool isCompact;

  const StudentRoomView({
    super.key,
    required this.studentId,
    this.isCompact = false,
  });

  @override
  ConsumerState<StudentRoomView> createState() => _StudentRoomViewState();
}

class _StudentRoomViewState extends ConsumerState<StudentRoomView> {
  Room? _room;
  Bed? _bed;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStudentRoomData();
  }

  Future<void> _loadStudentRoomData() async {
    setState(() => _isLoading = true);
    
    try {
      final roomService = ref.read(roomAllocationServiceProvider);
      
      // Load room and bed data in parallel
      final roomResult = await roomService.getStudentRoom(widget.studentId);
      final bedResult = await roomService.getStudentBed(widget.studentId);
      
      setState(() {
        if (roomResult.state == LoadState.success) {
          _room = roomResult.data;
        }
        if (bedResult.state == LoadState.success) {
          _bed = bedResult.data;
        }
        _isLoading = false;
        _error = roomResult.error ?? bedResult.error;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return widget.isCompact
          ? const SizedBox(
              height: 60,
              child: Center(child: CircularProgressIndicator()),
            )
          : const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return widget.isCompact
          ? IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: IOSGradeTheme.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Unable to load room information',
                        style: IOSGradeTheme.bodyMedium.copyWith(
                          color: IOSGradeTheme.error,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _loadStudentRoomData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: IOSGradeTheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error Loading Room',
                    style: IOSGradeTheme.titleLarge.copyWith(
                      color: IOSGradeTheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: IOSGradeTheme.bodyLarge.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _loadStudentRoomData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
    }

    if (_room == null && _bed == null) {
      return widget.isCompact
          ? IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      color: IOSGradeTheme.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'No room assigned',
                        style: IOSGradeTheme.bodyMedium.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 64,
                    color: IOSGradeTheme.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Room Assigned',
                    style: IOSGradeTheme.titleLarge.copyWith(
                      color: IOSGradeTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You haven\'t been assigned to a room yet.\nPlease contact your warden.',
                    style: IOSGradeTheme.bodyLarge.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
    }

    return widget.isCompact ? _buildCompactView() : _buildFullView();
  }

  Widget _buildCompactView() {
    return IOSGradeCard(
      child: InkWell(
        onTap: () => _showRoomDetails(),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.home,
                  color: IOSGradeTheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Room',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: IOSGradeTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _room != null 
                          ? 'Room ${_room!.roomNumber} • Bed ${_bed?.bedNumber ?? 'N/A'}'
                          : 'Bed ${_bed?.bedNumber ?? 'N/A'}',
                      style: IOSGradeTheme.bodyMedium.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                    if (_room != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${_room!.currentOccupancy}/${_room!.capacity} occupants',
                        style: IOSGradeTheme.footnote.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: IOSGradeTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Header
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusLarge),
                    ),
                    child: const Icon(
                      Icons.home,
                      size: 32,
                      color: IOSGradeTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Room',
                          style: IOSGradeTheme.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: IOSGradeTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_room != null) ...[
                          Text(
                            'Room ${_room!.roomNumber}',
                            style: IOSGradeTheme.titleMedium.copyWith(
                              color: IOSGradeTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_room!.roomType.name.toUpperCase()} • ${_room!.capacity} beds',
                            style: IOSGradeTheme.bodyMedium.copyWith(
                              color: IOSGradeTheme.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Bed Information
          if (_bed != null) ...[
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bed,
                          color: IOSGradeTheme.secondary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'My Bed',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: IOSGradeTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Bed Number', 'Bed ${_bed!.bedNumber}'),
                    _buildInfoRow('Bed Type', _bed!.bedType.name.toUpperCase()),
                    _buildInfoRow('Status', _bed!.status.name.toUpperCase()),
                    if (_bed!.allocatedAt != null)
                      _buildInfoRow('Allocated On', _formatDate(_bed!.allocatedAt!)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Room Details
          if (_room != null) ...[
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: IOSGradeTheme.info,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Room Details',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: IOSGradeTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Room Number', _room!.roomNumber),
                    _buildInfoRow('Room Type', _room!.roomType.name.toUpperCase()),
                    _buildInfoRow('Capacity', '${_room!.capacity} beds'),
                    _buildInfoRow('Current Occupancy', '${_room!.currentOccupancy} students'),
                    _buildInfoRow('Status', _room!.status.name.toUpperCase()),
                    if (_room!.description.isNotEmpty)
                      _buildInfoRow('Description', _room!.description),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Roommates
          if (_room != null && _room!.occupants.isNotEmpty) ...[
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          color: IOSGradeTheme.secondary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Roommates',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: IOSGradeTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ..._room!.occupants.map((occupant) => _buildRoommateCard(occupant)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Actions
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: IOSGradeTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showRoomDetails(),
                          icon: const Icon(Icons.info_outline),
                          label: const Text('Room Details'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _requestRoomChange(),
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text('Request Change'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoommateCard(Student roommate) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: IOSGradeTheme.secondary.withOpacity(0.1),
            child: Text(
              roommate.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: IOSGradeTheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roommate.name,
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: IOSGradeTheme.textPrimary,
                  ),
                ),
                Text(
                  roommate.studentId,
                  style: IOSGradeTheme.footnote.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showRoommateDetails(roommate),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showRoomDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_room != null ? 'Room ${_room!.roomNumber}' : 'My Bed'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_room != null) ...[
                Text('Room Type: ${_room!.roomType.name.toUpperCase()}'),
                Text('Capacity: ${_room!.capacity} beds'),
                Text('Current Occupancy: ${_room!.currentOccupancy} students'),
                Text('Status: ${_room!.status.name.toUpperCase()}'),
                if (_room!.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text('Description: ${_room!.description}'),
                ],
                const SizedBox(height: 16),
              ],
              if (_bed != null) ...[
                Text('Bed Number: ${_bed!.bedNumber}'),
                Text('Bed Type: ${_bed!.bedType.name.toUpperCase()}'),
                Text('Status: ${_bed!.status.name.toUpperCase()}'),
                if (_bed!.allocatedAt != null)
                  Text('Allocated On: ${_formatDate(_bed!.allocatedAt!)}'),
              ],
            ],
          ),
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

  void _requestRoomChange() {
    Toast.showInfo(context, 'Room change request feature coming soon');
  }

  void _showRoommateDetails(Student roommate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(roommate.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Student ID: ${roommate.studentId}'),
            Text('Email: ${roommate.email}'),
            Text('Status: ${roommate.status.name.toUpperCase()}'),
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
