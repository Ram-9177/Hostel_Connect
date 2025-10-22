# HostelConnect Mobile App - Role Access Matrix

## Overview
This document defines the comprehensive role-based access control matrix for the HostelConnect Mobile App, detailing permissions for each role across all features and functionalities.

## Role Definitions

### 1. Student
**Description**: Basic user with limited access to personal features
**Primary Functions**: View personal data, submit requests, access basic information

### 2. Warden
**Description**: Mid-level management with approval and management powers
**Primary Functions**: Approve requests, manage attendance, allocate rooms, create notices

### 3. Warden Head
**Description**: Senior management with policy control and advanced oversight
**Primary Functions**: Manage policies, override meal forecasts, broadcast notices, view advanced reports

### 4. Super Admin
**Description**: Full system administration with complete access
**Primary Functions**: User management, system configuration, comprehensive analytics, audit trails

### 5. Chef
**Description**: Kitchen management with meal forecasting capabilities
**Primary Functions**: Meal forecasting, ingredient planning, kitchen management, meal analytics

## Feature Access Matrix

### Authentication & Profile
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| Login | ✅ | ✅ | ✅ | ✅ | ✅ |
| Logout | ✅ | ✅ | ✅ | ✅ | ✅ |
| View Profile | ✅ | ✅ | ✅ | ✅ | ✅ |
| Edit Profile | ✅ | ✅ | ✅ | ✅ | ✅ |
| Change Password | ✅ | ✅ | ✅ | ✅ | ✅ |
| Silent Refresh | ✅ | ✅ | ✅ | ✅ | ✅ |

### Dashboard Access
| Dashboard | Student | Warden | Warden Head | Super Admin | Chef |
|-----------|---------|--------|-------------|-------------|------|
| Student Dashboard | ✅ | ❌ | ❌ | ✅ (View) | ❌ |
| Warden Dashboard | ❌ | ✅ | ❌ | ✅ (View) | ❌ |
| Warden Head Dashboard | ❌ | ❌ | ✅ | ✅ (View) | ❌ |
| Super Admin Dashboard | ❌ | ❌ | ❌ | ✅ | ❌ |
| Chef Dashboard | ❌ | ❌ | ❌ | ✅ (View) | ✅ |

### Gate Pass Management
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| Request Gate Pass | ✅ | ❌ | ❌ | ✅ (All) | ❌ |
| View Own Requests | ✅ | ❌ | ❌ | ✅ (All) | ❌ |
| Approve Requests | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Reject Requests | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| View All Requests | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Generate QR Code | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Scan Gate Events | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| View Scan History | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Emergency Bypass | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Gate Pass Analytics | ❌ | ✅ | ✅ | ✅ (All) | ❌ |

### Attendance Management
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| View Own Attendance | ✅ | ❌ | ❌ | ✅ (All) | ❌ |
| Create Attendance Session | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Start/Stop Session | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| QR Code Scanning | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Manual Attendance Entry | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| View Session Summary | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Attendance Reports | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Late Attendance Adjustment | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Night Attendance Calculation | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Attendance Analytics | ❌ | ✅ | ✅ | ✅ (All) | ❌ |

### Meal Management
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| Submit Meal Intent | ✅ | ❌ | ❌ | ✅ (All) | ❌ |
| View Own Meal History | ✅ | ❌ | ❌ | ✅ (All) | ❌ |
| View Meal Forecast | ❌ | ✅ | ✅ | ✅ (All) | ✅ |
| Add Meal Override | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| View Chef Board | ❌ | ❌ | ❌ | ✅ (All) | ✅ |
| Lock Meal Counts | ❌ | ❌ | ❌ | ✅ (All) | ✅ |
| Export Meal Data | ❌ | ❌ | ❌ | ✅ (All) | ✅ |
| Meal Analytics | ❌ | ✅ | ✅ | ✅ (All) | ✅ |
| Meal Policy Management | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| Ingredient Planning | ❌ | ❌ | ❌ | ✅ (All) | ✅ |

### Room & Bed Management
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| View Own Room/Bed | ✅ | ❌ | ❌ | ✅ (All) | ❌ |
| View Room Map | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Allocate Bed to Student | ❌ | ✅ | ❌ | ✅ (All) | ❌ |
| Transfer Student | ❌ | ✅ | ❌ | ✅ (All) | ❌ |
| Swap Students | ❌ | ✅ | ❌ | ✅ (All) | ❌ |
| Vacate Bed | ❌ | ✅ | ❌ | ✅ (All) | ❌ |
| View Allocation History | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Create Block/Floor/Room | ❌ | ❌ | ❌ | ✅ (All) | ❌ |
| Create Bed | ❌ | ❌ | ❌ | ✅ (All) | ❌ |
| CSV Import/Export | ❌ | ❌ | ❌ | ✅ (All) | ❌ |
| Room Analytics | ❌ | ✅ | ✅ | ✅ (All) | ❌ |

