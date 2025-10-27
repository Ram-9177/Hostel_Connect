# Migration Guide - New Features

## 🎯 What Changed?

This guide explains what files were modified and what new capabilities are available.

---

## 📂 File Changes Overview

### ✨ New Files (7 files)

#### Backend DTOs
1. **`/hostelconnect/src/notifications/dto/create-targeted-notification.dto.ts`**
   - Defines types for targeted notifications
   - Enums: `NotificationType`, `NotificationPriority`, `TargetType`

2. **`/hostelconnect/src/students/dto/bulk-student.dto.ts`**
   - `BulkStudentDto` - For CSV upload
   - `UpdateStudentDto` - For admin updates
   - `ResetPasswordDto` - For password resets

#### Backend Services
3. **`/hostelconnect/src/meals/meal-scheduler.service.ts`**
   - Cron jobs for daily meal notifications
   - Methods: `sendMorningMealReminder()`, `sendEveningCutoffWarning()`, `sendDailyMenuAnnouncement()`

#### Frontend Components
4. **`/src/components/admin/CreateNotificationForm.tsx`**
   - React component for creating targeted notifications
   - Cascading dropdowns for hostel → block → floor → room

5. **`/src/components/admin/BulkStudentUpload.tsx`**
   - React component for CSV upload
   - File validation and error display

#### Documentation
6. **`/NEW_FEATURES_GUIDE.md`** - Comprehensive API documentation
7. **`/QUICK_START_NEW_FEATURES.md`** - Quick setup guide

---

### 🔧 Modified Files (8 files)

#### 1. `/hostelconnect/src/notifications/notifications.service.ts`

**What Changed:**
- Added imports: `Student`, `Room`, `Block` entities
- Added method: `createTargetedNotification()`

**New Capabilities:**
```typescript
// Send to all students in a hostel
await notificationsService.createTargetedNotification({
  targetType: 'hostel',
  hostelId: 'uuid',
  title: 'Hostel Announcement',
  body: 'Message for all hostel residents',
  type: 'announcement',
  priority: 'medium'
}, adminUserId);

// Send to specific floor
await notificationsService.createTargetedNotification({
  targetType: 'floor',
  hostelId: 'uuid',
  blockId: 'uuid',
  floor: 2,
  title: 'Floor 2 Notice',
  // ...
});
```

---

#### 2. `/hostelconnect/src/notifications/notifications.controller.ts`

**What Changed:**
- Added endpoint: `POST /notifications/send-targeted`
- Added helper method: `checkAdminPermission()`

**New Endpoint:**
```typescript
@Post('send-targeted')
async sendTargetedNotification(@Request() req, @Body() dto: CreateTargetedNotificationDto)
```

**Before:**
```typescript
// Only had: /notifications/send (basic notification)
```

**After:**
```typescript
// Now has:
// - /notifications/send (basic)
// - /notifications/send-targeted (advanced with targeting)
```

---

#### 3. `/hostelconnect/src/notifications/notifications.module.ts`

**What Changed:**
```typescript
// BEFORE:
imports: [TypeOrmModule.forFeature([Notification, Device])]

// AFTER:
imports: [TypeOrmModule.forFeature([Notification, Device, Student, Room, Block])]
```

**Why:** Needed to query students by room/block/floor for targeted notifications.

---

#### 4. `/hostelconnect/src/students/students.service.ts`

**What Changed:**
- Added imports: `Hostel`, `User`, `bcrypt`
- Added methods:
  - `bulkCreateStudents()` - CSV batch processing
  - `updateStudentData()` - Admin update student
  - `resetStudentPassword()` - Admin reset password
  - `deleteStudentAccount()` - Soft delete (deactivate)
  - `permanentlyDeleteStudent()` - Hard delete

**New Capabilities:**
```typescript
// Bulk create from CSV
const result = await studentsService.bulkCreateStudents([
  { name: 'John Doe', hallTicket: 'TEST001', ... }
], adminId);

// Update student
await studentsService.updateStudentData(studentId, {
  firstName: 'John',
  email: 'new@email.com'
});

// Reset password
const { newPassword } = await studentsService.resetStudentPassword({
  studentId: 'uuid'
});
```

