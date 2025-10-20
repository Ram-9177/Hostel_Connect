import { Test, TestingModule } from '@nestjs/testing';
import { QRTokenService } from '../src/common/utils/qr-token.service';

describe('QRTokenService', () => {
  let service: QRTokenService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [QRTokenService],
    }).compile();

    service = module.get<QRTokenService>(QRTokenService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should generate and validate gate pass token', () => {
    const payload = {
      type: 'GATE_PASS' as const,
      entityId: 'test-pass-id',
      studentId: 'test-student-id',
    };

    const token = service.generateToken(payload);
    expect(token).toBeDefined();
    expect(typeof token).toBe('string');

    const validatedPayload = service.validateToken(token);
    expect(validatedPayload).toBeDefined();
    expect(validatedPayload?.type).toBe('GATE_PASS');
    expect(validatedPayload?.entityId).toBe('test-pass-id');
    expect(validatedPayload?.studentId).toBe('test-student-id');
  });

  it('should generate and validate attendance token', () => {
    const payload = {
      type: 'ATTENDANCE' as const,
      entityId: 'test-session-id',
      sessionId: 'test-session-id',
      nonce: 'test-nonce',
    };

    const token = service.generateToken(payload);
    expect(token).toBeDefined();

    const validatedPayload = service.validateToken(token);
    expect(validatedPayload).toBeDefined();
    expect(validatedPayload?.type).toBe('ATTENDANCE');
    expect(validatedPayload?.entityId).toBe('test-session-id');
    expect(validatedPayload?.sessionId).toBe('test-session-id');
    expect(validatedPayload?.nonce).toBe('test-nonce');
  });

  it('should reject invalid token', () => {
    const invalidToken = 'invalid-token';
    const validatedPayload = service.validateToken(invalidToken);
    expect(validatedPayload).toBeNull();
  });

  it('should generate gate pass token', () => {
    const passId = 'test-pass-id';
    const studentId = 'test-student-id';

    const token = service.generateGatePassToken(passId, studentId);
    expect(token).toBeDefined();

    const validatedPayload = service.validateToken(token);
    expect(validatedPayload?.type).toBe('GATE_PASS');
    expect(validatedPayload?.entityId).toBe(passId);
    expect(validatedPayload?.studentId).toBe(studentId);
  });

  it('should generate attendance token', () => {
    const sessionId = 'test-session-id';
    const nonce = 'test-nonce';

    const token = service.generateAttendanceToken(sessionId, nonce);
    expect(token).toBeDefined();

    const validatedPayload = service.validateToken(token);
    expect(validatedPayload?.type).toBe('ATTENDANCE');
    expect(validatedPayload?.entityId).toBe(sessionId);
    expect(validatedPayload?.sessionId).toBe(sessionId);
    expect(validatedPayload?.nonce).toBe(nonce);
  });
});
