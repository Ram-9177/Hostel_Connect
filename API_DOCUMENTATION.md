# 📡 HOSTELCONNECT API DOCUMENTATION

> **Version:** 1.0  
> **Base URL:** `https://api.hostelconnect.com/api/v1`  
> **Authentication:** JWT Bearer Token

---

## 📑 TABLE OF CONTENTS

1. [Authentication](#1-authentication-api)
2. [Students](#2-students-api)
3. [Gate Pass](#3-gate-pass-api)
4. [Attendance](#4-attendance-api)
5. [Notifications](#5-notifications-api)
6. [Meals](#6-meals-api)
7. [Analytics](#7-analytics-api)
8. [Hostels](#8-hostels-api)
9. [WebSocket Events](#9-websocket-events)
10. [Error Handling](#10-error-handling)

---

## 1. AUTHENTICATION API

### 1.1 Register Student

**Endpoint:** `POST /auth/register`  
**Auth Required:** No  
**Rate Limit:** 5 requests/minute

**Request Body:**
```json
{
  "email": "student@university.edu",
  "password": "SecurePass123!",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "+91-9876543210",
  "studentId": "STU001",
  "dateOfBirth": "2002-05-15",
  "gender": "MALE",
  "department": "Computer Science",
  "year": 2,
  "guardianName": "Jane Doe",
  "guardianPhone": "+91-9876543211"
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "uuid-here",
      "email": "student@university.edu",
      "role": "STUDENT",
      "isVerified": false
    },
    "tokens": {
      "accessToken": "eyJhbGciOiJIUzI1NiIs...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
      "expiresIn": 3600
    }
  }
}
```

---

### 1.2 Login

**Endpoint:** `POST /auth/login`  
**Auth Required:** No  
**Rate Limit:** 10 requests/minute

**Request Body:**
```json
{
  "email": "student@university.edu",
  "password": "SecurePass123!"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "uuid-here",
      "email": "student@university.edu",
      "role": "STUDENT",
      "firstName": "John",
      "lastName": "Doe",
      "profileImageUrl": "https://..."
    },
    "tokens": {
      "accessToken": "eyJhbGciOiJIUzI1NiIs...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
      "expiresIn": 3600
    }
  }
}
```

---

### 1.3 Refresh Token

**Endpoint:** `POST /auth/refresh`  
**Auth Required:** Yes (Refresh Token)

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIs...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
    "expiresIn": 3600
  }
}
```

---

### 1.4 Get Current User

**Endpoint:** `GET /auth/me`  
**Auth Required:** Yes

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "uuid-here",
    "email": "student@university.edu",
    "role": "STUDENT",
    "firstName": "John",
    "lastName": "Doe",
    "phone": "+91-9876543210",
    "studentDetails": {
      "studentId": "STU001",
      "department": "Computer Science",
      "year": 2,
      "hostelId": "hostel-uuid",
      "roomId": "room-uuid"
    }
  }
}
```

---

## 2. STUDENTS API

### 2.1 Create Student

**Endpoint:** `POST /students`  
**Auth Required:** Yes (ADMIN, SUPER_ADMIN)  
**Roles:** `['ADMIN', 'SUPER_ADMIN']`

**Request Body:**
```json
{
  "studentId": "STU002",
  "email": "student2@university.edu",
  "firstName": "Jane",
  "lastName": "Smith",
  "phone": "+91-9876543212",
  "dateOfBirth": "2003-03-20",
  "gender": "FEMALE",
  "bloodGroup": "O+",
  "department": "Electronics",
  "year": 1,
  "course": "B.Tech",
  "address": "123 Main St",
  "city": "Mumbai",
  "state": "Maharashtra",
  "pincode": "400001",
  "guardianName": "Mr. Smith",
  "guardianPhone": "+91-9876543213",
  "guardianRelation": "Father",
  "hostelId": "hostel-uuid",
  "blockId": "block-uuid",
  "roomId": "room-uuid",
  "bedNumber": 1
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "id": "student-uuid",
    "studentId": "STU002",
    "email": "student2@university.edu",
    "firstName": "Jane",
    "lastName": "Smith",
    "isActive": true,
    "createdAt": "2025-01-15T10:30:00Z"
  }
}
```

---

### 2.2 Bulk Upload Students (CSV)

**Endpoint:** `POST /students/bulk/upload`  
**Auth Required:** Yes (ADMIN, SUPER_ADMIN)  
**Content-Type:** `multipart/form-data`

**Request:**
```
Form Data:
  file: students.csv (CSV file)
```

**CSV Format:**
```csv
studentId,email,firstName,lastName,phone,dateOfBirth,gender,department,year
STU003,student3@university.edu,Mike,Johnson,9876543214,2002-07-10,MALE,Civil,3
STU004,student4@university.edu,Sarah,Williams,9876543215,2003-11-25,FEMALE,Mechanical,2
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "created": 2,
    "failed": 0,
    "errors": [],
    "details": {
      "totalRows": 2,
      "successfulInserts": 2,
      "duplicates": 0,
      "invalidRows": 0
    }
  }
}
```

---

### 2.3 List Students

**Endpoint:** `GET /students`  
**Auth Required:** Yes  
**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| page | number | No | Page number (default: 1) |
| limit | number | No | Items per page (default: 20, max: 100) |
| search | string | No | Search by name, email, studentId |
| hostelId | UUID | No | Filter by hostel |
| blockId | UUID | No | Filter by block |
| year | number | No | Filter by academic year |
| department | string | No | Filter by department |
| isActive | boolean | No | Filter by active status |

**Example Request:**
```
GET /students?page=1&limit=20&hostelId=hostel-uuid&year=2&isActive=true
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "id": "student-uuid",
        "studentId": "STU001",
        "firstName": "John",
        "lastName": "Doe",
        "email": "student@university.edu",
        "phone": "+91-9876543210",
        "department": "Computer Science",
        "year": 2,
        "hostel": {
          "id": "hostel-uuid",
          "name": "Hostel A"
        },
        "room": {
          "id": "room-uuid",
          "roomNumber": "101",
          "floor": 1
        },
        "isActive": true
      }
    ],
    "meta": {
      "totalItems": 150,
      "itemCount": 20,
      "itemsPerPage": 20,
      "totalPages": 8,
      "currentPage": 1
    }
  }
}
```

---

### 2.4 Get Student Details

**Endpoint:** `GET /students/:id`  
**Auth Required:** Yes

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "student-uuid",
    "studentId": "STU001",
    "firstName": "John",
    "lastName": "Doe",
    "email": "student@university.edu",
    "phone": "+91-9876543210",
    "dateOfBirth": "2002-05-15",
    "gender": "MALE",
    "bloodGroup": "A+",
    "department": "Computer Science",
    "year": 2,
    "course": "B.Tech",
    "address": "123 Main St",
    "city": "Mumbai",
    "state": "Maharashtra",
    "pincode": "400001",
    "guardianName": "Jane Doe",
    "guardianPhone": "+91-9876543211",
    "guardianRelation": "Mother",
    "hostel": {
      "id": "hostel-uuid",
      "name": "Hostel A",
      "code": "HST-A"
    },
    "block": {
      "id": "block-uuid",
      "name": "Block 1"
    },
    "room": {
      "id": "room-uuid",
      "roomNumber": "101",
      "floor": 1,
      "bedNumber": 2
    },
    "statistics": {
      "attendancePercentage": 87.5,
      "gatePassCount": 12,
      "lateReturns": 2,
      "mealAttendance": 92.3
    },
    "isActive": true,
    "joinedDate": "2024-08-01",
    "createdAt": "2024-07-15T10:00:00Z",
    "updatedAt": "2025-01-15T14:30:00Z"
  }
}
```

---

### 2.5 Update Student

**Endpoint:** `PUT /students/:id`  
**Auth Required:** Yes (ADMIN, SUPER_ADMIN)

**Request Body:**
```json
{
  "phone": "+91-9876543220",
  "year": 3,
  "roomId": "new-room-uuid",
  "bedNumber": 3
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "student-uuid",
    "phone": "+91-9876543220",
    "year": 3,
    "roomId": "new-room-uuid",
    "updatedAt": "2025-01-15T15:00:00Z"
  }
}
```

---

### 2.6 Reset Student Password

**Endpoint:** `POST /students/:id/reset-password`  
**Auth Required:** Yes (ADMIN, SUPER_ADMIN, WARDEN_HEAD)

**Request Body:**
```json
{
  "newPassword": "NewSecurePass123!",
  "sendEmail": true
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Password reset successfully. Email sent to student.",
  "data": {
    "passwordResetAt": "2025-01-15T15:30:00Z"
  }
}
```

---

### 2.7 Delete Student

**Endpoint:** `DELETE /students/:id`  
**Auth Required:** Yes (SUPER_ADMIN)

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Student account deleted successfully"
}
```

---

## 3. GATE PASS API

### 3.1 Create Gate Pass Request

**Endpoint:** `POST /gatepass`  
**Auth Required:** Yes (STUDENT)

**Request Body:**
```json
{
  "reason": "Family function",
  "fromDate": "2025-01-20T10:00:00Z",
  "toDate": "2025-01-20T22:00:00Z",
  "destination": "Home - Mumbai",
  "guardianContact": "+91-9876543211"
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "id": "gatepass-uuid",
    "studentId": "student-uuid",
    "reason": "Family function",
    "fromDate": "2025-01-20T10:00:00Z",
    "toDate": "2025-01-20T22:00:00Z",
    "destination": "Home - Mumbai",
    "status": "PENDING",
    "requestedAt": "2025-01-15T16:00:00Z",
    "student": {
      "studentId": "STU001",
      "name": "John Doe",
      "room": "101"
    }
  }
}
```

---

### 3.2 List Gate Passes

**Endpoint:** `GET /gatepass`  
**Auth Required:** Yes  
**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| page | number | No | Page number |
| limit | number | No | Items per page |
| studentId | UUID | No | Filter by student |
| status | enum | No | PENDING, APPROVED, REJECTED, EXPIRED, USED |
| fromDate | ISO Date | No | Filter by date range (start) |
| toDate | ISO Date | No | Filter by date range (end) |

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "id": "gatepass-uuid",
        "student": {
          "studentId": "STU001",
          "name": "John Doe",
          "room": "101",
          "phone": "+91-9876543210"
        },
        "reason": "Family function",
        "fromDate": "2025-01-20T10:00:00Z",
        "toDate": "2025-01-20T22:00:00Z",
        "destination": "Home - Mumbai",
        "status": "PENDING",
        "requestedAt": "2025-01-15T16:00:00Z"
      }
    ],
    "meta": {
      "totalItems": 25,
      "currentPage": 1,
      "totalPages": 3
    }
  }
}
```

---

### 3.3 Approve Gate Pass

**Endpoint:** `PUT /gatepass/:id/approve`  
**Auth Required:** Yes (WARDEN, WARDEN_HEAD)

**Request Body:**
```json
{
  "remarks": "Approved for family function"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "gatepass-uuid",
    "status": "APPROVED",
    "approvedBy": {
      "id": "warden-uuid",
      "name": "Dr. Warden Name"
    },
    "approvedAt": "2025-01-15T17:00:00Z",
    "qrCode": "GP2025011500001",
    "qrCodeUrl": "https://api.hostelconnect.com/qr/GP2025011500001.png"
  }
}
```

---

### 3.4 Reject Gate Pass

**Endpoint:** `PUT /gatepass/:id/reject`  
**Auth Required:** Yes (WARDEN, WARDEN_HEAD)

**Request Body:**
```json
{
  "reason": "Insufficient reason provided"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "gatepass-uuid",
    "status": "REJECTED",
    "rejectedBy": {
      "id": "warden-uuid",
      "name": "Dr. Warden Name"
    },
    "rejectedAt": "2025-01-15T17:00:00Z",
    "rejectedReason": "Insufficient reason provided"
  }
}
```

---

### 3.5 Scan QR Code (Entry/Exit)

**Endpoint:** `POST /gatepass/:id/scan`  
**Auth Required:** Yes (SECURITY)

**Request Body:**
```json
{
  "qrCode": "GP2025011500001",
  "scannedBy": "security-uuid",
  "location": "Main Gate"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "gatepass-uuid",
    "action": "EXIT",
    "exitTime": "2025-01-20T10:05:00Z",
    "exitScannedBy": {
      "name": "Security Guard 1"
    },
    "student": {
      "studentId": "STU001",
      "name": "John Doe",
      "room": "101",
      "photo": "https://..."
    },
    "validUntil": "2025-01-20T22:00:00Z"
  }
}
```

---

### 3.6 Get Gate Pass QR Code

**Endpoint:** `GET /gatepass/:id/qr`  
**Auth Required:** Yes

**Response:** `200 OK` (Image/PNG)

---

### 3.7 Get Pending Approvals (Warden)

**Endpoint:** `GET /gatepass/pending`  
**Auth Required:** Yes (WARDEN, WARDEN_HEAD)

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "count": 5,
    "passes": [
      {
        "id": "gatepass-uuid",
        "student": {
          "studentId": "STU001",
          "name": "John Doe",
          "room": "101",
          "block": "Block 1"
        },
        "reason": "Medical appointment",
        "fromDate": "2025-01-21T09:00:00Z",
        "toDate": "2025-01-21T14:00:00Z",
        "requestedAt": "2025-01-16T10:00:00Z",
        "priority": "NORMAL"
      }
    ]
  }
}
```

