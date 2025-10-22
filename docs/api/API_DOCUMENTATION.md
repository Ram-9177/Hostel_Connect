# HostelConnect API Documentation

## 🚀 Overview

The HostelConnect API is a RESTful service built with NestJS that provides comprehensive hostel management functionality. This documentation covers all endpoints, authentication, and integration details.

## 🔗 Base URL

- **Development:** `http://localhost:3000/api/v1`
- **Staging:** `https://hostelconnect-staging.azurewebsites.net/api/v1`
- **Production:** `https://hostelconnect-api.azurewebsites.net/api/v1`

## 🔐 Authentication

### JWT Token Authentication
All API endpoints require authentication using JWT tokens.

#### Login Request
```http
POST /auth/login
Content-Type: application/json

{
  "email": "student@demo.com",
  "password": "password123"
}
```

#### Login Response
```json
{
  "success": true,
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user_123",
    "email": "student@demo.com",
    "role": "student",
    "hostelId": "hostel_001",
    "firstName": "John",
    "lastName": "Doe",
    "phone": "+1234567890",
    "isActive": true,
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-01-01T00:00:00Z",
    "roomId": "room_001",
    "bedNumber": "A1"
  }
}
```

#### Using Tokens
Include the access token in the Authorization header:
```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

#### Token Refresh
```http
POST /auth/refresh
Content-Type: application/json

{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

## 👥 User Management

### Get User Profile
```http
GET /users/profile
Authorization: Bearer <token>
```

**Response:**
```json
{
  "id": "user_123",
  "email": "student@demo.com",
  "role": "student",
  "hostelId": "hostel_001",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "+1234567890",
  "isActive": true,
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z",
  "roomId": "room_001",
  "bedNumber": "A1"
}
```

### Update User Profile
```http
PUT /users/profile
Authorization: Bearer <token>
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe",
  "phone": "+1234567890"
}
```

### Get All Users (Admin Only)
```http
GET /users
Authorization: Bearer <token>
```

**Query Parameters:**
- `role` - Filter by role (student, warden, chef, admin)
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 20)

## 🚪 Gate Pass Management

### Request Gate Pass
```http
POST /gate-pass/request
Authorization: Bearer <token>
Content-Type: application/json

{
  "purpose": "Medical appointment",
  "destination": "City Hospital",
  "expectedReturn": "2024-01-01T18:00:00Z",
  "emergencyContact": "+1234567890",
  "notes": "Regular checkup"
}
```

**Response:**
```json
{
  "id": "pass_123",
  "studentId": "user_123",
  "purpose": "Medical appointment",
  "destination": "City Hospital",
  "expectedReturn": "2024-01-01T18:00:00Z",
  "emergencyContact": "+1234567890",
  "status": "pending",
  "requestedAt": "2024-01-01T10:00:00Z",
  "approvedAt": null,
  "approvedBy": null,
  "qrCode": null
}
```

### Get Gate Passes
```http
GET /gate-pass
Authorization: Bearer <token>
```

**Query Parameters:**
- `status` - Filter by status (pending, approved, rejected, used)
- `page` - Page number
- `limit` - Items per page

### Approve Gate Pass (Warden Only)
```http
PUT /gate-pass/{passId}/approve
Authorization: Bearer <token>
Content-Type: application/json

{
  "approved": true,
  "notes": "Approved for medical appointment"
}
```

### Generate QR Code
```http
POST /gate-pass/{passId}/qr
Authorization: Bearer <token>
```

**Response:**
```json
{
  "qrCode": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...",
  "expiresAt": "2024-01-01T10:00:30Z"
}
```

### Scan QR Code
```http
POST /gate-pass/scan
Authorization: Bearer <token>
Content-Type: application/json

{
  "qrToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "scannerId": "scanner_001"
}
```

**Response:**
```json
{
  "valid": true,
  "direction": "OUT",
  "student": {
    "id": "user_123",
    "name": "John Doe",
    "room": "Room 101",
    "bed": "A1"
  },
  "pass": {
    "id": "pass_123",
    "purpose": "Medical appointment",
    "expectedReturn": "2024-01-01T18:00:00Z"
  },
  "warnings": []
}
```

## 📊 Attendance Management

### Create Attendance Session
```http
POST /attendance/sessions
Authorization: Bearer <token>
Content-Type: application/json

{
  "session": "morning",
  "date": "2024-01-01",
  "mode": "KIOSK",
  "startTime": "08:00",
  "endTime": "09:00"
}
```

