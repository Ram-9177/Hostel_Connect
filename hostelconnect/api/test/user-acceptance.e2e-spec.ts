import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';
import { AuthService } from '../src/auth/auth.service';
import { UsersService } from '../src/users/users.service';

describe('HostelConnect User Acceptance Tests', () => {
  let app: INestApplication;
  let authService: AuthService;
  let usersService: UsersService;
  let accessToken: string;
  let userId: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [
        ConfigModule.forRoot({
          isGlobal: true,
          envFilePath: '.env.test',
        }),
        TypeOrmModule.forRoot({
          type: 'sqlite',
          database: ':memory:',
          entities: [__dirname + '/../src/**/*.entity{.ts,.js}'],
          synchronize: true,
        }),
        AppModule,
      ],
    }).compile();

    app = moduleFixture.createNestApplication();
    authService = moduleFixture.get<AuthService>(AuthService);
    usersService = moduleFixture.get<UsersService>(UsersService);
    
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  describe('Authentication Flow', () => {
    it('should register a new student', async () => {
      const studentData = {
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@test.com',
        password: 'password123',
        phone: '+1234567890',
        studentId: 'STU001',
        hostelId: 'hostel-1',
      };

      const response = await request(app.getHttpServer())
        .post('/api/v1/auth/register')
        .send(studentData)
        .expect(201);

      expect(response.body).toHaveProperty('user');
      expect(response.body).toHaveProperty('accessToken');
      expect(response.body.user.email).toBe(studentData.email);
      expect(response.body.user.role).toBe('STUDENT');
      
      userId = response.body.user.id;
      accessToken = response.body.accessToken;
    });

    it('should login with valid credentials', async () => {
      const loginData = {
        email: 'john.doe@test.com',
        password: 'password123',
      };

      const response = await request(app.getHttpServer())
        .post('/api/v1/auth/login')
        .send(loginData)
        .expect(200);

      expect(response.body).toHaveProperty('user');
      expect(response.body).toHaveProperty('accessToken');
      expect(response.body.user.email).toBe(loginData.email);
    });

    it('should reject invalid credentials', async () => {
      const loginData = {
        email: 'john.doe@test.com',
        password: 'wrongpassword',
      };

      await request(app.getHttpServer())
        .post('/api/v1/auth/login')
        .send(loginData)
        .expect(401);
    });

    it('should get user profile with valid token', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/auth/profile')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body).toHaveProperty('user');
      expect(response.body.user.email).toBe('john.doe@test.com');
    });
  });

  describe('Gate Pass Management', () => {
    let gatePassId: string;

    it('should create a gate pass request', async () => {
      const gatePassData = {
        reason: 'Medical appointment',
        destination: 'City Hospital',
        departureTime: new Date(Date.now() + 3600000).toISOString(), // 1 hour from now
        expectedReturnTime: new Date(Date.now() + 7200000).toISOString(), // 2 hours from now
      };

      const response = await request(app.getHttpServer())
        .post('/api/v1/gatepass')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(gatePassData)
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body.reason).toBe(gatePassData.reason);
      expect(response.body.status).toBe('PENDING');
      
      gatePassId = response.body.id;
    });

    it('should get user gate passes', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/gatepass')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
      expect(response.body.length).toBeGreaterThan(0);
    });

    it('should update gate pass status (warden)', async () => {
      // Create a warden user for approval
      const wardenData = {
        firstName: 'Jane',
        lastName: 'Warden',
        email: 'jane.warden@test.com',
        password: 'password123',
        role: 'WARDEN',
      };

      const wardenResponse = await request(app.getHttpServer())
        .post('/api/v1/auth/register')
        .send(wardenData)
        .expect(201);

      const wardenToken = wardenResponse.body.accessToken;

      const response = await request(app.getHttpServer())
        .put(`/api/v1/gatepass/${gatePassId}/approve`)
        .set('Authorization', `Bearer ${wardenToken}`)
        .send({ comments: 'Approved for medical appointment' })
        .expect(200);

      expect(response.body.status).toBe('APPROVED');
    });
  });

  describe('Room Management', () => {
    it('should get available rooms', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/rooms')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
    });

    it('should allocate room to student', async () => {
      const allocationData = {
        roomId: 'room-1',
        bedNumber: 1,
      };

      const response = await request(app.getHttpServer())
        .post('/api/v1/rooms/room-1/allocate')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(allocationData)
        .expect(200);

      expect(response.body).toHaveProperty('success');
      expect(response.body.success).toBe(true);
    });
  });

  describe('Attendance System', () => {
    it('should record attendance', async () => {
      const attendanceData = {
        qrToken: 'test-qr-token-123',
        location: 'Main Gate',
      };

      const response = await request(app.getHttpServer())
        .post('/api/v1/attendance/scan')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(attendanceData)
        .expect(201);

      expect(response.body).toHaveProperty('success');
      expect(response.body.success).toBe(true);
    });

    it('should get attendance history', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/attendance')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
    });
  });

  describe('Meal Management', () => {
    it('should submit meal intent', async () => {
      const mealData = {
        mealType: 'BREAKFAST',
        date: new Date().toISOString().split('T')[0],
        intent: true,
      };

      const response = await request(app.getHttpServer())
        .post('/api/v1/meals/intent')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(mealData)
        .expect(201);

      expect(response.body).toHaveProperty('success');
      expect(response.body.success).toBe(true);
    });

    it('should get meal history', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/meals')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
    });
  });

  describe('File Upload', () => {
    it('should upload profile picture', async () => {
      const response = await request(app.getHttpServer())
        .post('/api/v1/files/upload/profile-picture')
        .set('Authorization', `Bearer ${accessToken}`)
        .attach('file', Buffer.from('fake-image-data'), 'profile.jpg')
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body).toHaveProperty('url');
      expect(response.body.mimetype).toContain('image');
    });

    it('should get user files', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/files/user/files')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
    });
  });

  describe('Notifications', () => {
    it('should get user notifications', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/notifications')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
    });

    it('should get unread count', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/notifications/unread-count')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body).toHaveProperty('unreadCount');
      expect(typeof response.body.unreadCount).toBe('number');
    });
  });

  describe('Analytics', () => {
    it('should get comprehensive analytics', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/analytics/comprehensive')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body).toHaveProperty('occupancy');
      expect(response.body).toHaveProperty('attendance');
      expect(response.body).toHaveProperty('meals');
      expect(response.body).toHaveProperty('gatePasses');
      expect(response.body).toHaveProperty('predictions');
    });

    it('should get analytics insights', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/analytics/insights')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body).toHaveProperty('keyFindings');
      expect(response.body).toHaveProperty('recommendations');
      expect(response.body).toHaveProperty('alerts');
      expect(Array.isArray(response.body.keyFindings)).toBe(true);
    });
  });

  describe('Dashboard', () => {
    it('should get student dashboard data', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/dashboards/student')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body).toHaveProperty('user');
      expect(response.body).toHaveProperty('stats');
      expect(response.body).toHaveProperty('recentActivity');
    });
  });

  describe('Health Check', () => {
    it('should return health status', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/health')
        .expect(200);

      expect(response.body).toHaveProperty('status');
      expect(response.body.status).toBe('healthy');
    });
  });

  describe('Error Handling', () => {
    it('should handle unauthorized access', async () => {
      await request(app.getHttpServer())
        .get('/api/v1/users')
        .expect(401);
    });

    it('should handle invalid endpoints', async () => {
      await request(app.getHttpServer())
        .get('/api/v1/invalid-endpoint')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(404);
    });

    it('should handle validation errors', async () => {
      const invalidData = {
        email: 'invalid-email',
        password: '123', // Too short
      };

      await request(app.getHttpServer())
        .post('/api/v1/auth/register')
        .send(invalidData)
        .expect(400);
    });
  });

  describe('Performance Tests', () => {
    it('should handle concurrent requests', async () => {
      const promises = Array.from({ length: 10 }, () =>
        request(app.getHttpServer())
          .get('/api/v1/health')
          .expect(200)
      );

      const responses = await Promise.all(promises);
      responses.forEach(response => {
        expect(response.body.status).toBe('healthy');
      });
    });

    it('should respond within acceptable time', async () => {
      const startTime = Date.now();
      
      await request(app.getHttpServer())
        .get('/api/v1/health')
        .expect(200);

      const responseTime = Date.now() - startTime;
      expect(responseTime).toBeLessThan(1000); // Less than 1 second
    });
  });
});