---

## 4. ATTENDANCE API

### 4.1 Create Attendance Session

**Endpoint:** `POST /attendance/session`  
**Auth Required:** Yes (WARDEN, ADMIN)

**Request Body:**
```json
{
  "name": "Morning Roll Call",
  "date": "2025-01-16",
  "startTime": "2025-01-16T08:00:00Z",
  "endTime": "2025-01-16T09:00:00Z",
  "hostelId": "hostel-uuid",
  "blockId": "block-uuid"
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "id": "session-uuid",
    "name": "Morning Roll Call",
    "date": "2025-01-16",
    "startTime": "2025-01-16T08:00:00Z",
    "endTime": "2025-01-16T09:00:00Z",
    "qrCode": "ATT2025011600001",
    "qrCodeUrl": "https://api.hostelconnect.com/qr/ATT2025011600001.png",
    "totalStudents": 120,
    "expectedCount": 120
  }
}
```

---

### 4.2 Mark Attendance (Scan QR)

**Endpoint:** `POST /attendance/mark`  
**Auth Required:** Yes (STUDENT)

**Request Body:**
```json
{
  "sessionId": "session-uuid",
  "qrCode": "ATT2025011600001"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "attendance-uuid",
    "sessionId": "session-uuid",
    "studentId": "student-uuid",
    "status": "PRESENT",
    "markedAt": "2025-01-16T08:15:00Z",
    "message": "Attendance marked successfully"
  }
}
```

