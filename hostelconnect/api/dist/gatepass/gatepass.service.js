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
const qr_token_service_1 = require("../common/utils/qr-token.service");
const ad_event_entity_1 = require("../ads/entities/ad-event.entity");
let GatePassService = class GatePassService {
    constructor(gatePassRepository, adEventRepository, qrTokenService) {
        this.gatePassRepository = gatePassRepository;
        this.adEventRepository = adEventRepository;
        this.qrTokenService = qrTokenService;
    }
    async create(createDto, studentId) {
        if (createDto.startTime >= createDto.endTime) {
            throw new common_1.BadRequestException('End time must be after start time');
        }
        const overlappingPass = await this.gatePassRepository.findOne({
            where: {
                studentId,
                status: gate_pass_entity_1.GatePassStatus.APPROVED,
            },
        });
        if (overlappingPass) {
            const now = new Date();
            if (overlappingPass.startTime <= now && overlappingPass.endTime >= now) {
                throw new common_1.BadRequestException('Student already has an active gate pass');
            }
        }
        const gatePass = this.gatePassRepository.create({
            ...createDto,
            studentId,
        });
        return this.gatePassRepository.save(gatePass);
    }
    async findAll(studentId, hostelId) {
        const where = {};
        if (studentId)
            where.studentId = studentId;
        if (hostelId)
            where.hostelId = hostelId;
        return this.gatePassRepository.find({
            where,
            relations: ['student', 'hostel', 'decisionByUser'],
            order: { createdAt: 'DESC' },
        });
    }
    async findById(id) {
        const gatePass = await this.gatePassRepository.findOne({
            where: { id },
            relations: ['student', 'hostel', 'decisionByUser'],
        });
        if (!gatePass) {
            throw new common_1.NotFoundException('Gate pass not found');
        }
        return gatePass;
    }
    async approve(id, approveDto, wardenId) {
        const gatePass = await this.findById(id);
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.PENDING) {
            throw new common_1.BadRequestException('Gate pass is not pending approval');
        }
        gatePass.status = approveDto.approved ? gate_pass_entity_1.GatePassStatus.APPROVED : gate_pass_entity_1.GatePassStatus.REJECTED;
        gatePass.decisionBy = wardenId;
        gatePass.decisionAt = new Date();
        gatePass.note = approveDto.reason;
        if (gatePass.status === gate_pass_entity_1.GatePassStatus.APPROVED) {
            const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
            gatePass.qrTokenHash = qrToken;
            gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000);
        }
        return this.gatePassRepository.save(gatePass);
    }
    async cancel(id, studentId) {
        const gatePass = await this.findById(id);
        if (gatePass.studentId !== studentId) {
            throw new common_1.BadRequestException('You can only cancel your own gate pass');
        }
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.PENDING) {
            throw new common_1.BadRequestException('Only pending gate passes can be cancelled');
        }
        gatePass.status = gate_pass_entity_1.GatePassStatus.CANCELLED;
        return this.gatePassRepository.save(gatePass);
    }
    async getQRToken(id) {
        const gatePass = await this.findById(id);
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.APPROVED) {
            throw new common_1.BadRequestException('Gate pass must be approved to get QR token');
        }
        if (gatePass.isEmergency) {
            const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
            return {
                qrToken,
                expiresAt: new Date(Date.now() + 30 * 1000),
                adRequired: false,
            };
        }
        const adWatched = await this.checkAdWatched(gatePass.studentId, 'gatepass');
        if (!adWatched) {
            return {
                qrToken: '',
                expiresAt: new Date(),
                adRequired: true,
            };
        }
        if (!gatePass.qrTokenHash || !gatePass.qrTokenExpiresAt) {
            throw new common_1.BadRequestException('QR token not available');
        }
        if (gatePass.qrTokenExpiresAt < new Date()) {
            throw new common_1.BadRequestException('QR token has expired');
        }
        return {
            qrToken: gatePass.qrTokenHash,
            expiresAt: gatePass.qrTokenExpiresAt,
            adRequired: false,
        };
    }
    async refreshQRToken(id) {
        const gatePass = await this.findById(id);
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.APPROVED) {
            throw new common_1.BadRequestException('Gate pass must be approved to refresh QR token');
        }
        const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
        gatePass.qrTokenHash = qrToken;
        gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000);
        await this.gatePassRepository.save(gatePass);
        return {
            qrToken,
            expiresAt: gatePass.qrTokenExpiresAt,
        };
    }
    async checkAdWatched(studentId, module) {
        const twentyFourHoursAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);
        const adEvent = await this.adEventRepository.findOne({
            where: {
                userId: studentId,
                module,
                result: ad_event_entity_1.AdEventResult.COMPLETED,
                timestamp: { $gte: twentyFourHoursAgo },
            },
            order: { timestamp: 'DESC' },
        });
        return !!adEvent;
    }
    async markAdWatched(studentId, adId, module) {
        const adEvent = this.adEventRepository.create({
            adId,
            userId: studentId,
            module,
            result: ad_event_entity_1.AdEventResult.COMPLETED,
            timestamp: new Date(),
        });
        await this.adEventRepository.save(adEvent);
    }
    async unlockQRTokenAfterAd(id, studentId) {
        const gatePass = await this.findById(id);
        if (gatePass.status !== gate_pass_entity_1.GatePassStatus.APPROVED) {
            throw new common_1.BadRequestException('Gate pass must be approved to unlock QR token');
        }
        if (gatePass.studentId !== studentId) {
            throw new common_1.BadRequestException('You can only unlock your own gate pass');
        }
        const qrToken = this.qrTokenService.generateGatePassToken(gatePass.id, gatePass.studentId);
        gatePass.qrTokenHash = qrToken;
        gatePass.qrTokenExpiresAt = new Date(Date.now() + 30 * 1000);
        await this.gatePassRepository.save(gatePass);
        return {
            qrToken,
            expiresAt: gatePass.qrTokenExpiresAt,
        };
    }
};
exports.GatePassService = GatePassService;
exports.GatePassService = GatePassService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(gate_pass_entity_1.GatePass)),
    __param(1, (0, typeorm_1.InjectRepository)(ad_event_entity_1.AdEvent)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        qr_token_service_1.QRTokenService])
], GatePassService);
//# sourceMappingURL=gatepass.service.js.map