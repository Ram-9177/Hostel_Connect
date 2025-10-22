# HostelConnect User Guide

## 🎯 Welcome to HostelConnect

HostelConnect is a comprehensive hostel management system designed to streamline operations for students, wardens, chefs, and administrators. This guide will help you navigate the system based on your role.

## 👥 User Roles Overview

### Student
- Request gate passes
- View attendance records
- Manage meal preferences
- Check room assignments
- Read notices and announcements

### Warden
- Approve gate pass requests
- Scan QR codes for entry/exit
- Manage attendance sessions
- Allocate rooms and beds
- Send notices to students

### Chef
- Plan daily menus
- Track meal preparation
- Manage inventory
- View meal feedback
- Handle dietary requests

### Admin
- User management
- System configuration
- Analytics and reports
- Security settings
- Hostel management

## 🔐 Getting Started

### 1. Login Process
1. Open the HostelConnect app
2. Enter your email and password
3. Tap "Login" to access your dashboard
4. The app will automatically route you to your role-specific home page

### 2. Demo Credentials
| Role | Email | Password |
|------|-------|----------|
| Student | student@demo.com | password123 |
| Warden | warden@demo.com | password123 |
| Chef | chef@demo.com | password123 |
| Admin | admin@demo.com | password123 |

## 📱 Student Guide

### Dashboard Overview
Your student dashboard provides quick access to:
- **Attendance Status** - Current attendance percentage
- **Gate Passes** - Number of active passes
- **Meals** - Monthly meal count
- **Room Info** - Your assigned room and bed

### Key Features

#### 1. Gate Pass Requests
**How to Request a Gate Pass:**
1. Tap "Request Gate Pass" on your dashboard
2. Fill in the required details:
   - **Purpose** - Reason for leaving
   - **Destination** - Where you're going
   - **Expected Return** - When you'll be back
   - **Emergency Contact** - Phone number
3. Tap "Submit Request"
4. Wait for warden approval
5. Check status in your dashboard

**Gate Pass Status:**
- **Pending** - Awaiting approval
- **Approved** - Ready to use
- **Rejected** - Request denied
- **Used** - Pass has been scanned

#### 2. Attendance Tracking
**Viewing Attendance:**
1. Tap "View Attendance" on your dashboard
2. See your attendance percentage
3. View daily attendance records
4. Check for any manual adjustments

**Attendance Rules:**
- Minimum 75% attendance required
- Late entries marked as "Late"
- Manual adjustments by warden
- "Adjusted" badge for late recomputations

#### 3. Meal Management
**Managing Meals:**
1. Tap "Meal Management" on your dashboard
2. View daily menu
3. Opt-in/out for meals
4. Set meal preferences
5. View meal history

**Meal Cutoff:**
- Daily cutoff at 20:00 IST
- Changes after cutoff not allowed
- Emergency meals by warden approval

#### 4. Room Information
**Viewing Room Details:**
1. Tap "Room Information" on your dashboard
2. See your assigned room and bed
3. View roommates information
4. Check room facilities
5. Report room issues

#### 5. Notices & Updates
**Reading Notices:**
1. Tap "Notices & Updates" on your dashboard
2. View all notices
3. Mark notices as read
4. Check for urgent announcements
5. View notice history

## 🏠 Warden Guide

### Dashboard Overview
Your warden dashboard provides:
- **Today's Scans** - QR code scans count
- **Active Students** - Currently in hostel
- **Pending Requests** - Gate pass approvals needed
- **Complaints** - Student issues to address

### Key Features

#### 1. Gate Pass Scanner
**Scanning QR Codes:**
1. Tap "Gate Pass Scanner" on your dashboard
2. Point camera at student's QR code
3. App will automatically:
   - Verify the pass
   - Determine IN/OUT direction
   - Log the event
   - Show student details
4. Confirm the scan
5. View scan history

**QR Code Security:**
- 30-second validity window
- HMAC-signed tokens
- Replay protection
- Automatic expiration