---

### 4.3 Daily Attendance Report

**Endpoint:** `GET /attendance/report/daily`  
**Auth Required:** Yes (WARDEN, ADMIN)  
**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| date | ISO Date | Yes | Report date |
| hostelId | UUID | No | Filter by hostel |
| blockId | UUID | No | Filter by block |

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "date": "2025-01-16",
    "summary": {
      "totalStudents": 120,
      "present": 112,
      "absent": 6,
      "leave": 2,
      "percentage": 93.33
    },
    "absentees": [
      {
        "studentId": "STU005",
        "name": "Alice Brown",
        "room": "102",
        "phone": "+91-9876543220"
      }
    ]
  }
}
```

---

### 4.4 Monthly Attendance Report

**Endpoint:** `GET /attendance/report/monthly`  
**Auth Required:** Yes

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| month | number | Yes | Month (1-12) |
| year | number | Yes | Year (e.g., 2025) |
| studentId | UUID | No | Filter by student |

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "month": 1,
    "year": 2025,
    "student": {
      "studentId": "STU001",
      "name": "John Doe"
    },
    "summary": {
      "totalDays": 20,
      "present": 18,
      "absent": 1,
      "leave": 1,
      "percentage": 90.0
    },
    "dailyRecords": [
      {
        "date": "2025-01-01",
        "status": "PRESENT"
      },
      {
        "date": "2025-01-02",
        "status": "PRESENT"
      },
      {
        "date": "2025-01-03",
        "status": "ABSENT"
      }
    ]
  }
}
```

