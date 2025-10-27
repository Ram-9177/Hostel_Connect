import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GateEvent } from './entities/gate-event.entity';
import { GatePass, GatePassStatus } from '../gatepass/entities/gate-pass.entity';
import { ScanGatePassDto } from './dto/scan-gate-pass.dto';

@Injectable()
export class GateService {
  constructor(
    @InjectRepository(GateEvent)
    private readonly gateEventRepository: Repository<GateEvent>,
    @InjectRepository(GatePass)
    private readonly gatePassRepository: Repository<GatePass>,
  ) {}

  async scanGatePass(scanDto: ScanGatePassDto) {
    try {
      // Validate gate pass
      const gatePass = await this.validateGatePass(scanDto.qrCode);
      
      if (!gatePass) {
        return {
          success: false,
          message: 'Invalid or expired gate pass',
          event: null
        };
      }

      // Determine event type (IN/OUT)
      const eventType = await this.determineEventType(gatePass.studentId);

      // Create gate event
      const gateEvent = this.gateEventRepository.create({
        gatePassId: gatePass.id,
        studentId: gatePass.studentId,
        studentName: `${gatePass.firstName} ${gatePass.lastName}`,
        eventType,
        timestamp: new Date(),
        location: scanDto.location || 'Main Gate',
        status: 'SUCCESS',
        qrCode: scanDto.qrCode,
      });

      const savedEvent = await this.gateEventRepository.save(gateEvent);

      // Update gate pass status if needed
      if (eventType === 'OUT') {
        await this.gatePassRepository.update(gatePass.id, {
          status: GatePassStatus.ACTIVE,
          lastUsedAt: new Date(),
        });
      } else if (eventType === 'IN') {
        await this.gatePassRepository.update(gatePass.id, {
          status: GatePassStatus.COMPLETED,
          completedAt: new Date(),
        });
      }

      return {
        success: true,
        message: `Student ${eventType === 'OUT' ? 'exited' : 'entered'} successfully`,
        event: savedEvent,
        gatePass: gatePass
      };

    } catch (error) {
      console.error('Gate scan error:', error);
      
      // Record failed event
      const failedEvent = this.gateEventRepository.create({
        gatePassId: null,
        studentId: null,
        studentName: 'Unknown',
        eventType: 'UNKNOWN',
        timestamp: new Date(),
        location: scanDto.location || 'Main Gate',
        status: 'FAILED',
        qrCode: scanDto.qrCode,
        reason: error.message,
      });

      await this.gateEventRepository.save(failedEvent);

      return {
        success: false,
        message: 'Failed to process gate pass',
        error: error.message,
        event: failedEvent
      };
    }
  }

  async validateGatePass(qrCode: string) {
    try {
      // Parse QR code to get gate pass ID
      const passId = this.extractPassIdFromQR(qrCode);
      
      if (!passId) {
        return null;
      }

      // Find gate pass
      const gatePass = await this.gatePassRepository.findOne({
        where: { id: passId }
      });

      if (!gatePass) {
        return null;
      }

      // Check if pass is approved
      if (gatePass.status !== 'APPROVED') {
        return null;
      }

      // Check if pass is within valid time range
      const now = new Date();
      const startTime = new Date(gatePass.startTime);
      const endTime = new Date(gatePass.endTime);

      if (now < startTime || now > endTime) {
        return null;
      }

      return gatePass;

    } catch (error) {
      console.error('Gate pass validation error:', error);
      return null;
    }
  }

  async determineEventType(studentId: string): Promise<'IN' | 'OUT'> {
    // Find the most recent gate event for this student
    const recentEvent = await this.gateEventRepository.findOne({
      where: { studentId },
      order: { timestamp: 'DESC' }
    });

    // If no recent event or last event was IN, this should be OUT
    if (!recentEvent || recentEvent.eventType === 'IN') {
      return 'OUT';
    }

    // If last event was OUT, this should be IN
    return 'IN';
  }

  async getGateEvents() {
    return this.gateEventRepository.find({
      order: { timestamp: 'DESC' },
      take: 100
    });
  }

  async getTodayEvents() {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    return this.gateEventRepository.find({
      where: {
        timestamp: {
          $gte: today,
          $lt: tomorrow
        } as any
      },
      order: { timestamp: 'DESC' }
    });
  }

  async getStudentEvents(studentId: string) {
    return this.gateEventRepository.find({
      where: { studentId },
      order: { timestamp: 'DESC' },
      take: 50
    });
  }

  async getGateStats() {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const todayEvents = await this.gateEventRepository.find({
      where: {
        timestamp: {
          $gte: today,
          $lt: tomorrow
        } as any
      }
    });

    const stats = {
      totalScans: todayEvents.length,
      successfulScans: todayEvents.filter(e => e.status === 'SUCCESS').length,
      failedScans: todayEvents.filter(e => e.status === 'FAILED').length,
      studentsOut: todayEvents.filter(e => e.eventType === 'OUT').length,
      studentsIn: todayEvents.filter(e => e.eventType === 'IN').length,
      uniqueStudents: new Set(todayEvents.map(e => e.studentId)).size,
    };

    return stats;
  }

  private extractPassIdFromQR(qrCode: string): string | null {
    try {
      // Try to parse as JSON first
      const parsed = JSON.parse(qrCode);
      return parsed.passId || parsed.id || null;
    } catch {
      // If not JSON, assume it's just the pass ID
      return qrCode;
    }
  }
}