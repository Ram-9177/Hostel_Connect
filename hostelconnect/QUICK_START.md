# HostelConnect - Quick Start Guide

## 🚀 Complete Setup & Run Instructions

### Prerequisites
- Node.js 18+ installed
- Flutter 3.0+ installed
- Android Studio with at least one AVD created
- PostgreSQL database (or Docker for quick setup)

---

## Option 1: Automated Scripts (Recommended)

### Start Everything at Once
```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"
./scripts/start-all.sh
```

### Or Start Individually

**1. Start Emulator:**
```bash
./scripts/start-emulator.sh
```

**2. Start Backend (in another terminal):**
```bash
./scripts/start-backend.sh
```

**3. Start Mobile App:**
```bash
./scripts/start-mobile.sh
```

---

## Option 2: Manual Setup

### Step 1: Backend Setup

```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"

# Clean install (IMPORTANT: Use npm install, NOT npm ci)
rm -rf node_modules package-lock.json
npm install --no-optional

# Build
npm run build

# Run migrations
npm run migration:run

# Start server
npm run start:prod
```

### Step 2: Start Android Emulator

```bash
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"

# List available emulators
emulator -list-avds

# Start your emulator (replace with your AVD name)
emulator -avd "Your_AVD_Name" -netdelay none -netspeed full
```

### Step 3: Run Mobile App

```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/mobile"

# Get dependencies
flutter pub get

# Check devices
flutter devices

# Run app
flutter run
```

---

## 🔧 Environment Variables

Create `.env` file in `hostelconnect/` directory:

```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=your_password
DB_NAME=hostelconnect

# JWT
JWT_SECRET=your-super-secret-jwt-key-change-in-production
JWT_EXPIRATION=15m
JWT_REFRESH_EXPIRATION=7d

# Email (for verification)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
FROM_EMAIL=noreply@hostelconnect.com
APP_URL=http://localhost:3000

# Server
PORT=3000
NODE_ENV=production
```

---

## ✅ Verification Steps

1. **Backend Health Check:**
   ```bash
   curl http://localhost:3000/health
   ```

2. **Check Email Verification:**
   - Sign up with a real email
   - Check inbox for verification link
   - Login is blocked until email is verified

3. **Test Login:**
   - Use verified credentials
   - Should redirect to role-based dashboard

---

## 🐛 Troubleshooting

### Backend won't install (bcrypt error)
**Solution:** This is fixed! We use `bcryptjs` (pure JS) instead of native `bcrypt`. Just run:
```bash
rm -rf node_modules package-lock.json
npm install --no-optional
```

### Emulator not found
**Solution:** 
1. Open Android Studio
2. Tools → Device Manager
3. Create a new AVD
4. Use that AVD name in scripts

### Port 3000 already in use
**Solution:**
```bash
# Kill process on port 3000
lsof -ti:3000 | xargs kill -9

# Or change PORT in .env
```

---

## 📱 Features Implemented

✅ Email verification on signup  
✅ Real authentication (no demo credentials)  
✅ Role-based dashboards  
✅ Gate pass management  
✅ Attendance tracking  
✅ Meal intents  
✅ Modern UI with skeleton loaders  
✅ Performance optimizations  

---

## 📞 Support

For issues, check logs:
- Backend: `hostelconnect/logs/backend.log`
- Mobile: Flutter console output

---

**Happy Coding! 🎉**

