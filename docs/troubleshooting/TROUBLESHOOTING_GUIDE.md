# HostelConnect Troubleshooting Guide

## 🚨 Common Issues & Solutions

This guide covers the most common issues users encounter with HostelConnect and provides step-by-step solutions.

## 🔐 Authentication Issues

### Issue: Cannot Login
**Symptoms:**
- Login button doesn't respond
- "Invalid credentials" error
- App crashes on login attempt

**Solutions:**

1. **Check Credentials**
   ```bash
   # Verify demo credentials
   Student: student@demo.com / password123
   Warden: warden@demo.com / password123
   Chef: chef@demo.com / password123
   Admin: admin@demo.com / password123
   ```

2. **Check API Server**
   ```bash
   # Verify API is running
   curl http://localhost:3000/api/v1/health
   
   # Expected response
   {"status": "ok", "timestamp": "2024-01-01T10:00:00Z"}
   ```

3. **Check Network Connection**
   ```bash
   # Test connectivity
   ping localhost
   telnet localhost 3000
   ```

4. **Clear App Data**
   ```bash
   # Android
   adb shell pm clear com.example.hostelconnect
   
   # iOS
   # Delete and reinstall app
   ```

### Issue: Token Expired
**Symptoms:**
- "Unauthorized" error
- App redirects to login
- API calls fail with 401

**Solutions:**

1. **Check Token Validity**
   ```bash
   # Decode JWT token
   echo "your-token" | base64 -d
   ```

2. **Refresh Token**
   ```bash
   # Use refresh endpoint
   curl -X POST http://localhost:3000/api/v1/auth/refresh \
     -H "Content-Type: application/json" \
     -d '{"refreshToken": "your-refresh-token"}'
   ```

3. **Re-login**
   - Logout and login again
   - Check if credentials are correct

## 🌐 Network Issues

### Issue: Cannot Connect to Server
**Symptoms:**
- "Unable to connect to server" error
- Network timeout
- API calls fail

**Solutions:**

1. **Check API Server Status**
   ```bash
   # Check if server is running
   ps aux | grep node
   
   # Check port availability
   netstat -an | grep 3000
   ```

2. **Start API Server**
   ```bash
   cd hostelconnect/api
   node test-server.js
   ```

3. **Check Firewall**
   ```bash
   # macOS
   sudo pfctl -sr | grep 3000
   
   # Linux
   sudo ufw status
   ```

4. **Test Connectivity**
   ```bash
   # Test from emulator
   adb shell ping 10.0.2.2
   
   # Test API endpoint
   curl http://10.0.2.2:3000/api/v1/health
   ```

### Issue: CORS Errors
**Symptoms:**
- "CORS policy" error in browser
- Cross-origin request blocked
- API calls fail from web

**Solutions:**

1. **Check CORS Configuration**
   ```javascript
   // In test-server.js
   app.use(cors({
     origin: true,  // Allow all origins in dev
     credentials: true
   }));
   ```

2. **Test CORS**
   ```bash
   # Test preflight request
   curl -X OPTIONS http://localhost:3000/api/v1/auth/login \
     -H "Origin: http://localhost:3000" \
     -H "Access-Control-Request-Method: POST"
   ```

## 📱 Mobile App Issues

### Issue: App Crashes on Startup
**Symptoms:**
- App closes immediately
- White screen
- Error messages in console

**Solutions:**

1. **Check Flutter Console**
   ```bash
   flutter logs
   ```

2. **Check Dependencies**
   ```bash
   cd hostelconnect/mobile
   flutter pub get
   flutter pub deps
   ```

3. **Clean and Rebuild**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

4. **Check Device Compatibility**
   ```bash
   # Check Flutter doctor
   flutter doctor
   
   # Check device info
   flutter devices
   ```

### Issue: Build Failures
**Symptoms:**
- Build errors during compilation
- Missing dependencies
- Version conflicts

**Solutions:**

1. **Check Flutter Version**
   ```bash
   flutter --version
   # Should be 3.0.0 or higher
   ```

