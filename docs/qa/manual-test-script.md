# HostelConnect Manual Test Script

## 🎯 Testing Overview
This script provides step-by-step instructions for manually testing all HostelConnect features.

**Demo Accounts:**
- Student: `student@demo.com` / `password123`
- Warden: `warden@demo.com` / `password123`
- Warden Head: `head@demo.com` / `password123`
- Super Admin: `admin@demo.com` / `password123`
- Chef: `chef@demo.com` / `password123`

---

## 📱 Student Testing (student@demo.com)

### 1. Login & Home
1. **Open App** → Should show login screen
2. **Enter Credentials:**
   - Email: `student@demo.com`
   - Password: `password123`
3. **Tap Login** → Should navigate to Student Dashboard
4. **Verify:** Welcome message shows "Welcome, John!"
5. **Verify:** Role shows "STUDENT"
6. **Verify:** Quick stats show attendance, gate passes, meals

### 2. Gate Pass Request
1. **Tap "Request Gate Pass"** card
2. **Fill Form:**
   - Reason: "Medical appointment"
   - Departure: Tomorrow 10:00 AM
   - Return: Tomorrow 2:00 PM
3. **Tap Submit** → Should show success message
4. **Note:** Switch to Warden account to approve

### 3. Meals Management
1. **Tap "Meal Management"** card
2. **Set Preferences:**
   - Breakfast: Yes
   - Lunch: Yes
   - Dinner: No
3. **Tap Save** → Should show confirmation
4. **Verify:** Preferences saved successfully

### 4. Notices & Updates
1. **Tap "Notices & Updates"** card
2. **View Notice:** Tap on any notice
3. **Verify:** Notice opens with full content
4. **Tap Back** → Should return to notices list
5. **Verify:** Notice shows as read

### 5. Profile & Room Info
1. **Tap "Profile"** card
2. **Verify:** Shows "My Room/Bed" section
3. **Tap "My Room/Bed"** → Should show room details
4. **Verify:** Room 101, Bed 1 displayed
5. **Tap Back** → Should return to profile

---

## 👮 Warden Testing (warden@demo.com)

### 1. Login & Dashboard
1. **Logout** from Student account
2. **Login with Warden:**
   - Email: `warden@demo.com`
   - Password: `password123`
3. **Verify:** Warden Dashboard loads
4. **Verify:** Today's Overview shows scans, students, complaints

### 2. Gate Pass Approvals
1. **Tap "Gate Pass Approvals"** card
2. **View Pending:** Should see student's gate pass request
3. **Tap Approve** → Should show approval dialog
4. **Add Remarks:** "Approved for medical appointment"
5. **Tap Confirm** → Should show success
6. **Verify:** Gate pass status changes to "Approved"

### 3. Attendance Management
1. **Tap "Attendance Management"** card
2. **Create Session:**
   - Mode: KIOSK
   - Session Name: "Evening Attendance"
3. **Tap Start Session** → Should show scanner
4. **Test Scanner:** Point camera at QR code (if available)
5. **Manual Mark:** Tap "Manual Mark" for a student
6. **Add Reason:** "Late entry - traffic"
7. **Tap Save** → Should show confirmation
8. **Tap Close Session** → Should show summary

### 4. Room Allocation
1. **Tap "Room Allocation"** card
2. **View Rooms Map:** Should show room layout
3. **Allot Bed:** Tap on empty bed
4. **Select Student:** Choose from list
5. **Tap Allot** → Should show confirmation
6. **Test Transfer:** Move student to different bed
7. **Test Swap:** Swap two students' beds
8. **Test Vacate:** Remove student from bed

---

## 🎖️ Warden Head Testing (head@demo.com)

### 1. Login & Dashboard
1. **Logout** from Warden account
2. **Login with Head:**
   - Email: `head@demo.com`
   - Password: `password123`
3. **Verify:** Head Dashboard loads with live tiles
4. **Verify:** Shows "Updated HH:MM IST" timestamps

### 2. Policy Management
1. **Tap "Policy Management"** card
2. **Edit Meal Policy:**
   - Buffer %: Change to 5%
   - Cutoff Time: 20:00 IST
3. **Tap Save** → Should show confirmation
4. **Verify:** Policy updated successfully

### 3. Meal Overrides
1. **Tap "Meal Overrides"** card
2. **Add Override:**
   - Meal: Dinner
   - Adjustment: +5 portions
   - Reason: "Guest students"
3. **Tap Save** → Should show confirmation
4. **Verify:** Override appears in list

