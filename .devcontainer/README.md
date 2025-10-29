# 🚀 GitHub Codespaces Setup - HostelConnect

## Quick Start with Codespaces

### 1. Open in Codespaces

Click the button to create a new Codespace:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Ram-9177/Hostel_Connect)

### 2. Wait for Setup

The setup script will automatically:
- ✅ Install all dependencies (Node.js, Flutter, etc.)
- ✅ Build the API
- ✅ Set up environment variables
- ✅ Configure shell aliases
- ✅ Start PostgreSQL and Redis

**Estimated time:** 3-5 minutes

### 3. Start Development

Once setup is complete, you can start any service:

```bash
# Start the backend API
api-start

# Start the web app
web-start

# Start Flutter web app
flutter-web
```

---

## 📦 What's Included

### Pre-installed Tools
- **Node.js 20** - JavaScript runtime
- **Flutter** - Mobile development framework
- **PostgreSQL 15** - Database
- **Redis 7** - Caching layer
- **GitHub CLI** - GitHub integration
- **Docker** - Container support
- **Zsh + Oh My Zsh** - Enhanced shell

### VS Code Extensions
- ESLint & Prettier (code formatting)
- GitLens (Git superpowers)
- Docker & Docker Compose
- Thunder Client (API testing)
- Flutter & Dart support
- PostgreSQL client
- Redis client
- TODO Tree
- Error Lens
- Markdown support

---

## 🎯 Available Services

| Service | Port | URL | Description |
|---------|------|-----|-------------|
| API (NestJS) | 3000 | http://localhost:3000 | Backend REST API |
| API Docs (Swagger) | 3000 | http://localhost:3000/api | Interactive API documentation |
| Web App (React) | 5173 | http://localhost:5173 | Frontend web application |
| Flutter Web | 8080 | http://localhost:8080 | Mobile app (web version) |
| PostgreSQL | 5432 | localhost:5432 | Database |
| Redis | 6379 | localhost:6379 | Cache |
| Grafana | 3001 | http://localhost:3001 | Monitoring dashboards |
| Prometheus | 9090 | http://localhost:9090 | Metrics collector |

---

## 🛠️ Custom Aliases

The following aliases are pre-configured for convenience:

```bash
# Start services
api-start       # Start NestJS API in watch mode
web-start       # Start React web app (Vite)
flutter-web     # Start Flutter web app

# Database management
db-reset        # Reset database and run seeds

# View logs
logs-api        # View API container logs
logs-db         # View PostgreSQL logs
```

---

## 📂 Directory Structure

```
/workspace/
├── .devcontainer/          # Codespaces configuration
│   ├── devcontainer.json   # Main config
│   ├── setup.sh            # Initial setup script
│   └── startup.sh          # Startup script
├── hostelconnect/
│   ├── api/                # NestJS backend
│   ├── mobile/             # Flutter mobile app
│   └── docker-compose.yml  # Docker services
├── src/                    # React web app
├── .env                    # Environment variables
├── DEPLOYMENT_SUCCESS.md   # Deployment guide
└── FUTURE_ENHANCEMENTS.md  # Roadmap
```

---

## 🔧 Manual Setup (if needed)

If automatic setup fails, run these commands:

```bash
# 1. Install dependencies
npm ci
cd hostelconnect/api && npm ci && cd ../..

# 2. Build API
cd hostelconnect/api && npm run build && cd ../..

# 3. Set up environment
cp .env.example .env

# 4. Run migrations
cd hostelconnect/api
npm run migration:run
npm run seed
```

---

## 🧪 Testing the Setup

### Test the API
```bash
curl http://localhost:3000/api/v1/health
```

Expected response:
```json
{
  "success": true,
  "data": {
    "status": "healthy",
    "version": "1.0.0"
  }
}
```

### Test Web App
Open http://localhost:5173 in your browser

### Test Flutter Web
```bash
flutter-web
```
Then open http://localhost:8080

---

## 🐛 Troubleshooting

### PostgreSQL not starting
```bash
docker logs hostelconnect-postgres
docker restart hostelconnect-postgres
```

### API not responding
```bash
# Check if running
lsof -i :3000

# Restart API
api-start
```

### Flutter web build errors
```bash
cd hostelconnect/mobile
flutter clean
flutter pub get
flutter run -d chrome
```

### Port already in use
```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
kill -9 <PID>
```

---

## 💾 Database Management