2. **Update Dependencies**
   ```bash
   flutter pub upgrade
   ```

3. **Check pubspec.yaml**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     dio: ^5.0.0
     flutter_riverpod: ^2.0.0
     go_router: ^10.0.0
   ```

4. **Clean Build**
   ```bash
   flutter clean
   flutter pub get
   flutter build apk --debug
   ```

### Issue: Navigation Problems
**Symptoms:**
- Routes not working
- Navigation errors
- Page not found

**Solutions:**

1. **Check Route Definitions**
   ```dart
   // In main.dart
   GoRoute(
     path: '/student-home',
     builder: (context, state) => const StudentHomePage(),
   ),
   ```

2. **Check Navigation Calls**
   ```dart
   // Correct navigation
   context.go('/student-home');
   
   // Check if route exists
   final router = GoRouter.of(context);
   ```

3. **Debug Routes**
   ```dart
   // Add debug logging
   GoRouter(
     debugLogDiagnostics: true,
     routes: [...],
   );
   ```

## 🗄️ Database Issues

### Issue: Database Connection Failed
**Symptoms:**
- "Database connection error"
- SQLite errors
- Data not persisting

**Solutions:**

1. **Check Database File**
   ```bash
   # Check if database exists
   ls -la hostelconnect/api/database.sqlite
   
   # Check permissions
   chmod 644 hostelconnect/api/database.sqlite
   ```

2. **Recreate Database**
   ```bash
   cd hostelconnect/api
   rm database.sqlite
   npm run db:create
   npm run db:migrate
   npm run db:seed
   ```

3. **Check Database Schema**
   ```sql
   -- Connect to database
   sqlite3 database.sqlite
   
   -- Check tables
   .tables
   
   -- Check schema
   .schema users
   ```

### Issue: Data Not Loading
**Symptoms:**
- Empty lists
- "No data" messages
- API returns empty responses

**Solutions:**

1. **Check API Response**
   ```bash
   # Test API endpoint
   curl http://localhost:3000/api/v1/users
   
   # Check response format
   curl -H "Authorization: Bearer your-token" \
     http://localhost:3000/api/v1/users
   ```

2. **Check Data Seeding**
   ```bash
   # Seed demo data
   npm run db:seed
   ```

3. **Verify Data**
   ```sql
   -- Check if data exists
   SELECT COUNT(*) FROM users;
   SELECT * FROM users LIMIT 5;
   ```

## 🔍 QR Code Issues

### Issue: QR Code Not Scanning
**Symptoms:**
- Camera doesn't focus
- QR code not recognized
- Scan fails

**Solutions:**

1. **Check Camera Permissions**
   ```xml
   <!-- AndroidManifest.xml -->
   <uses-permission android:name="android.permission.CAMERA" />
   ```

2. **Test QR Code**
   ```bash
   # Generate test QR code
   echo "test-data" | qrencode -o test.png
   ```

3. **Check QR Code Validity**
   ```bash
   # QR codes expire in 30 seconds
   # Check timestamp in token
   ```

4. **Improve Scanning**
   - Ensure good lighting
   - Hold phone steady
   - Clean camera lens
   - Try different angles

### Issue: QR Code Expired
**Symptoms:**
- "QR code expired" error
- Scan fails immediately
- Token validation fails

**Solutions:**

1. **Check Token Expiry**
   ```javascript
   // QR tokens have 30-second TTL
   const now = Date.now();
   const tokenTime = decodedToken.iat * 1000;
   const isValid = (now - tokenTime) < 30000;
   ```

2. **Regenerate QR Code**
   ```bash
   # Request new QR code
   curl -X POST http://localhost:3000/api/v1/gate-pass/123/qr \
     -H "Authorization: Bearer your-token"
   ```

## 📊 Performance Issues

### Issue: Slow App Performance
**Symptoms:**
- App feels sluggish
- Long loading times
- UI freezes

**Solutions:**

1. **Check Memory Usage**
   ```bash
   # Android
   adb shell dumpsys meminfo com.example.hostelconnect
   ```

2. **Optimize Images**
   ```dart
   // Use appropriate image sizes
   Image.asset(
     'assets/images/logo.png',
     width: 100,
     height: 100,
   )
   ```

3. **Check Network Requests**
   ```dart
   // Add request timeout
   dio.options.connectTimeout = Duration(seconds: 30);
   dio.options.receiveTimeout = Duration(seconds: 30);
   ```

### Issue: High Battery Usage
**Symptoms:**
- Battery drains quickly
- App uses excessive CPU
- Device heats up

**Solutions:**

1. **Check Background Tasks**
   ```dart
   // Disable unnecessary background tasks
   // Use efficient state management
   ```

2. **Optimize Network Calls**
   ```dart
   // Cache API responses
   // Use pagination for large lists
   ```

3. **Check Location Services**
   ```dart
   // Disable if not needed
   // Use efficient location updates
   ```

## 🔧 Development Issues

### Issue: Hot Reload Not Working
**Symptoms:**
- Changes not reflected
- App doesn't update
- Hot reload fails

**Solutions:**

1. **Restart Development Server**
   ```bash
   # Stop current session
   Ctrl+C
   
   # Restart
   flutter run
   ```

2. **Check File Changes**
   ```bash
   # Ensure files are saved
   # Check for syntax errors
   ```

3. **Use Hot Restart**
   ```bash
   # Press 'R' in terminal
   # Or use VS Code hot restart
   ```

### Issue: Dependencies Conflicts
**Symptoms:**
- Version conflicts
- Build errors
- Package not found

**Solutions:**

1. **Check pubspec.yaml**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     dio: ^5.0.0
     # Avoid version conflicts
   ```