### 4. Broadcast Notice
1. **Tap "Broadcast Notice"** card
2. **Create Notice:**
   - Title: "Important Announcement"
   - Content: "Hostel meeting tomorrow at 6 PM"
   - Audience: All Students
3. **Tap Send** → Should show confirmation
4. **Verify:** Notice sent successfully

---

## 👑 Super Admin Testing (admin@demo.com)

### 1. Login & Dashboard
1. **Logout** from Head account
2. **Login with Admin:**
   - Email: `admin@demo.com`
   - Password: `password123`
3. **Verify:** Admin Dashboard loads
4. **Verify:** System Overview shows users, sessions, health

### 2. Organization Dashboard
1. **Tap "Organization Dashboard"** card
2. **View Monthly Analytics:** Should show charts
3. **Drill Down:** Tap on attendance chart
4. **Verify:** Detailed view opens
5. **Tap Back** → Should return to main dashboard

### 3. User Management
1. **Tap "User Management"** card
2. **View Users List:** Should show all users
3. **Search:** Try searching for "student"
4. **Verify:** Filtered results appear
5. **Tap Back** → Should return to dashboard

### 4. Hostel Structure
1. **Tap "Hostel Structure"** card
2. **Verify Blocks:** Should show Block A and Block B
3. **Expand Block A:** Should show 4 floors
4. **Expand Floor 1:** Should show 10 rooms
5. **Expand Room 101:** Should show 3 beds
6. **Verify:** All structure data is correct

---

## 👨‍🍳 Chef Testing (chef@demo.com)

### 1. Login & Dashboard
1. **Logout** from Admin account
2. **Login with Chef:**
   - Email: `chef@demo.com`
   - Password: `password123`
3. **Verify:** Chef Dashboard loads
4. **Verify:** Kitchen Overview shows meals served, opt-outs, feedback

### 2. Meal Forecast Board
1. **Tap "Meal Forecast Board"** card
2. **View Forecast:** Should show today's meal predictions
3. **Verify:** Shows YES + 5% buffer + overrides
4. **Export CSV:** Tap export button
5. **Verify:** CSV download starts

### 3. Menu Management
1. **Tap "Menu Management"** card
2. **View Today's Menu:** Should show planned meals
3. **Edit Menu:** Make changes to any meal
4. **Tap Save** → Should show confirmation
5. **Verify:** Menu updated successfully

---

## 🔍 Cross-Feature Testing

### 1. Session Persistence
1. **Login** with any account
2. **Minimize App** (home button)
3. **Reopen App** → Should stay logged in
4. **Verify:** No re-login required

### 2. Role-Based Access
1. **Login as Student**
2. **Try accessing Admin features** → Should show access denied
3. **Verify:** Telugu/English error message appears
4. **Tap Back** → Should return to student home

### 3. Navigation Testing
1. **From any non-root page, tap Back**
2. **Verify:** Returns to previous page
3. **Test Quick Access cards** → Should navigate correctly
4. **Test deep linking** → Should work properly

### 4. Error Handling
1. **Turn off WiFi** (simulate network error)
2. **Try any API action** → Should show friendly error
3. **Turn WiFi back on**
4. **Retry action** → Should work normally

---

## ✅ Success Criteria

### Must Pass:
- [ ] All logins work with demo accounts
- [ ] Role-based dashboards load correctly
- [ ] Quick Access cards navigate properly
- [ ] Back buttons work on all non-root pages
- [ ] Gate pass request → approval → QR → scan flow works
- [ ] Attendance sessions can be created and managed
- [ ] Room allocation functions work
- [ ] Notices can be created and read
- [ ] Session persistence works (no re-login)
- [ ] Error handling shows friendly messages

### Expected Behavior:
- Smooth animations and transitions
- Consistent Material Design 3 UI
- Telugu highlights on key elements
- English text elsewhere
- Live data updates (where applicable)
- Proper loading states
- Success/error feedback

---

## 🐛 Known Issues & Workarounds

1. **QR Scanner:** May need physical QR codes for testing
2. **Photo Upload:** Camera permissions may need manual approval
3. **Push Notifications:** May not work in emulator environment
4. **Network Issues:** Use `adb reverse tcp:3000 tcp:3000` if needed

---

## 📸 Screenshots to Capture

- `login-screen.png` - Login page
- `student-home.png` - Student dashboard
- `warden-dashboard.png` - Warden dashboard
- `gate-pass-request.png` - Gate pass form
- `attendance-scanner.png` - Attendance scanner
- `rooms-map.png` - Room allocation map
- `admin-dashboard.png` - Admin dashboard
- `chef-forecast.png` - Chef forecast board

---

**Total Testing Time:** ~30 minutes  
**Status:** Ready for client testing
