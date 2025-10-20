# HostelConnect Architecture Documentation

## Overview

HostelConnect is a production-ready monorepo for single-college hostel management with role-based access control, real-time dashboards, and offline-capable attendance scanning.

## System Architecture

### High-Level Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Flutter App   │    │   NestJS API    │    │   PostgreSQL    │
│   (Mobile)      │◄──►│   (Backend)     │◄──►│   (Database)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Local SQLite  │    │     Redis       │    │ Materialized    │
│   (Offline)     │    │   (Cache/Jobs)  │    │     Views       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Technology Stack

#### Frontend (Mobile)
- **Framework**: Flutter 3.16+
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Local Storage**: SQLite (sqflite)
- **HTTP Client**: Dio + Retrofit
- **QR Code**: qr_flutter, qr_code_scanner

#### Backend (API)
- **Framework**: NestJS (Node.js 20+)
- **Database**: PostgreSQL 15+
- **Cache/Queue**: Redis + BullMQ
- **Authentication**: JWT + Refresh Tokens
- **Validation**: class-validator + Zod
- **Documentation**: Swagger/OpenAPI

#### Infrastructure
- **Containerization**: Docker
- **CI/CD**: GitHub Actions
- **Development**: Codespaces + DevContainer
- **Monitoring**: Built-in health checks

## Core Modules

### 1. Authentication & Authorization
- JWT-based authentication with refresh tokens
- Role-based access control (RBAC)
- Device token management for scanners
- Rate limiting and security middleware

### 2. Gate Pass Management
- Request → Approve/Reject workflow
- 20s interstitial ad unlock system
- Emergency bypass option
- Real-time gate scanning with QR codes
- Rotating QR tokens (30s TTL)

### 3. Night Attendance System
- QR code scanning (Kiosk/Warden modes)
- Manual fallback with reason tracking
- Hybrid session support
- Late scan adjustments
- Offline-capable scanning

### 4. Meals Management
- Daily intent collection (20:00 IST cutoff)
- Chef forecast board
- Override capabilities (Warden Head only)
- Diet preference tracking

### 5. Room Management
- Live occupancy mapping
- Transfer/swap request system
- Damage tracking
- Allocation analytics

### 6. Real-time Dashboards
- Live metrics (15-30s refresh)
- Daily summaries
- Monthly analytics
- Materialized views for performance
- Drill-down capabilities

### 7. Ads System
- Interstitial ads for gate pass unlock
- Banner and minicard ads
- Event tracking and analytics
- Revenue optimization

## Data Model

### Core Entities

#### Users & Students
- `users`: System users with roles
- `students`: Student-specific information
- `hostels`: Hostel information
- `blocks`: Hostel blocks
- `rooms`: Individual rooms

#### Gate Pass System
- `gate_passes`: Gate pass requests
- `gate_events`: Entry/exit events
- `devices`: Scanner devices

#### Attendance System
- `attendance_sessions`: Attendance sessions
- `attendance_roster`: Student roster per session
- `attendance_checks`: Individual attendance records

#### Meals System
- `meal_intents`: Student meal preferences
- `meal_overrides`: Administrative overrides

#### Analytics
- `ads`: Advertisement content
- `ad_events`: Ad interaction tracking
- `audit_events`: System audit trail

### Materialized Views

#### Performance Optimization
- `mv_hostel_live`: Real-time hostel metrics
- `mv_attendance_session`: Session summaries
- `mv_gate_funnel_day`: Daily gate pass analytics
- `mv_meal_forecast_day`: Meal forecasting data
- `mv_room_occupancy_day`: Room occupancy metrics
- `mv_monthly_analytics`: Monthly aggregated data

## API Design

### RESTful Endpoints

#### Authentication
- `POST /auth/login` - User login
- `POST /auth/refresh` - Refresh access token
- `GET /auth/me` - Get current user profile
- `POST /auth/logout` - User logout