#### 2. Attendance Management
**Managing Attendance:**
1. Tap "Attendance Management" on your dashboard
2. Create attendance sessions:
   - **Session Type** - Morning/Evening
   - **Date** - Session date
   - **Mode** - KIOSK/WARDEN/HYBRID
   - **Time Window** - Start and end times
3. Monitor attendance in real-time
4. Make manual adjustments
5. Generate attendance reports

**Attendance Modes:**
- **KIOSK** - Self-service scanning
- **WARDEN** - Manual marking by warden
- **HYBRID** - Combination of both

#### 3. Room Allocation
**Managing Rooms:**
1. Tap "Room Allocation" on your dashboard
2. View room map with color-coded status:
   - **Green** - Available
   - **Red** - Occupied
   - **Yellow** - Maintenance
3. Allocate rooms to students
4. Transfer students between rooms
5. Handle room swap requests
6. Vacate rooms when needed

**Room Operations:**
- **Allot** - Assign room to student
- **Transfer** - Move student to different room
- **Swap** - Exchange rooms between students
- **Vacate** - Free up room

#### 4. Reports & Analytics
**Generating Reports:**
1. Tap "Reports & Analytics" on your dashboard
2. View live dashboard tiles:
   - **Attendance %** - Current attendance rates
   - **Gate Pass Stats** - Entry/exit statistics
   - **Meal Variance** - Meal consumption data
   - **Occupancy %** - Room utilization
3. Generate detailed reports
4. Export data to CSV
5. Schedule automated reports

#### 5. Broadcast Notice
**Sending Notices:**
1. Tap "Broadcast Notice" on your dashboard
2. Create notice:
   - **Title** - Notice subject
   - **Content** - Detailed message
   - **Priority** - Normal/High/Urgent
   - **Target** - All/Student/Warden/Chef
   - **Expiry** - Notice validity period
3. Send push notification
4. Track read receipts
5. View notice statistics

## 👨‍🍳 Chef Guide

### Dashboard Overview
Your chef dashboard shows:
- **Meals Served** - Today's meal count
- **Opt-outs** - Students who opted out
- **Feedback** - Average meal rating
- **Inventory** - Current stock levels

### Key Features

#### 1. Menu Management
**Planning Menus:**
1. Tap "Menu Management" on your dashboard
2. Create daily menu:
   - **Breakfast** - Morning meal items
   - **Lunch** - Afternoon meal items
   - **Dinner** - Evening meal items
3. Set portion sizes
4. Add dietary information
5. Save menu for the day

#### 2. Meal Preparation
**Tracking Preparation:**
1. Tap "Meal Preparation" on your dashboard
2. View meal forecast:
   - **Expected Count** - Based on opt-ins
   - **Buffer** - 5% extra for walk-ins
   - **Overrides** - Manual adjustments
3. Update preparation status
4. Log cooking times
5. Record waste/surplus

#### 3. Inventory Management
**Managing Inventory:**
1. Tap "Inventory Management" on your dashboard
2. Track ingredients:
   - **Current Stock** - Available quantities
   - **Usage Rate** - Consumption patterns
   - **Reorder Points** - When to restock
   - **Supplier Info** - Vendor details
3. Update stock levels
4. Generate purchase orders
5. Track delivery schedules

#### 4. Meal Feedback
**Viewing Feedback:**
1. Tap "Meal Feedback" on your dashboard
2. See student ratings:
   - **Overall Rating** - Average score
   - **Individual Reviews** - Detailed feedback
   - **Trends** - Rating patterns over time
3. Respond to feedback
4. Improve meal quality
5. Track satisfaction trends

#### 5. Dietary Requests
**Handling Special Diets:**
1. Tap "Dietary Requests" on your dashboard
2. View special requirements:
   - **Allergies** - Food allergies
   - **Religious** - Dietary restrictions
   - **Medical** - Health-related needs
   - **Preferences** - Personal choices
3. Plan special meals
4. Track compliance
5. Update meal options

## 👨‍💼 Admin Guide

### Dashboard Overview
Your admin dashboard displays:
- **Total Users** - System user count
- **Active Sessions** - Current logins
- **System Health** - Performance metrics
- **Recent Activity** - System events

### Key Features

