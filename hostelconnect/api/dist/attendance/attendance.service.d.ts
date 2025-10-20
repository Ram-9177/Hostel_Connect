import { Repository } from 'typeorm';
import { AttendanceSession } from './entities/attendance-session.entity';
import { AttendanceRoster } from './entities/attendance-roster.entity';
import { AttendanceCheck } from './entities/attendance-check.entity';
import { Student } from '../students/entities/student.entity';
import { Room } from '../rooms/entities/room.entity';
import { QRTokenService } from '../common/utils/qr-token.service';
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
export declare class AttendanceService {
    private readonly sessionRepository;
    private readonly rosterRepository;
    private readonly checkRepository;
    private readonly studentRepository;
    private readonly roomRepository;
    private readonly qrTokenService;
    constructor(sessionRepository: Repository<AttendanceSession>, rosterRepository: Repository<AttendanceRoster>, checkRepository: Repository<AttendanceCheck>, studentRepository: Repository<Student>, roomRepository: Repository<Room>, qrTokenService: QRTokenService);
    createSession(createDto: CreateAttendanceSessionDto): Promise<AttendanceSession>;
    private buildRoster;
    getRoster(sessionId: string): Promise<{
        sessionId: string;
        totalStudents: number;
        roster: any[];
    }>;
    scanAttendance(scanDto: ScanAttendanceDto): Promise<AttendanceCheck>;
    manualAttendance(manualDto: ManualAttendanceDto): Promise<AttendanceCheck>;
    closeSession(sessionId: string): Promise<AttendanceSession>;
    getSummary(sessionId: string): Promise<any>;
    generateAttendanceQR(sessionId: string): string;
}