---

## 5. NOTIFICATIONS API

### 5.1 Create Targeted Notification

**Endpoint:** `POST /notifications/targeted`  
**Auth Required:** Yes (WARDEN, ADMIN, SUPER_ADMIN)

**Request Body:**
```json
{
  "title": "Hostel Maintenance Notice",
  "body": "Water supply will be unavailable tomorrow from 9 AM to 2 PM",
  "type": "ANNOUNCEMENT",
  "priority": "HIGH",
  "targetType": "BLOCK",
  "hostelId": "hostel-uuid",
  "blockId": "block-uuid",
  "imageUrl": "https://example.com/notice.jpg",
  "actionUrl": "/notices/detail/123",
  "expiresAt": "2025-01-25T23:59:59Z"
}
```

**Target Types:**
- `ALL` - All students
- `HOSTEL` - Specific hostel (requires `hostelId`)
- `BLOCK` - Specific block (requires `hostelId`, `blockId`)
- `FLOOR` - Specific floor (requires `hostelId`, `blockId`, `floor`)
- `ROOM` - Specific room (requires `roomId`)
- `STUDENT` - Individual student (requires `studentId`)
- `ROLE` - By role (requires `role`: STUDENT/WARDEN/ADMIN)

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "notification": {
      "id": "notification-uuid",
      "title": "Hostel Maintenance Notice",
      "body": "Water supply will be unavailable tomorrow from 9 AM to 2 PM",
      "type": "ANNOUNCEMENT",
      "priority": "HIGH",
      "targetType": "BLOCK",
      "createdAt": "2025-01-16T10:00:00Z"
    },
    "targetCount": 45,
    "message": "Notification sent to 45 students successfully"
  }
}
```

---

### 5.2 List Notifications (User)

**Endpoint:** `GET /notifications`  
**Auth Required:** Yes  
**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| page | number | No | Page number |
| limit | number | No | Items per page |
| isRead | boolean | No | Filter by read status |
| type | enum | No | Filter by type |

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "id": "notification-uuid",
        "title": "Hostel Maintenance Notice",
        "body": "Water supply will be unavailable tomorrow...",
        "type": "ANNOUNCEMENT",
        "priority": "HIGH",
        "imageUrl": "https://...",
        "isRead": false,
        "createdAt": "2025-01-16T10:00:00Z"
      }
    ],
    "meta": {
      "totalItems": 15,
      "unreadCount": 5,
      "currentPage": 1
    }
  }
}
```

