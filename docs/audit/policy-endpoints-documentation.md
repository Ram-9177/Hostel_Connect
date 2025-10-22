# Policy Management System - API Endpoints & Fields

## Overview
The Policy Management System provides comprehensive policy configuration for hostel operations including curfew, attendance, meals, and room management policies.

## API Endpoints

### Policy CRUD Operations
- `POST /api/v1/hostels/{hostelId}/policies` - Create new policy
- `GET /api/v1/hostels/{hostelId}/policies` - Get all policies for hostel
- `GET /api/v1/policies/{policyId}` - Get specific policy
- `PUT /api/v1/policies/{policyId}` - Update policy
- `DELETE /api/v1/policies/{policyId}` - Delete policy
- `PATCH /api/v1/policies/{policyId}/activate` - Activate policy
- `PATCH /api/v1/policies/{policyId}/deactivate` - Deactivate policy

### Policy Templates
- `GET /api/v1/policies/templates` - Get available policy templates
- `POST /api/v1/hostels/{hostelId}/policies/from-template` - Create policy from template

### Policy Validation & History
- `POST /api/v1/policies/validate` - Validate policy configuration
- `GET /api/v1/policies/{policyId}/history` - Get policy change history
- `GET /api/v1/hostels/{hostelId}/policies/history` - Get hostel policy history

### Policy Statistics & Compliance
- `GET /api/v1/policies/{policyId}/statistics` - Get policy statistics
- `GET /api/v1/hostels/{hostelId}/policies/compliance` - Get compliance data
- `GET /api/v1/hostels/{hostelId}/policies/violations` - Get policy violations

### Role-Specific Access
- `GET /api/v1/hostels/{hostelId}/policies/warden` - Get warden-readable policies
- `GET /api/v1/hostels/{hostelId}/policies/summary` - Get student policy summary

### Specific Policy Types
- `GET /api/v1/hostels/{hostelId}/policies/curfew` - Get curfew policy
- `PUT /api/v1/hostels/{hostelId}/policies/curfew` - Update curfew policy
- `GET /api/v1/hostels/{hostelId}/policies/attendance` - Get attendance policy
- `PUT /api/v1/hostels/{hostelId}/policies/attendance` - Update attendance policy
- `GET /api/v1/hostels/{hostelId}/policies/meal` - Get meal policy
- `PUT /api/v1/hostels/{hostelId}/policies/meal` - Update meal policy
- `GET /api/v1/hostels/{hostelId}/policies/room` - Get room policy
- `PUT /api/v1/hostels/{hostelId}/policies/room` - Update room policy

### Bulk Operations
- `PUT /api/v1/hostels/{hostelId}/policies/bulk` - Bulk update policies
- `PATCH /api/v1/hostels/{hostelId}/policies/bulk-activate` - Bulk activate policies
- `PATCH /api/v1/hostels/{hostelId}/policies/bulk-deactivate` - Bulk deactivate policies

### Import/Export
- `GET /api/v1/hostels/{hostelId}/policies/export` - Export policies
- `POST /api/v1/hostels/{hostelId}/policies/import` - Import policies

### Notifications & Scheduling
- `POST /api/v1/policies/{policyId}/notify` - Notify policy change
- `POST /api/v1/policies/{policyId}/schedule` - Schedule policy activation

## Data Models

### HostelPolicy
```typescript
interface HostelPolicy {
  id: string;
  hostelId: string;
  name: string;
  type: PolicyType;
  configuration: Record<string, any>;
  isActive: boolean;
  effectiveFrom: Date;
  effectiveUntil?: Date;
  createdBy: string;
  createdByName: string;
  createdAt: Date;
  updatedAt: Date;
  description?: string;
  applicableRoles?: string[];
  metadata?: Record<string, any>;
}
```

### PolicyType Enum
```typescript
enum PolicyType {
  CURFEW = 'curfew',
  ATTENDANCE = 'attendance',
  MEAL = 'meal',
  ROOM = 'room',
  VISITOR = 'visitor',
  MAINTENANCE = 'maintenance',
  GENERAL = 'general'
}
```

### CurfewPolicy Configuration
```typescript
interface CurfewPolicy {
  weekdaysCurfew: TimeOfDay;
  weekendsCurfew: TimeOfDay;
  graceMinutes: number;
  allowLateEntry: boolean;
  exemptRoles: string[];
  timezone: string;
  penalties: Record<string, any>;
}
```

### AttendancePolicy Configuration
```typescript
interface AttendancePolicy {
  graceMinutes: number;
  minimumAttendancePercentage: number;
  rules: AttendanceRule[];
  consequences: Record<string, any>;
  allowManualEntry: boolean;
  requireReasonForAbsence: boolean;
}
```

### MealPolicy Configuration
```typescript
interface MealPolicy {
  breakfastCutoff: TimeOfDay;
  lunchCutoff: TimeOfDay;
  dinnerCutoff: TimeOfDay;
  forecastBufferPercentage: number;
  advanceBookingDays: number;
  allowLateBooking: boolean;
  dietaryRestrictions: Record<string, any>;
  mealTimings: Record<string, any>;
}
```

