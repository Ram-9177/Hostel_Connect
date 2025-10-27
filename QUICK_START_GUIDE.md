# 🚀 HostelConnect - Quick Reference Guide for AI Agents

**Use this guide to get productive in 5 minutes**

---

## 📍 Where To Find What

### Getting Started
1. **Project Overview** → `README.md` (5 min read)
2. **AI Development Guide** → `.github/copilot-instructions.md` (read before coding)
3. **Known Issues** → `BUG_AND_ERROR_ANALYSIS.md` (check before implementation)

### Architecture
- **System Design** → `ANALYSIS_SUMMARY.md` section "Architecture Understanding"
- **Data Flow** → `.github/copilot-instructions.md` top section
- **Example Module** → `hostelconnect/api/src/students/` (complete pattern)

### Code Patterns

**Backend (NestJS):**
- Service pattern → See `hostelconnect/api/src/students/students.service.ts`
- Error handling → See `hostelconnect/api/src/common/filters/`
- WebSocket → See `hostelconnect/api/src/socket/socket.gateway.ts`

**Frontend (React):**
- Component pattern → See `src/components/BottomNav.tsx`
- Error boundary → See `src/components/ErrorBoundary.tsx`
- Page routing → See `src/App.tsx`

**Mobile (Flutter):**
- Riverpod provider → See `hostelconnect/mobile/lib/core/providers/`
- Error handling → See `hostelconnect/mobile/lib/core/error_handling/`
- Features structure → See `hostelconnect/mobile/lib/features/`

---

## 🎯 Common Tasks

### Task: Add New API Endpoint

**Files to Create/Modify:**
```
1. hostelconnect/api/src/students/students.entity.ts      (Update if new fields)
2. hostelconnect/api/src/database/migrations/             (New migration)
3. hostelconnect/api/src/students/dtos/                   (Request/Response DTO)
4. hostelconnect/api/src/students/students.service.ts     (Business logic)
5. hostelconnect/api/src/students/students.controller.ts  (Route handler)
```

**Commands:**
```bash
cd hostelconnect/api
npm run migration:generate -- -n DescriptiveName
npm run migration:run
npm run start:dev  # Test in watch mode
```

**Pattern:**
```typescript
// Service (business logic)
@Injectable()
export class StudentsService {
  async create(createStudentDto: CreateStudentDto): Promise<Student> {
    try {
      // 1. Validate input
      const existing = await this.db.findOne(Student, { where: { email: createStudentDto.email } });
      if (existing) throw new ConflictException('Student exists');
      
      // 2. Create entity
      const student = this.db.create(Student, createStudentDto);
      const saved = await this.db.save(student);
      
      // 3. Invalidate cache
      await this.redis.del('students:list');
      
      // 4. Log
      this.logger.log('Student created', { id: saved.id });
      
      return saved;
    } catch (error) {
      throw new InternalServerErrorException('Failed to create student');
    }
  }
}

// Controller (route handler)
@Controller('students')
export class StudentsController {
  @Post()
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles('admin', 'warden-head')
  async create(@Body() createStudentDto: CreateStudentDto) {
    return this.studentsService.create(createStudentDto);
  }
}
```

---

### Task: Fix a Bug

**Process (5 Steps):**
1. **Find issue** → Search in `BUG_AND_ERROR_ANALYSIS.md`
2. **Understand root cause** → Read the problem description
3. **Check test** → Write test that reproduces bug first
4. **Fix code** → Make minimal changes
5. **Test & verify** → Run tests, check related code

**Example: React Component Bug**
```bash
# 1. Find in BUG_AND_ERROR_ANALYSIS.md
# 2. Read the issue

# 3. Write test
npm test -- GateSecurity.test.tsx

# 4. Fix the component
# Edit src/components/GateSecurity.tsx

# 5. Verify
npm run dev  # Test manually
npm test -- GateSecurity.test.tsx  # Run test
```

---

### Task: Add React Component

**Files:**
```
src/components/MyComponent.tsx    (Component)
src/components/MyComponent.css    (Styles if needed)
```

**Template:**
```tsx
import React, { useState, useCallback } from 'react';
import { toast } from 'sonner';

interface MyComponentProps {
  data?: string;
  onAction?: () => void;
}

export const MyComponent: React.FC<MyComponentProps> = ({
  data,
  onAction,
}) => {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string>('');

  const handleClick = useCallback(async () => {
    try {
      setIsLoading(true);
      setError('');
      
      // Your async operation
      await performAction();
      
      toast.success('Success!');
      onAction?.();
    } catch (err) {
      const message = err instanceof Error ? err.message : 'An error occurred';
      setError(message);
      toast.error(message);
    } finally {
      setIsLoading(false);
    }
  }, [onAction]);

  return (
    <div className="flex flex-col gap-4">
      {error && <div className="text-red-600">{error}</div>}
      <button 
        onClick={handleClick}
        disabled={isLoading}
        className="btn btn-primary"
      >
        {isLoading ? 'Loading...' : 'Click Me'}
      </button>
    </div>
  );
};
```

---

### Task: Add Flutter Screen

**Files:**
```
lib/features/myfeature/presentation/pages/my_page.dart
lib/features/myfeature/presentation/providers.dart
```

**Template:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPage extends ConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch provider
    final myDataAsync = ref.watch(myDataProvider);

    return myDataAsync.when(
      loading: () => const LoadingWidget(),
      error: (err, stack) => ErrorWidget(
        error: err.toString(),
        onRetry: () => ref.refresh(myDataProvider),
      ),
      data: (myData) => MyPageContent(data: myData),
    );
  }
}

