// lib/features/rooms/presentation/pages/enhanced_ios_room_allotment_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../core/guards/role_guard.dart';

class EnhancedIOSRoomAllotmentPage extends ConsumerStatefulWidget {
  const EnhancedIOSRoomAllotmentPage({super.key});

  @override
  ConsumerState<EnhancedIOSRoomAllotmentPage> createState() => _EnhancedIOSRoomAllotmentPageState();
}

class _EnhancedIOSRoomAllotmentPageState extends ConsumerState<EnhancedIOSRoomAllotmentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  String? _selectedStudentId;
  String? _selectedRoomId;
  String? _selectedBedId;
  String? _selectedFromStudentId;
  String? _selectedToStudentId;
  
  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> rooms = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    
    _loadData();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      students = [
        {'id': '1', 'name': 'John Doe', 'studentId': 'STU001', 'currentRoom': null},
        {'id': '2', 'name': 'Jane Smith', 'studentId': 'STU002', 'currentRoom': '101'},
        {'id': '3', 'name': 'Mike Johnson', 'studentId': 'STU003', 'currentRoom': '102'},
        {'id': '4', 'name': 'Sarah Wilson', 'studentId': 'STU004', 'currentRoom': null},
      ];
      rooms = [
        {'id': '1', 'roomNumber': '101', 'blockName': 'Block A', 'availableBeds': 2, 'totalBeds': 4},
        {'id': '2', 'roomNumber': '102', 'blockName': 'Block A', 'availableBeds': 1, 'totalBeds': 4},
        {'id': '3', 'roomNumber': '201', 'blockName': 'Block B', 'availableBeds': 3, 'totalBeds': 4},
        {'id': '4', 'roomNumber': '202', 'blockName': 'Block B', 'availableBeds': 4, 'totalBeds': 4},
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['warden', 'super_admin'],
      child: Scaffold(
        backgroundColor: IOSGradeTheme.background,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    _buildAppBar(),
                    _buildTabBar(),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildAllocateTab(),
                          _buildTransferTab(),
                          _buildSwapTab(),
                          _buildVacateTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: IOSGradeTheme.background,
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: IOSGradeTheme.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Allotment',
                  style: IOSGradeTheme.title2.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Manage student room assignments',
                  style: IOSGradeTheme.footnote.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: IOSGradeTheme.spacing3,
              vertical: IOSGradeTheme.spacing1,
            ),
            decoration: BoxDecoration(
              color: IOSGradeTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Text(
              'Warden',
              style: IOSGradeTheme.caption1.copyWith(
                color: IOSGradeTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: IOSGradeTheme.surface,
      child: TabBar(
        controller: _tabController,
        indicatorColor: IOSGradeTheme.primary,
        indicatorWeight: 3,
        labelColor: IOSGradeTheme.primary,
        unselectedLabelColor: IOSGradeTheme.textSecondary,
        labelStyle: IOSGradeTheme.footnote.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: IOSGradeTheme.footnote,
        tabs: const [
          Tab(
            icon: Icon(Icons.add_circle_outline, size: 20),
            text: 'Allocate',
          ),
          Tab(
            icon: Icon(Icons.swap_horiz_outlined, size: 20),
            text: 'Transfer',
          ),
          Tab(
            icon: Icon(Icons.swap_vert_outlined, size: 20),
            text: 'Swap',
          ),
          Tab(
            icon: Icon(Icons.remove_circle_outline, size: 20),
            text: 'Vacate',
          ),
        ],
      ),
    );
  }

  Widget _buildAllocateTab() {
    if (isLoading) {
      return const Center(
        child: IOSGradeLoadingIndicator(message: 'Loading data...'),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IOSGradeSectionHeader(
            title: 'Allocate Room',
            subtitle: 'Assign a room to an unassigned student',
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          
          IOSGradeCard(
            child: Column(
              children: [
                _buildStudentSelector(),
                const SizedBox(height: IOSGradeTheme.spacing4),
                _buildRoomSelector(),
                const SizedBox(height: IOSGradeTheme.spacing4),
                _buildBedSelector(),
                const SizedBox(height: IOSGradeTheme.spacing6),
                IOSGradeButton(
                  text: 'Allocate Room',
                  icon: Icons.check_circle_outline,
                  onPressed: _selectedStudentId != null && _selectedRoomId != null
                      ? _allocateRoom
                      : null,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: IOSGradeTheme.spacing6),
          
          const IOSGradeSectionHeader(
            title: 'Unassigned Students',
            subtitle: 'Students without room assignments',
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          
          ...students.where((s) => s['currentRoom'] == null).map((student) => 
            _buildStudentCard(student, showAllocate: true),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IOSGradeSectionHeader(
            title: 'Transfer Student',
            subtitle: 'Move student to a different room',
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          
          IOSGradeCard(
            child: Column(
              children: [
                _buildFromStudentSelector(),
                const SizedBox(height: IOSGradeTheme.spacing4),
                _buildToRoomSelector(),
                const SizedBox(height: IOSGradeTheme.spacing6),
                IOSGradeButton(
                  text: 'Transfer Student',
                  icon: Icons.swap_horiz_outlined,
                  onPressed: _selectedFromStudentId != null && _selectedRoomId != null
                      ? _transferStudent
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IOSGradeSectionHeader(
            title: 'Swap Students',
            subtitle: 'Exchange rooms between two students',
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          
          IOSGradeCard(
            child: Column(
              children: [
                _buildFromStudentSelector(),
                const SizedBox(height: IOSGradeTheme.spacing4),
                _buildToStudentSelector(),
                const SizedBox(height: IOSGradeTheme.spacing6),
                IOSGradeButton(
                  text: 'Swap Students',
                  icon: Icons.swap_vert_outlined,
                  onPressed: _selectedFromStudentId != null && _selectedToStudentId != null
                      ? _swapStudents
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVacateTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IOSGradeSectionHeader(
            title: 'Vacate Room',
            subtitle: 'Remove student from their current room',
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          
          IOSGradeCard(
            child: Column(
              children: [
                _buildStudentSelector(),
                const SizedBox(height: IOSGradeTheme.spacing6),
                IOSGradeButton(
                  text: 'Vacate Room',
                  icon: Icons.remove_circle_outline,
                  isDestructive: true,
                  onPressed: _selectedStudentId != null
                      ? _vacateRoom
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Student',
          style: IOSGradeTheme.headline.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Container(
          decoration: BoxDecoration(
            color: IOSGradeTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            border: Border.all(color: IOSGradeTheme.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedStudentId,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                child: Text('Choose a student'),
              ),
              items: students.map((student) {
                return DropdownMenuItem<String>(
                  value: student['id'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                    child: Text(student['name']),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStudentId = value;
                });
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Room',
          style: IOSGradeTheme.headline.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Container(
          decoration: BoxDecoration(
            color: IOSGradeTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            border: Border.all(color: IOSGradeTheme.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedRoomId,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                child: Text('Choose a room'),
              ),
              items: rooms.where((room) => room['availableBeds'] > 0).map((room) {
                return DropdownMenuItem<String>(
                  value: room['id'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                    child: Text('${room['roomNumber']} - ${room['blockName']} (${room['availableBeds']} beds)'),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRoomId = value;
                });
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBedSelector() {
    if (_selectedRoomId == null) return const SizedBox.shrink();
    
    final room = rooms.firstWhere((r) => r['id'] == _selectedRoomId);
    final availableBeds = room['availableBeds'] as int;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Bed',
          style: IOSGradeTheme.headline.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Container(
          decoration: BoxDecoration(
            color: IOSGradeTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            border: Border.all(color: IOSGradeTheme.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedBedId,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                child: Text('Choose a bed'),
              ),
              items: List.generate(availableBeds, (index) {
                final bedNumber = index + 1;
                return DropdownMenuItem<String>(
                  value: bedNumber.toString(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                    child: Text('Bed $bedNumber'),
                  ),
                );
              }),
              onChanged: (value) {
                setState(() {
                  _selectedBedId = value;
                });
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFromStudentSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From Student',
          style: IOSGradeTheme.headline.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Container(
          decoration: BoxDecoration(
            color: IOSGradeTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            border: Border.all(color: IOSGradeTheme.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFromStudentId,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                child: Text('Choose student'),
              ),
              items: students.where((s) => s['currentRoom'] != null).map((student) {
                return DropdownMenuItem<String>(
                  value: student['id'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                    child: Text('${student['name']} (Room ${student['currentRoom']})'),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFromStudentId = value;
                });
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToStudentSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'To Student',
          style: IOSGradeTheme.headline.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Container(
          decoration: BoxDecoration(
            color: IOSGradeTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            border: Border.all(color: IOSGradeTheme.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedToStudentId,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                child: Text('Choose student'),
              ),
              items: students.where((s) => s['currentRoom'] != null && s['id'] != _selectedFromStudentId).map((student) {
                return DropdownMenuItem<String>(
                  value: student['id'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                    child: Text('${student['name']} (Room ${student['currentRoom']})'),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedToStudentId = value;
                });
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToRoomSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'To Room',
          style: IOSGradeTheme.headline.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Container(
          decoration: BoxDecoration(
            color: IOSGradeTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            border: Border.all(color: IOSGradeTheme.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedRoomId,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                child: Text('Choose room'),
              ),
              items: rooms.where((room) => room['availableBeds'] > 0).map((room) {
                return DropdownMenuItem<String>(
                  value: room['id'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing4),
                    child: Text('${room['roomNumber']} - ${room['blockName']}'),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRoomId = value;
                });
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student, {bool showAllocate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: IOSGradeTheme.spacing2),
      child: IOSGradeListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: IOSGradeTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
          ),
          child: const Icon(
            Icons.person_outline,
            color: IOSGradeTheme.primary,
            size: 20,
          ),
        ),
        title: student['name'],
        subtitle: 'ID: ${student['studentId']}',
        trailing: showAllocate
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedStudentId = student['id'];
                  });
                  HapticFeedback.lightImpact();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: IOSGradeTheme.spacing2,
                    vertical: IOSGradeTheme.spacing1,
                  ),
                  decoration: BoxDecoration(
                    color: IOSGradeTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                  ),
                  child: Text(
                    'Allocate',
                    style: IOSGradeTheme.caption1.copyWith(
                      color: IOSGradeTheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  void _allocateRoom() {
    HapticFeedback.mediumImpact();
    // TODO: Implement room allocation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Room allocated successfully!'),
        backgroundColor: IOSGradeTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        ),
      ),
    );
  }

  void _transferStudent() {
    HapticFeedback.mediumImpact();
    // TODO: Implement student transfer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Student transferred successfully!'),
        backgroundColor: IOSGradeTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        ),
      ),
    );
  }

  void _swapStudents() {
    HapticFeedback.mediumImpact();
    // TODO: Implement student swap
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Students swapped successfully!'),
        backgroundColor: IOSGradeTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        ),
      ),
    );
  }

  void _vacateRoom() {
    HapticFeedback.mediumImpact();
    // TODO: Implement room vacation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Room vacated successfully!'),
        backgroundColor: IOSGradeTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        ),
      ),
    );
  }
}