### Notices & Communication
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| View Notices | ✅ | ✅ | ✅ | ✅ (All) | ❌ |
| Mark Notice as Read | ✅ | ✅ | ✅ | ✅ (All) | ❌ |
| Create Notice | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Broadcast Notice | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| Target Audience Selection | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Send Push Notifications | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| View Notice Analytics | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Notice Templates | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Notice History | ❌ | ✅ | ✅ | ✅ (All) | ❌ |

### Reports & Analytics
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| View Basic Reports | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| View Advanced Reports | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| View Comprehensive Reports | ❌ | ❌ | ❌ | ✅ (All) | ❌ |
| Daily Analytics | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Monthly Analytics | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| Drill-down Reports | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Export Reports | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Custom Report Builder | ❌ | ❌ | ❌ | ✅ (All) | ❌ |
| Real-time Dashboards | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Meal-specific Reports | ❌ | ❌ | ❌ | ✅ (All) | ✅ |

### Policy Management
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| View Policy Summary | ✅ | ✅ | ✅ | ✅ (All) | ❌ |
| View Full Policies | ❌ | ✅ | ✅ | ✅ (All) | ❌ |
| Edit Policies | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| Create New Policies | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| Delete Policies | ❌ | ❌ | ❌ | ✅ (All) | ❌ |
| Policy History | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| Policy Templates | ❌ | ❌ | ✅ | ✅ (All) | ❌ |
| Policy Enforcement | ❌ | ✅ | ✅ | ✅ (All) | ❌ |

### User Management (Super Admin Only)
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| View All Users | ❌ | ❌ | ❌ | ✅ | ❌ |
| Create User | ❌ | ❌ | ❌ | ✅ | ❌ |
| Edit User | ❌ | ❌ | ❌ | ✅ | ❌ |
| Delete User | ❌ | ❌ | ❌ | ✅ | ❌ |
| Assign Roles | ❌ | ❌ | ❌ | ✅ | ❌ |
| Reset Password | ❌ | ❌ | ❌ | ✅ | ❌ |
| Activate/Deactivate User | ❌ | ❌ | ❌ | ✅ | ❌ |
| View Staff Roster | ❌ | ❌ | ❌ | ✅ | ❌ |
| View Student Roster | ❌ | ❌ | ❌ | ✅ | ❌ |
| Bulk User Operations | ❌ | ❌ | ❌ | ✅ | ❌ |
| User Analytics | ❌ | ❌ | ❌ | ✅ | ❌ |

### System Administration (Super Admin Only)
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| System Health Monitoring | ❌ | ❌ | ❌ | ✅ | ❌ |
| Error Logs | ❌ | ❌ | ❌ | ✅ | ❌ |
| Performance Metrics | ❌ | ❌ | ❌ | ✅ | ❌ |
| Offline Queue Management | ❌ | ❌ | ❌ | ✅ | ❌ |
| Database Management | ❌ | ❌ | ❌ | ✅ | ❌ |
| API Configuration | ❌ | ❌ | ❌ | ✅ | ❌ |
| Environment Settings | ❌ | ❌ | ❌ | ✅ | ❌ |
| Backup Management | ❌ | ❌ | ❌ | ✅ | ❌ |
| Security Audit | ❌ | ❌ | ❌ | ✅ | ❌ |
| System Maintenance | ❌ | ❌ | ❌ | ✅ | ❌ |

### Hostel Structure Management (Super Admin Only)
| Feature | Student | Warden | Warden Head | Super Admin | Chef |
|---------|---------|--------|-------------|-------------|------|
| Create Hostel | ❌ | ❌ | ❌ | ✅ | ❌ |
| Edit Hostel | ❌ | ❌ | ❌ | ✅ | ❌ |
| Delete Hostel | ❌ | ❌ | ❌ | ✅ | ❌ |
| Create Block | ❌ | ❌ | ❌ | ✅ | ❌ |
| Edit Block | ❌ | ❌ | ❌ | ✅ | ❌ |
| Delete Block | ❌ | ❌ | ❌ | ✅ | ❌ |
| Create Floor | ❌ | ❌ | ❌ | ✅ | ❌ |
| Edit Floor | ❌ | ❌ | ❌ | ✅ | ❌ |
| Delete Floor | ❌ | ❌ | ❌ | ✅ | ❌ |
| Create Room | ❌ | ❌ | ❌ | ✅ | ❌ |
| Edit Room | ❌ | ❌ | ❌ | ✅ | ❌ |
| Delete Room | ❌ | ❌ | ❌ | ✅ | ❌ |
| Create Bed | ❌ | ❌ | ❌ | ✅ | ❌ |
| Edit Bed | ❌ | ❌ | ❌ | ✅ | ❌ |
| Delete Bed | ❌ | ❌ | ❌ | ✅ | ❌ |

