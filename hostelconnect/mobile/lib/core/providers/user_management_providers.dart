import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_management_models.dart';
import '../models/load_state.dart';
import '../api/user_management_api_service.dart';
import '../services/user_management_service.dart';
import '../services/dio_client.dart';

/// User Management Providers
/// Riverpod providers for user management state and operations

// Service Providers
final userManagementApiServiceProvider = Provider<UserManagementApiService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserManagementApiService(dioClient);
});

final userManagementServiceProvider = Provider<UserManagementService>((ref) {
  final apiService = ref.watch(userManagementApiServiceProvider);
  return UserManagementService(apiService);
});

// User List Providers
final usersProvider = StateNotifierProvider<UsersNotifier, LoadState<UserRoster>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return UsersNotifier(service);
});

final staffRosterProvider = StateNotifierProvider<StaffRosterNotifier, LoadState<UserRoster>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return StaffRosterNotifier(service);
});

final studentRosterProvider = StateNotifierProvider<StudentRosterNotifier, LoadState<UserRoster>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return StudentRosterNotifier(service);
});

// Individual User Providers
final userProvider = StateNotifierProvider.family<UserNotifier, LoadState<User>, String>((ref, userId) {
  final service = ref.watch(userManagementServiceProvider);
  return UserNotifier(service, userId);
});

// User Statistics Provider
final userStatisticsProvider = StateNotifierProvider<UserStatisticsNotifier, LoadState<UserStatistics>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return UserStatisticsNotifier(service);
});

// Search Providers
final userSearchProvider = StateNotifierProvider<UserSearchNotifier, LoadState<List<User>>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return UserSearchNotifier(service);
});

final usersByRoleProvider = StateNotifierProvider.family<UsersByRoleNotifier, LoadState<List<User>>, UserRole>((ref, role) {
  final service = ref.watch(userManagementServiceProvider);
  return UsersByRoleNotifier(service, role);
});

// User Activity Providers
final userActivityProvider = StateNotifierProvider.family<UserActivityNotifier, LoadState<List<Map<String, dynamic>>>, String>((ref, userId) {
  final service = ref.watch(userManagementServiceProvider);
  return UserActivityNotifier(service, userId);
});

final userLoginHistoryProvider = StateNotifierProvider.family<UserLoginHistoryNotifier, LoadState<List<Map<String, dynamic>>>, String>((ref, userId) {
  final service = ref.watch(userManagementServiceProvider);
  return UserLoginHistoryNotifier(service, userId);
});

// Bulk Operations Provider
final bulkOperationsProvider = StateNotifierProvider<BulkOperationsNotifier, LoadState<BulkOperationResult>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return BulkOperationsNotifier(service);
});

// Export/Import Providers
final userExportProvider = StateNotifierProvider<UserExportNotifier, LoadState<List<int>>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return UserExportNotifier(service);
});

final userImportProvider = StateNotifierProvider<UserImportNotifier, LoadState<BulkOperationResult>>((ref) {
  final service = ref.watch(userManagementServiceProvider);
  return UserImportNotifier(service);
});

// Filter State Providers
final userFiltersProvider = StateProvider<UserSearchFilters>((ref) {
  return const UserSearchFilters();
});

final staffFiltersProvider = StateProvider<UserSearchFilters>((ref) {
  return const UserSearchFilters();
});

final studentFiltersProvider = StateProvider<UserSearchFilters>((ref) {
  return const UserSearchFilters();
});

// Selected Users Provider
final selectedUsersProvider = StateProvider<List<String>>((ref) {
  return [];
});

// User Management Notifiers

class UsersNotifier extends StateNotifier<LoadState<UserRoster>> {
  final UserManagementService _service;

  UsersNotifier(this._service) : super(const LoadState.idle());

  Future<void> loadUsers(UserSearchFilters filters) async {
    state = const LoadState.loading();
    final result = await _service.getUsers(filters);
    state = result;
  }

  Future<void> refreshUsers(UserSearchFilters filters) async {
    final result = await _service.getUsers(filters);
    state = result;
  }

