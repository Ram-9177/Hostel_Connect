# HostelConnect Mobile App Runbook

## 📱 Mobile App Operations Guide

### Building the App

#### Debug Build
```bash
cd hostelconnect/mobile
flutter clean
flutter pub get
flutter build apk --debug
```

#### Release Build
```bash
cd hostelconnect/mobile
flutter clean
flutter pub get
flutter build apk --release
flutter build appbundle --release
```

### Running the App

#### Android Emulator
```bash
flutter emulators --launch Pixel_7_API_34
flutter run -d emulator-5554
```

#### Physical Device
```bash
flutter devices
flutter run -d <device-id>
```

### App Configuration

#### Environment Settings
- **Development:** `http://10.0.2.2:3000/api/v1`
- **Production:** `https://your-api-domain.com/api/v1`
- **Debug Logging:** Enabled in development

#### Permissions
- **Camera:** For QR scanning and photo upload
- **Storage:** For CSV export/import
- **Internet:** For API communication
- **Notifications:** For push notifications

### User Roles & Access

#### Student
- Gate pass requests
- Meal preferences
- Room information
- Notice reading
- Attendance viewing

#### Warden
- Gate pass approvals
- Attendance management
- Room allocation
- Student management
- QR scanning

#### Warden Head
- Policy management
- Meal overrides
- Notice broadcasting
- Dashboard analytics

#### Super Admin
- System administration
- User management
- Hostel structure
- Comprehensive reports

#### Chef
- Meal forecasting
- Menu management
- Inventory tracking
- Feedback analysis

### Key Features

#### Authentication
- Secure login with JWT tokens
- Session persistence
- Silent token refresh
- Role-based access control

#### Gate Pass System
- Request gate passes
- QR code generation (with ad requirement)
- QR scanning for entry/exit
- Approval workflow

#### Attendance Management
- KIOSK mode for self-service
- WARDEN mode for staff management
- HYBRID mode for flexible operation
- Manual marking with reasons
- Photo upload support

#### Room Management
- Room allocation
- Student transfers
- Bed swapping
- Vacancy management
- CSV import/export

#### Meal Management
- Daily meal preferences
- 20:00 IST cutoff
- Forecast calculation
- Chef board management

#### Notices & Communication
- Push notifications
- Inbox management
- Read receipts
- Offline queue support

### Troubleshooting

#### Common Issues

1. **"Unable to connect to server"**
   - Check API server is running
   - Verify network connectivity
   - Check emulator networking (10.0.2.2:3000)

2. **App crashes on login**
   - Check API response format
   - Verify null-safe parsing
   - Check token storage

3. **QR scanner not working**
   - Check camera permissions
   - Verify QR code format
   - Test with valid tokens

4. **Build errors**
   - Run `flutter clean`
   - Run `flutter pub get`
   - Check dependencies

#### Performance Issues

1. **Slow app startup**
   - Check network connectivity
   - Verify API response time
   - Check token validation

2. **Memory issues**
   - Monitor memory usage
   - Check for memory leaks
   - Optimize image loading

### Security Features

#### Data Protection
- Secure token storage
- Encrypted local data
- Secure API communication
- PII protection

#### Access Control
- Role-based permissions
- Session management
- Token rotation
- Secure logout

### Monitoring & Analytics

#### App Analytics
- User engagement tracking
- Feature usage statistics
- Performance metrics
- Error reporting

#### Ad Analytics
- Impression tracking
- Completion rates
- Skip rates
- Module-specific metrics

### Deployment

#### Android
- Generate signed APK
- Upload to Play Store
- Configure app signing
- Set up app updates

#### iOS (Future)
- Configure iOS project
- Set up app signing
- Upload to App Store
- Configure push notifications

### Maintenance

#### Regular Updates
- Security patches
- Feature updates
- Performance improvements
- Bug fixes

#### Data Backup
- User data backup
- Configuration backup
- Analytics data backup
- Recovery procedures
