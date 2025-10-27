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
exports.GatePassService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const gate_pass_entity_1 = require("./entities/gate-pass.entity");
const student_entity_1 = require("../students/entities/student.entity");
const crypto = require("crypto");
let GatePassService = class GatePassService {
    constructor(gatePassRepository, studentRepository) {
        this.gatePassRepository = gatePassRepository;
        this.studentRepository = studentRepository;
    }
    async createGatePass(createGatePassDto) {
        const student = await this.studentRepository.findOne({
            where: { studentId: createGatePassDto.studentId }
        });
        if (!student) {
            throw new common_1.NotFoundException('Student not found');
        }
        const gatePass = this.gatePassRepository.create({
            ...createGatePassDto,
            firstName: student.firstName,
            lastName: student.lastName,
            hostelId: student.hostelId,
            roomNumber: student.roomNumber,
            type: createGatePassDto.type || gate_pass_entity_1.GatePassType.REGULAR,
            isEmergency: createGatePassDto.isEmergency || false,
            status: gate_pass_entity_1.GatePassStatus.PENDING,
        });
        return this.gatePassRepository.save(gatePass);
    }
    async getAllGatePasses() {
        return this.gatePassRepository.find({
            order: { createdAt: 'DESC' }
        });
    }
    async getPendingGatePasses() {
        return this.gatePassRepository.find({
            where: { status: gate_pass_entity_1.GatePassStatus.PENDING },
            order: { createdAt: 'DESC' }
        });
    }
    async getStudentGatePasses(studentId) {
        return this.gatePassRepository.find({
            where: { studentId },
            order: { createdAt: 'DESC' }
        });
    }
    async approveGatePass(id, approveDto) {
        const gatePass = await this.gatePassRepository.findOne({ where: { id } });
        if (!gatePass) {
            throw new common_1.NotFoundException('Gate pass not found');
        }
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.PENDING) {
            throw new common_1.BadRequestException('Gate pass is not pending');
        }
        gatePass.status = gate_pass_entity_1.GatePassStatus.APPROVED;
        gatePass.approvedBy = 'current-warden';
        gatePass.approvedByName = 'Current Warden';
        gatePass.approvedAt = new Date();
        gatePass.decisionBy = 'current-warden';
        gatePass.decisionAt = new Date();
        gatePass.note = approveDto.reason;
        if (gatePass.status === gate_pass_entity_1.GatePassStatus.APPROVED) {
            const qrToken = crypto.randomBytes(32).toString('hex');
            gatePass.qrTokenHash = qrToken;
            gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000);
        }
        return this.gatePassRepository.save(gatePass);
    }
    async rejectGatePass(id, rejectDto) {
        const gatePass = await this.gatePassRepository.findOne({ where: { id } });
        if (!gatePass) {
            throw new common_1.NotFoundException('Gate pass not found');
        }
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.PENDING) {
            throw new common_1.BadRequestException('Gate pass is not pending');
        }
        gatePass.status = gate_pass_entity_1.GatePassStatus.REJECTED;
        gatePass.rejectedBy = 'current-warden';
        gatePass.rejectedByName = 'Current Warden';
        gatePass.rejectedAt = new Date();
        gatePass.rejectionReason = rejectDto.reason;
        gatePass.decisionBy = 'current-warden';
        gatePass.decisionAt = new Date();
        return this.gatePassRepository.save(gatePass);
    }
    async generateQRCode(id) {
        const gatePass = await this.gatePassRepository.findOne({ where: { id } });
        if (!gatePass) {
            throw new common_1.NotFoundException('Gate pass not found');
        }
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.APPROVED) {
            throw new common_1.BadRequestException('Gate pass is not approved');
        }
        if (!gatePass.qrTokenHash || !gatePass.qrTokenExpiresAt) {
            throw new common_1.BadRequestException('QR token not generated');
        }
        if (gatePass.qrTokenExpiresAt < new Date()) {
            throw new common_1.BadRequestException('QR token has expired');
        }
        return {
            qrToken: gatePass.qrTokenHash,
            expiresAt: gatePass.qrTokenExpiresAt,
        };
    }
    async useGatePass(id) {
        const gatePass = await this.gatePassRepository.findOne({ where: { id } });
        if (!gatePass) {
            throw new common_1.NotFoundException('Gate pass not found');
        }
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.APPROVED) {
            throw new common_1.BadRequestException('Gate pass is not approved');
        }
        if (gatePass.isEmergency) {
            gatePass.lastUsedAt = new Date();
        }
        else {
            gatePass.status = gate_pass_entity_1.GatePassStatus.COMPLETED;
            gatePass.completedAt = new Date();
        }
        const qrToken = crypto.randomBytes(32).toString('hex');
        gatePass.qrTokenHash = qrToken;
        gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000);
        return this.gatePassRepository.save(gatePass);
    }
    async refreshQRToken(id) {
        const gatePass = await this.gatePassRepository.findOne({ where: { id } });
        if (!gatePass) {
            throw new common_1.NotFoundException('Gate pass not found');
        }
        const qrToken = crypto.randomBytes(32).toString('hex');
        gatePass.qrTokenHash = qrToken;
        gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000);
        await this.gatePassRepository.save(gatePass);
        return {
            qrToken: gatePass.qrTokenHash,
            expiresAt: gatePass.qrTokenExpiresAt,
        };
    }
};
exports.GatePassService = GatePassService;
exports.GatePassService = GatePassService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(gate_pass_entity_1.GatePass)),
    __param(1, (0, typeorm_1.InjectRepository)(student_entity_1.Student)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository])
], GatePassService);
//# sourceMappingURL=gatepass.service.js.map