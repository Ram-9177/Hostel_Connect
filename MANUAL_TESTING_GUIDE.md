# 🧪 HostelConnect Manual Testing Guide

## 🚀 Current System Status

### ✅ What's Running:
- **Android App**: Running on Pixel 7 emulator (Android 14)
- **Docker Services**: PostgreSQL and Redis containers running
- **Backend API**: NestJS process running (may need configuration)

### 📱 Android App Testing

#### 1. **Login & Authentication**
- Open the HostelConnect app on the Android emulator
- Test login with different user roles:
  - Student login
  - Admin login
  - Warden login
- Test password reset functionality
- Test biometric authentication (if available)

#### 2. **Dashboard & Navigation**
- Navigate through different screens:
  - Home Dashboard
  - Profile Management
  - Settings
  - Notifications
- Test responsive design on different screen orientations
- Test navigation between different user roles

#### 3. **Core Features Testing**

##### **Gate Pass Management**
- Create a new gate pass request
- Test different gate pass types (OUTING, EMERGENCY, etc.)
- Test approval workflow
- Test QR code generation and scanning
- Test real-time status updates

##### **Attendance System**
- Test QR code scanning for attendance
- Test manual attendance entry
- Test attendance reports and analytics
- Test different attendance modes (KIOSK, MOBILE)

##### **Meal Management**
- Test meal intent submission
- Test meal forecasting
- Test meal override functionality
- Test meal analytics

##### **Room Management**
- Test room allocation
- Test room transfer requests
- Test room occupancy tracking
- Test room maintenance requests

##### **Notifications**
- Test push notifications
- Test in-app notifications
- Test real-time updates via WebSocket
- Test notification preferences

### 🔧 Backend API Testing

#### **API Endpoints to Test:**

##### **Authentication**
```bash
# Test login
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"student@example.com","password":"password123"}'

# Test registration
curl -X POST http://localhost:3000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"newuser@example.com","password":"password123","role":"STUDENT"}'
```

##### **Gate Pass Management**
```bash
# Create gate pass
curl -X POST http://localhost:3000/api/v1/gate-pass \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "studentId":"student-123",
    "hostelId":"hostel-1",
    "type":"OUTING",
    "startTime":"2024-01-15T10:00:00Z",
    "endTime":"2024-01-15T18:00:00Z",
    "reason":"Shopping"
  }'

# Get gate passes
curl -X GET http://localhost:3000/api/v1/gate-pass \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

##### **Attendance System**
```bash
# Create attendance session
curl -X POST http://localhost:3000/api/v1/attendance/sessions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "hostelId":"hostel-1",
    "mode":"KIOSK",
    "startTime":"2024-01-15T20:00:00Z",
    "endTime":"2024-01-15T22:00:00Z",
    "wingIds":["wing-1"]
  }'

# Mark attendance
curl -X POST http://localhost:3000/api/v1/attendance/check \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "sessionId":"session-123",
    "studentId":"student-123",
    "status":"PRESENT"
  }'
```

##### **Meal Management**
```bash
# Submit meal intent
curl -X POST http://localhost:3000/api/v1/meals/intents \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "date":"2024-01-16",
    "mealType":"BREAKFAST",
    "intent":"YES"
  }'

# Get meal analytics
curl -X GET http://localhost:3000/api/v1/meals/analytics \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

##### **Dashboard & Analytics**
```bash
# Get live hostel dashboard
curl -X GET "http://localhost:3000/api/v1/dash/hostel-live?hostelId=hostel-1" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Get analytics
curl -X GET http://localhost:3000/api/v1/analytics/overview \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### 🐳 Docker Services Testing

#### **Database Testing**
```bash
# Connect to PostgreSQL
docker exec -it hostelconnect-postgres psql -U hostelconnect -d hostelconnect

# Test Redis
docker exec -it hostelconnect-redis redis-cli ping
```

#### **Service Health Checks**
```bash
# Check container status
docker ps

