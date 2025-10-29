import 'package:json_annotation/json_annotation.dart';

part 'user_management_models.g.dart';

/// User management models for admin operations
/// Includes user creation, role assignment, and roster management

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final UserRole role;
  final UserStatus status;
  final String? hostelId;
  final String? studentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final String? profileImageUrl;
  final Map<String, dynamic>? metadata;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    required this.role,
    required this.status,
    this.hostelId,
    this.studentId,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.profileImageUrl,
    this.metadata,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    UserRole? role,
    UserStatus? status,
    String? hostelId,
    String? studentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    String? profileImageUrl,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      hostelId: hostelId ?? this.hostelId,
      studentId: studentId ?? this.studentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Display name for the user
  String get displayName => name ?? email;

  /// Check if user is active
  bool get isActive => status == UserStatus.active;

  /// Check if user is staff (not student)
  bool get isStaff => role != UserRole.student;
}

@JsonEnum()
enum UserRole {
  @JsonValue('student')
  student,
  @JsonValue('warden')
  warden,
  @JsonValue('warden_head')
  wardenHead,
  @JsonValue('gate_security')
  gateSecurity,
  @JsonValue('admin')
  admin,
  @JsonValue('chef')
  chef,
  @JsonValue('kitchen_incharge')
  kitchenIncharge,
  @JsonValue('super_admin')
  superAdmin,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.student:
        return 'Student';
      case UserRole.warden:
        return 'Warden';
      case UserRole.wardenHead:
        return 'Warden Head';
      case UserRole.gateSecurity:
        return 'Gate Security';
      case UserRole.admin:
        return 'Admin';
      case UserRole.chef:
        return 'Chef';
      case UserRole.kitchenIncharge:
        return 'Kitchen Incharge';
      case UserRole.superAdmin:
        return 'Super Admin';
    }
  }

  String get description {
    switch (this) {
      case UserRole.student:
        return 'Student living in hostel';
      case UserRole.warden:
        return 'Warden managing hostel operations';
      case UserRole.wardenHead:
        return 'Head warden with administrative privileges';
      case UserRole.gateSecurity:
        return 'Security staff handling gate entries and exits';
      case UserRole.admin:
        return 'Administrator with advanced management access';
      case UserRole.chef:
        return 'Chef managing meal operations';
      case UserRole.kitchenIncharge:
        return 'Kitchen incharge managing kitchen operations and reports';
      case UserRole.superAdmin:
        return 'Super administrator with full system access';
    }
  }
}

@JsonEnum()
enum UserStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('suspended')
  suspended,
  @JsonValue('pending')
  pending,
}

extension UserStatusExtension on UserStatus {
  String get displayName {
    switch (this) {
      case UserStatus.active:
        return 'Active';
      case UserStatus.inactive:
        return 'Inactive';
      case UserStatus.suspended:
        return 'Suspended';
      case UserStatus.pending:
        return 'Pending';
    }
  }

  String get description {
    switch (this) {
      case UserStatus.active:
        return 'User is active and can access the system';
      case UserStatus.inactive:
        return 'User is inactive and cannot access the system';
      case UserStatus.suspended:
        return 'User is suspended due to policy violations';
      case UserStatus.pending:
        return 'User account is pending approval';
    }
  }
}

@JsonSerializable()
class CreateUserRequest {
  final String email;
  final String password;
  final String? name;
  final String? phone;
  final UserRole role;
  final String? hostelId;
  final String? studentId;
  final Map<String, dynamic>? metadata;

  const CreateUserRequest({
    required this.email,
    required this.password,
    this.name,
    this.phone,
    required this.role,
    this.hostelId,
    this.studentId,
    this.metadata,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) => 
      _$CreateUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);
}

@JsonSerializable()
class UpdateUserRequest {
  final String? name;
  final String? phone;
  final UserRole? role;
  final UserStatus? status;
  final String? hostelId;
  final String? studentId;
  final Map<String, dynamic>? metadata;

