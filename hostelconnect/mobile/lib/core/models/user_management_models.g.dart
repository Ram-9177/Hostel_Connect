// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_management_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      hostelId: json['hostelId'] as String?,
      studentId: json['studentId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      profileImageUrl: json['profileImageUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
      'status': _$UserStatusEnumMap[instance.status]!,
      'hostelId': instance.hostelId,
      'studentId': instance.studentId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'profileImageUrl': instance.profileImageUrl,
      'metadata': instance.metadata,
    };

const _$UserRoleEnumMap = {
  UserRole.student: 'student',
  UserRole.warden: 'warden',
  UserRole.wardenHead: 'warden_head',
  UserRole.chef: 'chef',
  UserRole.superAdmin: 'super_admin',
};

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.inactive: 'inactive',
  UserStatus.suspended: 'suspended',
  UserStatus.pending: 'pending',
};

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    CreateUserRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      hostelId: json['hostelId'] as String?,
      studentId: json['studentId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
      'hostelId': instance.hostelId,
      'studentId': instance.studentId,
      'metadata': instance.metadata,
    };

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']),
      hostelId: json['hostelId'] as String?,
      studentId: json['studentId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role],
      'status': _$UserStatusEnumMap[instance.status],
      'hostelId': instance.hostelId,
      'studentId': instance.studentId,
      'metadata': instance.metadata,
    };

ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequest(
      userId: json['userId'] as String,
      newPassword: json['newPassword'] as String,
      forceChange: json['forceChange'] as bool? ?? true,
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'newPassword': instance.newPassword,
      'forceChange': instance.forceChange,
    };

