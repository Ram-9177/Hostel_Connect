"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AttendanceService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const attendance_session_entity_1 = require("./entities/attendance-session.entity");
const attendance_roster_entity_1 = require("./entities/attendance-roster.entity");
const attendance_check_entity_1 = require("./entities/attendance-check.entity");
const student_entity_1 = require("../students/entities/student.entity");
const room_entity_1 = require("../rooms/entities/room.entity");
const qr_token_service_1 = require("../common/utils/qr-token.service");
const crypto = require("crypto");
let AttendanceService = class AttendanceService {
    constructor(sessionRepository, rosterRepository, checkRepository, studentRepository, roomRepository, qrTokenService) {
        this.sessionRepository = sessionRepository;
        this.rosterRepository = rosterRepository;
        this.checkRepository = checkRepository;
        this.studentRepository = studentRepository;
        this.roomRepository = roomRepository;
        this.qrTokenService = qrTokenService;
    }
    async createSession(createDto) {
        if (createDto.startTime >= createDto.endTime) {
            throw new common_1.BadRequestException('End time must be after start time');
        }
        const overlappingSession = await this.sessionRepository.findOne({
            where: {
                hostelId: createDto.hostelId,
                date: createDto.date,
                slot: createDto.slot,
                status: 'ACTIVE',
            },
        });
        if (overlappingSession) {
            throw new common_1.BadRequestException('Active session already exists for this slot');
        }
        const nonce = crypto.randomBytes(16).toString('hex');
        const session = this.sessionRepository.create({
            ...createDto,
            nonce,
        });
        const savedSession = await this.sessionRepository.save(session);
        await this.buildRoster(savedSession.id, createDto.hostelId, createDto.wingIds);
        return savedSession;
    }
    async buildRoster(sessionId, hostelId, wingIds) {
        const students = await this.studentRepository.find({
            where: {
                isActive: true,
                hostelId: hostelId,
            },
        });
        const filteredStudents = students;
        const rosterEntries = filteredStudents.map(student => this.rosterRepository.create({
            sessionId,
            studentId: student.id,
            roomId: student.roomId,
        }));
        await this.rosterRepository.save(rosterEntries);
    }
    async getRoster(sessionId) {
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
                bedNumber: entry.student.studentId,
            })),
        };
    }
    async scanAttendance(scanDto) {
        const tokenPayload = this.qrTokenService.validateToken(scanDto.qrToken);
        if (!tokenPayload || tokenPayload.type !== 'ATTENDANCE') {
            throw new common_1.BadRequestException('Invalid or expired QR token');
        }
        const session = await this.sessionRepository.findOne({
            where: { id: scanDto.sessionId },
        });
        if (!session) {
            throw new common_1.NotFoundException('Attendance session not found');
        }
        if (session.nonce !== tokenPayload.nonce) {
            throw new common_1.BadRequestException('Invalid QR token for this session');
        }
        if (session.status !== 'ACTIVE') {
            throw new common_1.BadRequestException('Attendance session is not active');
        }
        const rosterEntry = await this.rosterRepository.findOne({
            where: {
                sessionId: scanDto.sessionId,
                studentId: tokenPayload.studentId,
            },
        });
        if (!rosterEntry) {
            throw new common_1.BadRequestException('Student not in attendance roster');
        }
        const existingCheck = await this.checkRepository.findOne({
            where: {
                sessionId: scanDto.sessionId,
                studentId: tokenPayload.studentId,
            },
        });
        if (existingCheck) {
            throw new common_1.BadRequestException('Attendance already recorded for this student');
        }
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
    async manualAttendance(manualDto) {
        const session = await this.sessionRepository.findOne({
            where: { id: manualDto.sessionId },
        });
        if (!session) {
            throw new common_1.NotFoundException('Attendance session not found');
        }
        if (session.status !== 'ACTIVE') {
            throw new common_1.BadRequestException('Attendance session is not active');
        }
        const rosterEntry = await this.rosterRepository.findOne({
            where: {
                sessionId: manualDto.sessionId,
                studentId: manualDto.studentId,
            },
        });
        if (!rosterEntry) {
            throw new common_1.BadRequestException('Student not in attendance roster');
        }
        const existingCheck = await this.checkRepository.findOne({
            where: {
                sessionId: manualDto.sessionId,
                studentId: manualDto.studentId,
            },
        });
        if (existingCheck) {
            throw new common_1.BadRequestException('Attendance already recorded for this student');
        }
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
    async closeSession(sessionId) {
        const session = await this.sessionRepository.findOne({
            where: { id: sessionId },
        });
        if (!session) {
            throw new common_1.NotFoundException('Attendance session not found');
        }
        if (session.status !== 'ACTIVE') {
            throw new common_1.BadRequestException('Session is not active');
        }
        session.status = 'CLOSED';
        return this.sessionRepository.save(session);
    }
    async getSummary(sessionId) {
        const session = await this.sessionRepository.findOne({
            where: { id: sessionId },
        });
        if (!session) {
            throw new common_1.NotFoundException('Attendance session not found');
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
    generateAttendanceQR(sessionId) {
        const session = this.sessionRepository.findOne({ where: { id: sessionId } });
        if (!session) {
            throw new common_1.NotFoundException('Attendance session not found');
        }
        return this.qrTokenService.generateAttendanceToken(sessionId, 'nonce');
    }
};
exports.AttendanceService = AttendanceService;
exports.AttendanceService = AttendanceService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(attendance_session_entity_1.AttendanceSession)),
    __param(1, (0, typeorm_1.InjectRepository)(attendance_roster_entity_1.AttendanceRoster)),
    __param(2, (0, typeorm_1.InjectRepository)(attendance_check_entity_1.AttendanceCheck)),
    __param(3, (0, typeorm_1.InjectRepository)(student_entity_1.Student)),
    __param(4, (0, typeorm_1.InjectRepository)(room_entity_1.Room)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        qr_token_service_1.QRTokenService])
], AttendanceService);
//# sourceMappingURL=attendance.service.js.map