# HostelConnect API Specification

## Base URL
```
http://localhost:3000/api
```

## Authentication

All endpoints require JWT authentication except login and refresh token endpoints.

### Headers
```
Authorization: Bearer <access_token>
Content-Type: application/json
```

## Endpoints

### Authentication

#### POST /auth/login
Login with email and password.

**Request Body:**
```json
{
  "email": "student@college.edu",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "uuid",
      "email": "student@college.edu",
      "role": "STUDENT"
    }
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### POST /auth/refresh
Refresh access token using refresh token.

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### GET /auth/me
Get current user profile.

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "email": "student@college.edu",
    "role": "STUDENT",
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00Z"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Gate Pass Management

#### POST /gate-pass
Create a new gate pass request.

**Request Body:**
```json
{
  "studentId": "uuid",
  "hostelId": "uuid",
  "type": "OUTING",
  "startTime": "2024-01-15T10:00:00Z",
  "endTime": "2024-01-15T18:00:00Z",
  "reason": "Going to library for study",
  "note": "Will return by 6 PM",
  "isEmergency": false
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "studentId": "uuid",
    "hostelId": "uuid",
    "type": "OUTING",
    "startTime": "2024-01-15T10:00:00Z",
    "endTime": "2024-01-15T18:00:00Z",
    "status": "PENDING",
    "reason": "Going to library for study",
    "note": "Will return by 6 PM",
    "isEmergency": false,
    "createdAt": "2024-01-15T10:30:00Z"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### GET /gate-pass
Get gate pass requests (filtered by role).

**Query Parameters:**
- `studentId` (optional): Filter by student ID
- `hostelId` (optional): Filter by hostel ID
- `status` (optional): Filter by status

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "studentId": "uuid",
      "hostelId": "uuid",
      "type": "OUTING",
      "startTime": "2024-01-15T10:00:00Z",
      "endTime": "2024-01-15T18:00:00Z",
      "status": "PENDING",
      "reason": "Going to library for study",
      "student": {
        "id": "uuid",
        "name": "John Doe",
        "studentId": "2024001"
      },
      "hostel": {
        "id": "uuid",
        "name": "Boys Hostel A"
      }
    }
  ],
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### PATCH /gate-pass/:id/approve
Approve or reject gate pass (Warden only).

**Request Body:**
```json
{
  "status": "APPROVED",
  "note": "Approved for library visit"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "status": "APPROVED",
    "decisionBy": "uuid",
    "decisionAt": "2024-01-15T10:35:00Z",
    "note": "Approved for library visit",
    "qrTokenHash": "base64-encoded-token",
    "qrTokenExpiresAt": "2024-01-15T10:35:30Z"
  },
  "timestamp": "2024-01-15T10:35:00Z"
}
```

#### GET /gate-pass/:id/qr
Get QR token for approved gate pass.

