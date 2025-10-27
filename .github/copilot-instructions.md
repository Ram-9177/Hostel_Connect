# GitHub Copilot Instructions for HostelConnect

> **Last Updated:** October 23, 2025 | **AI Agent Guide for HostelConnect Development**

## 🏗️ Architecture Overview

HostelConnect is a **production-ready hostel management system** with three major layers:

### Technology Stack
- **Frontend:** React 18 + Vite + Tailwind CSS + Radix UI (Web)
- **Mobile:** Flutter 3.16+ with Riverpod state management (iOS/Android)
- **Backend:** NestJS 10 + PostgreSQL 15 + Redis + Socket.io (Real-time)
- **Infrastructure:** Docker Compose, Nginx, Prometheus/Grafana monitoring

### Data Flow Architecture
```
Mobile/Web Client 
  ↓ (REST API + WebSocket)
NestJS Backend (api/v1)
  ↓ 
PostgreSQL (Primary Data) + Redis (Cache/Sessions)
  ↓
File Storage (Uploads) + Firebase (Notifications)
```

### Core Domain Models (See `hostelconnect/src/students`, `hostelconnect/src/rooms`, etc.)
- **Students:** Registration, profiles, hostel assignments
- **Gate Passes:** QR-based entry/exit with approval workflow
- **Attendance:** QR scanning with real-time tracking
- **Meals:** Menu planning, preferences, feedback
- **Notices:** Role-based announcements with read receipts

---

## 📁 Directory Structure & Responsibilities

```
├── src/                           # React web app (Vite)
│   ├── components/                # Reusable UI components (BottomNav, GateSecurity, etc.)
│   ├── components/pages/          # Full-page views with role-based logic
│   ├── styles/                    # Global CSS (Tailwind + custom)
│   └── App.tsx                    # Main app shell, role router
│
├── hostelconnect/
│   ├── api/                       # NestJS backend
│   │   ├── src/
│   │   │   ├── auth/              # JWT, role-based access control
│   │   │   ├── students/          # Student entity, controllers, services
│   │   │   ├── gatepass/          # Gate pass workflow logic
│   │   │   ├── attendance/        # QR-based attendance tracking
│   │   │   ├── common/            # Shared utilities (Redis, logging, exceptions)
│   │   │   ├── notifications/     # Firebase push notifications
│   │   │   ├── database/          # TypeORM migrations, seeds
│   │   │   └── main.ts            # API bootstrap with Swagger docs
│   │   └── package.json
│   │
│   ├── mobile/                    # Flutter app
│   │   ├── lib/
│   │   │   ├── features/          # Feature modules (auth, gatepass, meals, etc.)
│   │   │   ├── core/              # Shared logic (error handling, networking, storage)
│   │   │   ├── shared/            # UI components, themes
│   │   │   └── main.dart          # App bootstrap with GoRouter
│   │   └── pubspec.yaml
│   │
│   ├── docker-compose.yml         # All services (API, PostgreSQL, Redis, etc.)
│   └── nginx.conf                 # Reverse proxy configuration
│
└── .devcontainer/                 # Dev environment (Dockerfile, docker-compose.yml)
```

---

## 🔑 Critical Patterns & Conventions

### 1. **NestJS Backend - Service Layer Pattern**
All business logic lives in `*.service.ts`. Controllers delegate to services.

**Example** (`hostelconnect/api/src/gatepass/gatepass.service.ts`):
```typescript
@Injectable()
export class GatePassService {
  constructor(
    private db: DataSource,
    private redis: RedisService,
    private logger: AppLoggerService,
  ) {}

  async approveGatePass(id: string, wardedBy: string): Promise<GatePass> {
    // 1. Validate gate pass exists and is pending
    const pass = await this.db.find(GatePass, { where: { id } });
    if (!pass) throw new NotFoundException('Gate pass not found');
    
    // 2. Update database (transactional)
    pass.status = 'APPROVED';
    pass.approvedBy = wardedBy;
    await this.db.save(pass);
    
    // 3. Invalidate cache and emit WebSocket event
    await this.redis.del(`gatepass:${id}`);
    this.socketGateway.notifyApproval(pass.studentId, pass);
    
    this.logger.log('GatePass approved', { id, wardedBy });
    return pass;
  }
}
```

