# 🎉 HostelConnect Setup - Complete Guide

All code is **100% complete**! Follow these steps to get everything running.

## 🚀 Quick Start (Recommended)

```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"

# Step 1: Setup environment
./scripts/setup-env.sh
# Then edit .env with your credentials

# Step 2: Setup database (if using PostgreSQL)
./scripts/setup-database.sh

# Step 3: Start everything
./scripts/start-all.sh
```

---

## 📋 Manual Setup (Step-by-Step)

### Step 1: Environment Setup

```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"

# Create .env file
cp .env.example .env

# Edit .env with your settings:
nano .env  # or use your preferred editor
```

**Required in `.env`:**
- `DB_PASSWORD`: Your PostgreSQL password
- `JWT_SECRET`: Random secret (min 32 characters)
- `SMTP_USER`: Your email (for verification emails)
- `SMTP_PASS`: Your email app password (Gmail uses app passwords)

### Step 2: Database Setup

**Option A: PostgreSQL (Recommended)**
```bash
# Create database
createdb hostelconnect

# Or via psql
psql -U postgres
CREATE DATABASE hostelconnect;
\q
```

**Option B: SQLite (Development)**
- No setup needed - migrations will create the DB

### Step 3: Backend Installation & Start

```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"

# Clean install (fixes bcrypt issue)
rm -rf node_modules package-lock.json .npm
npm cache clean --force
npm install --no-optional --legacy-peer-deps

# Build
npm run build

# Run migrations
npm run migration:run

# Start server
npm run start:prod
```

**Backend runs on:** http://localhost:3000

### Step 4: Android Emulator

```bash
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"

# List available emulators
emulator -list-avds

# Start emulator (replace with your AVD name)
emulator -avd "Your_AVD_Name" -netdelay none -netspeed full
```

### Step 5: Mobile App

```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/mobile"

flutter pub get
flutter devices  # Should show your emulator
flutter run
```

---

## 🔧 Troubleshooting

### Backend npm install fails with bcrypt error

**The fix:**
```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"

# Nuclear clean
rm -rf node_modules package-lock.json .npm
rm -rf node_modules/bcrypt 2>/dev/null || true

# Force install bcryptjs
npm cache clean --force
npm install --no-optional --legacy-peer-deps

# Verify
npm ls bcryptjs
```

**Why this happens:** Spaces in path ("HostelConnect Mobile App") cause issues with native modules. We use `bcryptjs` (pure JS) to avoid this.

### Database connection fails

1. Check PostgreSQL is running: `pg_isready`
2. Verify credentials in `.env`
3. Ensure database exists: `psql -U postgres -l | grep hostelconnect`

### Email verification not working

1. Check SMTP credentials in `.env`
2. For Gmail: Use App Password (not regular password)
3. Test SMTP: Check backend logs for email errors

### Emulator not found

1. Open Android Studio
2. Tools → Device Manager
3. Create AVD if none exist
4. Use that name in scripts

---

## ✅ Verification Checklist

Once running, verify:

- [ ] Backend health: `curl http://localhost:3000/health`
- [ ] Sign up works
- [ ] Verification email received
- [ ] Can verify email via link
- [ ] Login works after verification
- [ ] Role-based dashboard loads correctly

---

## 📁 File Structure

```
hostelconnect/
├── .env                    # ⚠️ Create from .env.example
├── scripts/
│   ├── setup-env.sh       # Setup environment
│   ├── setup-database.sh  # Setup database
│   ├── start-backend.sh   # Start backend
│   ├── start-emulator.sh  # Start emulator
│   ├── start-mobile.sh    # Start Flutter app
│   └── start-all.sh       # Start everything
├── mobile/                 # Flutter app
└── api/                    # Backend API
```

---

## 🎯 What's Implemented

✅ Email verification (signup → email → verify → login)  
✅ Real authentication (no demo credentials)  
✅ Role-based access (Student, Warden, Chef, Admin)  
✅ Gate pass management  
✅ Attendance tracking  
✅ Meal intents  
✅ Modern UI with skeleton loaders  
✅ Performance optimizations  
✅ Clean, production-ready code  

---

## 🚨 Important Notes

1. **Never commit `.env`** - it contains secrets
2. **Change `JWT_SECRET`** in production
3. **Use strong passwords** for database
4. **Enable 2FA** for email account (required for app passwords)

---

**All code is complete! Just follow the setup steps above and you'll be running! 🚀**

