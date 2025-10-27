import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GatePass, GatePassType, GatePassStatus } from './entities/gate-pass.entity';
import { QRTokenService } from '../common/utils/qr-token.service';
import { AdEvent, AdEventResult } from '../ads/entities/ad-event.entity';

export interface CreateGatePassDto {
  studentId: string;
  hostelId: string;
  type: GatePassType;
  startTime: Date;
  endTime: Date;
  reason: string;
  note?: string;
  isEmergency?: boolean;
}

export interface ApproveGatePassDto {
  approved: boolean;
  reason?: string;
}

@Injectable()
export class GatePassService {
  constructor(
    @InjectRepository(GatePass)
    private readonly gatePassRepository: Repository<GatePass>,
    @InjectRepository(AdEvent)
    private readonly adEventRepository: Repository<AdEvent>,
    private readonly qrTokenService: QRTokenService,
  ) {}

  async create(createDto: CreateGatePassDto, studentId: string): Promise<GatePass> {
    // Validate time range
    if (createDto.startTime >= createDto.endTime) {
      throw new BadRequestException('End time must be after start time');
    }

    // Check for overlapping passes
    const overlappingPass = await this.gatePassRepository.findOne({
      where: {
        studentId,
        status: GatePassStatus.APPROVED,
      },
    });

    if (overlappingPass) {
      const now = new Date();
      if (overlappingPass.startTime <= now && overlappingPass.endTime >= now) {
        throw new BadRequestException('Student already has an active gate pass');
      }
    }

    const gatePass = this.gatePassRepository.create({
      ...createDto,
      studentId,
    });

    return this.gatePassRepository.save(gatePass);
  }

  async findAll(studentId?: string, hostelId?: string): Promise<GatePass[]> {
    const where: any = {};
    if (studentId) where.studentId = studentId;
    if (hostelId) where.hostelId = hostelId;

    return this.gatePassRepository.find({
      where,
      relations: ['student', 'hostel', 'decisionByUser'],
      order: { createdAt: 'DESC' },
    });
  }

  async findById(id: string): Promise<GatePass> {
    const gatePass = await this.gatePassRepository.findOne({
      where: { id },
      relations: ['student', 'hostel', 'decisionByUser'],
    });

    if (!gatePass) {
      throw new NotFoundException('Gate pass not found');
    }

    return gatePass;
  }

  async approve(id: string, approveDto: ApproveGatePassDto, wardenId: string): Promise<GatePass> {
    const gatePass = await this.findById(id);

    if (gatePass.status !== GatePassStatus.PENDING) {
      throw new BadRequestException('Gate pass is not pending approval');
    }

    gatePass.status = approveDto.approved ? GatePassStatus.APPROVED : GatePassStatus.REJECTED;
    gatePass.decisionBy = wardenId;
    gatePass.decisionAt = new Date();
    gatePass.note = approveDto.reason;

    // Generate QR token if approved
    if (gatePass.status === GatePassStatus.APPROVED) {
      const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
      gatePass.qrTokenHash = qrToken;
      gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000); // 30 seconds
    }

    return this.gatePassRepository.save(gatePass);
  }

  async cancel(id: string, studentId: string): Promise<GatePass> {
    const gatePass = await this.findById(id);

    if (gatePass.studentId !== studentId) {
      throw new BadRequestException('You can only cancel your own gate pass');
    }

    if (gatePass.status !== GatePassStatus.PENDING) {
      throw new BadRequestException('Only pending gate passes can be cancelled');
    }

    gatePass.status = GatePassStatus.CANCELLED;
    return this.gatePassRepository.save(gatePass);
  }

  async getQRToken(id: string): Promise<{ qrToken: string; expiresAt: Date; adRequired: boolean }> {
    const gatePass = await this.findById(id);

    if (gatePass.status !== GatePassStatus.APPROVED) {
      throw new BadRequestException('Gate pass must be approved to get QR token');
    }

    // Check if emergency pass - bypass ad requirement
    if (gatePass.isEmergency) {
      const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
      return {
        qrToken,
        expiresAt: new Date(Date.now() + 30 * 1000),
        adRequired: false,
      };
    }

    // For non-emergency passes, check if ad has been watched
    const adWatched = await this.checkAdWatched(gatePass.studentId, 'gatepass');
    
    if (!adWatched) {
      return {
        qrToken: '',
        expiresAt: new Date(),
        adRequired: true,
      };
    }

    if (!gatePass.qrTokenHash || !gatePass.qrTokenExpiresAt) {
      throw new BadRequestException('QR token not available');
    }

    if (gatePass.qrTokenExpiresAt < new Date()) {
      throw new BadRequestException('QR token has expired');
    }

    return {
      qrToken: gatePass.qrTokenHash,
      expiresAt: gatePass.qrTokenExpiresAt,
      adRequired: false,
    };
  }

  async refreshQRToken(id: string): Promise<{ qrToken: string; expiresAt: Date }> {
    const gatePass = await this.findById(id);

    if (gatePass.status !== GatePassStatus.APPROVED) {
      throw new BadRequestException('Gate pass must be approved to refresh QR token');
    }

    const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
    gatePass.qrTokenHash = qrToken;
    gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000); // 30 seconds

    await this.gatePassRepository.save(gatePass);

    return {
      qrToken,
      expiresAt: gatePass.qrTokenExpiresAt,
    };
  }

  async checkAdWatched(studentId: string, module: string): Promise<boolean> {
    // Check if student has watched a completed ad for this module in the last 24 hours
    const twentyFourHoursAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);
    
    const adEvent = await this.adEventRepository.findOne({
      where: {
        userId: studentId,
        module,
        result: AdEventResult.COMPLETED,
        timestamp: { $gte: twentyFourHoursAgo } as any,
      },
      order: { timestamp: 'DESC' },
    });

    return !!adEvent;
  }

  async markAdWatched(studentId: string, adId: string, module: string): Promise<void> {
    // Create ad event for completed ad
    const adEvent = this.adEventRepository.create({
      adId,
      userId: studentId,
      module,
      result: AdEventResult.COMPLETED,
      timestamp: new Date(),
    });

    await this.adEventRepository.save(adEvent);
  }

  async unlockQRTokenAfterAd(id: string, studentId: string): Promise<{ qrToken: string; expiresAt: Date }> {
    const gatePass = await this.findById(id);

    if (gatePass.status !== GatePassStatus.APPROVED) {
      throw new BadRequestException('Gate pass must be approved to unlock QR token');
    }

    if (gatePass.studentId !== studentId) {
      throw new BadRequestException('You can only unlock your own gate pass');
    }

    // Generate new QR token
    const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
    gatePass.qrTokenHash = qrToken;
    gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000); // 30 seconds

    await this.gatePassRepository.save(gatePass);

    return {
      qrToken,
      expiresAt: gatePass.qrTokenExpiresAt,
    };
  }
}