**Response:**
```json
{
  "id": "session_123",
  "session": "morning",
  "date": "2024-01-01",
  "mode": "KIOSK",
  "startTime": "08:00",
  "endTime": "09:00",
  "status": "active",
  "createdAt": "2024-01-01T07:30:00Z"
}
```

### Mark Attendance
```http
POST /attendance/mark
Authorization: Bearer <token>
Content-Type: application/json

{
  "sessionId": "session_123",
  "studentId": "user_123",
  "status": "present",
  "reason": "On time",
  "photo": "data:image/jpeg;base64,..."
}
```

### Get Attendance Records
```http
GET /attendance/records
Authorization: Bearer <token>
```

**Query Parameters:**
- `studentId` - Filter by student
- `date` - Filter by date
- `session` - Filter by session (morning, evening)
- `page` - Page number
- `limit` - Items per page

### Adjust Attendance
```http
PUT /attendance/{recordId}/adjust
Authorization: Bearer <token>
Content-Type: application/json

{
  "status": "present",
  "reason": "Late entry approved",
  "adjustedBy": "warden_001"
}
```

## 🍽️ Meal Management

### Get Daily Menu
```http
GET /meals/menu
Authorization: Bearer <token>
```

**Query Parameters:**
- `date` - Menu date (default: today)

**Response:**
```json
{
  "date": "2024-01-01",
  "breakfast": {
    "items": ["Idli", "Sambar", "Chutney"],
    "time": "07:00-09:00"
  },
  "lunch": {
    "items": ["Rice", "Dal", "Vegetables", "Curd"],
    "time": "12:00-14:00"
  },
  "dinner": {
    "items": ["Roti", "Dal", "Vegetables"],
    "time": "19:00-21:00"
  }
}
```

### Opt-in/Out for Meals
```http
POST /meals/opt-in
Authorization: Bearer <token>
Content-Type: application/json

{
  "date": "2024-01-01",
  "breakfast": true,
  "lunch": true,
  "dinner": false
}
```

### Get Meal Forecast
```http
GET /meals/forecast
Authorization: Bearer <token>
```

**Query Parameters:**
- `date` - Forecast date (default: today)

**Response:**
```json
{
  "date": "2024-01-01",
  "breakfast": {
    "expected": 150,
    "buffer": 8,
    "total": 158
  },
  "lunch": {
    "expected": 180,
    "buffer": 9,
    "total": 189
  },
  "dinner": {
    "expected": 120,
    "buffer": 6,
    "total": 126
  }
}
```

### Submit Meal Feedback
```http
POST /meals/feedback
Authorization: Bearer <token>
Content-Type: application/json

{
  "mealId": "meal_123",
  "rating": 4,
  "comments": "Good taste, could be spicier",
  "suggestions": "Add more vegetables"
}
```

## 🏠 Room Management

### Get Room Information
```http
GET /rooms/info
Authorization: Bearer <token>
```

**Response:**
```json
{
  "roomId": "room_001",
  "roomNumber": "101",
  "block": "A",
  "floor": 1,
  "capacity": 4,
  "occupancy": 3,
  "beds": [
    {
      "id": "bed_001",
      "number": "A1",
      "status": "occupied",
      "studentId": "user_123"
    },
    {
      "id": "bed_002",
      "number": "A2",
      "status": "available",
      "studentId": null
    }
  ]
}
```

### Allocate Room
```http
POST /rooms/allocate
Authorization: Bearer <token>
Content-Type: application/json

{
  "studentId": "user_123",
  "roomId": "room_001",
  "bedNumber": "A2"
}
```

### Transfer Room
```http
POST /rooms/transfer
Authorization: Bearer <token>
Content-Type: application/json

{
  "studentId": "user_123",
  "fromRoomId": "room_001",
  "toRoomId": "room_002",
  "reason": "Student request"
}
```

### Get Room Map
```http
GET /rooms/map
Authorization: Bearer <token>
```

**Response:**
```json
{
  "blocks": [
    {
      "id": "block_a",
      "name": "Block A",
      "floors": [
        {
          "id": "floor_1",
          "number": 1,
          "rooms": [
            {
              "id": "room_001",
              "number": "101",
              "status": "occupied",
              "occupancy": 3,
              "capacity": 4
            }
          ]
        }
      ]
    }
  ]
}
```

## 📢 Notice Management

### Create Notice
```http
POST /notices
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "Hostel Maintenance",
  "content": "Water supply will be interrupted from 2-4 PM",
  "priority": "high",
  "target": "all",
  "expiresAt": "2024-01-02T00:00:00Z"
}
```

### Get Notices
```http
GET /notices
Authorization: Bearer <token>
```

