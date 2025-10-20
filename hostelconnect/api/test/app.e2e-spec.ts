import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';

describe('HostelConnect API (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  afterEach(async () => {
    await app.close();
  });

  it('/ (GET)', () => {
    return request(app.getHttpServer())
      .get('/')
      .expect(200)
      .expect((res) => {
        expect(res.body.success).toBe(true);
        expect(res.body.data).toContain('HostelConnect');
      });
  });

  it('/health (GET)', () => {
    return request(app.getHttpServer())
      .get('/health')
      .expect(200)
      .expect((res) => {
        expect(res.body.success).toBe(true);
        expect(res.body.data.status).toBe('healthy');
        expect(res.body.data.version).toBeDefined();
      });
  });

  it('/api (GET)', () => {
    return request(app.getHttpServer())
      .get('/api')
      .expect(200);
  });

  it('/auth/login (POST) - should reject invalid credentials', () => {
    return request(app.getHttpServer())
      .post('/auth/login')
      .send({
        email: 'invalid@example.com',
        password: 'wrongpassword',
      })
      .expect(401)
      .expect((res) => {
        expect(res.body.success).toBe(false);
        expect(res.body.error).toBeDefined();
      });
  });

  it('/gate-pass (POST) - should require authentication', () => {
    return request(app.getHttpServer())
      .post('/gate-pass')
      .send({
        studentId: 'test-id',
        hostelId: 'test-hostel-id',
        type: 'OUTING',
        startTime: '2024-01-15T10:00:00Z',
        endTime: '2024-01-15T18:00:00Z',
        reason: 'Test reason',
      })
      .expect(401);
  });

  it('/dash/hostel-live (GET) - should require authentication', () => {
    return request(app.getHttpServer())
      .get('/dash/hostel-live')
      .expect(401);
  });

  it('/ads/eligible (GET) - should require authentication', () => {
    return request(app.getHttpServer())
      .get('/ads/eligible?module=gatepass')
      .expect(401);
  });
});