class MyPageContent extends StatelessWidget {
  final MyData data;
  
  const MyPageContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your content
          ],
        ),
      ),
    );
  }
}
```

---

## 🔧 Development Commands

### Backend (NestJS)
```bash
cd hostelconnect/api

# Development
npm run start:dev           # Watch mode with hot reload
npm run start:debug        # Debug mode for VS Code

# Testing
npm test                   # Run tests once
npm run test:watch        # Watch mode
npm run test:cov          # Coverage report

# Database
npm run migration:generate -- -n MigrationName
npm run migration:run
npm run migration:revert
npm run seed              # Seed initial data

# Building
npm run build
npm run start:prod
```

### Frontend (React)
```bash
cd /path/to/root

# Development
npm run dev                # Vite dev server (localhost:5173)
npm run build              # Build for production
npm run preview            # Preview production build

# Debugging
# Use React DevTools browser extension
# Check browser console for errors
```

### Mobile (Flutter)
```bash
cd hostelconnect/mobile

# Setup
flutter pub get            # Install dependencies

# Development
flutter run                # Run on default device/emulator
flutter run -v             # Verbose output for debugging
flutter run -d <device-id> # Run on specific device

# Building
flutter build apk          # Build Android APK
flutter build ios          # Build iOS app

# Testing
flutter test               # Run unit tests
flutter test integration_test/ # Run integration tests

# Analysis
flutter analyze            # Lint code
flutter pub global run devtools  # Launch DevTools
```

### Docker
```bash
cd hostelconnect

# Start all services
docker-compose up -d
docker-compose ps          # Show status

# View logs
docker-compose logs -f     # Follow logs
docker-compose logs api    # Just API service

# Stop all
docker-compose down
```

---

## 🐛 Common Errors & Fixes

### React: "Cannot read property 'xxx' of undefined"
**Cause:** Missing null/undefined check
**Fix:**
```tsx
// Bad
const name = user.profile.name;

// Good
const name = user?.profile?.name || 'Unknown';

// Better with TypeScript
const name: string = user?.profile?.name ?? 'Unknown';
```

### Flutter: "The getter 'xxx' was not found"
**Cause:** Missing provider or incorrect provider access
**Fix:**
```dart
// Bad
final data = myProvider;  // Returns AsyncValue, not data!

// Good
final dataAsync = ref.watch(myProvider);
final data = dataAsync.when(
  data: (d) => d,
  loading: () => null,
  error: (e, st) => throw e,
);
```

### Backend: "Unhandled promise rejection"
**Cause:** Async function not awaited or error not caught
**Fix:**
```typescript
// Bad
async create(dto) {
  this.dbService.save(dto);  // Fire and forget
  return { success: true };
}

// Good
async create(dto) {
  try {
    const result = await this.dbService.save(dto);
    return result;
  } catch (error) {
    throw new BadRequestException(error.message);
  }
}
```

### DevContainer: "sdkmanager not found"
**Cause:** Android SDK path incorrect
**Solution:** See `.github/copilot-instructions.md` → Known Issues #1

---

## ✅ Pre-Commit Checklist

Before committing code:

### All Platforms
- [ ] No console.log/debugPrint statements
- [ ] Error handling for all async operations
- [ ] Type-safe (no `any` types where possible)
- [ ] No TODOs without issues created

### Backend Only
- [ ] Updated TypeORM entity
- [ ] Created migration if schema changed
- [ ] Added input validation (DTOs)
- [ ] Error thrown (not just logged)
- [ ] Cache invalidated after mutations

### Frontend Only
- [ ] Component has error boundary
- [ ] Loading state shown to user
- [ ] Tailwind classes only (no inline styles)
- [ ] Accessible (ARIA labels for interactive elements)

### Mobile Only
- [ ] Used Riverpod provider (not setState)
- [ ] Error handled with .when() pattern
- [ ] No platform-specific code without condition
- [ ] Strings in strings.dart for i18n

---

## 📚 Documentation Reference

| Topic | File | Section |
|-------|------|---------|
| Architecture | `.github/copilot-instructions.md` | Top section |
| Design Patterns | `.github/copilot-instructions.md` | "Critical Patterns" |
| Workflows | `.github/copilot-instructions.md` | "Development Workflows" |
| Known Issues | `BUG_AND_ERROR_ANALYSIS.md` | All sections |
| UI/UX Improvements | `UI_UX_RECOMMENDATIONS.md` | All sections |
| Code Examples | `.github/copilot-instructions.md` | Throughout |
| Quick Start | `README.md` | "Quick Start" section |

---

## 🆘 Need Help?

1. **Error not understood?** → Check `BUG_AND_ERROR_ANALYSIS.md`
2. **How do I do X?** → Check `.github/copilot-instructions.md` Task Guidelines
3. **Code pattern needed?** → Check example implementations in key files
4. **UI issue?** → Check `UI_UX_RECOMMENDATIONS.md`
5. **Architecture question?** → Check `ANALYSIS_SUMMARY.md`

---

## 🎯 Success Criteria

Your code is production-ready when:
- ✅ All tests pass
- ✅ No console errors
- ✅ Error messages shown to users
- ✅ Types are specific (no `any`)
- ✅ Code follows existing patterns
- ✅ Documentation updated if needed
- ✅ No security vulnerabilities

---

**Happy Coding! 🚀**

Last Updated: October 23, 2025  
Questions? Check the full `.github/copilot-instructions.md` file