### Run Migrations
```bash
cd hostelconnect/api
npm run migration:run
```

### Revert Last Migration
```bash
npm run migration:revert
```

### Seed Database
```bash
npm run seed
```

### Reset Everything
```bash
db-reset  # Uses alias
```

### Connect to PostgreSQL
```bash
# Using psql
psql postgresql://postgres:password@localhost:5432/hostelconnect

# Or use VS Code PostgreSQL extension
```

---

## 🔑 Environment Variables

The setup script creates `.env` files automatically. Edit them if needed:

### Root `.env`
```env
DATABASE_URL=postgresql://postgres:password@postgres:5432/hostelconnect
REDIS_URL=redis://redis:6379
JWT_SECRET=dev-secret-change-in-production
ALLOW_UNVERIFIED_LOGIN=true
NODE_ENV=development
```

### API `.env` (`hostelconnect/api/.env`)
Same as above, plus:
```env
PORT=3000
CORS_ORIGIN=http://localhost:5173,http://localhost:8080
```

---

## 📝 Development Workflow

### 1. Start Development
```bash
# Terminal 1: API
api-start

# Terminal 2: Web App
web-start

# Terminal 3: Flutter (optional)
flutter-web
```

### 2. Make Changes
- Edit code in VS Code
- API auto-reloads on save (watch mode)
- Web app hot-reloads on save (Vite HMR)
- Flutter hot-reloads on save

### 3. Test Changes
```bash
# API tests
cd hostelconnect/api
npm test

# E2E tests
npm run test:e2e
```

### 4. Commit & Push
```bash
git add .
git commit -m "feat: add new feature"
git push
```

---

## 🚀 Deployment from Codespaces

### Deploy API to Railway
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize project
railway init

# Deploy
railway up
```

### Build Mobile Apps
```bash
# Android APK
cd hostelconnect/mobile
flutter build apk --release

# iOS (requires macOS locally)
flutter build ipa --release
```

---

## 🎨 VS Code Tips

### Keyboard Shortcuts
- `Ctrl+P` - Quick file open
- `Ctrl+Shift+P` - Command palette
- `Ctrl+`` - Toggle terminal
- `Ctrl+B` - Toggle sidebar
- `Ctrl+/` - Toggle comment

### Useful Commands
- `>Thunder Client: New Request` - Test APIs
- `>Git Graph: View Git Graph` - Visualize commits
- `>PostgreSQL: New Query` - Run SQL queries
- `>Flutter: New Project` - Create Flutter project

### Recommended Workflow
1. Use **GitLens** to see who changed what
2. Use **Thunder Client** to test API endpoints
3. Use **Error Lens** to see errors inline
4. Use **TODO Tree** to track TODOs

---

## 📚 Documentation Links

- **API Documentation:** http://localhost:3000/api
- **Deployment Guide:** [DEPLOYMENT_SUCCESS.md](../DEPLOYMENT_SUCCESS.md)
- **Future Roadmap:** [FUTURE_ENHANCEMENTS.md](../FUTURE_ENHANCEMENTS.md)
- **GitHub Copilot Instructions:** [.github/copilot-instructions.md](../.github/copilot-instructions.md)

---

## 🤝 Collaboration

### Sharing Your Codespace
Codespaces are private by default. To share:
1. Click "Ports" tab
2. Right-click on port → Change Port Visibility
3. Choose "Public" or "Private"

### Live Share
Use VS Code Live Share extension for pair programming:
1. Click "Live Share" button (bottom status bar)
2. Share the link with your team
3. Collaborate in real-time

---

## 💡 Pro Tips

1. **Use Aliases:** Type `alias` to see all available shortcuts
2. **Split Terminal:** `Ctrl+Shift+5` to split terminal
3. **Multiple Cursors:** `Alt+Click` to place multiple cursors
4. **Format on Save:** Already enabled in settings
5. **Auto Imports:** TypeScript auto-imports are enabled
6. **Git Autofetch:** Git automatically fetches updates

---

## 🆘 Getting Help

- **GitHub Issues:** https://github.com/Ram-9177/Hostel_Connect/issues
- **Documentation:** Check `/workspace/docs/` folder
- **Logs:** Run `logs-api` or `logs-db`

---

## 🎉 You're All Set!

Your Codespace is fully configured for HostelConnect development.

**Happy Coding! 🚀**

---

**Last Updated:** October 29, 2025  
**Codespace Version:** 2.0
