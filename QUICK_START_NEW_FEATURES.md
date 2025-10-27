# 🚀 Quick Start - New Features

## What's Been Added?

✅ **Targeted Notifications** - Send to all, hostel, block, floor, room, or individual students  
✅ **Bulk Student Upload** - CSV upload with auto-account creation  
✅ **Student Management** - Update, reset password, deactivate, delete  
✅ **Automated Meal Notifications** - Daily reminders at 7 AM, 6 PM, 9 AM

---

## ⚡ Fast Setup (5 Minutes)

### 1. Install Dependencies

```bash
cd hostelconnect/api
npm install csv-parser @types/multer
```

### 2. Start the Backend

```bash
npm run start:dev
```

### 3. Test an Endpoint

**Send notification to all students:**

```bash
# Login first (replace with your admin credentials)
TOKEN=$(curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@hostel.com","password":"admin123"}' \
  | jq -r '.token')

# Send notification
curl -X POST http://localhost:3000/api/v1/notifications/send-targeted \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Welcome to New Features!",
    "body": "Testing the new targeted notification system",
    "type": "announcement",
    "priority": "medium",
    "targetType": "all"
  }'
```

---

## 📋 Quick Test Scenarios

### Scenario 1: Bulk Upload Students

**Create test CSV** (`students.csv`):
```csv
Name,Hall Ticket,College code,Number,Hostel Name
John Doe,TEST001,CS,9876543210,Boys Hostel A
Jane Smith,TEST002,EC,9876543211,Girls Hostel B
```

**Upload:**
```bash
curl -X POST http://localhost:3000/api/v1/students/bulk-upload \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@students.csv"
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Bulk upload completed. Created: 2, Errors: 0",
  "created": 2,
  "errors": []
}
```

---

### Scenario 2: Send Notification to Specific Floor

```bash
curl -X POST http://localhost:3000/api/v1/notifications/send-targeted \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Floor 2 Meeting",
    "body": "All Floor 2 students, please attend the meeting at 5 PM",
    "type": "notice",
    "priority": "high",
    "targetType": "floor",
    "hostelId": "YOUR_HOSTEL_ID",
    "blockId": "YOUR_BLOCK_ID",
    "floor": 2
  }'
```

---

### Scenario 3: Reset Student Password

```bash
curl -X POST http://localhost:3000/api/v1/students/reset-password \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "studentId": "STUDENT_UUID"
  }'
```

**Response:**
```json
{
  "success": true,
  "newPassword": "TEST001"
}
```

---

### Scenario 4: Trigger Morning Meal Reminder (Manual Test)

```bash
curl -X POST http://localhost:3000/api/v1/meals/notifications/trigger \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"type": "morning"}'
```

---

## 🕐 Scheduled Jobs

The following notifications run automatically:

| Time | Type | Message |
|------|------|---------|
| 7:00 AM | Morning Reminder | "Good morning! Don't forget to submit your meal preferences..." |
| 6:00 PM | Cutoff Warning | "Only 2 hours left! Submit your meal preferences..." |
| 9:00 AM | Menu Announcement | "Check out today's meal menu..." |

**Verify logs:**
```bash
# Watch for scheduled notifications
docker-compose logs -f api | grep "MealSchedulerService"
```

---

## 🎨 Frontend Integration

### Add to Admin Dashboard

```tsx
import CreateNotificationForm from './components/admin/CreateNotificationForm';
import BulkStudentUpload from './components/admin/BulkStudentUpload';

// In your admin page:
<CreateNotificationForm token={authToken} />
<BulkStudentUpload token={authToken} onUploadComplete={() => refresh()} />
```

---

## 📊 API Endpoints Summary

| Endpoint | Method | Permission | Purpose |
|----------|--------|------------|---------|
| `/notifications/send-targeted` | POST | Admin/Warden | Send targeted notification |
| `/students/bulk-upload` | POST | Admin/Warden | Upload CSV of students |
| `/students/manage/:id` | PUT | Admin/Warden | Update student data |
| `/students/reset-password` | POST | Admin/Warden | Reset student password |
| `/students/manage/:id/deactivate` | DELETE | Admin/Warden | Deactivate student |
| `/students/manage/:id/permanent` | DELETE | Super Admin | Permanently delete |
| `/meals/notifications/trigger` | POST | Admin/Warden | Trigger meal notification |

---

## 🔍 Troubleshooting

### Issue: "Hostel not found" error during CSV upload
**Fix:** Ensure hostel names in CSV exactly match database (case-sensitive).

### Issue: Scheduled notifications not running
**Fix:** 
```bash
# Check if schedule module is loaded
npm list @nestjs/schedule

# If missing:
npm install @nestjs/schedule
```

### Issue: "Unauthorized" when testing
**Fix:** Ensure you're logged in as SUPER_ADMIN, WARDEN_HEAD, or WARDEN.

---

## 📖 Full Documentation

For detailed documentation, see:
- **NEW_FEATURES_GUIDE.md** - Complete API reference
- **IMPLEMENTATION_SUMMARY.md** - Technical details

---

## ✅ Checklist

- [ ] Dependencies installed (`csv-parser`, `@types/multer`)
- [ ] Backend running (`npm run start:dev`)
- [ ] Tested targeted notification endpoint
- [ ] Tested CSV upload
- [ ] Verified scheduled jobs (check logs at 7 AM, 6 PM, 9 AM)
- [ ] Integrated frontend components
- [ ] Updated mobile app (optional)

---

**Ready to use!** 🎉

**Questions?** Check the full documentation in **NEW_FEATURES_GUIDE.md**