---

#### 5. `/hostelconnect/src/students/students.controller.ts`

**What Changed:**
- Added imports: `FileInterceptor`, `csv-parser`
- Added endpoints:
  - `POST /students/bulk-upload` - CSV upload
  - `PUT /students/manage/:id` - Update student
  - `POST /students/reset-password` - Reset password
  - `DELETE /students/manage/:id/deactivate` - Deactivate
  - `DELETE /students/manage/:id/permanent` - Permanent delete

**Before:**
```typescript
// Only CRUD: GET, PUT, DELETE basic operations
```

**After:**
```typescript
// Now has admin-level operations:
// - Bulk upload
// - Password reset
// - Soft/hard delete
```

---

#### 6. `/hostelconnect/src/students/students.module.ts`

**What Changed:**
```typescript
// BEFORE:
imports: [TypeOrmModule.forFeature([Student])]

// AFTER:
imports: [TypeOrmModule.forFeature([Student, Hostel, User])]
```

**Why:** Needed to create User accounts and validate Hostel names during bulk upload.

---

#### 7. `/hostelconnect/src/meals/meals.controller.ts`

**What Changed:**
- Added import: `MealSchedulerService`
- Added endpoint: `POST /meals/notifications/trigger`

**New Capability:**
```typescript
// Manually trigger meal notifications (for testing)
@Post('notifications/trigger')
async triggerMealNotification(@Body() body: { type: 'morning' | 'evening' | 'menu' })
```

---

#### 8. `/hostelconnect/src/meals/meals.module.ts`

**What Changed:**
```typescript
// BEFORE:
imports: [TypeOrmModule.forFeature([...])],
providers: [MealsService]

// AFTER:
imports: [
  TypeOrmModule.forFeature([...]),
  ScheduleModule.forRoot(),
  NotificationsModule
],
providers: [MealsService, MealSchedulerService, SocketService]
```

**Why:** Added cron job support and notification capabilities for automated reminders.

---

## 🔄 Database Changes

**Good News: NO MIGRATIONS REQUIRED!**

All new features use existing database tables:
- ✅ `notifications` - Already existed
- ✅ `students` - Already existed
- ✅ `users` - Already existed
- ✅ `hostels` - Already existed
- ✅ `blocks` - Already existed
- ✅ `rooms` - Already existed

---

## 🆕 New Dependencies

Add these to `package.json` if missing:

```json
{
  "dependencies": {
    "csv-parser": "^3.0.0",
    "@types/multer": "^1.4.11",
    "@nestjs/schedule": "^4.0.0"
  }
}
```

Install:
```bash
npm install csv-parser @types/multer
```

---

## 🔐 Permission Changes

### New Permission Checks

All new endpoints check for admin roles:

```typescript
private checkAdminPermission(role: string): boolean {
  return ['SUPER_ADMIN', 'WARDEN_HEAD', 'WARDEN'].includes(role);
}

private checkSuperAdminPermission(role: string): boolean {
  return ['SUPER_ADMIN'].includes(role);
}
```

### Permission Matrix

| Endpoint | SUPER_ADMIN | WARDEN_HEAD | WARDEN | STUDENT |
|----------|-------------|-------------|--------|---------|
| Send targeted notification | ✅ | ✅ | ✅ | ❌ |
| Bulk upload students | ✅ | ✅ | ✅ | ❌ |
| Update student data | ✅ | ✅ | ✅ | ❌ |
| Reset password | ✅ | ✅ | ✅ | ❌ |
| Deactivate student | ✅ | ✅ | ✅ | ❌ |
| **Permanent delete** | ✅ | ❌ | ❌ | ❌ |

---

## 📊 API Changes Summary

### Notifications Module

**Before:**
- ✅ GET `/notifications` - Get user notifications
- ✅ POST `/notifications/send` - Send basic notification

**After:**
- ✅ GET `/notifications` - Get user notifications
- ✅ POST `/notifications/send` - Send basic notification
- 🆕 **POST `/notifications/send-targeted`** - Send to specific groups

---

### Students Module

