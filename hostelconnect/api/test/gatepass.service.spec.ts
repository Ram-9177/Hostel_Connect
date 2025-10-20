import { Test, TestingModule } from '@nestjs/testing';
import { GatePassService } from '../src/gatepass/gatepass.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { GatePass } from '../src/gatepass/entities/gate-pass.entity';
import { AdEvent } from '../src/ads/entities/ad-event.entity';
import { QRTokenService } from '../src/common/utils/qr-token.service';

describe('GatePassService', () => {
  let service: GatePassService;
  let gatePassRepository: any;
  let adEventRepository: any;
  let qrTokenService: QRTokenService;

  const mockGatePass = {
    id: 'test-pass-id',
    studentId: 'test-student-id',
    hostelId: 'test-hostel-id',
    type: 'OUTING',
    startTime: new Date('2024-01-15T10:00:00Z'),
    endTime: new Date('2024-01-15T18:00:00Z'),
    status: 'APPROVED',
    reason: 'Test reason',
    isEmergency: false,
    qrTokenHash: 'test-token',
    qrTokenExpiresAt: new Date(Date.now() + 30000),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        GatePassService,
        {
          provide: getRepositoryToken(GatePass),
          useValue: {
            create: jest.fn(),
            save: jest.fn(),
            findOne: jest.fn(),
            find: jest.fn(),
            update: jest.fn(),
          },
        },
        {
          provide: getRepositoryToken(AdEvent),
          useValue: {
            create: jest.fn(),
            save: jest.fn(),
            findOne: jest.fn(),
          },
        },
        {
          provide: QRTokenService,
          useValue: {
            generateGatePassToken: jest.fn(),
            validateToken: jest.fn(),
          },
        },
      ],
    }).compile();

    service = module.get<GatePassService>(GatePassService);
    gatePassRepository = module.get(getRepositoryToken(GatePass));
    adEventRepository = module.get(getRepositoryToken(AdEvent));
    qrTokenService = module.get<QRTokenService>(QRTokenService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should create gate pass', async () => {
    const createDto = {
      studentId: 'test-student-id',
      hostelId: 'test-hostel-id',
      type: 'OUTING' as const,
      startTime: new Date('2024-01-15T10:00:00Z'),
      endTime: new Date('2024-01-15T18:00:00Z'),
      reason: 'Test reason',
    };

    gatePassRepository.create.mockReturnValue(mockGatePass);
    gatePassRepository.save.mockResolvedValue(mockGatePass);
    gatePassRepository.findOne.mockResolvedValue(null); // No overlapping passes

    const result = await service.create(createDto, 'test-student-id');
    expect(result).toBeDefined();
    expect(result.studentId).toBe('test-student-id');
  });

  it('should get QR token for approved gate pass', async () => {
    gatePassRepository.findOne.mockResolvedValue(mockGatePass);
    jest.spyOn(service, 'checkAdWatched').mockResolvedValue(true);

    const result = await service.getQRToken('test-pass-id');
    expect(result).toBeDefined();
    expect(result.qrToken).toBe('test-token');
    expect(result.adRequired).toBe(false);
  });

  it('should require ad for non-emergency gate pass', async () => {
    gatePassRepository.findOne.mockResolvedValue(mockGatePass);
    jest.spyOn(service, 'checkAdWatched').mockResolvedValue(false);

    const result = await service.getQRToken('test-pass-id');
    expect(result).toBeDefined();
    expect(result.adRequired).toBe(true);
    expect(result.qrToken).toBe('');
  });

  it('should bypass ad requirement for emergency gate pass', async () => {
    const emergencyPass = { ...mockGatePass, isEmergency: true };
    gatePassRepository.findOne.mockResolvedValue(emergencyPass);
    qrTokenService.generateGatePassToken.mockReturnValue('emergency-token');

    const result = await service.getQRToken('test-pass-id');
    expect(result).toBeDefined();
    expect(result.adRequired).toBe(false);
    expect(result.qrToken).toBe('emergency-token');
  });
});