**Response:**
```json
{
  "success": true,
  "data": {
    "qrToken": "base64-encoded-token",
    "expiresAt": "2024-01-15T10:35:30Z"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### POST /gate/scan
Scan gate pass QR code.

**Request Body:**
```json
{
  "qrToken": "base64-encoded-token",
  "eventType": "OUT",
  "deviceId": "uuid",
  "latitude": 12.9716,
  "longitude": 77.5946
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "eventId": "uuid",
    "passId": "uuid",
    "studentId": "uuid",
    "eventType": "OUT",
    "timestamp": "2024-01-15T10:30:00Z",
    "message": "Gate pass scanned successfully"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Attendance Management

#### POST /attendance/sessions
Create attendance session.

**Request Body:**
```json
{
  "hostelId": "uuid",
  "wingIds": ["uuid1", "uuid2"],
  "date": "2024-01-15",
  "slot": "NIGHT",
  "startTime": "2024-01-15T21:00:00Z",
  "endTime": "2024-01-15T23:00:00Z",
  "mode": "HYBRID"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "hostelId": "uuid",
    "wingIds": ["uuid1", "uuid2"],
    "date": "2024-01-15",
    "slot": "NIGHT",
    "startTime": "2024-01-15T21:00:00Z",
    "endTime": "2024-01-15T23:00:00Z",
    "mode": "HYBRID",
    "nonce": "random-nonce",
    "status": "ACTIVE",
    "createdAt": "2024-01-15T10:30:00Z"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### GET /attendance/sessions/:id/roster
Get attendance roster for session.

**Response:**
```json
{
  "success": true,
  "data": {
    "sessionId": "uuid",
    "totalStudents": 120,
    "roster": [
      {
        "studentId": "uuid",
        "studentName": "John Doe",
        "roomNumber": "A-101",
        "bedNumber": 1
      }
    ]
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### POST /attendance/scan
Scan attendance QR code.

**Request Body:**
```json
{
  "sessionId": "uuid",
  "qrToken": "base64-encoded-token",
  "deviceId": "uuid",
  "wardenId": "uuid"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "checkId": "uuid",
    "sessionId": "uuid",
    "studentId": "uuid",
    "method": "STUDENT_QR",
    "timestamp": "2024-01-15T10:30:00Z",
    "message": "Attendance recorded successfully"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### POST /attendance/manual
Record manual attendance.

**Request Body:**
```json
{
  "sessionId": "uuid",
  "studentId": "uuid",
  "wardenId": "uuid",
  "reason": "Student was in washroom",
  "photoUrl": "optional-photo-url"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "checkId": "uuid",
    "sessionId": "uuid",
    "studentId": "uuid",
    "method": "MANUAL",
    "timestamp": "2024-01-15T10:30:00Z",
    "reason": "Student was in washroom",
    "message": "Manual attendance recorded"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### GET /attendance/sessions/:id/summary
Get attendance session summary.

**Response:**
```json
{
  "success": true,
  "data": {
    "sessionId": "uuid",
    "hostelId": "uuid",
    "date": "2024-01-15",
    "slot": "NIGHT",
    "mode": "HYBRID",
    "totalRoster": 120,
    "scannedCount": 105,
    "manualCount": 8,
    "kioskCount": 95,
    "wardenCount": 18,
    "attendancePercentage": 87.5,
    "updatedAt": "2024-01-15T10:30:00Z"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Meals Management

#### POST /meals/intents/open
Open meal intents for a specific date.

**Request Body:**
```json
{
  "date": "2024-01-16"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "date": "2024-01-16",
    "isOpen": true,
    "cutoffTime": "2024-01-15T20:00:00Z",
    "message": "Meal intents opened for 2024-01-16"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### POST /meals/intent/day
Set meal intents for entire day.

**Request Body:**
```json
{
  "date": "2024-01-16",
  "intents": {
    "BREAKFAST": "YES",
    "LUNCH": "YES",
    "SNACKS": "NO",
    "DINNER": "YES"
  }
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "date": "2024-01-16",
    "intents": {
      "BREAKFAST": "YES",
      "LUNCH": "YES",
      "SNACKS": "NO",
      "DINNER": "YES"
    },
    "message": "Meal intents set for 2024-01-16"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### GET /meals/forecast
Get meal forecast for upcoming days.

**Query Parameters:**
- `days` (optional): Number of days to forecast (default: 7)

**Response:**
```json
{
  "success": true,
  "data": {
    "forecasts": [
      {
        "date": "2024-01-16",
        "meals": {
          "BREAKFAST": {
            "yesCount": 85,
            "noCount": 35,
            "forecastCount": 89,
            "overrideDelta": 0
          },
          "LUNCH": {
            "yesCount": 92,
            "noCount": 28,
            "forecastCount": 97,
            "overrideDelta": 0
          }
        }
      }
    ]
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Dashboards

#### GET /dash/hostel-live
Get live hostel dashboard data.

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "hostelId": "uuid",
      "hostelName": "Boys Hostel A",
      "totalStrength": 120,
      "outpassNow": 15,
      "presentDerived": 105,
      "scanPresent": 95,
      "manualPresent": 10,
      "kioskScans": 85,
      "wardenScans": 20,
      "updatedAt": "2024-01-15T10:30:00Z"
    }
  ],
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### GET /dash/monthly
Get monthly analytics.

**Query Parameters:**
- `month` (optional): Month in YYYY-MM format (default: current month)

**Response:**
```json
{
  "success": true,
  "data": {
    "month": "2024-01",
    "hostelId": "uuid",
    "hostelName": "Boys Hostel A",
    "attendanceSessions": 30,
    "avgAttendancePercentage": 87.5,
    "gatePassRequests": 150,
    "gatePassApproved": 135,
    "gatePassApprovalRate": 90.0,
    "mealDays": 31,
    "avgMealYesPercentage": 85.2,
    "occupiedRooms": 110,
    "totalRooms": 120,
    "roomOccupancyPercentage": 91.7,
    "updatedAt": "2024-01-15T10:30:00Z"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Ads System

#### GET /ads/eligible
Get eligible ad for module.

**Query Parameters:**
- `module`: Module name (e.g., "gatepass")

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "type": "INTERSTITIAL",
    "assetUrl": "https://example.com/ad-banner.jpg",
    "durationS": 20
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### POST /ads/event
Log ad event.

**Request Body:**
```json
{
  "adId": "uuid",
  "module": "gatepass",
  "result": "COMPLETED"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "eventId": "uuid",
    "adId": "uuid",
    "module": "gatepass",
    "result": "COMPLETED",
    "timestamp": "2024-01-15T10:30:00Z",
    "message": "Ad event logged successfully"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

## Error Responses

### Validation Error (400)
```json
{
  "success": false,
  "error": "ValidationError",
  "message": "Invalid input data",
  "statusCode": 400,
  "timestamp": "2024-01-15T10:30:00Z",
  "path": "/api/gate-pass"
}
```

### Unauthorized (401)
```json
{
  "success": false,
  "error": "UnauthorizedException",
  "message": "Invalid credentials",
  "statusCode": 401,
  "timestamp": "2024-01-15T10:30:00Z",
  "path": "/api/auth/login"
}
```

### Forbidden (403)
```json
{
  "success": false,
  "error": "ForbiddenException",
  "message": "Insufficient permissions",
  "statusCode": 403,
  "timestamp": "2024-01-15T10:30:00Z",
  "path": "/api/gate-pass/uuid/approve"
}
```

### Not Found (404)
```json
{
  "success": false,
  "error": "NotFoundException",
  "message": "Gate pass not found",
  "statusCode": 404,
  "timestamp": "2024-01-15T10:30:00Z",
  "path": "/api/gate-pass/uuid"
}
```

### Rate Limited (429)
```json
{
  "success": false,
  "error": "ThrottlerException",
  "message": "Too many requests",
  "statusCode": 429,
  "timestamp": "2024-01-15T10:30:00Z",
  "path": "/api/auth/login"
}
```

### Internal Server Error (500)
```json
{
  "success": false,
  "error": "InternalServerError",
  "message": "Internal server error",
  "statusCode": 500,
  "timestamp": "2024-01-15T10:30:00Z",
  "path": "/api/gate-pass"
}
```

## Rate Limiting

- **General API**: 100 requests per minute per IP
- **Authentication**: 10 requests per minute per IP
- **Scanning endpoints**: 30 requests per minute per device

## WebSocket Events (Future)

### Real-time Updates
- `attendance_update`: Live attendance updates
- `gate_pass_status`: Gate pass status changes
- `meal_forecast_update`: Meal forecast updates
- `system_notification`: System-wide notifications

## SDKs and Libraries

### JavaScript/TypeScript
```bash
npm install @hostelconnect/api-client
```

### Flutter/Dart
```yaml
dependencies:
  hostelconnect_api: ^1.0.0
```

### Python
```bash
pip install hostelconnect-api
```