#### Gate Pass
- `POST /gate-pass` - Create gate pass request
- `GET /gate-pass` - List gate passes
- `PATCH /gate-pass/:id/approve` - Approve/reject gate pass
- `GET /gate-pass/:id/qr` - Get QR token
- `POST /gate/scan` - Scan gate pass

#### Attendance
- `POST /attendance/sessions` - Create attendance session
- `GET /attendance/sessions/:id/roster` - Get session roster
- `POST /attendance/scan` - Scan attendance QR
- `POST /attendance/manual` - Manual attendance entry
- `GET /attendance/sessions/:id/summary` - Session summary

#### Meals
- `POST /meals/intents/open` - Open meal intents
- `POST /meals/intent/day` - Set daily intents
- `PATCH /meals/intent` - Update single intent
- `GET /meals/forecast` - Get meal forecast
- `POST /meals/override` - Create meal override

#### Dashboards
- `GET /dash/hostel-live` - Live hostel metrics
- `GET /dash/attendance/session/:id` - Session summary
- `GET /dash/gate/funnel` - Gate pass funnel
- `GET /dash/meals/forecast` - Meal forecast
- `GET /dash/monthly` - Monthly analytics

#### Ads
- `GET /ads/eligible?module=gatepass` - Get eligible ad
- `POST /ads/event` - Log ad event

### Response Format

All API responses follow a consistent format:

```json
{
  "success": true,
  "data": { ... },
  "message": "Optional message",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

Error responses:

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

## Security Considerations

### Authentication & Authorization
- JWT tokens with 15-minute expiry
- Refresh tokens with 7-day expiry
- Role-based access control
- Device token management for scanners

### Data Protection
- Field-level encryption for PII
- Comprehensive audit logging
- Rate limiting (100 requests/minute)
- Input validation and sanitization

### Compliance
- DPDP (Digital Personal Data Protection) compliance
- Non-biometric alternatives always available
- Data retention policies
- User consent management

## Performance Targets

### API Performance
- p95 API response time ≤ 300ms
- Scan verification ≤ 250ms
- Live dashboard API ≤ 200ms

### Database Performance
- Materialized views refreshed every 15-30s (live)
- Daily views refreshed every 5 minutes
- Monthly views refreshed hourly
- Partitioned tables for high-volume data

### Offline Capabilities
- Local SQLite queue for attendance scans
- FIFO sync with server deduplication
- Offline-first architecture for scanners

## Deployment Architecture

### Development Environment
- Docker Compose for local development
- GitHub Codespaces for cloud development
- Hot reload for both API and mobile app

### Production Environment
- Containerized deployment (Docker)
- Horizontal scaling capability
- Load balancing and health checks
- Automated backups and monitoring

## Monitoring & Observability

### Health Checks
- API health endpoint (`/health`)
- Database connectivity monitoring
- Redis connectivity monitoring
- External service dependencies

### Logging
- Structured logging with timestamps
- Request/response logging
- Error tracking and alerting
- Performance metrics collection

### Analytics
- User behavior tracking
- Feature usage analytics
- Performance metrics
- Business intelligence dashboards

## Future Enhancements

### Planned Features
- Real-time notifications (WebSocket)
- Advanced reporting and analytics
- Mobile app push notifications
- Integration with external systems
- Multi-hostel support
- Advanced room management features

### Scalability Considerations
- Microservices architecture migration
- Event-driven architecture
- Caching strategies
- Database sharding
- CDN integration for static assets

## Development Guidelines

### Code Quality
- TypeScript strict mode for API
- Dart null-safety for mobile app
- Unit tests with >80% coverage
- Contract tests for API schemas
- Conventional commits
- Lint-clean code

### Testing Strategy
- Unit tests for business logic
- Integration tests for API endpoints
- E2E tests for critical user flows
- Performance tests for bottlenecks
- Security tests for vulnerabilities

### Documentation
- API documentation (Swagger)
- Database schema documentation
- Architecture decision records
- Deployment guides
- User manuals