**Before:**
- ✅ GET `/students` - List all students
- ✅ GET `/students/:id` - Get one student
- ✅ PUT `/students/:id` - Update student
- ✅ DELETE `/students/:id` - Delete student

**After:**
- ✅ GET `/students` - List all students
- ✅ GET `/students/:id` - Get one student
- ✅ PUT `/students/:id` - Update student (basic)
- ✅ DELETE `/students/:id` - Delete student (basic)
- 🆕 **POST `/students/bulk-upload`** - CSV upload
- 🆕 **PUT `/students/manage/:id`** - Admin update
- 🆕 **POST `/students/reset-password`** - Reset password
- 🆕 **DELETE `/students/manage/:id/deactivate`** - Soft delete
- 🆕 **DELETE `/students/manage/:id/permanent`** - Hard delete

---

### Meals Module

**Before:**
- ✅ POST `/meals/intents/open` - Open meal intents
- ✅ POST `/meals/intent/day` - Set day intents
- ✅ GET `/meals/forecast` - Get forecast

**After:**
- ✅ POST `/meals/intents/open` - Open meal intents
- ✅ POST `/meals/intent/day` - Set day intents
- ✅ GET `/meals/forecast` - Get forecast
- 🆕 **POST `/meals/notifications/trigger`** - Manual trigger reminders

---

## 🕐 New Scheduled Jobs

### Cron Jobs Added

```typescript
// Morning reminder - 7:00 AM IST
@Cron('0 7 * * *', { timeZone: 'Asia/Kolkata' })
async sendMorningMealReminder()

// Evening warning - 6:00 PM IST
@Cron('0 18 * * *', { timeZone: 'Asia/Kolkata' })
async sendEveningCutoffWarning()

// Menu announcement - 9:00 AM IST
@Cron('0 9 * * *', { timeZone: 'Asia/Kolkata' })
async sendDailyMenuAnnouncement()
```

**Monitor:**
```bash
docker-compose logs -f api | grep "MealSchedulerService"
```

---

## 🔄 Breaking Changes

**Good News: NONE!**

All changes are **additive** - existing functionality is preserved.

- ✅ Old endpoints still work
- ✅ No database schema changes
- ✅ Backward compatible

---

## 🚀 Upgrade Steps

1. **Pull latest code**
   ```bash
   git pull origin main
   ```

2. **Install new dependencies**
   ```bash
   cd hostelconnect/api
   npm install
   ```

3. **Build**
   ```bash
   npm run build
   ```

4. **Restart server**
   ```bash
   npm run start:dev
   # or
   docker-compose restart api
   ```

5. **Verify**
   - Check Swagger docs at `/api`
   - Test new endpoints
   - Monitor cron job logs

---

## 📝 Configuration Changes

### Optional: Customize Cron Times

Edit `/src/meals/meal-scheduler.service.ts`:

```typescript
// Change from 7 AM to 8 AM:
@Cron('0 8 * * *', { timeZone: 'Asia/Kolkata' })

// Change timezone:
@Cron('0 7 * * *', { timeZone: 'America/New_York' })
```

### Optional: Customize Email Domain

Edit `/src/students/students.service.ts`:

```typescript
// Change default email domain:
const email = studentData.email || 
  `${studentData.hallTicket.toLowerCase()}@yourcollege.edu`;
```

---

## ✅ Testing Checklist

After upgrade, test:

- [ ] Login as admin
- [ ] Send notification to all students
- [ ] Send notification to specific floor
- [ ] Upload CSV with 2-3 test students
- [ ] Reset a student's password
- [ ] Update student data
- [ ] Deactivate a student
- [ ] Trigger morning meal notification manually
- [ ] Check logs for cron job execution

---

## 🐛 Rollback Plan

If issues occur:

1. **Revert code:**
   ```bash
   git revert HEAD
   ```

2. **Restart server:**
   ```bash
   docker-compose restart api
   ```

3. **No database changes to rollback** (no migrations were run)

---

## 📞 Support

For issues:
1. Check logs: `docker-compose logs api`
2. Review `NEW_FEATURES_GUIDE.md`
3. Check Swagger UI: `http://localhost:3000/api`

---

**Migration Complete!** 🎉

All new features are now available while maintaining full backward compatibility.