**Key Conventions:**
- Wrap all async operations in try-catch
- Use custom exceptions (NotFoundException, ValidationException)
- Invalidate relevant Redis keys after mutations
- Emit WebSocket events for real-time features
- Log important operations with context

### 2. **React Components - Hooks & State Management**
Use React hooks + Tailwind for styling. Avoid inline styles.

**Example** (`src/components/GateSecurity.tsx`):
```tsx
const GateSecurity: React.FC = () => {
  const [isScanning, setIsScanning] = useState(false);
  const [scannedPass, setScannedPass] = useState<GatePass | null>(null);
  const [error, setError] = useState<string>('');

  const handleQRScan = useCallback(async (qrData: string) => {
    try {
      setError('');
      const pass = JSON.parse(qrData);
      const validated = await validateGatePass(pass);
      setScannedPass(validated);
      // Show success toast
      toast.success('Gate pass validated');
    } catch (err) {
      setError(err.message);
      toast.error(err.message);
    }
  }, []);

  return (
    <div className="flex flex-col gap-4">
      <QRScanner onScan={handleQRScan} />
      {error && <ErrorAlert message={error} />}
      {scannedPass && <PassDetails pass={scannedPass} />}
    </div>
  );
};
```

**Key Conventions:**
- Use TypeScript interfaces for all props and state
- Prefer useCallback for event handlers to prevent unnecessary re-renders
- Always show user feedback (toast, loading state) for async operations
- Wrap async in try-catch, show error UI
- Use semantic class names from Tailwind

### 3. **Flutter Mobile - Riverpod State Management**
All data flows through providers. No direct state modifications.

**Example** (`hostelconnect/mobile/lib/features/gatepass/providers.dart`):
```dart
final gatePassProvider = FutureProvider.family<GatePass, String>((ref, id) async {
  final api = ref.watch(gatePassApiProvider);
  return api.getGatePass(id);
});

class GatePassNotifier extends StateNotifier<AsyncValue<GatePass>> {
  final GatePassApi api;
  
  GatePassNotifier(this.api) : super(const AsyncValue.loading());

  Future<void> approvePass(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => api.approvePass(id));
  }
}

final gatePassNotifierProvider = StateNotifierProvider<GatePassNotifier, AsyncValue<GatePass>>(...);
```

**Key Conventions:**
- Use FutureProvider for read-only data
- Use StateNotifierProvider for mutable state
- Wrap async in AsyncValue.guard() to handle errors
- Never use setState() directly—update state through provider
- Use .when() pattern to render loading/error/data states

### 4. **Error Handling - Consistent Exception Flow**
All layers throw specific exceptions that bubble to UI.

**Backend** (`hostelconnect/api/src/common/filters/http-exception.filter.ts`):
```typescript
@Catch()
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse();
    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message = 'Internal server error';

    if (exception instanceof ValidationException) {
      status = HttpStatus.BAD_REQUEST;
      message = exception.message;
    } else if (exception instanceof UnauthorizedException) {
      status = HttpStatus.UNAUTHORIZED;
    }

    response.status(status).json({
      success: false,
      error: exception.name,
      message,
      statusCode: status,
    });
  }
}
```

**Frontend** (`src/components/ErrorBoundary.tsx`):
```tsx
try {
  await apiCall();
} catch (err) {
  if (err.status === 401) {
    // Redirect to login
  } else if (err.status === 400) {
    // Show validation errors
    toast.error(err.message);
  } else {
    // Generic error
    setError('Something went wrong');
  }
}
```

### 5. **Database Layer - TypeORM with Migrations**
All schema changes must use TypeORM migrations (see `hostelconnect/api/src/database/migrations/`).