---

### 5.3 Mark Notification as Read

**Endpoint:** `PUT /notifications/:id/read`  
**Auth Required:** Yes

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": "notification-uuid",
    "isRead": true,
    "readAt": "2025-01-16T11:30:00Z"
  }
}
```

---

### 5.4 Get Unread Count

**Endpoint:** `GET /notifications/unread/count`  
**Auth Required:** Yes

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "unreadCount": 5
  }
}
```

---

## 6. MEALS API

### 6.1 Create Menu

**Endpoint:** `POST /meals/menu`  
**Auth Required:** Yes (CHEF, ADMIN)

**Request Body:**
```json
{
  "date": "2025-01-17",
  "hostelId": "hostel-uuid",
  "breakfastItems": ["Idli", "Sambar", "Chutney", "Tea/Coffee"],
  "lunchItems": ["Rice", "Dal", "Roti", "Sabzi", "Curd"],
  "dinnerItems": ["Roti", "Paneer Curry", "Rice", "Salad"]
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "id": "menu-uuid",
    "date": "2025-01-17",
    "hostelId": "hostel-uuid",
    "breakfastItems": ["Idli", "Sambar", "Chutney", "Tea/Coffee"],
    "lunchItems": ["Rice", "Dal", "Roti", "Sabzi", "Curd"],
    "dinnerItems": ["Roti", "Paneer Curry", "Rice", "Salad"],
    "createdAt": "2025-01-16T12:00:00Z"
  }
}
```

---

### 6.2 Submit Meal Intent

