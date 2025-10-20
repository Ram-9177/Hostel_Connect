# HostelConnect - Production-Ready Hostel Management System

A comprehensive monorepo for single-college hostel management with role-based access control, real-time dashboards, and offline-capable attendance scanning.

## 🏗️ Architecture Overview

- **Mobile**: Flutter app with role-aware navigation (Student, Warden, Warden Head, Super Admin, Chef)
- **Backend**: NestJS API with PostgreSQL, Redis, and Socket.IO
- **Infrastructure**: Docker-ready with GitHub Actions CI/CD
- **Performance**: p95 API ≤ 300ms, scan verify ≤ 250ms, live dashboard ≤ 200ms

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- Flutter 3.16+
- PostgreSQL 15+
- Redis 7+

### Development Setup

1. **Clone and setup**:
   ```bash
   git clone <repo-url>
   cd hostelconnect
   ```

2. **Backend setup**:
   ```bash
   cd api
   npm install
   cp .env.example .env
   # Configure database and Redis URLs
   npm run migration:run
   npm run seed
   npm run start:dev
   ```

3. **Mobile setup**:
   ```bash
   cd mobile
   flutter pub get
   flutter run
   ```

### Using Codespaces
Click "Code" → "Codespaces" → "Create codespace" for instant development environment.

## 📁 Monorepo Structure

```
hostelconnect/
├── mobile/                 # Flutter app
├── api/                    # NestJS backend
├── docs/                   # Architecture & API docs
├── infra/                  # Docker & deployment configs
├── ads/creatives/          # Ad assets & metadata
├── .github/               # GitHub workflows & templates
└── .devcontainer/         # Codespaces configuration
```

## 🔐 Roles & Permissions

- **Super Admin**: Full system access, monthly analytics
- **Warden Head**: Policy management, meal overrides, room allocations
- **Warden**: Gate pass approvals, attendance sessions, room management
- **Student**: Gate pass requests, meal intents, attendance scanning
- **Chef**: Meal forecast board, kitchen management

## 🎯 Core Modules

### Gate Pass Management
- Request → Approve/Reject workflow
- 20s interstitial ad unlock
- Emergency bypass option
- Real-time gate scanning

### Night Attendance
- QR code scanning (Kiosk/Warden modes)
- Manual fallback with reason tracking
- Hybrid session support
- Late scan adjustments

### Meals Management
- Daily intent collection (20:00 IST cutoff)
- Chef forecast board
- Override capabilities
- Diet preference tracking

### Room Management
- Live occupancy map
- Transfer/swap requests
- Damage tracking
- Allocation analytics

### Real-time Dashboards
- Live metrics (15-30s refresh)
- Daily summaries
- Monthly analytics
- Drill-down capabilities

## 🛠️ Development

### API Development
```bash
cd api
npm run test              # Run tests
npm run test:e2e         # E2E tests
npm run lint             # Lint check
npm run migration:run    # Run migrations
```

### Mobile Development
```bash
cd mobile
flutter test             # Run tests
flutter analyze         # Static analysis
flutter build apk       # Build Android
```

## 📊 Performance Targets

- **API Response**: p95 ≤ 300ms
- **Scan Verification**: ≤ 250ms
- **Live Dashboard**: ≤ 200ms
- **Offline Sync**: FIFO queue with deduplication

## 🔒 Security Features

- JWT + refresh token authentication
- Device token management for scanners
- Rate limiting and field encryption
- Comprehensive audit logging
- DPDP compliance

## 📈 Monitoring & Analytics

- Real-time dashboards with IST timestamps
- Materialized views for performance
- Audit trail for all operations
- Performance metrics tracking

## 🤝 Contributing

1. Follow conventional commits
2. Ensure tests pass
3. Update documentation
4. Use GitHub Projects for task tracking

## 📄 License

Private repository - All rights reserved.

---

**Built with ❤️ for efficient hostel management**