  const UpdateUserRequest({
    this.name,
    this.phone,
    this.role,
    this.status,
    this.hostelId,
    this.studentId,
    this.metadata,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => 
      _$UpdateUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordRequest {
  final String userId;
  final String newPassword;
  final bool forceChange;

  const ResetPasswordRequest({
    required this.userId,
    required this.newPassword,
    this.forceChange = true,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => 
      _$ResetPasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}

@JsonSerializable()
class UserRoster {
  final List<User> users;
  final int totalCount;
  final int page;
  final int pageSize;
  final bool hasMore;

  const UserRoster({
    required this.users,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });

  factory UserRoster.fromJson(Map<String, dynamic> json) => 
      _$UserRosterFromJson(json);
  Map<String, dynamic> toJson() => _$UserRosterToJson(this);
}

@JsonSerializable()
class UserSearchFilters {
  final String? searchQuery;
  final UserRole? role;
  final UserStatus? status;
  final String? hostelId;
  final DateTime? createdAfter;
  final DateTime? createdBefore;
  final DateTime? lastLoginAfter;
  final DateTime? lastLoginBefore;
  final int page;
  final int pageSize;
  final String? sortBy;
  final bool ascending;

  const UserSearchFilters({
    this.searchQuery,
    this.role,
    this.status,
    this.hostelId,
    this.createdAfter,
    this.createdBefore,
    this.lastLoginAfter,
    this.lastLoginBefore,
    this.page = 1,
    this.pageSize = 20,
    this.sortBy = 'createdAt',
    this.ascending = false,
  });

  factory UserSearchFilters.fromJson(Map<String, dynamic> json) => 
      _$UserSearchFiltersFromJson(json);
  Map<String, dynamic> toJson() => _$UserSearchFiltersToJson(this);

  UserSearchFilters copyWith({
    String? searchQuery,
    UserRole? role,
    UserStatus? status,
    String? hostelId,
    DateTime? createdAfter,
    DateTime? createdBefore,
    DateTime? lastLoginAfter,
    DateTime? lastLoginBefore,
    int? page,
    int? pageSize,
    String? sortBy,
    bool? ascending,
  }) {
    return UserSearchFilters(
      searchQuery: searchQuery ?? this.searchQuery,
      role: role ?? this.role,
      status: status ?? this.status,
      hostelId: hostelId ?? this.hostelId,
      createdAfter: createdAfter ?? this.createdAfter,
      createdBefore: createdBefore ?? this.createdBefore,
      lastLoginAfter: lastLoginAfter ?? this.lastLoginAfter,
      lastLoginBefore: lastLoginBefore ?? this.lastLoginBefore,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }
}

@JsonSerializable()
class UserStatistics {
  final int totalUsers;
  final int activeUsers;
  final int inactiveUsers;
  final int suspendedUsers;
  final int pendingUsers;
  final Map<UserRole, int> usersByRole;
  final Map<String, int> usersByHostel;
  final int usersCreatedToday;
  final int usersCreatedThisWeek;
  final int usersCreatedThisMonth;
  final double averageLoginFrequency;
  final int usersNeverLoggedIn;

  const UserStatistics({
    required this.totalUsers,
    required this.activeUsers,
    required this.inactiveUsers,
    required this.suspendedUsers,
    required this.pendingUsers,
    required this.usersByRole,
    required this.usersByHostel,
    required this.usersCreatedToday,
    required this.usersCreatedThisWeek,
    required this.usersCreatedThisMonth,
    required this.averageLoginFrequency,
    required this.usersNeverLoggedIn,
  });

  factory UserStatistics.fromJson(Map<String, dynamic> json) => 
      _$UserStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatisticsToJson(this);
}

@JsonSerializable()
class RoleAssignmentRequest {
  final String userId;
  final UserRole newRole;
  final String? reason;
  final String? assignedBy;

  const RoleAssignmentRequest({
    required this.userId,
    required this.newRole,
    this.reason,
    this.assignedBy,
  });

  factory RoleAssignmentRequest.fromJson(Map<String, dynamic> json) => 
      _$RoleAssignmentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RoleAssignmentRequestToJson(this);
}

@JsonSerializable()
class UserActivationRequest {
  final String userId;
  final UserStatus status;
  final String? reason;
  final String? actionBy;

  const UserActivationRequest({
    required this.userId,
    required this.status,
    this.reason,
    this.actionBy,
  });

  factory UserActivationRequest.fromJson(Map<String, dynamic> json) => 
      _$UserActivationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserActivationRequestToJson(this);
}

@JsonSerializable()
class BulkUserOperationRequest {
  final List<String> userIds;
  final BulkOperationType operation;
  final Map<String, dynamic>? parameters;

  const BulkUserOperationRequest({
    required this.userIds,
    required this.operation,
    this.parameters,
  });

  factory BulkUserOperationRequest.fromJson(Map<String, dynamic> json) => 
      _$BulkUserOperationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BulkUserOperationRequestToJson(this);
}

@JsonEnum()
enum BulkOperationType {
  @JsonValue('activate')
  activate,
  @JsonValue('deactivate')
  deactivate,
  @JsonValue('suspend')
  suspend,
  @JsonValue('reset_password')
  resetPassword,
  @JsonValue('assign_role')
  assignRole,
  @JsonValue('delete')
  delete,
}

@JsonSerializable()
class BulkOperationResult {
  final int totalProcessed;
  final int successful;
  final int failed;
  final List<String> errors;
  final Map<String, dynamic>? details;

  const BulkOperationResult({
    required this.totalProcessed,
    required this.successful,
    required this.failed,
    required this.errors,
    this.details,
  });

  factory BulkOperationResult.fromJson(Map<String, dynamic> json) => 
      _$BulkOperationResultFromJson(json);
  Map<String, dynamic> toJson() => _$BulkOperationResultToJson(this);
}

/// Extension methods for User model
extension UserExtensions on User {
  String get displayName => name ?? email.split('@').first;
  
  String get roleDisplayName {
    switch (role) {
      case UserRole.student:
        return 'Student';
      case UserRole.warden:
        return 'Warden';
      case UserRole.wardenHead:
        return 'Warden Head';
      case UserRole.chef:
        return 'Chef';
      case UserRole.superAdmin:
        return 'Super Admin';
    }
  }
  
  String get statusDisplayName {
    switch (status) {
      case UserStatus.active:
        return 'Active';
      case UserStatus.inactive:
        return 'Inactive';
      case UserStatus.suspended:
        return 'Suspended';
      case UserStatus.pending:
        return 'Pending';
    }
  }
  
  bool get isActive => status == UserStatus.active;
  bool get canLogin => status == UserStatus.active;
  
  String get lastLoginDisplay {
    if (lastLoginAt == null) return 'Never';
    final now = DateTime.now();
    final difference = now.difference(lastLoginAt!);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

/// Extension methods for UserRole
extension UserRoleExtensions on UserRole {
  List<String> get permissions {
    switch (this) {
      case UserRole.superAdmin:
        return [
          'users.create',
          'users.bulk_create',
          'users.read',
          'users.update',
          'users.delete',
          'users.assign_role',
          'users.reset_password',
          'users.activate',
          'users.deactivate',
          'hostels.manage',
          'rooms.manage',
          'attendance.manage',
          'gatepass.manage',
          'meals.manage',
          'notices.manage',
          'reports.view',
          'policies.manage',
        ];
      case UserRole.admin:
        return [
          'users.create',
          'users.bulk_create',
          'users.read',
          'users.update',
          'users.assign_role',
          'users.reset_password',
          'users.activate',
          'users.deactivate',
          'attendance.manage',
          'gatepass.approve',
          'meals.manage',
          'notices.create',
          'reports.view',
          'policies.view',
        ];
      case UserRole.wardenHead:
        return [
          'users.read',
          'users.create',
          'users.bulk_create',
          'users.update',
          'attendance.manage',
          'gatepass.approve',
          'meals.manage',
          'notices.create',
          'reports.view',
          'policies.view',
        ];
      case UserRole.warden:
        return [
          'users.read',
          'users.bulk_create',
          'attendance.manage',
          'gatepass.approve',
          'meals.view',
          'notices.view',
          'reports.view',
        ];
      case UserRole.gateSecurity:
        return [
          'gatepass.scan',
          'gatepass.view',
          'notices.view',
        ];
      case UserRole.chef:
        return [
          'meals.view',
          'meals.forecast',
          'notices.view',
          'reports.view',
        ];
      case UserRole.kitchenIncharge:
        return [
          'meals.view',
          'meals.forecast',
          'reports.view',
          'reports.export',
        ];
      case UserRole.student:
        return [
          'attendance.view',
          'gatepass.request',
          'meals.intent',
          'notices.view',
          'profile.update',
        ];
    }
  }
  
  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }
}
