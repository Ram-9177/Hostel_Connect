// lib/features/study_room/presentation/pages/study_room_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StudyRoomPage extends ConsumerStatefulWidget {
  const StudyRoomPage({super.key});

  @override
  ConsumerState<StudyRoomPage> createState() => _StudyRoomPageState();
}

class _StudyRoomPageState extends ConsumerState<StudyRoomPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Mock data - replace with actual API
  final List<Room> _rooms = [
    Room(
      id: '1',
      name: 'Study Room 1',
      floor: 'Ground Floor',
      capacity: 6,
      occupied: 4,
      amenities: ['WiFi', 'Whiteboard', 'AC'],
    ),
    Room(
      id: '2',
      name: 'Study Room 2',
      floor: 'Ground Floor',
      capacity: 8,
      occupied: 0,
      amenities: ['WiFi', 'Projector', 'Whiteboard', 'AC'],
    ),
    Room(
      id: '3',
      name: 'Conference Room',
      floor: 'First Floor',
      capacity: 20,
      occupied: 15,
      amenities: ['WiFi', 'Projector', 'Video Conference', 'AC', 'Speakers'],
    ),
    Room(
      id: '4',
      name: 'Study Room 3',
      floor: 'First Floor',
      capacity: 4,
      occupied: 4,
      amenities: ['WiFi', 'Whiteboard'],
    ),
    Room(
      id: '5',
      name: 'Reading Room',
      floor: 'Second Floor',
      capacity: 12,
      occupied: 8,
      amenities: ['WiFi', 'Silent Zone', 'AC'],
    ),
  ];

  final List<Booking> _myBookings = [
    Booking(
      id: '1',
      roomName: 'Study Room 2',
      date: DateTime.now(),
      startTime: '02:00 PM',
      endTime: '04:00 PM',
      status: 'Active',
    ),
    Booking(
      id: '2',
      roomName: 'Conference Room',
      date: DateTime.now().add(const Duration(days: 2)),
      startTime: '10:00 AM',
      endTime: '12:00 PM',
      status: 'Upcoming',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Rooms'),
        backgroundColor: const Color(0xFF7E22CE),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7E22CE), Color(0xFFA855F7)],
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Available Rooms'),
            Tab(text: 'My Bookings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAvailableRoomsTab(),
          _buildMyBookingsTab(),
        ],
      ),
    );
  }

  Widget _buildAvailableRoomsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _rooms.length,
      itemBuilder: (context, index) {
        final room = _rooms[index];
        return _buildRoomCard(room);
      },
    );
  }

  Widget _buildRoomCard(Room room) {
    final isAvailable = room.occupied < room.capacity;
    final occupancyPercentage = (room.occupied / room.capacity * 100).toInt();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                room.floor,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isAvailable ? 'Available' : 'Full',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isAvailable ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Occupancy Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Occupancy',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${room.occupied}/${room.capacity} seats',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: room.occupied / room.capacity,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          occupancyPercentage < 50
                              ? const Color(0xFF10B981)
                              : occupancyPercentage < 80
                                  ? const Color(0xFFF59E0B)
                                  : const Color(0xFFEF4444),
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                
                // Amenities
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: room.amenities.map((amenity) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7E22CE).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getAmenityIcon(amenity),
                            size: 14,
                            color: const Color(0xFF7E22CE),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            amenity,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF7E22CE),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          if (isAvailable)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7E22CE), Color(0xFFA855F7)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showBookingDialog(room),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.event_available, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Book Room',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMyBookingsTab() {
    if (_myBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No bookings yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _myBookings.length,
      itemBuilder: (context, index) {
        final booking = _myBookings[index];
        return _buildBookingCard(booking);
      },
    );
  }

  Widget _buildBookingCard(Booking booking) {
    final isActive = booking.status == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isActive ? const Color(0xFF10B981) : const Color(0xFF3B82F6)).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.roomName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF10B981).withOpacity(0.1)
                        : const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  DateFormat('MMM dd, yyyy').format(booking.date),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  '${booking.startTime} - ${booking.endTime}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            if (isActive) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _cancelBooking(booking),
                  icon: const Icon(Icons.cancel, size: 18),
                  label: const Text('Cancel Booking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'whiteboard':
        return Icons.border_color;
      case 'projector':
        return Icons.videocam;
      case 'ac':
        return Icons.ac_unit;
      case 'video conference':
        return Icons.video_call;
      case 'speakers':
        return Icons.speaker;
      case 'silent zone':
        return Icons.volume_off;
      default:
        return Icons.check_circle;
    }
  }

  void _showBookingDialog(Room room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book ${room.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select date and time for your booking:'),
            const SizedBox(height: 16),
            // In a real app, add date/time pickers here
            Text(
              'Date: ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              'Time: 02:00 PM - 04:00 PM',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Room booked successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E22CE),
            ),
            child: const Text('Confirm Booking'),
          ),
        ],
      ),
    );
  }

  void _cancelBooking(Booking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: Text('Are you sure you want to cancel your booking for ${booking.roomName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking cancelled')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}

class Room {
  final String id;
  final String name;
  final String floor;
  final int capacity;
  final int occupied;
  final List<String> amenities;

  Room({
    required this.id,
    required this.name,
    required this.floor,
    required this.capacity,
    required this.occupied,
    required this.amenities,
  });
}

class Booking {
  final String id;
  final String roomName;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String status;

  Booking({
    required this.id,
    required this.roomName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
  });
}
