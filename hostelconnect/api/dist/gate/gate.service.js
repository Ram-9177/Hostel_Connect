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
let GateService = class GateService {
    constructor(gateEventRepository, gatePassRepository) {
        this.gateEventRepository = gateEventRepository;
        this.gatePassRepository = gatePassRepository;
    }
    async scanGatePass(scanDto) {
        try {
            const gatePass = await this.validateGatePass(scanDto.qrCode);
            if (!gatePass) {
                return {
                    success: false,
                    message: 'Invalid or expired gate pass',
                    event: null
                };
            }
            const eventType = await this.determineEventType(gatePass.studentId);
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
            if (eventType === 'OUT') {
                await this.gatePassRepository.update(gatePass.id, {
                    status: gate_pass_entity_1.GatePassStatus.ACTIVE,
                    lastUsedAt: new Date(),
                });
            }
            else if (eventType === 'IN') {
                await this.gatePassRepository.update(gatePass.id, {
                    status: gate_pass_entity_1.GatePassStatus.COMPLETED,
                    completedAt: new Date(),
                });
            }
            return {
                success: true,
                message: `Student ${eventType === 'OUT' ? 'exited' : 'entered'} successfully`,
                event: savedEvent,
                gatePass: gatePass
            };
        }
        catch (error) {
            console.error('Gate scan error:', error);
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
    async validateGatePass(qrCode) {
        try {
            const passId = this.extractPassIdFromQR(qrCode);
            if (!passId) {
                return null;
            }
            const gatePass = await this.gatePassRepository.findOne({
                where: { id: passId }
            });
            if (!gatePass) {
                return null;
            }
            if (gatePass.status !== 'APPROVED') {
                return null;
            }
            const now = new Date();
            const startTime = new Date(gatePass.startTime);
            const endTime = new Date(gatePass.endTime);
            if (now < startTime || now > endTime) {
                return null;
            }
            return gatePass;
        }
        catch (error) {
            console.error('Gate pass validation error:', error);
            return null;
        }
    }
    async determineEventType(studentId) {
        const recentEvent = await this.gateEventRepository.findOne({
            where: { studentId },
            order: { timestamp: 'DESC' }
        });
        if (!recentEvent || recentEvent.eventType === 'IN') {
            return 'OUT';
        }
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
                }
            },
            order: { timestamp: 'DESC' }
        });
    }
    async getStudentEvents(studentId) {
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
                }
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
    extractPassIdFromQR(qrCode) {
        try {
            const parsed = JSON.parse(qrCode);
            return parsed.passId || parsed.id || null;
        }
        catch {
            return qrCode;
        }
    }
};
exports.GateService = GateService;
exports.GateService = GateService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(gate_event_entity_1.GateEvent)),
    __param(1, (0, typeorm_1.InjectRepository)(gate_pass_entity_1.GatePass)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository])
], GateService);
//# sourceMappingURL=gate.service.js.map