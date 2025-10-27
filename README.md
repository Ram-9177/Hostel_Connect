# 🏠 HostelConnect - Complete Hostel Management Solution

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/hostelconnect/app)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/hostelconnect/app)

> **Production-ready hostel management system for students, wardens, and administrators**

## 🚀 Features

### 👨‍🎓 Student Features
- **Gate Pass Management** - Request and track outpasses
- **Attendance Tracking** - Mark daily attendance
- **Meal Preferences** - Set meal preferences and track consumption
- **Study Room Booking** - Reserve study spaces
- **Schedule Management** - View timetables and events
- **Notices & Updates** - Stay updated with hostel announcements
- **Profile Management** - Update personal information

### 👨‍🏫 Warden Features
- **Student Management** - Track student records and activities
- **Attendance Oversight** - Monitor attendance patterns
- **Room Management** - Manage room assignments and inspections
- **Gate Pass Approval** - Approve/reject outpass requests
- **Analytics Dashboard** - View comprehensive reports
- **Emergency Management** - Handle emergency requests

### 👨‍💼 Admin Features
- **Complete System Control** - Full administrative access
- **User Management** - Manage all user accounts and roles
- **System Configuration** - Configure hostel settings
- **Reports & Analytics** - Generate detailed reports
- **Security Management** - Monitor security activities

## 🛠️ Technology Stack

### Frontend
- **React 18** - Modern UI framework
- **TypeScript** - Type-safe development
- **Vite** - Fast build tool
- **Tailwind CSS** - Utility-first CSS framework
- **Radix UI** - Accessible component library
- **Framer Motion** - Smooth animations

### Backend
- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **JWT** - Authentication tokens
- **bcrypt** - Password hashing
- **SQLite** - Database (development)
- **PostgreSQL** - Database (production)

### Mobile
- **Flutter** - Cross-platform mobile development
- **Dart** - Programming language
- **Riverpod** - State management
- **Go Router** - Navigation

## 📱 Installation & Setup

### Prerequisites
- Node.js 18+ 
- npm 8+
- Flutter 3.0+ (for mobile)
- Git

### Web Application

```bash
# Clone the repository
git clone https://github.com/hostelconnect/app.git
cd app

# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

### Mobile Application

```bash
# Navigate to mobile directory
cd hostelconnect/mobile

# Install Flutter dependencies
flutter pub get

# Run on Android
flutter run

# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## 🌐 Deployment

### Web Deployment (Vercel/Netlify)

```bash
# Build the application
npm run build

# Deploy to Vercel
vercel --prod

# Deploy to Netlify
netlify deploy --prod --dir=build
```

### Mobile Deployment (Play Store/App Store)

```bash
# Build release APK
flutter build apk --release

# Build release AAB (recommended for Play Store)
flutter build appbundle --release

# Upload to Play Console
# Follow Google Play Console instructions
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# API Configuration
VITE_API_BASE_URL=https://api.hostelconnect.app
VITE_APP_NAME=HostelConnect
VITE_APP_VERSION=1.0.0

# Authentication
JWT_SECRET=your_jwt_secret_key
JWT_REFRESH_SECRET=your_refresh_secret_key

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/hostelconnect
```

### Mobile Configuration

Update `lib/core/network/api_config.dart`:

```dart
class ApiConfig {
  static const String baseUrl = 'https://api.hostelconnect.app/api/v1';
  static const Duration timeout = Duration(seconds: 30);
}
```

## 📊 API Endpoints

### Authentication
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/refresh` - Refresh token
- `GET /api/v1/auth/profile` - Get user profile

### Student Features
- `GET /api/v1/students/gatepasses` - Get gate passes
- `POST /api/v1/students/gatepasses` - Create gate pass
- `GET /api/v1/students/attendance` - Get attendance
- `POST /api/v1/students/attendance` - Mark attendance

### Warden Features
- `GET /api/v1/warden/students` - Get all students
- `GET /api/v1/warden/gatepasses` - Get pending gate passes
- `PUT /api/v1/warden/gatepasses/:id` - Approve/reject gate pass

## 🎨 UI/UX Features

- **Responsive Design** - Works on all screen sizes
- **Dark/Light Mode** - Theme switching
- **Accessibility** - WCAG 2.1 compliant
- **Animations** - Smooth transitions and micro-interactions
- **Offline Support** - Works without internet connection
- **PWA Ready** - Installable web app

## 🔒 Security Features

- **JWT Authentication** - Secure token-based auth
- **Password Hashing** - bcrypt encryption
- **CORS Protection** - Cross-origin request security
- **Input Validation** - Server-side validation
- **Rate Limiting** - API request throttling
- **HTTPS Only** - Secure connections

## 📈 Performance

- **Fast Loading** - Optimized bundle size
- **Lazy Loading** - Code splitting
- **Caching** - Smart caching strategies
- **CDN Ready** - Static asset optimization
- **Mobile Optimized** - Touch-friendly interface

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: [docs.hostelconnect.app](https://docs.hostelconnect.app)
- **Issues**: [GitHub Issues](https://github.com/hostelconnect/app/issues)
- **Email**: support@hostelconnect.app
- **Discord**: [HostelConnect Community](https://discord.gg/hostelconnect)

## 🏆 Production Ready

This application is production-ready and includes:

- ✅ Complete authentication system
- ✅ Real-time data synchronization
- ✅ Comprehensive error handling
- ✅ Security best practices
- ✅ Performance optimization
- ✅ Mobile responsiveness
- ✅ Accessibility compliance
- ✅ Deployment configurations

---

**Built with ❤️ by the HostelConnect Team**

*Transforming hostel management for the digital age*