UserRoster _$UserRosterFromJson(Map<String, dynamic> json) => UserRoster(
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$UserRosterToJson(UserRoster instance) =>
    <String, dynamic>{
      'users': instance.users,
      'totalCount': instance.totalCount,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'hasMore': instance.hasMore,
    };

UserSearchFilters _$UserSearchFiltersFromJson(Map<String, dynamic> json) =>
    UserSearchFilters(
      searchQuery: json['searchQuery'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']),
      hostelId: json['hostelId'] as String?,
      createdAfter: json['createdAfter'] == null
          ? null
          : DateTime.parse(json['createdAfter'] as String),
      createdBefore: json['createdBefore'] == null
          ? null
          : DateTime.parse(json['createdBefore'] as String),
      lastLoginAfter: json['lastLoginAfter'] == null
          ? null
          : DateTime.parse(json['lastLoginAfter'] as String),
      lastLoginBefore: json['lastLoginBefore'] == null
          ? null
          : DateTime.parse(json['lastLoginBefore'] as String),
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
      sortBy: json['sortBy'] as String? ?? 'createdAt',
      ascending: json['ascending'] as bool? ?? false,
    );

Map<String, dynamic> _$UserSearchFiltersToJson(UserSearchFilters instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'role': _$UserRoleEnumMap[instance.role],
      'status': _$UserStatusEnumMap[instance.status],
      'hostelId': instance.hostelId,
      'createdAfter': instance.createdAfter?.toIso8601String(),
      'createdBefore': instance.createdBefore?.toIso8601String(),
      'lastLoginAfter': instance.lastLoginAfter?.toIso8601String(),
      'lastLoginBefore': instance.lastLoginBefore?.toIso8601String(),
      'page': instance.page,
      'pageSize': instance.pageSize,
      'sortBy': instance.sortBy,
      'ascending': instance.ascending,
    };

UserStatistics _$UserStatisticsFromJson(Map<String, dynamic> json) =>
    UserStatistics(
      totalUsers: (json['totalUsers'] as num).toInt(),
      activeUsers: (json['activeUsers'] as num).toInt(),
      inactiveUsers: (json['inactiveUsers'] as num).toInt(),
      suspendedUsers: (json['suspendedUsers'] as num).toInt(),
      pendingUsers: (json['pendingUsers'] as num).toInt(),
      usersByRole: (json['usersByRole'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$UserRoleEnumMap, k), (e as num).toInt()),
      ),
      usersByHostel: Map<String, int>.from(json['usersByHostel'] as Map),
      usersCreatedToday: (json['usersCreatedToday'] as num).toInt(),
      usersCreatedThisWeek: (json['usersCreatedThisWeek'] as num).toInt(),
      usersCreatedThisMonth: (json['usersCreatedThisMonth'] as num).toInt(),
      averageLoginFrequency: (json['averageLoginFrequency'] as num).toDouble(),
      usersNeverLoggedIn: (json['usersNeverLoggedIn'] as num).toInt(),
    );

Map<String, dynamic> _$UserStatisticsToJson(UserStatistics instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'activeUsers': instance.activeUsers,
      'inactiveUsers': instance.inactiveUsers,
      'suspendedUsers': instance.suspendedUsers,
      'pendingUsers': instance.pendingUsers,
      'usersByRole': instance.usersByRole
          .map((k, e) => MapEntry(_$UserRoleEnumMap[k]!, e)),
      'usersByHostel': instance.usersByHostel,
      'usersCreatedToday': instance.usersCreatedToday,
      'usersCreatedThisWeek': instance.usersCreatedThisWeek,
      'usersCreatedThisMonth': instance.usersCreatedThisMonth,
      'averageLoginFrequency': instance.averageLoginFrequency,
      'usersNeverLoggedIn': instance.usersNeverLoggedIn,
    };

RoleAssignmentRequest _$RoleAssignmentRequestFromJson(
        Map<String, dynamic> json) =>
    RoleAssignmentRequest(
      userId: json['userId'] as String,
      newRole: $enumDecode(_$UserRoleEnumMap, json['newRole']),
      reason: json['reason'] as String?,
      assignedBy: json['assignedBy'] as String?,
    );

Map<String, dynamic> _$RoleAssignmentRequestToJson(
        RoleAssignmentRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'newRole': _$UserRoleEnumMap[instance.newRole]!,
      'reason': instance.reason,
      'assignedBy': instance.assignedBy,
    };

UserActivationRequest _$UserActivationRequestFromJson(
        Map<String, dynamic> json) =>
    UserActivationRequest(
      userId: json['userId'] as String,
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      reason: json['reason'] as String?,
      actionBy: json['actionBy'] as String?,
    );

Map<String, dynamic> _$UserActivationRequestToJson(
        UserActivationRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': _$UserStatusEnumMap[instance.status]!,
      'reason': instance.reason,
      'actionBy': instance.actionBy,
    };

BulkUserOperationRequest _$BulkUserOperationRequestFromJson(
        Map<String, dynamic> json) =>
    BulkUserOperationRequest(
      userIds:
          (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
      operation: $enumDecode(_$BulkOperationTypeEnumMap, json['operation']),
      parameters: json['parameters'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BulkUserOperationRequestToJson(
        BulkUserOperationRequest instance) =>
    <String, dynamic>{
      'userIds': instance.userIds,
      'operation': _$BulkOperationTypeEnumMap[instance.operation]!,
      'parameters': instance.parameters,
    };

const _$BulkOperationTypeEnumMap = {
  BulkOperationType.activate: 'activate',
  BulkOperationType.deactivate: 'deactivate',
  BulkOperationType.suspend: 'suspend',
  BulkOperationType.resetPassword: 'reset_password',
  BulkOperationType.assignRole: 'assign_role',
  BulkOperationType.delete: 'delete',
};

BulkOperationResult _$BulkOperationResultFromJson(Map<String, dynamic> json) =>
    BulkOperationResult(
      totalProcessed: (json['totalProcessed'] as num).toInt(),
      successful: (json['successful'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      details: json['details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BulkOperationResultToJson(
        BulkOperationResult instance) =>
    <String, dynamic>{
      'totalProcessed': instance.totalProcessed,
      'successful': instance.successful,
      'failed': instance.failed,
      'errors': instance.errors,
      'details': instance.details,
    };
