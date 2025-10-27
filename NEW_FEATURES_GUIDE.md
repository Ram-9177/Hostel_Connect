# New Features Implementation Guide

## Overview
This document describes the newly implemented features for HostelConnect:

1. **Targeted Notification System** - Create notifications for specific groups (all, hostel, block, floor, room, individual)
2. **Bulk Student Creation** - CSV upload for batch student registration
3. **Student Management** - Admin capabilities to modify, reset, and delete student accounts
4. **Automated Meal Notifications** - Daily scheduled notifications for meal intent reminders

---

## 🔔 1. Targeted Notification System

### Features
- Admin/Warden/Warden Head can create notifications for:
  - ✅ All students
  - ✅ Specific hostel
  - ✅ Specific block
  - ✅ Specific floor
  - ✅ Specific room
  - ✅ Individual student
  - ✅ Role-based (e.g., all wardens)

### API Endpoint

**POST** `/api/v1/notifications/send-targeted`

**Authorization**: `SUPER_ADMIN`, `WARDEN_HEAD`, `WARDEN`

**Request Body**:
```json
{
  "title": "Important Announcement",
  "body": "This is a test notification",
  "type": "announcement",
  "priority": "high",
  "targetType": "floor",
  "hostelId": "hostel-uuid",
  "blockId": "block-uuid",
  "floor": 2,
  "expiresAt": "2025-10-30T00:00:00Z"
}
```

**Target Types**:
- `all` - All students
- `hostel` - Requires `hostelId`
- `block` - Requires `hostelId` and `blockId`
- `floor` - Requires `hostelId`, `blockId`, and `floor`
- `room` - Requires `roomId`
- `student` - Requires `studentId`
- `role` - Requires `role` (e.g., "STUDENT", "WARDEN")

**Response**:
```json
{
  "success": true,
  "message": "Notification sent to 45 students",
  "notification": { /* notification object */ },
  "targetCount": 45
}
```

### Notification Types
- `gate_pass`
- `attendance`
- `room_allocation`
- `meal_intent`
- `notice`
- `system`
- `announcement` ⭐ NEW

### Priority Levels
- `low` - Regular updates
- `medium` - Important information
- `high` - Urgent matters
- `urgent` - Critical alerts

---

## 👥 2. Bulk Student Creation (CSV Upload)

### Features
- Upload CSV file with student data
- Automatic user account creation
- Default password generation (Hall Ticket number)
- Hostel assignment based on name
- Email auto-generation if not provided
- Detailed error reporting for failed entries

### API Endpoint

**POST** `/api/v1/students/bulk-upload`

**Authorization**: `SUPER_ADMIN`, `WARDEN_HEAD`, `WARDEN`

**Request**: Form-data with CSV file

**CSV Format**:
```csv
Name,Hall Ticket,College code,Number,Hostel Name
John Doe,21CS001,CS,9876543210,Boys Hostel A
Jane Smith,21CS002,CS,9876543211,Girls Hostel B
```

**CSV Columns**:
- `Name` - Student full name (will be split into first/last name)
- `Hall Ticket` - Student ID / Hall ticket number (unique)
- `College code` - College/Department code
- `Number` - Phone number
- `Hostel Name` - Name of the hostel (must exist in database)

**Response**:
```json
{
  "success": true,
  "message": "Bulk upload completed. Created: 48, Errors: 2",
  "created": 48,
  "errors": [
    {
      "hallTicket": "21CS003",
      "error": "Hostel not found: Invalid Hostel"
    },
    {
      "hallTicket": "21CS004",
      "error": "Student already exists"
    }
  ]
}
```

### Default Settings
- **Default Password**: Hall Ticket number
- **Default Email**: `{hall_ticket}@student.college.edu` (if not provided)
- **Role**: `STUDENT`
- **Status**: Active

---

## ⚙️ 3. Student Management (Admin)

### Features

#### 3.1 Update Student Data

**PUT** `/api/v1/students/manage/:id`