**Create migration:**
```bash
cd hostelconnect/api
npm run migration:generate -- -n AddFieldToStudent
npm run migration:run
```

**Key Conventions:**
- Never modify entities directly—use migrations
- Always include rollback capability in migrations
- Use proper indexes on frequently queried columns
- Document schema changes in migration files

### 6. **Real-Time Features - WebSocket via Socket.io**
Gate pass approvals, notices, and attendance are real-time.

**Backend** (`hostelconnect/api/src/socket/socket.gateway.ts`):
```typescript
@WebSocketGateway()
export class SocketGateway {
  @SubscribeMessage('subscribe-gatepass')
  handleGatePassSubscribe(client: Socket, studentId: string) {
    client.join(`student:${studentId}`);
  }

  notifyApproval(studentId: string, pass: GatePass) {
    this.server.to(`student:${studentId}`).emit('gatepass-approved', pass);
  }
}
```

**Frontend** (`src/components/StudentHome.tsx`):
```tsx
useEffect(() => {
  socket.on('gatepass-approved', (pass) => {
    toast.success('Your gate pass was approved!');
    updateLocalState(pass);
  });
}, []);
```

---

## 🔧 Development Workflows

### **Running the Project**

**Full Stack (Docker):**
```bash
cd hostelconnect
docker-compose up -d
# API: http://localhost:3000/api/v1
# Swagger: http://localhost:3000/api
# PostgreSQL: localhost:5432 (postgres/password)
# Redis: localhost:6379
```

**Backend Only (Watch Mode):**
```bash
cd hostelconnect/api
npm install
npm run start:dev
```

**Frontend (React):**
```bash
npm install
npm run dev
# Vite: http://localhost:5173
```

**Mobile (Flutter):**
```bash
cd hostelconnect/mobile
flutter pub get
flutter run  # or flutter run -d <device-id>
```

### **Database Migrations**
```bash
# Generate new migration based on entity changes
npm run migration:generate -- -n DescriptiveNameHere

# Run migrations
npm run migration:run

# Revert last migration
npm run migration:revert

# Seed initial data
npm run seed
```

### **Testing**
```bash
# Backend tests
cd hostelconnect/api
npm run test           # Run once
npm run test:watch    # Watch mode
npm run test:cov      # Coverage report

# Frontend tests (when available)
npm run test

# Mobile tests (when available)
cd hostelconnect/mobile
flutter test
```

### **Debugging**
```bash
# Backend debug mode (VS Code Debugger)
npm run start:debug
# Then: Debug > Attach to process in VS Code

# Flutter debug
flutter run -v  # Verbose output
# or use DevTools: flutter pub global run devtools

# React
npm run dev  # Vite automatically shows source maps
# Use React DevTools browser extension
```

---

## 🚫 Common Pitfalls & How to Avoid Them

### 1. **Silent Redis Failures**
❌ **DON'T:** Return default value on error
```typescript
async get(key) {
  try { return await redis.get(key); }
  catch (e) { console.error(e); return null; }  // Can't tell if key exists or Redis is down
}
```

✅ **DO:** Throw proper exception
```typescript
async get(key) {
  try { return await redis.get(key); }
  catch (e) { 
    this.logger.error('Redis failed', e);
    throw new CacheUnavailableException();
  }
}
```

### 2. **Unhandled Promises**
❌ **DON'T:** Fire-and-forget async calls
```tsx
const handleClick = () => {
  apiCall();  // No await, no .catch()
  setLoading(false);
};
```

✅ **DO:** Handle promise chain
```tsx
const handleClick = async () => {
  try {
    setLoading(true);
    await apiCall();
  } catch (err) {
    toast.error(err.message);
  } finally {
    setLoading(false);
  }
};
```

### 3. **Type-Unsafe Mock Data**
❌ **DON'T:** Mix typed and untyped data
```tsx
const mockPass = { id: '1', name: 'John' };  // Missing required fields
const real = await fetchGatePass();  // Different shape?
```

