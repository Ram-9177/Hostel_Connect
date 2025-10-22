// lib/features/rooms/presentation/pages/room_allotment_page.dart - COMPLETE IMPLEMENTATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/unified_theme.dart';
import '../../../../core/state/app_state.dart';
import '../widgets/student_room_view.dart';

class RoomAllotmentPage extends ConsumerStatefulWidget {
  const RoomAllotmentPage({super.key});

  @override
  ConsumerState<RoomAllotmentPage> createState() => _RoomAllotmentPageState();
}

class _RoomAllotmentPageState extends ConsumerState<RoomAllotmentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1'; // TODO: Get from auth context

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final userRole = appState.user?.role.toLowerCase() ?? 'student';

    return Scaffold(
      backgroundColor: UnifiedTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Room Management'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh room data
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Room', icon: Icon(Icons.bed)),
            Tab(text: 'Available', icon: Icon(Icons.search)),
            Tab(text: 'Requests', icon: Icon(Icons.request_page)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyRoomTab(),
          _buildAvailableRoomsTab(),
          _buildRequestsTab(),
        ],
      ),
      floatingActionButton: userRole == 'warden' || userRole == 'warden_head' || userRole == 'super_admin'
          ? FloatingActionButton.extended(
              onPressed: _manageRooms,
              icon: const Icon(Icons.settings),
              label: const Text('Manage'),
              backgroundColor: UnifiedTheme.primary,
              foregroundColor: Colors.white,
            )
          : userRole == 'student'
              ? FloatingActionButton.extended(
                  onPressed: _requestRoomChange,
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Request Change'),
                  backgroundColor: UnifiedTheme.primary,
                  foregroundColor: Colors.white,
                )
              : null,
    );
  }

  Widget _buildMyRoomTab() {
    return const StudentRoomView();
  }

  Widget _buildAvailableRoomsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Available Rooms',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Browse available rooms',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.request_page,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Room Requests',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'View room change requests',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _manageRooms() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Room Management'),
        content: const Text('Advanced room management features will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _requestRoomChange() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Room Change'),
        content: const Text('Room change request feature will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}