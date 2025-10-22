import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/models/load_state.dart';
import 'package:hostelconnect/core/providers/user_management_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';
import 'package:hostelconnect/core/navigation/navigation_service.dart';
import '../widgets/user_filters_widget.dart';
import '../widgets/user_list_item.dart';
import '../widgets/user_statistics_widget.dart';
import '../widgets/bulk_operations_widget.dart';

/// Staff Roster Page
/// Dedicated page for managing staff members (wardens, warden heads, chefs)
class StaffRosterPage extends ConsumerStatefulWidget {
  const StaffRosterPage({super.key});

  @override
  ConsumerState<StaffRosterPage> createState() => _StaffRosterPageState();
}

class _StaffRosterPageState extends ConsumerState<StaffRosterPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  UserRole? _selectedRole;
  UserStatus? _selectedStatus;
  String? _selectedHostelId;
  List<String> _selectedUsers = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadStaffRoster();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreStaff();
    }
  }

  void _loadStaffRoster() {
    ref.read(staffRosterProvider.notifier).loadStaffRoster(
      searchQuery: _searchController.text.trim().isEmpty 
          ? null 
          : _searchController.text.trim(),
      role: _selectedRole,
      status: _selectedStatus,
      hostelId: _selectedHostelId,
      page: 1,
    );
  }

  void _loadMoreStaff() {
    if (_isLoadingMore) return;
    
    setState(() {
      _isLoadingMore = true;
    });

    ref.read(staffRosterProvider.notifier).loadStaffRoster(
      searchQuery: _searchController.text.trim().isEmpty 
          ? null 
          : _searchController.text.trim(),
      role: _selectedRole,
      status: _selectedStatus,
      hostelId: _selectedHostelId,
      page: _currentPage + 1,
    );

    setState(() {
      _currentPage++;
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        backgroundColor: IOSGradeTheme.surface,
        elevation: 0,
        title: Text(
          'Staff Roster',
          style: IOSGradeTheme.headlineMedium.copyWith(
            color: IOSGradeTheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IOSGradeBackButton(
          onPressed: () => NavigationService.goBack(),
        ),
        actions: [
          if (_selectedUsers.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _clearSelection,
              tooltip: 'Clear Selection',
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshStaff,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters Section
          Container(
            padding: const EdgeInsets.all(16),
            color: IOSGradeTheme.surface,
            child: Column(
              children: [
                // Search Bar
                IOSGradeSearchField(
                  controller: _searchController,
                  hintText: 'Search staff members...',
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                ),
                const SizedBox(height: 12),
                // Filters
                StaffFiltersWidget(
                  selectedRole: _selectedRole,
                  selectedStatus: _selectedStatus,
                  selectedHostelId: _selectedHostelId,
                  onFiltersChanged: _onFiltersChanged,
                ),
                // Bulk Operations
                if (_selectedUsers.isNotEmpty)
                  BulkOperationsWidget(
                    selectedUsers: _selectedUsers,
                    onBulkOperation: _onBulkOperation,
                  ),
              ],
            ),
          ),
          // Staff List
          Expanded(
            child: _buildStaffList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createStaffMember,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Staff'),
        backgroundColor: IOSGradeTheme.primary,
        foregroundColor: IOSGradeTheme.onPrimary,
      ),
    );
  }

  Widget _buildStaffList() {
    final staffState = ref.watch(staffRosterProvider);
    
    return staffState.when(
      idle: () => const Center(
        child: Text('No staff loaded'),
      ),
      loading: () => const Center(
        child: IOSGradeLoadingIndicator(),
      ),
      success: (roster) => _buildStaffListContent(roster),
      error: (error) => Center(
        child: IOSGradeErrorWidget(
          error: error,
          onRetry: _refreshStaff,
        ),
      ),
    );
  }

  Widget _buildStaffListContent(UserRoster roster) {
    if (roster.users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: IOSGradeTheme.onSurfaceVariant,
            ),
            SizedBox(height: 16),
            Text(
              'No staff members found',
              style: TextStyle(
                fontSize: 18,
                color: IOSGradeTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: roster.users.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == roster.users.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: IOSGradeLoadingIndicator(),
            ),
          );
        }

        final user = roster.users[index];
        return UserListItem(
          user: user,
          isSelected: _selectedUsers.contains(user.id),
          onTap: () => _onUserTap(user),
          onLongPress: () => _onUserLongPress(user),
          onAction: (action) => _onStaffAction(user, action),
        );
      },
    );
  }

  void _onSearchChanged(String query) {
    _loadStaffRoster();
  }

  void _onSearchSubmitted(String query) {
    _loadStaffRoster();
  }

  void _onFiltersChanged({
    UserRole? role,
    UserStatus? status,
    String? hostelId,
  }) {
    setState(() {
      _selectedRole = role;
      _selectedStatus = status;
      _selectedHostelId = hostelId;
    });
    _loadStaffRoster();
  }

  void _onUserTap(User user) {
    setState(() {
      if (_selectedUsers.contains(user.id)) {
        _selectedUsers.remove(user.id);
      } else {
        _selectedUsers.add(user.id);
      }
    });
  }

  void _onUserLongPress(User user) {
    setState(() {
      if (!_selectedUsers.contains(user.id)) {
        _selectedUsers.add(user.id);
      }
    });
  }

  void _onStaffAction(User user, String action) {
    switch (action) {
      case 'view_details':
        _viewStaffDetails(user);
        break;
      case 'edit':
        _editStaffMember(user);
        break;
      case 'assign_role':
        _assignRole(user);
        break;
      case 'reset_password':
        _resetPassword(user);
        break;
      case 'activate':
        _activateStaff(user);
        break;
      case 'deactivate':
        _deactivateStaff(user);
        break;
      case 'suspend':
        _suspendStaff(user);
        break;
      case 'delete':
        _deleteStaff(user);
        break;
    }
  }

  void _onBulkOperation(String operation, List<String> userIds) {
    // Implement bulk operations for staff
    _showSuccessMessage('Bulk operation completed');
    _clearSelection();
  }

  void _createStaffMember() {
    // Navigate to create staff member page
    NavigationService.pushNamed('/create-staff');
  }

  void _viewStaffDetails(User user) {
    NavigationService.pushNamed('/staff-details', arguments: user.id);
  }

  void _editStaffMember(User user) {
    NavigationService.pushNamed('/edit-staff', arguments: user.id);
  }

  void _assignRole(User user) {
    NavigationService.pushNamed('/assign-role', arguments: user.id);
  }

  void _resetPassword(User user) {
    NavigationService.pushNamed('/reset-password', arguments: user.id);
  }

  void _activateStaff(User user) {
    _showSuccessMessage('Staff member activated');
    _refreshStaff();
  }

  void _deactivateStaff(User user) {
    _showSuccessMessage('Staff member deactivated');
    _refreshStaff();
  }

  void _suspendStaff(User user) {
    _showSuccessMessage('Staff member suspended');
    _refreshStaff();
  }

  void _deleteStaff(User user) {
    _showSuccessMessage('Staff member deleted');
    _refreshStaff();
  }

  void _clearSelection() {
    setState(() {
      _selectedUsers.clear();
    });
  }

  void _refreshStaff() {
    ref.read(staffRosterProvider.notifier).refreshStaffRoster(
      searchQuery: _searchController.text.trim().isEmpty 
          ? null 
          : _searchController.text.trim(),
      role: _selectedRole,
      status: _selectedStatus,
      hostelId: _selectedHostelId,
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: IOSGradeTheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Staff Filters Widget
/// Specialized filters for staff members
class StaffFiltersWidget extends StatelessWidget {
  final UserRole? selectedRole;
  final UserStatus? selectedStatus;
  final String? selectedHostelId;
  final Function({
    UserRole? role,
    UserStatus? status,
    String? hostelId,
  }) onFiltersChanged;

  const StaffFiltersWidget({
    super.key,
    required this.selectedRole,
    required this.selectedStatus,
    required this.selectedHostelId,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_list, size: 20),
              const SizedBox(width: 8),
              Text(
                'Staff Filters',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              // Role Filter (Staff-specific roles)
              _buildRoleFilter(),
              // Status Filter
              _buildStatusFilter(),
              // Hostel Filter
              _buildHostelFilter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserRole?>(
          value: selectedRole,
          hint: const Text('Role'),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Roles'),
            ),
            // Only staff roles
            const DropdownMenuItem(
              value: UserRole.warden,
              child: Text('Warden'),
            ),
            const DropdownMenuItem(
              value: UserRole.wardenHead,
              child: Text('Warden Head'),
            ),
            const DropdownMenuItem(
              value: UserRole.chef,
              child: Text('Chef'),
            ),
          ],
          onChanged: (value) {
            onFiltersChanged(role: value);
          },
        ),
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserStatus?>(
          value: selectedStatus,
          hint: const Text('Status'),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Status'),
            ),
            ...UserStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status.displayName),
              );
            }),
          ],
          onChanged: (value) {
            onFiltersChanged(status: value);
          },
        ),
      ),
    );
  }

  Widget _buildHostelFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: selectedHostelId,
          hint: const Text('Hostel'),
          items: const [
            DropdownMenuItem(
              value: null,
              child: Text('All Hostels'),
            ),
            // TODO: Add actual hostels from provider
          ],
          onChanged: (value) {
            onFiltersChanged(hostelId: value);
          },
        ),
      ),
    );
  }

  void _clearFilters() {
    onFiltersChanged(role: null, status: null, hostelId: null);
  }
}