  Future<void> loadMoreUsers(UserSearchFilters filters) async {
    if (state is LoadStateSuccess<UserRoster>) {
      final currentRoster = (state as LoadStateSuccess<UserRoster>).data;
      if (currentRoster.hasMore) {
        final nextPageFilters = filters.copyWith(page: currentRoster.page + 1);
        final result = await _service.getUsers(nextPageFilters);
        
        if (result is LoadStateSuccess<UserRoster>) {
          final newRoster = UserRoster(
            users: [...currentRoster.users, ...result.data.users],
            totalCount: result.data.totalCount,
            page: result.data.page,
            pageSize: result.data.pageSize,
            hasMore: result.data.hasMore,
          );
          state = LoadState.success(newRoster);
        }
      }
    }
  }
}

class StaffRosterNotifier extends StateNotifier<LoadState<UserRoster>> {
  final UserManagementService _service;

  StaffRosterNotifier(this._service) : super(const LoadState.idle());

  Future<void> loadStaffRoster({
    String? searchQuery,
    UserRole? role,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    state = const LoadState.loading();
    final result = await _service.getStaffRoster(
      searchQuery: searchQuery,
      role: role,
      status: status,
      hostelId: hostelId,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }

  Future<void> refreshStaffRoster({
    String? searchQuery,
    UserRole? role,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    final result = await _service.getStaffRoster(
      searchQuery: searchQuery,
      role: role,
      status: status,
      hostelId: hostelId,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }
}

class StudentRosterNotifier extends StateNotifier<LoadState<UserRoster>> {
  final UserManagementService _service;

  StudentRosterNotifier(this._service) : super(const LoadState.idle());

  Future<void> loadStudentRoster({
    String? searchQuery,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    state = const LoadState.loading();
    final result = await _service.getStudentRoster(
      searchQuery: searchQuery,
      status: status,
      hostelId: hostelId,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }

  Future<void> refreshStudentRoster({
    String? searchQuery,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    final result = await _service.getStudentRoster(
      searchQuery: searchQuery,
      status: status,
      hostelId: hostelId,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }
}

class UserNotifier extends StateNotifier<LoadState<User>> {
  final UserManagementService _service;
  final String _userId;

  UserNotifier(this._service, this._userId) : super(const LoadState.idle()) {
    loadUser();
  }

  Future<void> loadUser() async {
    state = const LoadState.loading();
    final result = await _service.getUserById(_userId);
    state = result;
  }

  Future<void> updateUser(UpdateUserRequest request) async {
    final result = await _service.updateUser(_userId, request);
    state = result;
  }

  Future<void> assignRole(RoleAssignmentRequest request) async {
    final result = await _service.assignRole(request);
    state = result;
  }

  Future<void> updateStatus(UserActivationRequest request) async {
    final result = await _service.updateUserStatus(request);
    state = result;
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    final result = await _service.resetPassword(request);
    if (result is LoadStateSuccess) {
      // Reload user to get updated info
      await loadUser();
    }
  }

  Future<void> deleteUser() async {
    final result = await _service.deleteUser(_userId);
    state = result;
  }
}

class UserStatisticsNotifier extends StateNotifier<LoadState<UserStatistics>> {
  final UserManagementService _service;

  UserStatisticsNotifier(this._service) : super(const LoadState.idle());

  Future<void> loadStatistics({String? hostelId}) async {
    state = const LoadState.loading();
    final result = await _service.getUserStatistics(hostelId: hostelId);
    state = result;
  }

  Future<void> refreshStatistics({String? hostelId}) async {
    final result = await _service.getUserStatistics(hostelId: hostelId);
    state = result;
  }
}

class UserSearchNotifier extends StateNotifier<LoadState<List<User>>> {
  final UserManagementService _service;

  UserSearchNotifier(this._service) : super(const LoadState.idle());

  Future<void> searchUsers(String query) async {
    if (query.trim().isEmpty) {
      state = const LoadState.success([]);
      return;
    }

    state = const LoadState.loading();
    final result = await _service.searchUsers(query);
    state = result;
  }

  void clearSearch() {
    state = const LoadState.success([]);
  }
}

class UsersByRoleNotifier extends StateNotifier<LoadState<List<User>>> {
  final UserManagementService _service;
  final UserRole _role;

  UsersByRoleNotifier(this._service, this._role) : super(const LoadState.idle()) {
    loadUsersByRole();
  }

  Future<void> loadUsersByRole({String? hostelId}) async {
    state = const LoadState.loading();
    final result = await _service.getUsersByRole(_role, hostelId: hostelId);
    state = result;
  }

  Future<void> refreshUsersByRole({String? hostelId}) async {
    final result = await _service.getUsersByRole(_role, hostelId: hostelId);
    state = result;
  }
}

class UserActivityNotifier extends StateNotifier<LoadState<List<Map<String, dynamic>>>> {
  final UserManagementService _service;
  final String _userId;

  UserActivityNotifier(this._service, this._userId) : super(const LoadState.idle());

  Future<void> loadActivityLog({
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 50,
  }) async {
    state = const LoadState.loading();
    final result = await _service.getUserActivityLog(
      _userId,
      startDate: startDate,
      endDate: endDate,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }

  Future<void> refreshActivityLog({
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 50,
  }) async {
    final result = await _service.getUserActivityLog(
      _userId,
      startDate: startDate,
      endDate: endDate,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }
}

class UserLoginHistoryNotifier extends StateNotifier<LoadState<List<Map<String, dynamic>>>> {
  final UserManagementService _service;
  final String _userId;

  UserLoginHistoryNotifier(this._service, this._userId) : super(const LoadState.idle());

  Future<void> loadLoginHistory({
    int page = 1,
    int pageSize = 50,
  }) async {
    state = const LoadState.loading();
    final result = await _service.getUserLoginHistory(
      _userId,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }

  Future<void> refreshLoginHistory({
    int page = 1,
    int pageSize = 50,
  }) async {
    final result = await _service.getUserLoginHistory(
      _userId,
      page: page,
      pageSize: pageSize,
    );
    state = result;
  }
}

class BulkOperationsNotifier extends StateNotifier<LoadState<BulkOperationResult>> {
  final UserManagementService _service;

  BulkOperationsNotifier(this._service) : super(const LoadState.idle());

  Future<void> performBulkOperation(BulkUserOperationRequest request) async {
    state = const LoadState.loading();
    final result = await _service.bulkUserOperation(request);
    state = result;
  }

  void clearResult() {
    state = const LoadState.idle();
  }
}

class UserExportNotifier extends StateNotifier<LoadState<List<int>>> {
  final UserManagementService _service;

  UserExportNotifier(this._service) : super(const LoadState.idle());

  Future<void> exportUsers(UserSearchFilters filters) async {
    state = const LoadState.loading();
    final result = await _service.exportUsersToCsv(filters);
    state = result;
  }

  void clearExport() {
    state = const LoadState.idle();
  }
}

class UserImportNotifier extends StateNotifier<LoadState<BulkOperationResult>> {
  final UserManagementService _service;

  UserImportNotifier(this._service) : super(const LoadState.idle());

  Future<void> importUsers(List<int> csvData) async {
    state = const LoadState.loading();
    final result = await _service.importUsersFromCsv(csvData);
    state = result;
  }

  void clearImport() {
    state = const LoadState.idle();
  }
}

// Helper Providers

/// Provider for current user's permissions
final currentUserPermissionsProvider = Provider<List<String>>((ref) {
  // This would be connected to the auth provider
  // For now, return empty list
  return [];
});

/// Provider for checking if user can perform action
final canPerformActionProvider = Provider.family<bool, String>((ref, action) {
  final permissions = ref.watch(currentUserPermissionsProvider);
  return permissions.contains(action);
});

/// Provider for role display information
final roleDisplayInfoProvider = Provider.family<Map<String, dynamic>, UserRole>((ref, role) {
  final service = ref.watch(userManagementServiceProvider);
  return service.getRoleDisplayInfo(role);
});

/// Provider for status display information
final statusDisplayInfoProvider = Provider.family<Map<String, dynamic>, UserStatus>((ref, status) {
  final service = ref.watch(userManagementServiceProvider);
  return service.getStatusDisplayInfo(status);
});

/// Provider for formatted user statistics
final formattedUserStatisticsProvider = Provider<Map<String, dynamic>>((ref) {
  final statisticsState = ref.watch(userStatisticsProvider);
  if (statisticsState is LoadStateSuccess<UserStatistics>) {
    final service = ref.watch(userManagementServiceProvider);
    return service.formatUserStatistics(statisticsState.data);
  }
  return {};
});