2. **Clean Dependencies**
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Check Flutter Version**
   ```bash
   flutter --version
   # Ensure compatibility
   ```

## 🚨 Emergency Procedures

### Issue: Complete System Failure
**Symptoms:**
- App won't start
- API completely down
- Database corrupted

**Solutions:**

1. **Restart Everything**
   ```bash
   # Stop all processes
   pkill -f node
   pkill -f flutter
   
   # Restart API
   cd hostelconnect/api
   node test-server.js
   
   # Restart Flutter
   cd hostelconnect/mobile
   flutter run
   ```

2. **Reset to Default State**
   ```bash
   # Reset database
   rm hostelconnect/api/database.sqlite
   npm run db:create
   npm run db:migrate
   npm run db:seed
   
   # Reset Flutter
   flutter clean
   flutter pub get
   ```

3. **Check System Resources**
   ```bash
   # Check disk space
   df -h
   
   # Check memory
   free -h
   
   # Check processes
   top
   ```

## 📞 Getting Help

### Self-Service Options
1. **Check Documentation**
   - User Guide
   - API Documentation
   - Deployment Guide

2. **Search Issues**
   - GitHub Issues
   - Stack Overflow
   - Flutter Documentation

3. **Community Support**
   - Flutter Discord
   - GitHub Discussions
   - Stack Overflow

### Contact Support
- **Email:** support@hostelconnect.com
- **Phone:** +1-800-HOSTEL-1
- **In-App:** Use feedback form
- **GitHub:** Create issue

### When Contacting Support
Include:
- **Error Messages** - Exact error text
- **Steps to Reproduce** - What you were doing
- **Device Information** - OS, version, model
- **Screenshots** - Visual evidence
- **Logs** - Console output

## 🔍 Debugging Tools

### Flutter Debugging
```bash
# Enable debug logging
flutter run --verbose

# Check device logs
flutter logs

# Profile performance
flutter run --profile
```

### API Debugging
```bash
# Enable debug mode
NODE_ENV=development node test-server.js

# Check API logs
tail -f api.log

# Test endpoints
curl -v http://localhost:3000/api/v1/health
```

### Network Debugging
```bash
# Check network connectivity
ping localhost
telnet localhost 3000

# Monitor network traffic
netstat -an | grep 3000
```

---

**This troubleshooting guide covers the most common issues. For additional support, contact our help desk or create a GitHub issue.**
