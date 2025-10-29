import { Injectable, NotFoundException, BadRequestException, forwardRef, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GatePass, GatePassType, GatePassStatus } from './entities/gate-pass.entity';
import { Student } from '../students/entities/student.entity';
import { CreateGatePassDto, ApproveGatePassDto, RejectGatePassDto } from './dto/create-gate-pass.dto';
import { SocketGateway } from '../socket/socket.gateway';
import * as crypto from 'crypto';

@Injectable()
export class GatePassService {
  constructor(
    @InjectRepository(GatePass)
    private readonly gatePassRepository: Repository<GatePass>,
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    @Inject(forwardRef(() => SocketGateway))
    private readonly socketGateway: SocketGateway,
  ) {}

  async createGatePass(createGatePassDto: CreateGatePassDto): Promise<GatePass> {
    // Find student
    const student = await this.studentRepository.findOne({
      where: { studentId: createGatePassDto.studentId }
    });

    if (!student) {
      throw new NotFoundException('Student not found');
    }

    const gatePass = this.gatePassRepository.create({
      ...createGatePassDto,
      firstName: student.firstName,
      lastName: student.lastName,
      hostelId: student.hostelId,
      roomNumber: student.roomNumber,
      type: createGatePassDto.type || GatePassType.REGULAR,
      isEmergency: createGatePassDto.isEmergency || false,
      status: GatePassStatus.PENDING,
    });

    const savedGatePass = await this.gatePassRepository.save(gatePass);

    // Emit real-time notification to wardens
    await this.socketGateway.sendNotificationToRole('WARDEN', {
      type: 'NEW_GATE_PASS_REQUEST',
      title: 'New Gate Pass Request',
      message: `${student.firstName} ${student.lastName} requested a gate pass`,
      data: savedGatePass,
    });

    return savedGatePass;
  }

  async getAllGatePasses(): Promise<GatePass[]> {
    return this.gatePassRepository.find({
      order: { createdAt: 'DESC' }
    });
  }

  async getPendingGatePasses(): Promise<GatePass[]> {
    return this.gatePassRepository.find({
      where: { status: GatePassStatus.PENDING },
      order: { createdAt: 'DESC' }
    });
  }

  async getStudentGatePasses(studentId: string): Promise<GatePass[]> {
    return this.gatePassRepository.find({
      where: { studentId },
      order: { createdAt: 'DESC' }
    });
  }

  async approveGatePass(id: string, approveDto: ApproveGatePassDto): Promise<GatePass> {
    const gatePass = await this.gatePassRepository.findOne({ where: { id } });

    if (!gatePass) {
      throw new NotFoundException('Gate pass not found');
    }

    if (gatePass.status !== GatePassStatus.PENDING) {
      throw new BadRequestException('Gate pass is not pending');
    }

    gatePass.status = GatePassStatus.APPROVED;
    gatePass.approvedBy = 'current-warden'; // This should come from JWT
    gatePass.approvedByName = 'Current Warden';
    gatePass.approvedAt = new Date();
    gatePass.decisionBy = 'current-warden';
    gatePass.decisionAt = new Date();
    gatePass.note = approveDto.reason;

    // Generate QR token for approved passes
    if (gatePass.status === GatePassStatus.APPROVED) {
      const qrToken = crypto.randomBytes(32).toString('hex');
      gatePass.qrTokenHash = qrToken;
      gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000); // 30 seconds
    }

    const savedGatePass = await this.gatePassRepository.save(gatePass);

    // Emit real-time notification to student
    await this.socketGateway.sendNotificationToUser(gatePass.studentId, {
      type: 'GATE_PASS_APPROVED',
      title: 'Gate Pass Approved',
      message: 'Your gate pass request has been approved',
      data: savedGatePass,
    });

    // Broadcast to all wardens for dashboard update
    await this.socketGateway.broadcastGatePassUpdate(id, savedGatePass);

    return savedGatePass;
  }

  async rejectGatePass(id: string, rejectDto: RejectGatePassDto): Promise<GatePass> {
    const gatePass = await this.gatePassRepository.findOne({ where: { id } });

    if (!gatePass) {
      throw new NotFoundException('Gate pass not found');
    }

    if (gatePass.status !== GatePassStatus.PENDING) {
      throw new BadRequestException('Gate pass is not pending');
    }

    gatePass.status = GatePassStatus.REJECTED;
    gatePass.rejectedBy = 'current-warden';
    gatePass.rejectedByName = 'Current Warden';
    gatePass.rejectedAt = new Date();
    gatePass.rejectionReason = rejectDto.reason;
    gatePass.decisionBy = 'current-warden';
    gatePass.decisionAt = new Date();

    const savedGatePass = await this.gatePassRepository.save(gatePass);

    // Emit real-time notification to student
    await this.socketGateway.sendNotificationToUser(gatePass.studentId, {
      type: 'GATE_PASS_REJECTED',
      title: 'Gate Pass Rejected',
      message: `Your gate pass request was rejected. Reason: ${rejectDto.reason}`,
      data: savedGatePass,
    });

    return savedGatePass;
  }

  async generateQRCode(id: string): Promise<{ qrToken: string; expiresAt: Date }> {
    const gatePass = await this.gatePassRepository.findOne({ where: { id } });

    if (!gatePass) {
      throw new NotFoundException('Gate pass not found');
    }

    if (gatePass.status !== GatePassStatus.APPROVED) {
      throw new BadRequestException('Gate pass is not approved');
    }

    if (!gatePass.qrTokenHash || !gatePass.qrTokenExpiresAt) {
      throw new BadRequestException('QR token not generated');
    }

    if (gatePass.qrTokenExpiresAt < new Date()) {
      throw new BadRequestException('QR token has expired');
    }

    return {
      qrToken: gatePass.qrTokenHash,
      expiresAt: gatePass.qrTokenExpiresAt,
    };
  }

  async useGatePass(id: string): Promise<GatePass> {
    const gatePass = await this.gatePassRepository.findOne({ where: { id } });

    if (!gatePass) {
      throw new NotFoundException('Gate pass not found');
    }

    if (gatePass.status !== GatePassStatus.APPROVED) {
      throw new BadRequestException('Gate pass is not approved');
    }

    // Check if it's an emergency pass
    if (gatePass.isEmergency) {
      // Emergency passes can be used multiple times
      gatePass.lastUsedAt = new Date();
    } else {
      // Regular passes are single-use
      gatePass.status = GatePassStatus.COMPLETED;
      gatePass.completedAt = new Date();
    }

    // Generate new QR token for next use
    const qrToken = crypto.randomBytes(32).toString('hex');
    gatePass.qrTokenHash = qrToken;
    gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000); // 30 seconds

    return this.gatePassRepository.save(gatePass);
  }

  async refreshQRToken(id: string): Promise<{ qrToken: string; expiresAt: Date }> {
    const gatePass = await this.gatePassRepository.findOne({ where: { id } });

    if (!gatePass) {
      throw new NotFoundException('Gate pass not found');
    }

    const qrToken = crypto.randomBytes(32).toString('hex');
    gatePass.qrTokenHash = qrToken;
    gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000); // 30 seconds

    await this.gatePassRepository.save(gatePass);

    return {
      qrToken: gatePass.qrTokenHash,
      expiresAt: gatePass.qrTokenExpiresAt,
    };
  }
}