**Query Parameters:**
- `priority` - Filter by priority (low, normal, high, urgent)
- `target` - Filter by target audience
- `page` - Page number
- `limit` - Items per page

### Mark Notice as Read
```http
PUT /notices/{noticeId}/read
Authorization: Bearer <token>
```

### Get Notice Statistics
```http
GET /notices/{noticeId}/stats
Authorization: Bearer <token>
```

**Response:**
```json
{
  "totalSent": 200,
  "delivered": 195,
  "read": 180,
  "readRate": 0.9,
  "deliveryRate": 0.975
}
```

## 📊 Reports & Analytics

### Get Dashboard Data
```http
GET /reports/dashboard
Authorization: Bearer <token>
```

**Response:**
```json
{
  "attendance": {
    "percentage": 85.5,
    "totalStudents": 200,
    "presentToday": 171
  },
  "gatePasses": {
    "pending": 5,
    "approved": 12,
    "used": 8
  },
  "meals": {
    "served": 450,
    "optOuts": 25,
    "feedback": 4.2
  },
  "rooms": {
    "total": 50,
    "occupied": 45,
    "available": 5,
    "occupancyRate": 0.9
  }
}
```

### Generate Report
```http
POST /reports/generate
Authorization: Bearer <token>
Content-Type: application/json

{
  "type": "attendance",
  "startDate": "2024-01-01",
  "endDate": "2024-01-31",
  "format": "pdf"
}
```

### Get Report
```http
GET /reports/{reportId}
Authorization: Bearer <token>
```

## 🔔 Push Notifications

### Register Device Token
```http
POST /notifications/register
Authorization: Bearer <token>
Content-Type: application/json

{
  "deviceToken": "fcm_token_here",
  "platform": "android"
}
```

### Send Push Notification
```http
POST /notifications/send
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "New Notice",
  "body": "Check the latest hostel announcement",
  "target": "all",
  "data": {
    "noticeId": "notice_123"
  }
}
```

## 🚨 Error Handling

### Error Response Format
```json
{
  "error": "VALIDATION_ERROR",
  "message": "Invalid input data",
  "details": {
    "field": "email",
    "reason": "Invalid email format"
  },
  "timestamp": "2024-01-01T10:00:00Z"
}
```

### Common Error Codes
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Validation Error
- `500` - Internal Server Error

### Rate Limiting
- **Rate Limit:** 100 requests per minute per IP
- **Headers:** `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`

## 🔧 Development

### Local Development
```bash
# Install dependencies
npm install

# Start development server
npm run start:dev

# Run tests
npm test

# Build for production
npm run build
```

### Environment Variables
```env
NODE_ENV=development
PORT=3000
DATABASE_URL=sqlite:./database.sqlite
REDIS_URL=redis://localhost:6379
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=24h
```

### Testing
```bash
# Run unit tests
npm run test

# Run integration tests
npm run test:e2e

# Run tests with coverage
npm run test:cov
```

## 📚 SDK Examples

### JavaScript/TypeScript
```typescript
import axios from 'axios';

const api = axios.create({
  baseURL: 'https://hostelconnect-api.azurewebsites.net/api/v1',
  headers: {
    'Content-Type': 'application/json'
  }
});

// Login
const login = async (email: string, password: string) => {
  const response = await api.post('/auth/login', { email, password });
  const { accessToken } = response.data;
  api.defaults.headers.common['Authorization'] = `Bearer ${accessToken}`;
  return response.data;
};

// Get user profile
const getProfile = async () => {
  const response = await api.get('/users/profile');
  return response.data;
};
```

### Flutter/Dart
```dart
import 'package:dio/dio.dart';

class HostelConnectAPI {
  final Dio _dio = Dio();
  
  HostelConnectAPI() {
    _dio.options.baseUrl = 'https://hostelconnect-api.azurewebsites.net/api/v1';
    _dio.options.headers['Content-Type'] = 'application/json';
  }
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return response.data;
  }
  
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _dio.get('/users/profile');
    return response.data;
  }
}
```

## 🔒 Security

### Authentication
- JWT tokens with 24-hour expiration
- Refresh tokens for seamless renewal
- Role-based access control
- Secure password hashing (bcrypt)

### Data Protection
- HTTPS/TLS encryption
- Input validation and sanitization
- SQL injection prevention
- XSS protection
- CORS configuration

### Rate Limiting
- 100 requests per minute per IP
- Exponential backoff for retries
- Request size limits
- Timeout handling

---

**This API documentation provides comprehensive information for integrating with the HostelConnect system. For additional support, contact our development team.**