**Authorization**: `SUPER_ADMIN`, `WARDEN_HEAD`, `WARDEN`

**Request Body**:
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@student.college.edu",
  "phone": "9876543210",
  "roomId": "room-uuid",
  "bedNumber": 3,
  "hostelId": "hostel-uuid",
  "isActive": true
}
```

#### 3.2 Reset Password

**POST** `/api/v1/students/reset-password`

**Authorization**: `SUPER_ADMIN`, `WARDEN_HEAD`, `WARDEN`

**Request Body**:
```json
{
  "studentId": "student-uuid",
  "newPassword": "optional-new-password"
}
```

**Response**:
```json
{
  "success": true,
  "newPassword": "21CS001"
}
```

**Note**: If `newPassword` is not provided, it defaults to the student's Hall Ticket number.

#### 3.3 Deactivate Student Account

**DELETE** `/api/v1/students/manage/:id/deactivate`

**Authorization**: `SUPER_ADMIN`, `WARDEN_HEAD`, `WARDEN`

**Effect**: Soft delete - sets `isActive` to `false`. Student can't log in but data is preserved.

#### 3.4 Permanently Delete Student

**DELETE** `/api/v1/students/manage/:id/permanent`

**Authorization**: `SUPER_ADMIN` only

**Effect**: Hard delete - permanently removes student from database. **USE WITH CAUTION!**

---

## 📅 4. Automated Meal Notifications

### Features
- **Daily Morning Reminder** (7:00 AM IST)
- **Evening Cutoff Warning** (6:00 PM IST)
- **Daily Menu Announcement** (9:00 AM IST)

### Scheduled Notifications

#### 4.1 Morning Meal Reminder
- **Time**: 7:00 AM (Asia/Kolkata timezone)
- **Recipients**: All active students
- **Message**: "Good morning! Don't forget to submit your meal preferences for tomorrow. Deadline: 8:00 PM today."
- **Priority**: Medium
- **Expires**: 24 hours

#### 4.2 Evening Cutoff Warning
- **Time**: 6:00 PM (Asia/Kolkata timezone)
- **Recipients**: All active students
- **Message**: "Only 2 hours left! Submit your meal preferences for tomorrow before 8:00 PM."
- **Priority**: High
- **Expires**: 4 hours

#### 4.3 Daily Menu Announcement
- **Time**: 9:00 AM (Asia/Kolkata timezone)
- **Recipients**: All active students
- **Message**: "Check out today's meal menu! View your meal schedule."
- **Priority**: Low
- **Expires**: 12 hours

### Manual Trigger (Testing/Admin)

**POST** `/api/v1/meals/notifications/trigger`

**Authorization**: `SUPER_ADMIN`, `WARDEN_HEAD`, `WARDEN`

**Request Body**:
```json
{
  "type": "morning"
}
```

**Types**:
- `morning` - Morning meal reminder
- `evening` - Evening cutoff warning
- `menu` - Daily menu announcement

**Response**:
```json
{
  "success": true,
  "sentCount": 150
}
```

---

## 🏗️ Technical Implementation

### New Files Created

1. **DTOs**:
   - `/src/notifications/dto/create-targeted-notification.dto.ts`
   - `/src/students/dto/bulk-student.dto.ts`

2. **Services**:
   - `/src/meals/meal-scheduler.service.ts`

3. **Controllers** (Enhanced):
   - `/src/notifications/notifications.controller.ts`
   - `/src/students/students.controller.ts`
   - `/src/meals/meals.controller.ts`

4. **Services** (Enhanced):
   - `/src/notifications/notifications.service.ts`
   - `/src/students/students.service.ts`

### Dependencies Required

The following packages are already in the project:
- `@nestjs/schedule` - For cron jobs
- `@nestjs/platform-express` - For file uploads
- `bcrypt` - For password hashing
- `csv-parser` - For CSV parsing

If missing, install with:
```bash
cd hostelconnect/api
npm install csv-parser @types/multer
```

### Database Updates

No new migrations required! All features use existing entities:
- `Student`
- `User`
- `Notification`
- `Hostel`
- `Block`
- `Room`

---

## 🧪 Testing Guide

### 1. Test Targeted Notifications

```bash
# Login as admin
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@hostel.com","password":"admin123"}'