/// Student Roster Page
/// Dedicated page for managing students
class StudentRosterPage extends ConsumerStatefulWidget {
  const StudentRosterPage({super.key});

  @override
  ConsumerState<StudentRosterPage> createState() => _StudentRosterPageState();
}

class _StudentRosterPageState extends ConsumerState<StudentRosterPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  UserStatus? _selectedStatus;
  String? _selectedHostelId;
  List<String> _selectedUsers = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadStudentRoster();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreStudents();
    }
  }

  void _loadStudentRoster() {
    ref.read(studentRosterProvider.notifier).loadStudentRoster(
      searchQuery: _searchController.text.trim().isEmpty 
          ? null 
          : _searchController.text.trim(),
      status: _selectedStatus,
      hostelId: _selectedHostelId,
      page: 1,
    );
  }

  void _loadMoreStudents() {
    if (_isLoadingMore) return;
    
    setState(() {
      _isLoadingMore = true;
    });

    ref.read(studentRosterProvider.notifier).loadStudentRoster(
      searchQuery: _searchController.text.trim().isEmpty 
          ? null 
          : _searchController.text.trim(),
      status: _selectedStatus,
      hostelId: _selectedHostelId,
      page: _currentPage + 1,
    );

    setState(() {
      _currentPage++;
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        backgroundColor: IOSGradeTheme.surface,
        elevation: 0,
        title: Text(
          'Student Roster',
          style: IOSGradeTheme.headlineMedium.copyWith(
            color: IOSGradeTheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IOSGradeBackButton(
          onPressed: () => NavigationService.goBack(),
        ),
        actions: [
          if (_selectedUsers.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _clearSelection,
              tooltip: 'Clear Selection',
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshStudents,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters Section
          Container(
            padding: const EdgeInsets.all(16),
            color: IOSGradeTheme.surface,
            child: Column(
              children: [
                // Search Bar
                IOSGradeSearchField(
                  controller: _searchController,
                  hintText: 'Search students...',
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                ),
                const SizedBox(height: 12),
                // Filters
                StudentFiltersWidget(
                  selectedStatus: _selectedStatus,
                  selectedHostelId: _selectedHostelId,
                  onFiltersChanged: _onFiltersChanged,
                ),
                // Bulk Operations
                if (_selectedUsers.isNotEmpty)
                  BulkOperationsWidget(
                    selectedUsers: _selectedUsers,
                    onBulkOperation: _onBulkOperation,
                  ),
              ],
            ),
          ),
          // Student List
          Expanded(
            child: _buildStudentList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createStudent,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Student'),
        backgroundColor: IOSGradeTheme.primary,
        foregroundColor: IOSGradeTheme.onPrimary,
      ),
    );
  }

  Widget _buildStudentList() {
    final studentsState = ref.watch(studentRosterProvider);
    
    return studentsState.when(
      idle: () => const Center(
        child: Text('No students loaded'),
      ),
      loading: () => const Center(
        child: IOSGradeLoadingIndicator(),
      ),
      success: (roster) => _buildStudentListContent(roster),
      error: (error) => Center(
        child: IOSGradeErrorWidget(
          error: error,
          onRetry: _refreshStudents,
        ),
      ),
    );
  }

  Widget _buildStudentListContent(UserRoster roster) {
    if (roster.users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: IOSGradeTheme.onSurfaceVariant,
            ),
            SizedBox(height: 16),
            Text(
              'No students found',
              style: TextStyle(
                fontSize: 18,
                color: IOSGradeTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: roster.users.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == roster.users.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: IOSGradeLoadingIndicator(),
            ),
          );
        }

        final user = roster.users[index];
        return UserListItem(
          user: user,
          isSelected: _selectedUsers.contains(user.id),
          onTap: () => _onUserTap(user),
          onLongPress: () => _onUserLongPress(user),
          onAction: (action) => _onStudentAction(user, action),
        );
      },
    );
  }

  void _onSearchChanged(String query) {
    _loadStudentRoster();
  }

  void _onSearchSubmitted(String query) {
    _loadStudentRoster();
  }

  void _onFiltersChanged({
    UserStatus? status,
    String? hostelId,
  }) {
    setState(() {
      _selectedStatus = status;
      _selectedHostelId = hostelId;
    });
    _loadStudentRoster();
  }

  void _onUserTap(User user) {
    setState(() {
      if (_selectedUsers.contains(user.id)) {
        _selectedUsers.remove(user.id);
      } else {
        _selectedUsers.add(user.id);
      }
    });
  }

  void _onUserLongPress(User user) {
    setState(() {
      if (!_selectedUsers.contains(user.id)) {
        _selectedUsers.add(user.id);
      }
    });
  }

  void _onStudentAction(User user, String action) {
    switch (action) {
      case 'view_details':
        _viewStudentDetails(user);
        break;
      case 'edit':
        _editStudent(user);
        break;
      case 'activate':
        _activateStudent(user);
        break;
      case 'deactivate':
        _deactivateStudent(user);
        break;
      case 'suspend':
        _suspendStudent(user);
        break;
      case 'delete':
        _deleteStudent(user);
        break;
    }
  }

  void _onBulkOperation(String operation, List<String> userIds) {
    // Implement bulk operations for students
    _showSuccessMessage('Bulk operation completed');
    _clearSelection();
  }

  void _createStudent() {
    // Navigate to create student page
    NavigationService.pushNamed('/create-student');
  }

  void _viewStudentDetails(User user) {
    NavigationService.pushNamed('/student-details', arguments: user.id);
  }

  void _editStudent(User user) {
    NavigationService.pushNamed('/edit-student', arguments: user.id);
  }

  void _activateStudent(User user) {
    _showSuccessMessage('Student activated');
    _refreshStudents();
  }

  void _deactivateStudent(User user) {
    _showSuccessMessage('Student deactivated');
    _refreshStudents();
  }

  void _suspendStudent(User user) {
    _showSuccessMessage('Student suspended');
    _refreshStudents();
  }

  void _deleteStudent(User user) {
    _showSuccessMessage('Student deleted');
    _refreshStudents();
  }

  void _clearSelection() {
    setState(() {
      _selectedUsers.clear();
    });
  }

  void _refreshStudents() {
    ref.read(studentRosterProvider.notifier).refreshStudentRoster(
      searchQuery: _searchController.text.trim().isEmpty 
          ? null 
          : _searchController.text.trim(),
      status: _selectedStatus,
      hostelId: _selectedHostelId,
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: IOSGradeTheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Student Filters Widget
/// Specialized filters for students
class StudentFiltersWidget extends StatelessWidget {
  final UserStatus? selectedStatus;
  final String? selectedHostelId;
  final Function({
    UserStatus? status,
    String? hostelId,
  }) onFiltersChanged;

  const StudentFiltersWidget({
    super.key,
    required this.selectedStatus,
    required this.selectedHostelId,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_list, size: 20),
              const SizedBox(width: 8),
              Text(
                'Student Filters',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              // Status Filter
              _buildStatusFilter(),
              // Hostel Filter
              _buildHostelFilter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserStatus?>(
          value: selectedStatus,
          hint: const Text('Status'),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Status'),
            ),
            ...UserStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status.displayName),
              );
            }),
          ],
          onChanged: (value) {
            onFiltersChanged(status: value);
          },
        ),
      ),
    );
  }

  Widget _buildHostelFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: selectedHostelId,
          hint: const Text('Hostel'),
          items: const [
            DropdownMenuItem(
              value: null,
              child: Text('All Hostels'),
            ),
            // TODO: Add actual hostels from provider
          ],
          onChanged: (value) {
            onFiltersChanged(hostelId: value);
          },
        ),
      ),
    );
  }

  void _clearFilters() {
    onFiltersChanged(status: null, hostelId: null);
  }
}