**Endpoint:** `POST /meals/intent`  
**Auth Required:** Yes (STUDENT)

**Request Body:**
```json
{
  "date": "2025-01-17",
  "wantsBreakfast": true,
  "wantsLunch": true,
  "wantsDinner": false,
  "specialRequest": "Extra roti please"
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "id": "intent-uuid",
    "studentId": "student-uuid",
    "date": "2025-01-17",
    "wantsBreakfast": true,
    "wantsLunch": true,
    "wantsDinner": false,
    "submittedAt": "2025-01-16T19:30:00Z",
    "message": "Meal intent submitted successfully"
  }
}
```

---

### 6.3 Get Meal Counts (Chef)

**Endpoint:** `GET /meals/count/:date`  
**Auth Required:** Yes (CHEF, ADMIN)

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "date": "2025-01-17",
    "hostelId": "hostel-uuid",
    "counts": {
      "breakfast": {
        "total": 112,
        "percentage": 93.33
      },
      "lunch": {
        "total": 108,
        "percentage": 90.0
      },
      "dinner": {
        "total": 95,
        "percentage": 79.17
      }
    },
    "totalStudents": 120,
    "submissionRate": 98.33
  }
}
```

---

## 7. ANALYTICS API

### 7.1 Get Dashboard Data

**Endpoint:** `GET /analytics/dashboard`  
**Auth Required:** Yes (WARDEN, ADMIN)

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "overview": {
      "totalStudents": 500,
      "activeStudents": 487,
      "presentToday": 463,
      "attendancePercentage": 95.06
    },
    "gatePass": {
      "pendingApprovals": 12,
      "approvedToday": 8,
      "activeNow": 5
    },
    "meals": {
      "breakfastCount": 456,
      "lunchCount": 478,
      "dinnerCount": 421
    },
    "occupancy": {
      "totalRooms": 150,
      "occupiedRooms": 145,
      "occupancyRate": 96.67,
      "vacantBeds": 23
    }
  }
}
```

---

### 7.2 Get Attendance Analytics

**Endpoint:** `GET /analytics/attendance`  
**Auth Required:** Yes

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| startDate | ISO Date | Yes | Analysis start date |
| endDate | ISO Date | Yes | Analysis end date |
| hostelId | UUID | No | Filter by hostel |

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "period": {
      "startDate": "2025-01-01",
      "endDate": "2025-01-16"
    },
    "trends": [
      {
        "date": "2025-01-01",
        "percentage": 94.5
      },
      {
        "date": "2025-01-02",
        "percentage": 96.2
      }
    ],
    "averagePercentage": 95.3,
    "defaulters": [
      {
        "studentId": "STU010",
        "name": "Student Name",
        "percentage": 72.5,
        "absentDays": 4
      }
    ]
  }
}
```

---

## 8. HOSTELS API

### 8.1 Create Hostel

**Endpoint:** `POST /hostels`  
**Auth Required:** Yes (ADMIN, SUPER_ADMIN)

**Request Body:**
```json
{
  "name": "Hostel A",
  "code": "HST-A",
  "address": "123 University Road",
  "capacity": 200,
  "gender": "MALE",
  "wardenId": "warden-uuid"
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "id": "hostel-uuid",
    "name": "Hostel A",
    "code": "HST-A",
    "capacity": 200,
    "currentOccupancy": 0,
    "createdAt": "2025-01-16T14:00:00Z"
  }
}
```

---

### 8.2 List Available Rooms

**Endpoint:** `GET /rooms/available`  
**Auth Required:** Yes

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| hostelId | UUID | No | Filter by hostel |
| gender | enum | No | MALE/FEMALE |

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "rooms": [
      {
        "id": "room-uuid",
        "roomNumber": "101",
        "floor": 1,
        "capacity": 3,
        "currentOccupancy": 2,
        "availableBeds": 1,
        "block": {
          "name": "Block 1"
        },
        "hostel": {
          "name": "Hostel A"
        }
      }
    ],
    "totalAvailableBeds": 45
  }
}
```

---

## 9. WEBSOCKET EVENTS

