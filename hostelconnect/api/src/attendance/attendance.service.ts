import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { AttendanceSession } from './entities/attendance-session.entity';
import { AttendanceRoster } from './entities/attendance-roster.entity';
import { AttendanceCheck } from './entities/attendance-check.entity';
import { Student } from '../students/entities/student.entity';
import { Room } from '../rooms/entities/room.entity';
import { QRTokenService } from '../common/utils/qr-token.service';
import * as crypto from 'crypto';

export interface CreateAttendanceSessionDto {
  hostelId: string;
  wingIds: string[];
  date: Date;
  slot: string;
  startTime: Date;
  endTime: Date;
  mode: string;
}

export interface ScanAttendanceDto {
  sessionId: string;
  qrToken: string;
  deviceId?: string;
  wardenId?: string;
}

export interface ManualAttendanceDto {
  sessionId: string;
  studentId: string;
  wardenId: string;
  reason: string;
  photoUrl?: string;
}

@Injectable()
export class AttendanceService {
  constructor(
    @InjectRepository(AttendanceSession)
    private readonly sessionRepository: Repository<AttendanceSession>,
    @InjectRepository(AttendanceRoster)
    private readonly rosterRepository: Repository<AttendanceRoster>,
    @InjectRepository(AttendanceCheck)
    private readonly checkRepository: Repository<AttendanceCheck>,
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    @InjectRepository(Room)
    private readonly roomRepository: Repository<Room>,
    private readonly qrTokenService: QRTokenService,
  ) {}

  async createSession(createDto: CreateAttendanceSessionDto): Promise<AttendanceSession> {
    // Validate time range
    if (createDto.startTime >= createDto.endTime) {
      throw new BadRequestException('End time must be after start time');
    }

    // Check for overlapping sessions
    const overlappingSession = await this.sessionRepository.findOne({
      where: {
        hostelId: createDto.hostelId,
        date: createDto.date,
        slot: createDto.slot,
        status: 'ACTIVE',
      },
    });

    if (overlappingSession) {
      throw new BadRequestException('Active session already exists for this slot');
    }

    // Generate nonce for QR token
    const nonce = crypto.randomBytes(16).toString('hex');

    const session = this.sessionRepository.create({
      ...createDto,
      nonce,
    });

    const savedSession = await this.sessionRepository.save(session);

    // Build roster for the session
    await this.buildRoster(savedSession.id, createDto.hostelId, createDto.wingIds);

    return savedSession;
  }

  private async buildRoster(sessionId: string, hostelId: string, wingIds: string[]): Promise<void> {
    // Get all active students
    const students = await this.studentRepository.find({
      where: {
        isActive: true,
        hostelId: hostelId,
      },
    });

    // For now, include all students in the hostel (wing filtering can be added later)
    const filteredStudents = students;

    // Create roster entries
    const rosterEntries = filteredStudents.map(student => 
      this.rosterRepository.create({
        sessionId,
        studentId: student.id,
        roomId: student.roomId,
      })
    );

    await this.rosterRepository.save(rosterEntries);
  }

  async getRoster(sessionId: string): Promise<{ sessionId: string; totalStudents: number; roster: any[] }> {
    const roster = await this.rosterRepository.find({
      where: { sessionId },
      relations: ['student', 'room'],
    });

    return {
      sessionId,
      totalStudents: roster.length,
      roster: roster.map(entry => ({
        studentId: entry.studentId,
        studentName: `${entry.student.firstName} ${entry.student.lastName}`,
        roomNumber: entry.room.roomNumber,
        bedNumber: entry.student.studentId, // Using studentId as bed identifier
      })),
    };
  }