## Permission Levels

### Level 1: Read-Only Access
- View personal data
- View notices
- View policy summary
- View own attendance/meal history

### Level 2: Basic Management
- Submit requests
- Create notices
- Manage attendance sessions
- Allocate rooms

### Level 3: Advanced Management
- Override meal forecasts
- Broadcast notices
- Manage policies
- View advanced reports

### Level 4: Full Administration
- User management
- System configuration
- Comprehensive analytics
- Audit trails

## Role Hierarchy

```
Super Admin (Level 4)
├── Warden Head (Level 3)
│   ├── Warden (Level 2)
│   └── Student (Level 1)
└── Chef (Level 2 - Specialized)
```

## Access Control Implementation

### Role Guard Implementation
```dart
class RoleGuard {
  static bool canAccess(String feature, String userRole) {
    final permissions = _getPermissions(userRole);
    return permissions.contains(feature);
  }
  
  static List<String> _getPermissions(String role) {
    switch (role) {
      case 'STUDENT':
        return [
          'view_profile', 'edit_profile', 'request_gatepass',
          'view_attendance', 'submit_meal_intent', 'view_notices',
          'view_room', 'view_policy_summary'
        ];
      case 'WARDEN':
        return [
          ..._getPermissions('STUDENT'),
          'approve_gatepass', 'manage_attendance', 'allocate_rooms',
          'create_notices', 'view_reports', 'view_policies'
        ];
      case 'WARDEN_HEAD':
        return [
          ..._getPermissions('WARDEN'),
          'manage_policies', 'meal_overrides', 'broadcast_notices',
          'advanced_reports', 'view_all_attendance'
        ];
      case 'SUPER_ADMIN':
        return [
          'all_permissions' // Complete access
        ];
      case 'CHEF':
        return [
          'view_meal_forecast', 'chef_board', 'meal_analytics',
          'ingredient_planning', 'export_meal_data'
        ];
      default:
        return [];
    }
  }
}
```

### Feature-Level Permissions
```dart
class FeaturePermissions {
  static const Map<String, List<String>> permissions = {
    'gatepass_request': ['STUDENT', 'SUPER_ADMIN'],
    'gatepass_approve': ['WARDEN', 'WARDEN_HEAD', 'SUPER_ADMIN'],
    'attendance_manage': ['WARDEN', 'WARDEN_HEAD', 'SUPER_ADMIN'],
    'room_allocate': ['WARDEN', 'SUPER_ADMIN'],
    'policy_manage': ['WARDEN_HEAD', 'SUPER_ADMIN'],
    'user_manage': ['SUPER_ADMIN'],
    'system_admin': ['SUPER_ADMIN'],
    'meal_forecast': ['WARDEN_HEAD', 'SUPER_ADMIN', 'CHEF'],
  };
}
```

## Security Considerations

### Data Access Restrictions
- **Student**: Only personal data
- **Warden**: Hostel-level data
- **Warden Head**: Multi-hostel data
- **Super Admin**: System-wide data
- **Chef**: Meal-related data only

### Action Restrictions
- **Create**: Limited to assigned roles
- **Read**: Based on data scope
- **Update**: Role-specific modifications
- **Delete**: Super Admin only

### Audit Trail Requirements
- All user actions logged
- Role changes tracked
- Permission modifications recorded
- Security events monitored

## Testing Matrix

### Role Access Testing
| Test Case | Student | Warden | Warden Head | Super Admin | Chef |
|-----------|---------|--------|-------------|-------------|------|
| Login with valid credentials | ✅ | ✅ | ✅ | ✅ | ✅ |
| Access unauthorized feature | ❌ | ❌ | ❌ | ❌ | ❌ |
| View role-appropriate dashboard | ✅ | ✅ | ✅ | ✅ | ✅ |
| Perform role-specific actions | ✅ | ✅ | ✅ | ✅ | ✅ |
| Access forbidden data | ❌ | ❌ | ❌ | ❌ | ❌ |

### Permission Testing
| Test Case | Expected Result |
|-----------|----------------|
| Student tries to approve gate pass | Access Denied |
| Warden tries to manage policies | Access Denied |
| Warden Head tries to create users | Access Denied |
| Chef tries to allocate rooms | Access Denied |
| Super Admin accesses any feature | Access Granted |

## Conclusion

This role access matrix provides comprehensive coverage of all features and functionalities in the HostelConnect Mobile App. The hierarchical permission system ensures that users can only access features appropriate to their role, maintaining security and data integrity.

The implementation uses role guards and permission checks at multiple levels to ensure robust access control throughout the application.

---

**Last Updated**: December 2024  
**Version**: 1.0.0  
**Status**: Production Ready