**Connection:**
```javascript
const socket = io('wss://api.hostelconnect.com', {
  auth: {
    token: 'your-jwt-token'
  }
});
```

### Client → Server Events

#### Subscribe to Notifications
```javascript
socket.emit('subscribe-notifications', {
  userId: 'user-uuid'
});
```

#### Subscribe to Gate Pass Updates
```javascript
socket.emit('subscribe-gatepass', {
  studentId: 'student-uuid'
});
```

---

### Server → Client Events

#### New Notification
```javascript
socket.on('notification', (notification) => {
  console.log('New notification:', notification);
  // {
  //   id: 'notification-uuid',
  //   title: 'Meal Reminder',
  //   body: 'Submit meal intent for tomorrow',
  //   type: 'MEAL_INTENT',
  //   priority: 'MEDIUM'
  // }
});
```

#### Gate Pass Approved
```javascript
socket.on('gatepass-approved', (gatePass) => {
  console.log('Gate pass approved:', gatePass);
  // {
  //   id: 'gatepass-uuid',
  //   status: 'APPROVED',
  //   qrCode: 'GP2025011600001',
  //   qrCodeUrl: 'https://...'
  // }
});
```

#### Gate Pass Rejected
```javascript
socket.on('gatepass-rejected', (data) => {
  console.log('Gate pass rejected:', data);
  // {
  //   id: 'gatepass-uuid',
  //   reason: 'Insufficient reason'
  // }
});
```

#### Attendance Session Created
```javascript
socket.on('attendance-session-created', (session) => {
  console.log('New attendance session:', session);
  // {
  //   id: 'session-uuid',
  //   name: 'Morning Roll Call',
  //   qrCode: 'ATT2025011600001',
  //   endTime: '2025-01-16T09:00:00Z'
  // }
});
```

#### Meal Reminder
```javascript
socket.on('meal-reminder', (reminder) => {
  console.log('Meal reminder:', reminder);
  // {
  //   type: 'MORNING_REMINDER',
  //   date: '2025-01-17',
  //   deadline: '2025-01-16T20:00:00Z'
  // }
});
```

---

## 10. ERROR HANDLING

### Error Response Format

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  },
  "statusCode": 400
}
```

### HTTP Status Codes

| Code | Meaning | Usage |
|------|---------|-------|
| 200 | OK | Successful GET, PUT, DELETE |
| 201 | Created | Successful POST |
| 400 | Bad Request | Validation error, invalid input |
| 401 | Unauthorized | Missing or invalid token |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 409 | Conflict | Duplicate resource |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Server error |

### Common Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `VALIDATION_ERROR` | 400 | Invalid input data |
| `UNAUTHORIZED` | 401 | Authentication required |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `DUPLICATE_EMAIL` | 409 | Email already exists |
| `DUPLICATE_STUDENT_ID` | 409 | Student ID already exists |
| `GATE_PASS_EXPIRED` | 400 | Gate pass has expired |
| `ATTENDANCE_ALREADY_MARKED` | 400 | Attendance already marked |
| `MEAL_INTENT_DEADLINE_PASSED` | 400 | Deadline for meal intent has passed |
| `RATE_LIMIT_EXCEEDED` | 429 | Too many requests |
| `INTERNAL_ERROR` | 500 | Internal server error |

---

## 🔐 AUTHENTICATION HEADERS

All authenticated requests must include:

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

## 📊 RATE LIMITING

| Endpoint Category | Rate Limit |
|-------------------|------------|
| Authentication | 10 requests/minute |
| Student Operations | 100 requests/minute |
| Gate Pass | 50 requests/minute |
| Notifications | 30 requests/minute |
| Analytics | 20 requests/minute |

---

## 🚀 PAGINATION

All list endpoints support pagination:

**Query Parameters:**
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 20, max: 100)

**Response Meta:**
```json
{
  "meta": {
    "totalItems": 150,
    "itemCount": 20,
    "itemsPerPage": 20,
    "totalPages": 8,
    "currentPage": 1
  }
}
```

---

**API Version:** 1.0  
**Last Updated:** January 2025  
**Total Endpoints:** 120+  
**Base URL:** `https://api.hostelconnect.com/api/v1`