#### 1. User Management
**Managing Users:**
1. Tap "User Management" on your dashboard
2. View all users by role:
   - **Students** - Student accounts
   - **Wardens** - Warden accounts
   - **Chefs** - Chef accounts
   - **Admins** - Admin accounts
3. Create new users
4. Edit user details
5. Deactivate accounts
6. Reset passwords

#### 2. System Settings
**Configuring System:**
1. Tap "System Settings" on your dashboard
2. Configure:
   - **Hostel Info** - Basic details
   - **Meal Times** - Service schedules
   - **Attendance Rules** - Policies
   - **Gate Pass Limits** - Restrictions
3. Set system parameters
4. Configure notifications
5. Manage system preferences

#### 3. Reports & Analytics
**System Analytics:**
1. Tap "Reports & Analytics" on your dashboard
2. View comprehensive reports:
   - **User Activity** - Login patterns
   - **System Performance** - Response times
   - **Feature Usage** - Most used features
   - **Error Logs** - System issues
3. Generate custom reports
4. Export data
5. Schedule automated reports

#### 4. Hostel Management
**Managing Hostel:**
1. Tap "Hostel Management" on your dashboard
2. Configure hostel structure:
   - **Blocks** - Building sections
   - **Floors** - Floor levels
   - **Rooms** - Room details
   - **Beds** - Bed assignments
3. Import/export room data
4. Manage hostel capacity
5. Update room status

#### 5. Security & Access
**Security Management:**
1. Tap "Security & Access" on your dashboard
2. Monitor security:
   - **Login Attempts** - Failed logins
   - **Access Logs** - User activities
   - **Permission Changes** - Role updates
   - **System Alerts** - Security events
3. Configure access controls
4. Set security policies
5. Monitor compliance

## 🔧 Troubleshooting

### Common Issues

#### 1. Login Problems
**Issue:** Cannot log in
**Solutions:**
- Check email and password
- Ensure internet connection
- Try demo credentials
- Contact admin for account issues

#### 2. QR Code Scanning
**Issue:** QR code not scanning
**Solutions:**
- Ensure good lighting
- Hold phone steady
- Check QR code validity (30 seconds)
- Try refreshing the pass

#### 3. Attendance Issues
**Issue:** Attendance not recorded
**Solutions:**
- Check session timing
- Verify QR code validity
- Contact warden for manual entry
- Check internet connection

#### 4. Meal Problems
**Issue:** Meal not available
**Solutions:**
- Check meal cutoff time (20:00 IST)
- Verify meal opt-in status
- Contact chef for special requests
- Check meal schedule

#### 5. Room Issues
**Issue:** Room assignment problems
**Solutions:**
- Check room availability
- Contact warden for allocation
- Verify room status
- Check for maintenance issues

## 📞 Support

### Getting Help
- **Email:** support@hostelconnect.com
- **Phone:** +1-800-HOSTEL-1
- **In-App:** Use the help button
- **Documentation:** Check this guide

### Reporting Issues
1. Use the in-app feedback form
2. Email support with details
3. Include screenshots if possible
4. Describe steps to reproduce

### Feature Requests
1. Submit via feedback form
2. Email product team
3. Include use case details
4. Suggest improvements

## 🎯 Best Practices

### For Students
- Check notices regularly
- Request gate passes early
- Maintain good attendance
- Report issues promptly
- Use meal opt-in wisely

### For Wardens
- Scan QR codes promptly
- Monitor attendance closely
- Respond to requests quickly
- Keep records updated
- Communicate clearly

### For Chefs
- Plan menus in advance
- Track inventory regularly
- Monitor meal feedback
- Handle special requests
- Maintain food quality

### For Admins
- Monitor system health
- Review reports regularly
- Update user permissions
- Maintain security standards
- Plan system improvements

## 🔄 Updates & Maintenance

### System Updates
- Updates are automatic
- No action required
- New features announced
- Bug fixes included
- Performance improvements

### Maintenance Windows
- Scheduled maintenance
- Advance notice provided
- Minimal downtime
- System notifications
- Status updates

---

**This user guide provides comprehensive instructions for using HostelConnect effectively. For additional support, contact our help desk.**
