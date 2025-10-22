import '../models/user_management_models.dart';
import '../api/user_management_api_service.dart';
import '../models/load_state.dart';

/// User Management Service Layer
/// Handles business logic for user management operations
class UserManagementService {
  final UserManagementApiService _apiService;

  UserManagementService(this._apiService);

  /// Create a new user with validation
  Future<LoadState<User>> createUser(CreateUserRequest request) async {
    try {
      // Validate request
      final validationError = _validateCreateUserRequest(request);
      if (validationError != null) {
        return LoadState.error(validationError);
      }

      // Create user via API
      final user = await _apiService.createUser(request);
      
      // Send welcome email
      try {
        await _apiService.sendWelcomeEmail(user.id);
      } catch (e) {
        // Log error but don't fail the user creation
        print('Failed to send welcome email: $e');
      }

      return LoadState.success(user);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get user by ID with caching
  Future<LoadState<User>> getUserById(String userId) async {
    try {
      final user = await _apiService.getUserById(userId);
      return LoadState.success(user);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Update user with validation
  Future<LoadState<User>> updateUser(
    String userId,
    UpdateUserRequest request,
  ) async {
    try {
      // Validate request
      final validationError = _validateUpdateUserRequest(request);
      if (validationError != null) {
        return LoadState.error(validationError);
      }

      final user = await _apiService.updateUser(userId, request);
      return LoadState.success(user);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Delete user with confirmation
  Future<LoadState<void>> deleteUser(String userId) async {
    try {
      await _apiService.deleteUser(userId);
      return LoadState.success(null);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get users with advanced filtering
  Future<LoadState<UserRoster>> getUsers(UserSearchFilters filters) async {
    try {
      final roster = await _apiService.getUsers(filters);
      return LoadState.success(roster);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get staff roster with role filtering
  Future<LoadState<UserRoster>> getStaffRoster({
    String? searchQuery,
    UserRole? role,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final roster = await _apiService.getStaffRoster(
        searchQuery: searchQuery,
        role: role,
        status: status,
        hostelId: hostelId,
        page: page,
        pageSize: pageSize,
      );
      return LoadState.success(roster);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get student roster with filtering
  Future<LoadState<UserRoster>> getStudentRoster({
    String? searchQuery,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final roster = await _apiService.getStudentRoster(
        searchQuery: searchQuery,
        status: status,
        hostelId: hostelId,
        page: page,
        pageSize: pageSize,
      );
      return LoadState.success(roster);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Assign role to user with validation
  Future<LoadState<User>> assignRole(RoleAssignmentRequest request) async {
    try {
      // Validate role assignment
      final validationError = _validateRoleAssignment(request);
      if (validationError != null) {
        return LoadState.error(validationError);
      }

      final user = await _apiService.assignRole(request);
      return LoadState.success(user);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Reset user password with validation
  Future<LoadState<void>> resetPassword(ResetPasswordRequest request) async {
    try {
      // Validate password
      final validationError = _validatePassword(request.newPassword);
      if (validationError != null) {
        return LoadState.error(validationError);
      }

      await _apiService.resetPassword(request);
      return LoadState.success(null);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Update user status with validation
  Future<LoadState<User>> updateUserStatus(UserActivationRequest request) async {
    try {
      // Validate status change
      final validationError = _validateStatusChange(request);
      if (validationError != null) {
        return LoadState.error(validationError);
      }

      final user = await _apiService.updateUserStatus(request);
      return LoadState.success(user);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Bulk user operations with progress tracking
  Future<LoadState<BulkOperationResult>> bulkUserOperation(
    BulkUserOperationRequest request,
  ) async {
    try {
      // Validate bulk operation
      final validationError = _validateBulkOperation(request);
      if (validationError != null) {
        return LoadState.error(validationError);
      }

      final result = await _apiService.bulkUserOperation(request);
      return LoadState.success(result);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get user statistics with caching
  Future<LoadState<UserStatistics>> getUserStatistics({String? hostelId}) async {
    try {
      final statistics = await _apiService.getUserStatistics(hostelId: hostelId);
      return LoadState.success(statistics);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Export users to CSV
  Future<LoadState<List<int>>> exportUsersToCsv(UserSearchFilters filters) async {
    try {
      final csvData = await _apiService.exportUsersToCsv(filters);
      return LoadState.success(csvData);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Import users from CSV
  Future<LoadState<BulkOperationResult>> importUsersFromCsv(
    List<int> csvData,
  ) async {
    try {
      final result = await _apiService.importUsersFromCsv(csvData);
      return LoadState.success(result);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Search users with suggestions
  Future<LoadState<List<User>>> searchUsers(String query) async {
    try {
      if (query.trim().isEmpty) {
        return LoadState.success([]);
      }

      final users = await _apiService.searchUsers(query);
      return LoadState.success(users);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get users by role with caching
  Future<LoadState<List<User>>> getUsersByRole(
    UserRole role, {
    String? hostelId,
  }) async {
    try {
      final users = await _apiService.getUsersByRole(role, hostelId: hostelId);
      return LoadState.success(users);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get user activity log
  Future<LoadState<List<Map<String, dynamic>>>> getUserActivityLog(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final activities = await _apiService.getUserActivityLog(
        userId,
        startDate: startDate,
        endDate: endDate,
        page: page,
        pageSize: pageSize,
      );
      return LoadState.success(activities);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Get user login history
  Future<LoadState<List<Map<String, dynamic>>>> getUserLoginHistory(
    String userId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final history = await _apiService.getUserLoginHistory(
        userId,
        page: page,
        pageSize: pageSize,
      );
      return LoadState.success(history);
    } catch (e) {
      return LoadState.error(e.toString());
    }
  }

  /// Validate create user request
  String? _validateCreateUserRequest(CreateUserRequest request) {
    if (request.email.trim().isEmpty) {
      return 'Email is required';
    }
    
    if (!_isValidEmail(request.email)) {
      return 'Please enter a valid email address';
    }
    
    if (request.password.trim().isEmpty) {
      return 'Password is required';
    }
    
    final passwordError = _validatePassword(request.password);
    if (passwordError != null) {
      return passwordError;
    }
    
    if (request.name != null && request.name!.trim().isEmpty) {
      return 'Name cannot be empty';
    }
    
    if (request.phone != null && !_isValidPhone(request.phone!)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  /// Validate update user request
  String? _validateUpdateUserRequest(UpdateUserRequest request) {
    if (request.name != null && request.name!.trim().isEmpty) {
      return 'Name cannot be empty';
    }
    
    if (request.phone != null && !_isValidPhone(request.phone!)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  /// Validate role assignment
  String? _validateRoleAssignment(RoleAssignmentRequest request) {
    if (request.newRole == UserRole.superAdmin) {
      return 'Super Admin role cannot be assigned directly';
    }
    
    return null;
  }

  /// Validate password strength
  String? _validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }

  /// Validate status change
  String? _validateStatusChange(UserActivationRequest request) {
    if (request.status == UserStatus.suspended && 
        (request.reason == null || request.reason!.trim().isEmpty)) {
      return 'Reason is required for suspension';
    }
    
    return null;
  }

  /// Validate bulk operation
  String? _validateBulkOperation(BulkUserOperationRequest request) {
    if (request.userIds.isEmpty) {
      return 'No users selected for bulk operation';
    }
    
    if (request.userIds.length > 100) {
      return 'Cannot process more than 100 users at once';
    }
    
    return null;
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  /// Validate phone format
  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phone.replaceAll(' ', ''));
  }

  /// Generate random password
  String generateRandomPassword({int length = 12}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*';
    final random = DateTime.now().millisecondsSinceEpoch;
    final password = StringBuffer();
    
    for (int i = 0; i < length; i++) {
      password.write(chars[random % chars.length]);
    }
    
    return password.toString();
  }

  /// Get role display information
  Map<String, dynamic> getRoleDisplayInfo(UserRole role) {
    switch (role) {
      case UserRole.student:
        return {
          'name': 'Student',
          'description': 'Can view attendance, request gate passes, submit meal intents',
          'color': 0xFF4CAF50,
          'icon': 'person',
        };
      case UserRole.warden:
        return {
          'name': 'Warden',
          'description': 'Can manage attendance, approve gate passes, view reports',
          'color': 0xFF2196F3,
          'icon': 'security',
        };
      case UserRole.wardenHead:
        return {
          'name': 'Warden Head',
          'description': 'Can manage all hostel operations, create notices, view analytics',
          'color': 0xFFFF9800,
          'icon': 'admin_panel_settings',
        };
      case UserRole.chef:
        return {
          'name': 'Chef',
          'description': 'Can view meal forecasts, manage meal planning',
          'color': 0xFF9C27B0,
          'icon': 'restaurant',
        };
      case UserRole.superAdmin:
        return {
          'name': 'Super Admin',
          'description': 'Full system access, can manage users and hostels',
          'color': 0xFFF44336,
          'icon': 'admin_panel_settings',
        };
    }
  }

  /// Get status display information
  Map<String, dynamic> getStatusDisplayInfo(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return {
          'name': 'Active',
          'description': 'User can login and use the system',
          'color': 0xFF4CAF50,
          'icon': 'check_circle',
        };
      case UserStatus.inactive:
        return {
          'name': 'Inactive',
          'description': 'User account is disabled',
          'color': 0xFF9E9E9E,
          'icon': 'pause_circle',
        };
      case UserStatus.suspended:
        return {
          'name': 'Suspended',
          'description': 'User account is temporarily suspended',
          'color': 0xFFFF9800,
          'icon': 'block',
        };
      case UserStatus.pending:
        return {
          'name': 'Pending',
          'description': 'User account is awaiting activation',
          'color': 0xFF2196F3,
          'icon': 'schedule',
        };
    }
  }

  /// Format user statistics for display
  Map<String, dynamic> formatUserStatistics(UserStatistics stats) {
    return {
      'totalUsers': stats.totalUsers,
      'activeUsers': stats.activeUsers,
      'inactiveUsers': stats.inactiveUsers,
      'suspendedUsers': stats.suspendedUsers,
      'pendingUsers': stats.pendingUsers,
      'usersByRole': stats.usersByRole.map((role, count) => 
        MapEntry(role.name, count)),
      'usersByHostel': stats.usersByHostel,
      'usersCreatedToday': stats.usersCreatedToday,
      'usersCreatedThisWeek': stats.usersCreatedThisWeek,
      'usersCreatedThisMonth': stats.usersCreatedThisMonth,
      'averageLoginFrequency': stats.averageLoginFrequency,
      'usersNeverLoggedIn': stats.usersNeverLoggedIn,
    };
  }
}