# Send notification to all students
curl -X POST http://localhost:3000/api/v1/notifications/send-targeted \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test Announcement",
    "body": "This is a test notification to all students",
    "type": "announcement",
    "priority": "medium",
    "targetType": "all"
  }'
```

### 2. Test Bulk Student Upload

Create a test CSV file (`students.csv`):
```csv
Name,Hall Ticket,College code,Number,Hostel Name
Test Student 1,TEST001,CS,1234567890,Boys Hostel A
Test Student 2,TEST002,CS,1234567891,Boys Hostel A
```

Upload:
```bash
curl -X POST http://localhost:3000/api/v1/students/bulk-upload \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "file=@students.csv"
```

### 3. Test Meal Notifications

```bash
# Trigger morning reminder
curl -X POST http://localhost:3000/api/v1/meals/notifications/trigger \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"type":"morning"}'
```

---

## 🔐 Permission Matrix

| Feature | SUPER_ADMIN | WARDEN_HEAD | WARDEN | STUDENT |
|---------|------------|-------------|--------|---------|
| Create targeted notifications | ✅ | ✅ | ✅ | ❌ |
| Bulk upload students | ✅ | ✅ | ✅ | ❌ |
| Update student data | ✅ | ✅ | ✅ | ❌ |
| Reset student password | ✅ | ✅ | ✅ | ❌ |
| Deactivate student | ✅ | ✅ | ✅ | ❌ |
| Permanently delete student | ✅ | ❌ | ❌ | ❌ |
| Trigger meal notifications | ✅ | ✅ | ✅ | ❌ |

---

## 📱 Frontend Integration Guide

### React Admin Panel

Create notification creation form:

```tsx
// src/components/admin/CreateNotificationForm.tsx
import React, { useState } from 'react';

const CreateNotificationForm = () => {
  const [formData, setFormData] = useState({
    title: '',
    body: '',
    type: 'announcement',
    priority: 'medium',
    targetType: 'all',
  });

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    const response = await fetch('/api/v1/notifications/send-targeted', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formData),
    });
    
    const result = await response.json();
    toast.success(`Notification sent to ${result.targetCount} students`);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <input
        type="text"
        placeholder="Title"
        value={formData.title}
        onChange={(e) => setFormData({...formData, title: e.target.value})}
        className="w-full p-2 border rounded"
      />
      
      <textarea
        placeholder="Message"
        value={formData.body}
        onChange={(e) => setFormData({...formData, body: e.target.value})}
        className="w-full p-2 border rounded"
      />
      
      <select
        value={formData.targetType}
        onChange={(e) => setFormData({...formData, targetType: e.target.value})}
        className="w-full p-2 border rounded"
      >
        <option value="all">All Students</option>
        <option value="hostel">Specific Hostel</option>
        <option value="block">Specific Block</option>
        <option value="floor">Specific Floor</option>
        <option value="room">Specific Room</option>
      </select>
      
      <button type="submit" className="bg-blue-500 text-white px-4 py-2 rounded">
        Send Notification
      </button>
    </form>
  );
};
```

### Bulk Upload Component

```tsx
// src/components/admin/BulkStudentUpload.tsx
import React, { useState } from 'react';