  async scanAttendance(scanDto: ScanAttendanceDto): Promise<AttendanceCheck> {
    // Validate QR token
    const tokenPayload = this.qrTokenService.validateToken(scanDto.qrToken);
    if (!tokenPayload || tokenPayload.type !== 'ATTENDANCE') {
      throw new BadRequestException('Invalid or expired QR token');
    }

    // Verify session nonce
    const session = await this.sessionRepository.findOne({
      where: { id: scanDto.sessionId },
    });

    if (!session) {
      throw new NotFoundException('Attendance session not found');
    }

    if (session.nonce !== tokenPayload.nonce) {
      throw new BadRequestException('Invalid QR token for this session');
    }

    if (session.status !== 'ACTIVE') {
      throw new BadRequestException('Attendance session is not active');
    }

    // Check if student is in roster
    const rosterEntry = await this.rosterRepository.findOne({
      where: {
        sessionId: scanDto.sessionId,
        studentId: tokenPayload.studentId,
      },
    });

    if (!rosterEntry) {
      throw new BadRequestException('Student not in attendance roster');
    }

    // Check for duplicate attendance
    const existingCheck = await this.checkRepository.findOne({
      where: {
        sessionId: scanDto.sessionId,
        studentId: tokenPayload.studentId,
      },
    });

    if (existingCheck) {
      throw new BadRequestException('Attendance already recorded for this student');
    }

    // Create attendance check
    const attendanceCheck = this.checkRepository.create({
      sessionId: scanDto.sessionId,
      studentId: tokenPayload.studentId,
      method: 'STUDENT_QR',
      timestamp: new Date(),
      deviceId: scanDto.deviceId,
      wardenId: scanDto.wardenId,
    });

    return this.checkRepository.save(attendanceCheck);
  }

  async manualAttendance(manualDto: ManualAttendanceDto): Promise<AttendanceCheck> {
    const session = await this.sessionRepository.findOne({
      where: { id: manualDto.sessionId },
    });

    if (!session) {
      throw new NotFoundException('Attendance session not found');
    }

    if (session.status !== 'ACTIVE') {
      throw new BadRequestException('Attendance session is not active');
    }

    // Check if student is in roster
    const rosterEntry = await this.rosterRepository.findOne({
      where: {
        sessionId: manualDto.sessionId,
        studentId: manualDto.studentId,
      },
    });

    if (!rosterEntry) {
      throw new BadRequestException('Student not in attendance roster');
    }

    // Check for duplicate attendance
    const existingCheck = await this.checkRepository.findOne({
      where: {
        sessionId: manualDto.sessionId,
        studentId: manualDto.studentId,
      },
    });

    if (existingCheck) {
      throw new BadRequestException('Attendance already recorded for this student');
    }

    // Create manual attendance check
    const attendanceCheck = this.checkRepository.create({
      sessionId: manualDto.sessionId,
      studentId: manualDto.studentId,
      method: 'MANUAL',
      timestamp: new Date(),
      wardenId: manualDto.wardenId,
      reason: manualDto.reason,
      photoUrl: manualDto.photoUrl,
    });

    return this.checkRepository.save(attendanceCheck);
  }

  async closeSession(sessionId: string): Promise<AttendanceSession> {
    const session = await this.sessionRepository.findOne({
      where: { id: sessionId },
    });

    if (!session) {
      throw new NotFoundException('Attendance session not found');
    }

    if (session.status !== 'ACTIVE') {
      throw new BadRequestException('Session is not active');
    }

    session.status = 'CLOSED';
    return this.sessionRepository.save(session);
  }

  async getSummary(sessionId: string): Promise<any> {
    const session = await this.sessionRepository.findOne({
      where: { id: sessionId },
    });

    if (!session) {
      throw new NotFoundException('Attendance session not found');
    }

    const roster = await this.rosterRepository.find({
      where: { sessionId },
    });

    const checks = await this.checkRepository.find({
      where: { sessionId },
    });

    const totalRoster = roster.length;
    const scannedCount = checks.length;
    const manualCount = checks.filter(c => c.method === 'MANUAL').length;
    const kioskCount = checks.filter(c => c.deviceId && c.device?.type === 'KIOSK_SCANNER').length;
    const wardenCount = checks.filter(c => c.deviceId && c.device?.type === 'WARDEN_SCANNER').length;
    const attendancePercentage = totalRoster > 0 ? (scannedCount / totalRoster) * 100 : 0;

    return {
      sessionId,
      hostelId: session.hostelId,
      date: session.date,
      slot: session.slot,
      mode: session.mode,
      totalRoster,
      scannedCount,
      manualCount,
      kioskCount,
      wardenCount,
      attendancePercentage: Math.round(attendancePercentage * 100) / 100,
      updatedAt: session.updatedAt,
    };
  }

  generateAttendanceQR(sessionId: string): string {
    const session = this.sessionRepository.findOne({ where: { id: sessionId } });
    if (!session) {
      throw new NotFoundException('Attendance session not found');
    }

    return this.qrTokenService.generateAttendanceToken(sessionId, 'nonce');
  }
}
