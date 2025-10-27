# HostelConnect Developer Documentation
## Complete Guide for Developers and Contributors

> **Version:** 1.0 | **Last Updated:** January 2025 | **For:** Developers, Contributors, Technical Teams

---

## 📋 Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Development Environment Setup](#development-environment-setup)
3. [Project Structure](#project-structure)
4. [Backend API Development](#backend-api-development)
5. [Frontend Development](#frontend-development)
6. [Mobile App Development](#mobile-app-development)
7. [Database Management](#database-management)
8. [Testing Guide](#testing-guide)
9. [API Documentation](#api-documentation)
10. [Deployment](#deployment)
11. [Troubleshooting](#troubleshooting)

---

## 🏗️ Architecture Overview

### Technology Stack

**Backend:**
- **Framework:** NestJS 10.x
- **Language:** TypeScript 5.x
- **Database:** PostgreSQL 15+
- **ORM:** TypeORM 0.3.x
- **Caching:** Redis 7.x
- **Real-time:** Socket.io
- **Scheduling:** @nestjs/schedule (Cron jobs)
- **Authentication:** JWT (JSON Web Tokens)

**Frontend (Web):**
- **Framework:** React 18.x with Vite
- **Language:** TypeScript
- **Styling:** TailwindCSS 3.x
- **UI Components:** Radix UI
- **State Management:** React Hooks
- **HTTP Client:** Axios

**Mobile (Android/iOS):**
- **Framework:** Flutter 3.16+
- **Language:** Dart 3.x
- **State Management:** Riverpod 2.x
- **Routing:** GoRouter
- **HTTP Client:** Dio
- **Local Storage:** Hive / SharedPreferences

### System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Client Layer                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   React Web  │  │    Flutter   │  │   Admin UI   │      │
│  │   Frontend   │  │  Mobile App  │  │    Panel     │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                           │
                      REST API / WebSocket
                           │
┌─────────────────────────────────────────────────────────────┐
│                Application Layer (NestJS)                    │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Controllers → Services → Repositories → Entities    │  │
│  │                                                        │  │
│  │  Auth | Students | GatePass | Meals | Notifications │  │
│  │  Attendance | Hostels | Rooms | Analytics           │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   Guards &   │  │  Middleware  │  │   Filters &   │     │
│  │ Interceptors │  │   & Pipes    │  │  Exceptions   │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                           │
                   Database Layer
                           │
┌─────────────────────────────────────────────────────────────┐
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  PostgreSQL  │  │     Redis    │  │     File     │     │
│  │   Primary    │  │    Cache &   │  │   Storage    │     │
│  │   Database   │  │   Sessions   │  │   (Uploads)  │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

### Core Domain Models

1. **User** → Base authentication entity
2. **Student** → Student profiles, hall tickets, hostel assignments
3. **Warden / WardenHead** → Staff management entities
4. **Hostel / Block / Room** → Accommodation hierarchy
5. **GatePass** → Entry/exit permission system
6. **Attendance** → QR-based check-in tracking
7. **Meal** → Menu planning, preferences, feedback
8. **Notice** → Announcements and notifications

---

## 💻 Development Environment Setup

### Prerequisites

**Required Software:**
- Node.js 18+ LTS
- PostgreSQL 15+
- Redis 7+
- Flutter 3.16+ (for mobile development)
- Docker & Docker Compose (optional but recommended)
- Git

**Recommended Tools:**
- VS Code with extensions:
  - ESLint
  - Prettier
  - Flutter
  - Docker
  - PostgreSQL Explorer
- Postman or Insomnia (API testing)
- Android Studio / Xcode (mobile development)
- pgAdmin or DBeaver (database management)

### Initial Setup

#### 1. Clone Repository

```bash
git clone https://github.com/yourusername/hostelconnect.git
cd hostelconnect
```

#### 2. Backend Setup

```bash
cd hostelconnect/api
npm install

# Create environment file
cp .env.example .env

# Edit .env with your configuration
# DATABASE_URL=postgresql://username:password@localhost:5432/hostelconnect
# JWT_SECRET=your-secret-key
# REDIS_URL=redis://localhost:6379

# Run database migrations
npm run migration:run

# Seed initial data (admin users, hostels, etc.)
npm run seed

# Start development server
npm run start:dev
```

Backend will run on http://localhost:3000

#### 3. Frontend Setup

```bash
cd ../..  # Back to root
npm install

# Start React development server
npm run dev
```

Frontend will run on http://localhost:5173

#### 4. Mobile Setup

```bash
cd hostelconnect/mobile
flutter pub get

# Configure API endpoint in lib/core/config/api_config.dart
# const baseUrl = 'http://localhost:3000/api/v1';  // For emulator
# const baseUrl = 'http://YOUR_IP:3000/api/v1';    // For physical device

# Run on connected device/emulator
flutter run
```

#### 5. Docker Setup (Alternative)

```bash
# Start all services (PostgreSQL, Redis, API, Web)
docker-compose up -d

# View logs
docker-compose logs -f api

# Stop all services
docker-compose down
```

---

## 📁 Project Structure

```
hostelconnect/
├── api/                           # NestJS Backend
│   ├── src/
│   │   ├── auth/                  # Authentication module
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.service.ts
│   │   │   ├── jwt.strategy.ts
│   │   │   └── guards/
│   │   │
│   │   ├── students/              # Student management
│   │   │   ├── students.controller.ts
│   │   │   ├── students.service.ts
│   │   │   ├── student.entity.ts
│   │   │   └── dto/
│   │   │       ├── create-student.dto.ts
│   │   │       ├── bulk-student.dto.ts
│   │   │       └── update-student.dto.ts
│   │   │
│   │   ├── gatepass/              # Gate pass system
│   │   ├── attendance/            # Attendance tracking
│   │   ├── meals/                 # Meal management
│   │   │   ├── meals.controller.ts
│   │   │   ├── meals.service.ts
│   │   │   └── meal-scheduler.service.ts  # Cron jobs
│   │   │
│   │   ├── notifications/         # Notification system
│   │   │   ├── notifications.controller.ts
│   │   │   ├── notifications.service.ts
│   │   │   └── dto/
│   │   │       └── create-targeted-notification.dto.ts
│   │   │
│   │   ├── common/                # Shared utilities
│   │   │   ├── decorators/
│   │   │   ├── guards/
│   │   │   ├── interceptors/
│   │   │   ├── filters/
│   │   │   └── exceptions/
│   │   │
│   │   ├── database/              # Database configuration
│   │   │   ├── migrations/
│   │   │   └── seeds/
│   │   │
│   │   └── main.ts                # Application bootstrap
│   │
│   ├── test/                      # E2E tests
│   ├── package.json
│   └── tsconfig.json
│
├── mobile/                        # Flutter Mobile App
│   ├── lib/
│   │   ├── core/                  # Core functionality
│   │   │   ├── config/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── services/
│   │   │   └── utils/
│   │   │
│   │   ├── features/              # Feature modules
│   │   │   ├── auth/
│   │   │   ├── dashboards/
│   │   │   │   └── presentation/
│   │   │   │       ├── pages/
│   │   │   │       │   ├── complete_student_dashboard.dart
│   │   │   │       │   ├── complete_super_admin_dashboard.dart
│   │   │   │       │   └── complete_warden_dashboard.dart
│   │   │   │       └── widgets/
│   │   │   │
│   │   │   ├── admin/
│   │   │   │   └── presentation/
│   │   │   │       └── pages/
│   │   │   │           ├── create_notification_page.dart
│   │   │   │           ├── bulk_student_upload_page.dart
│   │   │   │           ├── student_management_page.dart
│   │   │   │           └── analytics_dashboard_page.dart
│   │   │   │
│   │   │   ├── gatepass/
│   │   │   ├── meals/
│   │   │   └── attendance/
│   │   │
│   │   ├── shared/                # Shared widgets
│   │   └── main.dart
│   │
│   ├── android/
│   ├── ios/
│   ├── pubspec.yaml
│   └── test/
│
├── src/                           # React Frontend
│   ├── components/
│   │   ├── admin/
│   │   │   ├── CreateNotificationForm.tsx
│   │   │   └── BulkStudentUpload.tsx
│   │   ├── pages/
│   │   └── shared/
│   │
│   ├── services/
│   ├── contexts/
│   └── App.tsx
│
├── docker-compose.yml
├── package.json
└── README.md
```

---

## 🔧 Backend API Development

### Creating a New Module

```bash
cd hostelconnect/api

# Generate new module with controller, service, and entity
nest generate module example
nest generate controller example
nest generate service example
```

### Module Structure Example

**example.entity.ts:**
```typescript
import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn } from 'typeorm';

@Entity('examples')
export class Example {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column({ nullable: true })
  description: string;

  @CreateDateColumn()
  createdAt: Date;
}
```

**create-example.dto.ts:**
```typescript
import { IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class CreateExampleDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsOptional()
  description?: string;
}
```

**example.service.ts:**
```typescript
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Example } from './example.entity';
import { CreateExampleDto } from './dto/create-example.dto';

@Injectable()
export class ExampleService {
  constructor(
    @InjectRepository(Example)
    private exampleRepo: Repository<Example>,
  ) {}

  async create(dto: CreateExampleDto): Promise<Example> {
    const example = this.exampleRepo.create(dto);
    return await this.exampleRepo.save(example);
  }

  async findAll(): Promise<Example[]> {
    return await this.exampleRepo.find();
  }

  async findOne(id: string): Promise<Example> {
    const example = await this.exampleRepo.findOne({ where: { id } });
    if (!example) {
      throw new NotFoundException(`Example with ID ${id} not found`);
    }
    return example;
  }
}
```

**example.controller.ts:**
```typescript
import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';
import { ExampleService } from './example.service';
import { CreateExampleDto } from './dto/create-example.dto';

@Controller('examples')
@UseGuards(JwtAuthGuard, RolesGuard)
export class ExampleController {
  constructor(private readonly exampleService: ExampleService) {}

  @Post()
  @Roles('SUPER_ADMIN', 'WARDEN_HEAD')
  create(@Body() dto: CreateExampleDto) {
    return this.exampleService.create(dto);
  }

  @Get()
  findAll() {
    return this.exampleService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.exampleService.findOne(id);
  }
}
```

### Implementing Cron Jobs

```typescript
import { Injectable } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';

@Injectable()
export class SchedulerService {
  // Runs every day at 7:00 AM IST
  @Cron('0 7 * * *', {
    timeZone: 'Asia/Kolkata',
  })
  async morningTask() {
    console.log('Running morning task at 7 AM IST');
    // Your logic here
  }

  // Runs every 15 minutes
  @Cron(CronExpression.EVERY_15_MINUTES)
  async frequentTask() {
    console.log('Running every 15 minutes');
  }
}
```

### Database Migrations

```bash
# Generate migration based on entity changes
npm run migration:generate -- -n AddNewFieldToStudent

# Run migrations
npm run migration:run

# Revert last migration
npm run migration:revert
```

**Example Migration:**
```typescript
import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddNewFieldToStudent1234567890 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "students" 
      ADD COLUMN "newField" VARCHAR(255) DEFAULT NULL
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "students" 
      DROP COLUMN "newField"
    `);
  }
}
```

---

## 🎨 Frontend Development

### React Component Structure

```typescript
import React, { useState, useCallback } from 'react';
import { useAuth } from '@/contexts/AuthContext';

interface ExampleComponentProps {
  title: string;
  onSubmit?: (data: any) => void;
}

export const ExampleComponent: React.FC<ExampleComponentProps> = ({ 
  title, 
  onSubmit 
}) => {
  const [data, setData] = useState<string>('');
  const [loading, setLoading] = useState(false);
  const { user } = useAuth();

  const handleSubmit = useCallback(async () => {
    setLoading(true);
    try {
      // API call
      await onSubmit?.(data);
    } catch (error) {
      console.error(error);
    } finally {
      setLoading(false);
    }
  }, [data, onSubmit]);

  return (
    <div className="p-4 bg-white rounded-lg shadow">
      <h2 className="text-xl font-bold mb-4">{title}</h2>
      <input
        type="text"
        value={data}
        onChange={(e) => setData(e.target.value)}
        className="w-full px-4 py-2 border rounded"
      />
      <button
        onClick={handleSubmit}
        disabled={loading}
        className="mt-4 px-6 py-2 bg-blue-600 text-white rounded"
      >
        {loading ? 'Loading...' : 'Submit'}
      </button>
    </div>
  );
};
```

---

## 📱 Mobile App Development

### Flutter Provider Pattern

```dart
// Provider Definition
final exampleProvider = FutureProvider<List<Example>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return await api.getExamples();
});

// State Notifier for Mutable State
class ExampleNotifier extends StateNotifier<AsyncValue<List<Example>>> {
  final ExampleApi api;
  
  ExampleNotifier(this.api) : super(const AsyncValue.loading());

  Future<void> loadExamples() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => api.getExamples());
  }

  Future<void> addExample(Example example) async {
    await api.createExample(example);
    loadExamples(); // Refresh list
  }
}

// Usage in Widget
class ExamplePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examplesAsync = ref.watch(exampleProvider);

    return examplesAsync.when(
      data: (examples) => ListView.builder(
        itemCount: examples.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(examples[index].name),
        ),
      ),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
```

---

## 📊 API Documentation

### Authentication

**POST /api/v1/auth/login**
```json
Request:
{
  "hallTicket": "2024CS001",
  "password": "password123"
}

Response:
{
  "access_token": "eyJhbGc...",
  "user": {
    "id": "uuid",
    "name": "John Doe",
    "role": "STUDENT"
  }
}
```

### Notifications

**POST /api/v1/notifications/send-targeted**
```json
Request:
{
  "title": "Hostel Maintenance",
  "body": "Water supply will be off tomorrow 9-11 AM",
  "type": "announcement",
  "priority": "high",
  "targetType": "hostel",
  "hostelId": "uuid"
}

Response:
{
  "success": true,
  "message": "Notification sent to 425 students",
  "targetCount": 425
}
```

### Bulk Student Upload

**POST /api/v1/students/bulk-upload**
```
Content-Type: multipart/form-data

file: students.csv (CSV format)

Response:
{
  "totalProcessed": 50,
  "successCount": 48,
  "errorCount": 2,
  "errors": [
    { "row": 15, "error": "Hall ticket already exists" },
    { "row": 32, "error": "Invalid hostel name" }
  ]
}
```

Full API documentation available at: **http://localhost:3000/api** (Swagger UI)

---

## 🧪 Testing

### Backend Unit Tests

```typescript
import { Test } from '@nestjs/testing';
import { ExampleService } from './example.service';

describe('ExampleService', () => {
  let service: ExampleService;

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      providers: [ExampleService],
    }).compile();

    service = module.get<ExampleService>(ExampleService);
  });

  it('should create an example', async () => {
    const dto = { name: 'Test' };
    const result = await service.create(dto);
    expect(result).toBeDefined();
    expect(result.name).toBe('Test');
  });
});
```

Run tests:
```bash
npm run test          # Unit tests
npm run test:watch    # Watch mode
npm run test:cov      # Coverage report
```

---

## 🚀 Deployment

### Production Build

**Backend:**
```bash
npm run build
npm run start:prod
```

**Frontend:**
```bash
npm run build
# Output in build/ directory
```

**Mobile:**
```bash
flutter build apk --release
flutter build ios --release
```

### Docker Deployment

```bash
docker-compose -f docker-compose.production.yml up -d
```

---

## 🐛 Troubleshooting

### Common Issues

**1. Database Connection Error**
```
Solution: Check PostgreSQL is running and .env has correct credentials
```

**2. JWT Token Invalid**
```
Solution: Ensure JWT_SECRET is consistent across restarts
```

**3. Flutter Build Fails**
```bash
flutter clean
flutter pub get
flutter build apk
```

---

## 📞 Support

- **Documentation:** [GitHub Wiki](https://github.com/yourusername/hostelconnect/wiki)
- **Issues:** [GitHub Issues](https://github.com/yourusername/hostelconnect/issues)
- **Email:** developer@hostelconnect.com

---

**Happy Coding! 🎉**
