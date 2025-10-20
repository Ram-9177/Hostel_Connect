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
exports.GateService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const gate_event_entity_1 = require("./entities/gate-event.entity");
const gate_pass_entity_1 = require("../gatepass/entities/gate-pass.entity");
const qr_token_service_1 = require("../common/utils/qr-token.service");
let GateService = class GateService {
    constructor(gateEventRepository, gatePassRepository, qrTokenService) {
        this.gateEventRepository = gateEventRepository;
        this.gatePassRepository = gatePassRepository;
        this.qrTokenService = qrTokenService;
    }
    async scanGatePass(scanDto) {
        const tokenPayload = this.qrTokenService.validateToken(scanDto.qrToken);
        if (!tokenPayload || tokenPayload.type !== 'GATE_PASS') {
            throw new common_1.BadRequestException('Invalid or expired QR token');
        }
        const gatePass = await this.gatePassRepository.findOne({
            where: { id: tokenPayload.entityId },
            relations: ['student'],
        });
        if (!gatePass) {
            throw new common_1.NotFoundException('Gate pass not found');
        }
        if (gatePass.status !== 'APPROVED') {
            throw new common_1.BadRequestException('Gate pass is not approved');
        }
        const now = new Date();
        if (now < gatePass.startTime || now > gatePass.endTime) {
            throw new common_1.BadRequestException('Gate pass is not valid at this time');
        }
        const existingEvent = await this.gateEventRepository.findOne({
            where: {
                passId: gatePass.id,
                eventType: scanDto.eventType,
            },
            order: { timestamp: 'DESC' },
        });
        if (existingEvent) {
            const timeDiff = now.getTime() - existingEvent.timestamp.getTime();
            if (timeDiff < 5 * 60 * 1000) {
                throw new common_1.BadRequestException('Duplicate scan detected');
            }
        }
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
        if (scanDto.eventType === 'OUT') {
            await this.gatePassRepository.update(gatePass.id, {
                status: 'EXPIRED',
            });
        }
        return savedEvent;
    }
    async getGatePassEvents(passId) {
        return this.gateEventRepository.find({
            where: { passId },
            order: { timestamp: 'ASC' },
        });
    }
    async getStudentGateEvents(studentId, limit = 10) {
        return this.gateEventRepository.find({
            where: { studentId },
            order: { timestamp: 'DESC' },
            take: limit,
        });
    }
};
exports.GateService = GateService;
exports.GateService = GateService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(gate_event_entity_1.GateEvent)),
    __param(1, (0, typeorm_1.InjectRepository)(gate_pass_entity_1.GatePass)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        qr_token_service_1.QRTokenService])
], GateService);
//# sourceMappingURL=gate.service.js.map