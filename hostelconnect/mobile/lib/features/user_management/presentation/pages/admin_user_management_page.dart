import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/providers/auth_provider.dart';
import 'package:hostelconnect/core/models/load_state.dart';
import 'package:hostelconnect/core/providers/user_management_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';
import 'package:hostelconnect/core/navigation/navigation_service.dart';
import '../widgets/user_creation_dialog.dart';
import '../widgets/user_edit_dialog.dart';
import '../widgets/role_assignment_dialog.dart';
import '../widgets/password_reset_dialog.dart';
import '../widgets/user_status_dialog.dart';
import '../widgets/user_filters_widget.dart';
import '../widgets/user_list_item.dart';
import '../widgets/bulk_operations_widget.dart';

/// Admin User Management Page
/// Comprehensive user management interface for Super Admin
class AdminUserManagementPage extends ConsumerStatefulWidget {
  const AdminUserManagementPage({super.key});

  @override
  ConsumerState<AdminUserManagementPage> createState() => _AdminUserManagementPageState();
}

class _AdminUserManagementPageState extends ConsumerState<AdminUserManagementPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<String> _selectedUsers = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    // Load users, staff roster, and student roster
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).loadUsers(
        const UserSearchFilters(),
      );
      ref.read(staffRosterProvider.notifier).loadStaffRoster();
      ref.read(studentRosterProvider.notifier).loadStudentRoster();
      ref.read(userStatisticsProvider.notifier).loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final role = auth.role?.toLowerCase() ?? 'student';
    final canBulk = ['admin', 'warden_head', 'warden', 'super_admin'].contains(role);
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        backgroundColor: IOSGradeTheme.surface,
        elevation: 0,
        title: Text(
          'User Management',
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
            onPressed: _refreshData,
            tooltip: 'Refresh',
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'create_user',
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Create User'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'export_users',
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Export Users'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              if (canBulk)
                const PopupMenuItem(
                  value: 'import_users',
                  child: ListTile(
                    leading: Icon(Icons.upload),
                    title: Text('Import Users (Bulk)'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Users'),
            Tab(text: 'Staff'),
            Tab(text: 'Students'),
          ],
          labelColor: IOSGradeTheme.primary,
          unselectedLabelColor: IOSGradeTheme.onSurfaceVariant,
          indicatorColor: IOSGradeTheme.primary,
        ),
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
                  hintText: 'Search users...',
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                ),
                const SizedBox(height: 12),
                // Filters
                UserFiltersWidget(
                  onFiltersChanged: _onFiltersChanged,
                ),
                // Bulk Operations
                if (_selectedUsers.isNotEmpty && canBulk)
                  BulkOperationsWidget(
                    selectedUsers: _selectedUsers,
                    onBulkOperation: _onBulkOperation,
                  ),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllUsersTab(),
                _buildStaffTab(),
                _buildStudentsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createUser,
        icon: const Icon(Icons.person_add),
        label: const Text('Create User'),
        backgroundColor: IOSGradeTheme.primary,
        foregroundColor: IOSGradeTheme.onPrimary,
      ),
    );
  }

  Widget _buildAllUsersTab() {
    final usersState = ref.watch(usersProvider);
    
    return usersState.when(
      idle: () => const Center(
        child: Text('No users loaded'),
      ),
      loading: () => const Center(
        child: IOSGradeLoadingIndicator(),
      ),
      success: (roster) => _buildUserList(roster.users, _onUserAction),
      error: (error) => Center(
        child: IOSGradeErrorWidget(
          error: error,
          onRetry: () => _refreshData(),
        ),
      ),
    );
  }

  Widget _buildStaffTab() {
    final staffState = ref.watch(staffRosterProvider);
    
    return staffState.when(
      idle: () => const Center(
        child: Text('No staff loaded'),
      ),
      loading: () => const Center(
        child: IOSGradeLoadingIndicator(),
      ),
      success: (roster) => _buildUserList(roster.users, _onStaffAction),
      error: (error) => Center(
        child: IOSGradeErrorWidget(
          error: error,
          onRetry: () => _refreshStaffData(),
        ),
      ),
    );
  }

  Widget _buildStudentsTab() {
    final studentsState = ref.watch(studentRosterProvider);
    
    return studentsState.when(
      idle: () => const Center(
        child: Text('No students loaded'),
      ),
      loading: () => const Center(
        child: IOSGradeLoadingIndicator(),
      ),
      success: (roster) => _buildUserList(roster.users, _onStudentAction),
      error: (error) => Center(
        child: IOSGradeErrorWidget(
          error: error,
          onRetry: () => _refreshStudentData(),
        ),
      ),
    );
  }

  Widget _buildUserList(List<User> users, Function(User, String) onAction) {
    if (users.isEmpty) {
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
              'No users found',
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
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserListItem(
          user: user,
          isSelected: _selectedUsers.contains(user.id),
          onTap: () => _onUserTap(user),
          onLongPress: () => _onUserLongPress(user),
          onAction: (action) => onAction(user, action),
        );
      },
    );
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
      });
      _refreshData();
    } else {
      setState(() {
        _isSearching = true;
      });
      _performSearch(query);
    }
  }

  void _onSearchSubmitted(String query) {
    _performSearch(query);
  }

  void _performSearch(String query) {
    final filters = UserSearchFilters(searchQuery: query);
    
    switch (_tabController.index) {
      case 0:
        ref.read(usersProvider.notifier).loadUsers(filters);
        break;
      case 1:
        ref.read(staffRosterProvider.notifier).loadStaffRoster(
          searchQuery: query,
        );
        break;
      case 2:
        ref.read(studentRosterProvider.notifier).loadStudentRoster(
          searchQuery: query,
        );
        break;
    }
  }

  void _onFiltersChanged(UserSearchFilters filters) {
    switch (_tabController.index) {
      case 0:
        ref.read(usersProvider.notifier).loadUsers(filters);
        break;
      case 1:
        ref.read(staffRosterProvider.notifier).loadStaffRoster(
          searchQuery: filters.searchQuery,
          role: filters.role,
          status: filters.status,
          hostelId: filters.hostelId,
        );
        break;
      case 2:
        ref.read(studentRosterProvider.notifier).loadStudentRoster(
          searchQuery: filters.searchQuery,
          status: filters.status,
          hostelId: filters.hostelId,
        );
        break;
    }
  }

  void _onUserTap(User user) {
    if (_selectedUsers.contains(user.id)) {
      setState(() {
        _selectedUsers.remove(user.id);
      });
    } else {
      setState(() {
        _selectedUsers.add(user.id);
      });
    }
  }

  void _onUserLongPress(User user) {
    setState(() {
      if (!_selectedUsers.contains(user.id)) {
        _selectedUsers.add(user.id);
      }
    });
  }

  void _onUserAction(User user, String action) {
    switch (action) {
      case 'edit':
        _editUser(user);
        break;
      case 'assign_role':
        _assignRole(user);
        break;
      case 'reset_password':
        _resetPassword(user);
        break;
      case 'activate':
        _activateUser(user);
        break;
      case 'deactivate':
        _deactivateUser(user);
        break;
      case 'suspend':
        _suspendUser(user);
        break;
      case 'delete':
        _deleteUser(user);
        break;
      case 'view_details':
        _viewUserDetails(user);
        break;
    }
  }

  void _onStaffAction(User user, String action) {
    _onUserAction(user, action);
  }

  void _onStudentAction(User user, String action) {
    _onUserAction(user, action);
  }

  void _onBulkOperation(String operation, List<String> userIds) {
    final request = BulkUserOperationRequest(
      userIds: userIds,
      operation: BulkOperationType.values.firstWhere(
        (type) => type.name == operation,
      ),
    );

    ref.read(bulkOperationsProvider.notifier).performBulkOperation(request);
    
    // Clear selection after operation
    setState(() {
      _selectedUsers.clear();
    });
  }

  void _createUser() {
    showDialog(
      context: context,
      builder: (context) => UserCreationDialog(
        onUserCreated: (user) {
          _refreshData();
          _showSuccessMessage('User created successfully');
        },
      ),
    );
  }

  void _editUser(User user) {
    showDialog(
      context: context,
      builder: (context) => UserEditDialog(
        user: user,
        onUserUpdated: (updatedUser) {
          _refreshData();
          _showSuccessMessage('User updated successfully');
        },
      ),
    );
  }

  void _assignRole(User user) {
    showDialog(
      context: context,
      builder: (context) => RoleAssignmentDialog(
        user: user,
        onRoleAssigned: (updatedUser) {
          _refreshData();
          _showSuccessMessage('Role assigned successfully');
        },
      ),
    );
  }

  void _resetPassword(User user) {
    showDialog(
      context: context,
      builder: (context) => PasswordResetDialog(
        user: user,
        onPasswordReset: () {
          _showSuccessMessage('Password reset successfully');
        },
      ),
    );
  }

  void _activateUser(User user) {
    showDialog(
      context: context,
      builder: (context) => UserStatusDialog(
        user: user,
        newStatus: UserStatus.active,
        onStatusChanged: (updatedUser) {
          _refreshData();
          _showSuccessMessage('User activated successfully');
        },
      ),
    );
  }

  void _deactivateUser(User user) {
    showDialog(
      context: context,
      builder: (context) => UserStatusDialog(
        user: user,
        newStatus: UserStatus.inactive,
        onStatusChanged: (updatedUser) {
          _refreshData();
          _showSuccessMessage('User deactivated successfully');
        },
      ),
    );
  }

  void _suspendUser(User user) {
    showDialog(
      context: context,
      builder: (context) => UserStatusDialog(
        user: user,
        newStatus: UserStatus.suspended,
        onStatusChanged: (updatedUser) {
          _refreshData();
          _showSuccessMessage('User suspended successfully');
        },
      ),
    );
  }

  void _deleteUser(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _confirmDeleteUser(user);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteUser(User user) {
    ref.read(userProvider(user.id).notifier).deleteUser();
    _refreshData();
    _showSuccessMessage('User deleted successfully');
  }

  void _viewUserDetails(User user) {
    // Navigate to user details page
    NavigationService.pushNamed('/user-details', arguments: user.id);
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'create_user':
        _createUser();
        break;
      case 'export_users':
        _exportUsers();
        break;
      case 'import_users':
        _importUsers();
        break;
    }
  }

  void _exportUsers() {
    final filters = UserSearchFilters();
    ref.read(userExportProvider.notifier).exportUsers(filters);
    
    // Show export dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Users'),
        content: const Text('Users will be exported to CSV format.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _importUsers() {
    // Show import dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Users'),
        content: const Text('Select a CSV file to import users.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement file picker
            },
            child: const Text('Select File'),
          ),
        ],
      ),
    );
  }

  void _clearSelection() {
    setState(() {
      _selectedUsers.clear();
    });
  }

  void _refreshData() {
    _refreshAllUsersData();
    _refreshStaffData();
    _refreshStudentData();
    ref.read(userStatisticsProvider.notifier).refreshStatistics();
  }

  void _refreshAllUsersData() {
    ref.read(usersProvider.notifier).refreshUsers(
      const UserSearchFilters(),
    );
  }

  void _refreshStaffData() {
    ref.read(staffRosterProvider.notifier).refreshStaffRoster();
  }

  void _refreshStudentData() {
    ref.read(studentRosterProvider.notifier).refreshStudentRoster();
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
