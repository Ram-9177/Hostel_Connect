import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GateEvent } from './entities/gate-event.entity';
import { GatePass } from '../gatepass/entities/gate-pass.entity';
import { QRTokenService } from '../common/utils/qr-token.service';

export interface ScanGatePassDto {
  qrToken: string;
  eventType: string;
  deviceId?: string;
  guardUserId?: string;
  latitude?: number;
  longitude?: number;
}

@Injectable()
export class GateService {
  constructor(
    @InjectRepository(GateEvent)
    private readonly gateEventRepository: Repository<GateEvent>,
    @InjectRepository(GatePass)
    private readonly gatePassRepository: Repository<GatePass>,
    private readonly qrTokenService: QRTokenService,
  ) {}

  async scanGatePass(scanDto: ScanGatePassDto): Promise<GateEvent> {
    // Validate QR token
    const tokenPayload = this.qrTokenService.validateToken(scanDto.qrToken);
    if (!tokenPayload || tokenPayload.type !== 'GATE_PASS') {
      throw new BadRequestException('Invalid or expired QR token');
    }

    // Find the gate pass
    const gatePass = await this.gatePassRepository.findOne({
      where: { id: tokenPayload.entityId },
      relations: ['student'],
    });

    if (!gatePass) {
      throw new NotFoundException('Gate pass not found');
    }

    // Validate gate pass status
    if (gatePass.status !== 'APPROVED') {
      throw new BadRequestException('Gate pass is not approved');
    }

    // Check if gate pass is still valid
    const now = new Date();
    if (now < gatePass.startTime || now > gatePass.endTime) {
      throw new BadRequestException('Gate pass is not valid at this time');
    }

    // Check for duplicate events
    const existingEvent = await this.gateEventRepository.findOne({
      where: {
        passId: gatePass.id,
        eventType: scanDto.eventType,
      },
      order: { timestamp: 'DESC' },
    });

    if (existingEvent) {
      // Check if this is a duplicate scan within 5 minutes
      const timeDiff = now.getTime() - existingEvent.timestamp.getTime();
      if (timeDiff < 5 * 60 * 1000) { // 5 minutes
        throw new BadRequestException('Duplicate scan detected');
      }
    }

    // Create gate event
    const gateEvent = this.gateEventRepository.create({
      passId: gatePass.id,
      studentId: gatePass.studentId,
      eventType: scanDto.eventType,
      method: 'QR_SCAN',
      deviceId: scanDto.deviceId,
      guardUserId: scanDto.guardUserId,
      timestamp: now,
      latitude: scanDto.latitude,
      longitude: scanDto.longitude,
    });

    const savedEvent = await this.gateEventRepository.save(gateEvent);

    // Update gate pass status if needed
    if (scanDto.eventType === 'OUT') {
      // Mark as used when student goes out
      await this.gatePassRepository.update(gatePass.id, {
        status: 'EXPIRED',
      });
    }

    return savedEvent;
  }

  async getGatePassEvents(passId: string): Promise<GateEvent[]> {
    return this.gateEventRepository.find({
      where: { passId },
      order: { timestamp: 'ASC' },
    });
  }

  async getStudentGateEvents(studentId: string, limit: number = 10): Promise<GateEvent[]> {
    return this.gateEventRepository.find({
      where: { studentId },
      order: { timestamp: 'DESC' },
      take: limit,
    });
  }
}