# HostelConnect - Complete Hostel Management System

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![NestJS](https://img.shields.io/badge/NestJS-E0234E?style=for-the-badge&logo=nestjs&logoColor=white)](https://nestjs.com/)
[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

A comprehensive hostel management system built with Flutter and NestJS, featuring role-based access control, real-time updates, and modern UI/UX.

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.0+)
- Node.js (16+)
- Android Studio / Xcode
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd HostelConnect
   ```

2. **Start the API Server**
   ```bash
   cd hostelconnect/api
   npm install
   node test-server.js
   ```

3. **Run the Flutter App**
   ```bash
   cd hostelconnect/mobile
   flutter pub get
   flutter run
   ```

## 🎯 Features

### Core Functionality
- **Authentication System** - JWT-based with role management
- **Role-Based Dashboards** - Student, Warden, Chef, Admin
- **Gate Pass Management** - Request, approval, and QR scanning
- **Attendance Tracking** - Manual and automated systems
- **Meal Management** - Menu planning and meal tracking
- **Room Allocation** - Bed management and room assignments
- **Notice Board** - Announcements and notifications
- **Reports & Analytics** - Comprehensive reporting system

### Technical Features
- **Real-time Updates** - Live data synchronization
- **Offline Support** - Queue operations when offline
- **Push Notifications** - FCM integration
- **File Uploads** - Profile pictures and documents
- **QR Code Scanning** - Gate pass verification
- **Multi-language Support** - English and Telugu

## 👥 User Roles

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

## 🔐 Demo Credentials

| Role | Email | Password |
|------|-------|----------|
| Student | student@demo.com | password123 |
| Warden | warden@demo.com | password123 |
| Chef | chef@demo.com | password123 |
| Admin | admin@demo.com | password123 |

## 🏗️ Architecture

### Backend (NestJS)
```
hostelconnect/api/
├── src/
│   ├── auth/           # Authentication module
│   ├── users/          # User management
│   ├── gate-pass/      # Gate pass system
│   ├── attendance/     # Attendance tracking
│   ├── meals/          # Meal management
│   ├── rooms/          # Room allocation
│   ├── notices/        # Notice board
│   └── reports/        # Analytics
├── test-server.js      # Development server
└── package.json
```

### Frontend (Flutter)
```
hostelconnect/mobile/
├── lib/
│   ├── core/           # Core functionality
│   │   ├── auth/       # Authentication
│   │   ├── api/        # API services
│   │   ├── models/     # Data models
│   │   └── network/    # HTTP client
│   ├── features/       # Feature modules
│   │   ├── gate_pass/  # Gate pass system
│   │   ├── attendance/ # Attendance tracking
│   │   ├── meals/      # Meal management
│   │   ├── rooms/      # Room management
│   │   ├── notices/    # Notice board
│   │   └── reports/    # Analytics
│   ├── shared/         # Shared components
│   │   ├── widgets/    # Reusable widgets
│   │   ├── theme/      # App theming
│   │   └── utils/      # Utilities
│   └── main.dart       # App entry point
└── pubspec.yaml
```

## 🎨 Design System

### Color Palette
- **Primary:** #1E88E5 (Blue)
- **Success:** #16A34A (Green)
- **Warning:** #F59E0B (Orange)
- **Error:** #DC2626 (Red)
- **Accent:** #FFB300 (Yellow)

### Typography
- **Headlines:** Bold, 32px
- **Titles:** Semi-bold, 22px
- **Body:** Regular, 16px
- **Captions:** Regular, 12px

### Components
- Material Design 3 components
- Consistent spacing (8px grid)
- Rounded corners (12px radius)
- Subtle shadows and elevations

## 🔧 Development

### API Development
```bash
cd hostelconnect/api
npm run start:dev    # Development mode
npm run build        # Production build
npm run test         # Run tests
```

### Flutter Development
```bash
cd hostelconnect/mobile
flutter run          # Run on device/emulator
flutter build apk    # Build Android APK
flutter build ios    # Build iOS app
flutter test         # Run tests
```

### Database
- **Development:** SQLite (local)
- **Production:** PostgreSQL (Docker)
- **Caching:** Redis (Docker)

## 🚀 Deployment

### Docker Setup
```bash
docker-compose up -d
```

### Azure Deployment
1. Configure Azure App Service
2. Set up PostgreSQL Flexible Server
3. Configure Redis Cache
4. Deploy using GitHub Actions

### Environment Variables
```env
# API Configuration
PORT=3000
NODE_ENV=production
DATABASE_URL=postgresql://...
REDIS_URL=redis://...

# JWT Configuration
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=24h

# FCM Configuration
FCM_SERVER_KEY=your-fcm-key
```

## 📱 Mobile App

### Android
- **Target SDK:** 34
- **Min SDK:** 21
- **Architecture:** ARM64, x86_64
- **Permissions:** Camera, Storage, Network

### iOS
- **Target:** iOS 12.0+
- **Architecture:** ARM64
- **Permissions:** Camera, Photo Library, Network

## 🔒 Security

### Authentication
- JWT tokens with rotation
- Secure storage for tokens
- Role-based access control
- Session management

### API Security
- CORS configuration
- Rate limiting
- Input validation
- SQL injection prevention
- XSS protection

### Mobile Security
- Certificate pinning
- Secure storage
- Biometric authentication
- App sandboxing

## 📊 Performance

### Backend
- **Response Time:** <300ms (p95)
- **Throughput:** 1000+ requests/second
- **Uptime:** 99.9% SLA
- **Caching:** Redis for hot data

### Frontend
- **App Size:** <50MB
- **Startup Time:** <3 seconds
- **Memory Usage:** <100MB
- **Battery:** Optimized for mobile

## 🧪 Testing

### Backend Tests
```bash
npm run test          # Unit tests
npm run test:e2e      # Integration tests
npm run test:cov      # Coverage report
```

### Frontend Tests
```bash
flutter test          # Unit tests
flutter test integration_test/  # Integration tests
flutter test --coverage        # Coverage report
```

## 📈 Monitoring

### Application Monitoring
- **Backend:** Application Insights
- **Frontend:** Sentry
- **Database:** Query performance
- **API:** Response times and errors

### Business Metrics
- **User Engagement:** Daily active users
- **Feature Usage:** Most used features
- **Performance:** App responsiveness
- **Errors:** Crash rates and bugs

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

### Code Style
- **Backend:** ESLint + Prettier
- **Frontend:** Dart analyzer
- **Commits:** Conventional commits
- **PRs:** Descriptive titles and descriptions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Documentation
- [API Documentation](docs/api/)
- [Mobile App Guide](docs/mobile/)
- [Deployment Guide](docs/deployment/)
- [Troubleshooting](docs/troubleshooting/)

### Contact
- **Email:** support@hostelconnect.com
- **Issues:** GitHub Issues
- **Discussions:** GitHub Discussions

## 🎉 Acknowledgments

- Flutter team for the amazing framework
- NestJS team for the robust backend
- Material Design for the design system
- Open source community for inspiration

---

**Built with ❤️ for better hostel management**