# Check logs
docker logs hostelconnect-postgres
docker logs hostelconnect-redis
```

### 📊 Testing Scenarios

#### **Scenario 1: Complete Student Workflow**
1. Student logs into the app
2. Views dashboard and notifications
3. Creates a gate pass request
4. Waits for approval
5. Scans QR code at gate
6. Returns and marks attendance
7. Submits meal intent

#### **Scenario 2: Admin Management**
1. Admin logs in
2. Reviews pending gate pass requests
3. Approves/rejects requests
4. Views attendance reports
5. Manages room allocations
6. Sends notifications to students

#### **Scenario 3: Real-time Features**
1. Test WebSocket connections
2. Verify real-time notifications
3. Test live dashboard updates
4. Test collaborative features

### 🔍 Testing Tools

#### **API Testing Tools**
- **Postman**: Import API collection for comprehensive testing
- **curl**: Command-line testing (examples above)
- **Swagger UI**: Available at `http://localhost:3000/api`

#### **Mobile Testing Tools**
- **Android Studio**: Device emulator and debugging
- **Flutter Inspector**: Widget inspection and debugging
- **Firebase Console**: Push notification testing

### 📝 Test Data

#### **Sample Users**
```json
{
  "students": [
    {"email": "student1@hostel.com", "password": "password123", "role": "STUDENT"},
    {"email": "student2@hostel.com", "password": "password123", "role": "STUDENT"}
  ],
  "admins": [
    {"email": "admin@hostel.com", "password": "admin123", "role": "ADMIN"},
    {"email": "warden@hostel.com", "password": "warden123", "role": "WARDEN"}
  ]
}
```

#### **Sample Hostel Data**
```json
{
  "hostels": [
    {"id": "hostel-1", "name": "Boys Hostel A", "capacity": 200},
    {"id": "hostel-2", "name": "Girls Hostel B", "capacity": 150}
  ],
  "rooms": [
    {"id": "room-101", "hostelId": "hostel-1", "capacity": 2, "type": "DOUBLE"},
    {"id": "room-102", "hostelId": "hostel-1", "capacity": 2, "type": "DOUBLE"}
  ]
}
```

### 🚨 Common Issues & Solutions

#### **API Not Responding**
1. Check if NestJS process is running: `ps aux | grep nest`
2. Verify database connection
3. Check port conflicts: `lsof -i :3000`
4. Review API logs for errors

#### **Android App Issues**
1. Check emulator status
2. Verify Flutter dependencies
3. Test on physical device if emulator fails
4. Check network connectivity

#### **Database Issues**
1. Verify Docker containers are running
2. Check database migrations
3. Verify connection strings
4. Test database connectivity

### 📈 Performance Testing

#### **Load Testing**
- Test API endpoints with multiple concurrent requests
- Test mobile app performance with large datasets
- Test real-time features under load

#### **Stress Testing**
- Test system behavior under high user load
- Test database performance with large datasets
- Test WebSocket connections under stress

### ✅ Testing Checklist

- [ ] Android app launches successfully
- [ ] User authentication works
- [ ] All major features are accessible
- [ ] API endpoints respond correctly
- [ ] Database operations work
- [ ] Real-time features function
- [ ] Push notifications work
- [ ] QR code scanning works
- [ ] File uploads work
- [ ] Error handling is proper
- [ ] Performance is acceptable
- [ ] Security measures are in place

### 🎯 Next Steps

1. **Start with basic functionality**: Login, navigation, core features
2. **Test edge cases**: Invalid inputs, network failures, etc.
3. **Test integration**: Mobile app ↔ API ↔ Database
4. **Test real-time features**: WebSockets, notifications
5. **Test performance**: Load testing, stress testing
6. **Document issues**: Keep track of bugs and improvements

---

## 🚀 Quick Start Commands

```bash
# Start Android app
cd mobile && flutter run

# Start API (if not running)
cd api && npm run start:dev

# Test API
curl http://localhost:3000/api/v1/

# Check Docker services
docker ps

# View API documentation
open http://localhost:3000/api
```

Happy Testing! 🎉