const BulkStudentUpload = () => {
  const [file, setFile] = useState(null);
  const [uploading, setUploading] = useState(false);

  const handleUpload = async () => {
    setUploading(true);
    
    const formData = new FormData();
    formData.append('file', file);
    
    const response = await fetch('/api/v1/students/bulk-upload', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
      },
      body: formData,
    });
    
    const result = await response.json();
    setUploading(false);
    
    toast.success(`${result.created} students created successfully`);
    if (result.errors.length > 0) {
      toast.error(`${result.errors.length} errors occurred`);
    }
  };

  return (
    <div className="p-4">
      <input
        type="file"
        accept=".csv"
        onChange={(e) => setFile(e.target.files[0])}
        className="mb-4"
      />
      
      <button
        onClick={handleUpload}
        disabled={!file || uploading}
        className="bg-green-500 text-white px-4 py-2 rounded disabled:bg-gray-300"
      >
        {uploading ? 'Uploading...' : 'Upload CSV'}
      </button>
    </div>
  );
};
```

---

## 🚀 Deployment Checklist

- [ ] Install missing dependencies (`csv-parser`, `@types/multer`)
- [ ] Verify all modules are imported in `app.module.ts`
- [ ] Test all endpoints with Postman/curl
- [ ] Verify scheduled jobs are running (check logs at 7 AM, 6 PM, 9 AM)
- [ ] Test CSV upload with sample data
- [ ] Verify notification delivery (WebSocket + Database)
- [ ] Update API documentation (Swagger)
- [ ] Add error monitoring for scheduled jobs
- [ ] Configure timezone correctly (`Asia/Kolkata`)
- [ ] Test with real student data

---

## 📊 Monitoring

### Check Scheduled Jobs Status

```bash
# View logs for scheduled meal notifications
docker-compose logs -f api | grep "MealSchedulerService"

# Expected output:
# [MealSchedulerService] Sending morning meal reminder...
# [MealSchedulerService] Successfully sent 150 meal reminders
```

### Database Queries

```sql
-- Check recent targeted notifications
SELECT 
  title, 
  COUNT(*) as recipient_count,
  created_at
FROM notifications
WHERE created_at > NOW() - INTERVAL '1 day'
GROUP BY title, created_at
ORDER BY created_at DESC;

-- Check bulk uploaded students
SELECT 
  COUNT(*) as total_students,
  hostel_id,
  created_at::date as upload_date
FROM students
WHERE created_at > NOW() - INTERVAL '7 days'
GROUP BY hostel_id, created_at::date;
```

---

## ❓ FAQ

**Q: Can I change the scheduled notification times?**
A: Yes, edit the cron expressions in `/src/meals/meal-scheduler.service.ts`:
- `@Cron('0 7 * * *')` - 7:00 AM
- `@Cron('0 18 * * *')` - 6:00 PM
- `@Cron('0 9 * * *')` - 9:00 AM

**Q: What happens if CSV upload fails partially?**
A: The system processes all rows and returns a detailed error report. Successfully created students remain in the database.

**Q: Can students reset their own passwords?**
A: No, only admins/wardens can reset passwords. Students should contact admin.

**Q: Are meal notifications sent even on holidays?**
A: Yes, currently they run every day. You can add holiday logic in the scheduler service.

**Q: How do I customize notification messages?**
A: Edit the message templates in `/src/meals/meal-scheduler.service.ts` methods.

---

## 🐛 Troubleshooting

### Issue: CSV upload fails with "Hostel not found"
**Solution**: Ensure hostel names in CSV exactly match hostel names in the database (case-sensitive).

### Issue: Scheduled notifications not sending
**Solution**: 
1. Check if `@nestjs/schedule` is installed
2. Verify `ScheduleModule.forRoot()` is in `app.module.ts`
3. Check server timezone: `date` in terminal
4. Review logs for errors

### Issue: "Unauthorized" when sending notifications
**Solution**: Ensure user role is `SUPER_ADMIN`, `WARDEN_HEAD`, or `WARDEN`.

---

## 📝 Next Steps

1. **Frontend Integration**: Create admin panels for all new features
2. **Mobile App**: Add UI for viewing meal notifications and targeted announcements
3. **Analytics**: Add dashboard to track notification delivery and open rates
4. **Email Integration**: Send email notifications in addition to push notifications
5. **SMS Integration**: Critical notifications via SMS
6. **Notification Templates**: Pre-defined templates for common announcements

---

**Created by**: AI Assistant  
**Date**: October 27, 2025  
**Version**: 1.0.0
