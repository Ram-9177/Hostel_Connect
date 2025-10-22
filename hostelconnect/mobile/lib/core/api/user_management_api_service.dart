import 'package:dio/dio.dart';
import '../models/user_management_models.dart';
import '../services/dio_client.dart';

/// User Management API Service
/// Handles all user-related API operations for admin functionality
class UserManagementApiService {
  final DioClient _dioClient;

  UserManagementApiService(this._dioClient);

  /// Create a new user
  Future<User> createUser(CreateUserRequest request) async {
    try {
      final response = await _dioClient.post(
        '/admin/users',
        data: request.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get user by ID
  Future<User> getUserById(String userId) async {
    try {
      final response = await _dioClient.get('/admin/users/$userId');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update user information
  Future<User> updateUser(String userId, UpdateUserRequest request) async {
    try {
      final response = await _dioClient.put(
        '/admin/users/$userId',
        data: request.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete user
  Future<void> deleteUser(String userId) async {
    try {
      await _dioClient.delete('/admin/users/$userId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get users with filters and pagination
  Future<UserRoster> getUsers(UserSearchFilters filters) async {
    try {
      final response = await _dioClient.get(
        '/admin/users',
        queryParameters: filters.toJson(),
      );
      return UserRoster.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get staff roster (wardens, warden heads, chefs)
  Future<UserRoster> getStaffRoster({
    String? searchQuery,
    UserRole? role,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final filters = UserSearchFilters(
        searchQuery: searchQuery,
        role: role,
        status: status,
        hostelId: hostelId,
        page: page,
        pageSize: pageSize,
      );
      
      final response = await _dioClient.get(
        '/admin/users/staff',
        queryParameters: filters.toJson(),
      );
      return UserRoster.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get student roster
  Future<UserRoster> getStudentRoster({
    String? searchQuery,
    UserStatus? status,
    String? hostelId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final filters = UserSearchFilters(
        searchQuery: searchQuery,
        role: UserRole.student,
        status: status,
        hostelId: hostelId,
        page: page,
        pageSize: pageSize,
      );
      
      final response = await _dioClient.get(
        '/admin/users/students',
        queryParameters: filters.toJson(),
      );
      return UserRoster.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Assign role to user
  Future<User> assignRole(RoleAssignmentRequest request) async {
    try {
      final response = await _dioClient.post(
        '/admin/users/${request.userId}/assign-role',
        data: request.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Reset user password
  Future<void> resetPassword(ResetPasswordRequest request) async {
    try {
      await _dioClient.post(
        '/admin/users/${request.userId}/reset-password',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Activate/Deactivate user
  Future<User> updateUserStatus(UserActivationRequest request) async {
    try {
      final response = await _dioClient.post(
        '/admin/users/${request.userId}/status',
        data: request.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Bulk user operations
  Future<BulkOperationResult> bulkUserOperation(
    BulkUserOperationRequest request,
  ) async {
    try {
      final response = await _dioClient.post(
        '/admin/users/bulk',
        data: request.toJson(),
      );
      return BulkOperationResult.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get user statistics
  Future<UserStatistics> getUserStatistics({String? hostelId}) async {
    try {
      final response = await _dioClient.get(
        '/admin/users/statistics',
        queryParameters: hostelId != null ? {'hostelId': hostelId} : null,
      );
      return UserStatistics.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Export users to CSV
  Future<List<int>> exportUsersToCsv(UserSearchFilters filters) async {
    try {
      final response = await _dioClient.get(
        '/admin/users/export/csv',
        queryParameters: filters.toJson(),
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Import users from CSV
  Future<BulkOperationResult> importUsersFromCsv(List<int> csvData) async {
    try {
      final response = await _dioClient.post(
        '/admin/users/import/csv',
        data: FormData.fromMap({
          'file': MultipartFile.fromBytes(
            csvData,
            filename: 'users.csv',
          ),
        }),
      );
      return BulkOperationResult.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get user activity log
  Future<List<Map<String, dynamic>>> getUserActivityLog(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };
      
      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }
      
      final response = await _dioClient.get(
        '/admin/users/$userId/activity',
        queryParameters: queryParams,
      );
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Search users by email or name
  Future<List<User>> searchUsers(String query, {int limit = 10}) async {
    try {
      final response = await _dioClient.get(
        '/admin/users/search',
        queryParameters: {
          'q': query,
          'limit': limit,
        },
      );
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get users by role
  Future<List<User>> getUsersByRole(UserRole role, {String? hostelId}) async {
    try {
      final queryParams = <String, dynamic>{
        'role': role.name,
      };
      
      if (hostelId != null) {
        queryParams['hostelId'] = hostelId;
      }
      
      final response = await _dioClient.get(
        '/admin/users/by-role',
        queryParameters: queryParams,
      );
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get user permissions
  Future<List<String>> getUserPermissions(String userId) async {
    try {
      final response = await _dioClient.get('/admin/users/$userId/permissions');
      return List<String>.from(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update user permissions
  Future<void> updateUserPermissions(
    String userId,
    List<String> permissions,
  ) async {
    try {
      await _dioClient.put(
        '/admin/users/$userId/permissions',
        data: {'permissions': permissions},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get user dashboard data
  Future<Map<String, dynamic>> getUserDashboardData(String userId) async {
    try {
      final response = await _dioClient.get('/admin/users/$userId/dashboard');
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Send welcome email to user
  Future<void> sendWelcomeEmail(String userId) async {
    try {
      await _dioClient.post('/admin/users/$userId/send-welcome');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get user login history
  Future<List<Map<String, dynamic>>> getUserLoginHistory(
    String userId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final response = await _dioClient.get(
        '/admin/users/$userId/login-history',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
      );
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle API errors
  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Unknown error occurred';
        
        switch (statusCode) {
          case 400:
            return Exception('Invalid request: $message');
          case 401:
            return Exception('Unauthorized: Please login again');
          case 403:
            return Exception('Forbidden: You do not have permission to perform this action');
          case 404:
            return Exception('User not found');
          case 409:
            return Exception('Conflict: $message');
          case 422:
            return Exception('Validation error: $message');
          case 500:
            return Exception('Server error: Please try again later');
          default:
            return Exception('Error $statusCode: $message');
        }
      
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      
      case DioExceptionType.connectionError:
        return Exception('Connection error. Please check your internet connection.');
      
      case DioExceptionType.badCertificate:
        return Exception('Certificate error. Please contact support.');
      
      case DioExceptionType.unknown:
      default:
        return Exception('Unknown error occurred. Please try again.');
    }
  }
}