✅ **DO:** Use same types everywhere
```tsx
interface GatePass { /* full definition */ }
const mockPass: GatePass = { /* all required fields */ };
const real: GatePass = await fetchGatePass();
```

### 4. **Stale Cache After Mutations**
❌ **DON'T:** Update database but forget cache
```typescript
await db.update(Student, { id }, { name: 'John' });
// Cache still has old data!
```

✅ **DO:** Invalidate cache after mutations
```typescript
await db.update(Student, { id }, { name: 'John' });
await redis.del(`student:${id}`);
```

### 5. **Missing Error Boundaries in React**
❌ **DON'T:** Let component crashes bubble to root
```tsx
<GateSecurity />  // If it throws, entire app is broken
```

✅ **DO:** Wrap with error boundary
```tsx
<ErrorBoundary pageName="GateSecurity">
  <GateSecurity />
</ErrorBoundary>
```

---

## ⚠️ Known Issues & Workarounds

1. **Mobile Scanner Module Commented Out** (`pubspec.yaml` line 54)
   - **Issue:** Build failure with `mobile_scanner` package
   - **Workaround:** Using fallback QR detection (no camera app)
   - **TODO:** Fix underlying Gradle/Kotlin issue

2. **Background Sync Not Implemented** (`mobile/lib/main.dart`)
   - **Status:** Placeholder only
   - **Needed:** Implement WorkManager integration for iOS/Android
   - **Priority:** High

3. **Placeholder Performance Metrics** (`api/src/common/services/database-optimization.service.ts`)
   - **Issue:** Hardcoded cache hit rate (0.95)
   - **Fix:** Parse actual Redis INFO response

---

## 📊 Key Files to Know

| Purpose | Location | Key Exports |
|---------|----------|-------------|
| API Routes | `hostelconnect/api/src/**/*.controller.ts` | CRUD endpoints, DTOs |
| Database Entities | `hostelconnect/api/src/**/*.entity.ts` | TypeORM schemas |
| Shared Types | `hostelconnect/api/src/common/types/` | Custom exception types |
| React Pages | `src/components/pages/*.tsx` | Role-based views |
| UI Components | `src/components/*.tsx` | Reusable widgets |
| Mobile Models | `hostelconnect/mobile/lib/core/models/` | Data models, error types |
| Mobile Providers | `hostelconnect/mobile/lib/core/providers/` | Riverpod state |

---

## 🎯 Task Guidelines for AI Agents

**When adding a new feature:**
1. **Define types first** (interface/class/entity)
2. **Backend:** Create API endpoint (controller + service) + test
3. **Frontend:** Create component + hook if needed
4. **Mobile:** Create provider + UI screen
5. **Database:** Add migration if new fields needed
6. **Documentation:** Update API docs (Swagger tags)

**When fixing a bug:**
1. **Locate root cause** (backend, frontend, mobile, or all?)
2. **Write test** that reproduces bug
3. **Fix code** with minimal changes
4. **Test fix** (unit + manual)
5. **Check cache invalidation** if data changed

**When refactoring:**
1. **Keep interfaces stable** (no breaking API changes without migration)
2. **Test before/after** behavior
3. **Update related code** (services that depend on refactored code)
4. **Document why** in commit message

---

## 🔒 Security Checklist

- [ ] All API endpoints require authentication (except `/auth/*`)
- [ ] Role-based access verified in controller guards
- [ ] Input validation on all DTOs
- [ ] SQL injection protected (use TypeORM params, never concatenate)
- [ ] JWT tokens refreshed periodically
- [ ] Sensitive data logged only in dev mode
- [ ] CORS configured restrictively (not `*` in production)
- [ ] Rate limiting on auth endpoints (already configured via `@Throttle()`)

---

**Need help?** Check existing code patterns in `/hostelconnect/api/src/students/` (complete example module) or refer to the issue tracker for known blockers.