### RoomPolicy Configuration
```typescript
interface RoomPolicy {
  genderPolicy: GenderPolicy;
  wingRules: WingRule[];
  maxRoomCapacity: number;
  allowRoomSwapping: boolean;
  swapCooldownDays: number;
  maintenanceRules: Record<string, any>;
  visitorRules: Record<string, any>;
}
```

### TimeOfDay
```typescript
interface TimeOfDay {
  hour: number;
  minute: number;
}
```

### PolicySummary (Student View)
```typescript
interface PolicySummary {
  hostelId: string;
  rules: PolicyRule[];
  lastUpdated: Date;
  version: string;
}

interface PolicyRule {
  title: string;
  description: string;
  category: string;
  icon: string;
  isImportant: boolean;
}
```

### PolicyChangeHistory
```typescript
interface PolicyChangeHistory {
  id: string;
  policyId: string;
  changeType: PolicyChangeType;
  oldValue: Record<string, any>;
  newValue: Record<string, any>;
  changedBy: string;
  changedByName: string;
  changedAt: Date;
  reason?: string;
  metadata?: Record<string, any>;
}
```

### PolicyStatistics
```typescript
interface PolicyStatistics {
  policyId: string;
  totalViolations: number;
  totalWarnings: number;
  totalPenalties: number;
  violationsByType: Record<string, number>;
  violationsByMonth: Record<string, number>;
  lastViolation: Date;
  complianceRate: number;
}
```

## Integration Points

### Meal Forecast Integration
- Meal policies affect forecast calculations with buffer percentages
- Cutoff times determine booking availability
- Policy changes automatically update meal forecasts

### Dashboard Integration
- Policy-based labels show cutoff times (e.g., "cutoff 20:00 IST")
- Compliance rates displayed in admin dashboards
- Policy violations shown in warden dashboards

### Role-Based Access
- **Super Admin**: Full CRUD access to all policies
- **Warden Head**: Full CRUD access to policies for their hostels
- **Warden**: Read-only access to active policies
- **Student**: Summary view with important rules only

## Policy Templates

### Default Templates
1. **Standard Curfew Policy**
   - Weekdays: 10:00 PM
   - Weekends: 11:00 PM
   - Grace: 15 minutes

2. **Standard Attendance Policy**
   - Grace: 10 minutes
   - Minimum: 75%
   - Manual entry allowed

3. **Standard Meal Policy**
   - Breakfast cutoff: 9:00 AM
   - Lunch cutoff: 2:00 PM
   - Dinner cutoff: 8:00 PM
   - Buffer: 10%

4. **Standard Room Policy**
   - Gender: Same gender
   - Max capacity: 4
   - Swapping allowed

## Validation Rules

### Curfew Policy Validation
- Weekdays curfew must be before weekends curfew
- Grace minutes must be between 0-60
- Exempt roles must be valid user roles

### Attendance Policy Validation
- Grace minutes must be between 0-30
- Minimum percentage must be between 50-100
- Rules must have valid time ranges

### Meal Policy Validation
- Cutoff times must be in chronological order
- Buffer percentage must be between 0-50
- Advance booking days must be between 0-7

### Room Policy Validation
- Max capacity must be between 1-8
- Cooldown days must be between 0-30
- Wing rules must be consistent

## Error Handling

### Common Error Responses
- `400 Bad Request`: Invalid policy configuration
- `401 Unauthorized`: Insufficient permissions
- `403 Forbidden`: Role not allowed for operation
- `404 Not Found`: Policy or hostel not found
- `409 Conflict`: Policy conflicts with existing rules
- `422 Unprocessable Entity`: Validation errors

### Error Response Format
```typescript
interface ErrorResponse {
  error: string;
  message: string;
  details?: Record<string, any>;
  validationErrors?: ValidationError[];
}
```

## Security Considerations

### Authentication
- All policy endpoints require authentication
- JWT tokens validated for each request

### Authorization
- Role-based access control enforced
- Policy ownership validation
- Audit logging for all changes

### Data Protection
- Sensitive policy data encrypted
- Personal information in policies masked
- Compliance with data protection regulations

## Performance Considerations

### Caching
- Active policies cached for 5 minutes
- Policy summaries cached for 1 hour
- Statistics cached for 15 minutes

### Rate Limiting
- Policy creation: 10 requests/minute
- Policy updates: 20 requests/minute
- Policy reads: 100 requests/minute

### Database Optimization
- Indexed on hostelId, policyId, type
- Partitioned by policy type
- Archived inactive policies

## Monitoring & Analytics

### Metrics Tracked
- Policy creation/update frequency
- Compliance rates by policy type
- Violation patterns and trends
- API response times

### Alerts
- High violation rates
- Policy conflicts
- Failed validations
- Performance degradation

## Future Enhancements

### Planned Features
- Policy versioning and rollback
- Automated policy suggestions
- Machine learning compliance prediction
- Advanced reporting and analytics
- Policy templates marketplace
- Integration with external systems
